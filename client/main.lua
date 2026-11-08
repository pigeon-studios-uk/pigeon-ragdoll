--[[
    Pigeon Ragdoll: client.

    A key (U by default) makes the player's character fall over and lie limp, for a moment of roleplay:
    fainting, being knocked down, playing dead. With Config.Mode = 'toggle' they stay down until they press
    it again; with 'timed' they get up after Config.Seconds. They can't do it in a vehicle, in water,
    falling or parachuting, and there's a cooldown after getting up.

    Ragdolls are synced by the game, so everyone sees it. Nothing runs while the player is standing.
]]

local RESOURCE = GetCurrentResourceName()
local HOLD_MS = 500            -- how often the ragdoll is renewed while the player is down
local RAGDOLL_MS = 1000        -- each renewal keeps them down this long, so they get up soon after the last
local RELAX = 0                -- ragdoll type: limp

-- 'auto' follows ox_lib's language (the ox:locale convar), and English when that isn't set.
local locale = Config.Locale == 'auto' and GetConvar('ox:locale', 'en') or Config.Locale
local strings = Locales[locale] or Locales.en

local function t(key, values)
    local text = strings[key] or Locales.en[key] or key
    return (text:gsub('{(%w+)}', function(name)
        local value = values and values[name]
        return value ~= nil and tostring(value) or '{' .. name .. '}'
    end))
end

local down = false
local downSince, upAt = 0, -math.huge
local blocked = false          -- set by other resources through SetBlocked
local lastMessage = {}

local function notify(key, values)
    if not Config.ShowMessages then return end
    local now = GetGameTimer()
    if lastMessage[key] and now - lastMessage[key] < 2000 then return end
    lastMessage[key] = now
    local text = t(key, values)
    local mode = Config.Notifications
    if mode == 'ox_lib' or (mode == 'auto' and GetResourceState('ox_lib') == 'started') then
        TriggerEvent('ox_lib:notify', { title = strings.title, description = text, type = 'error' })
    else
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandThefeedPostTicker(false, false)
    end
end

--- True if the player is somewhere they can't fall over.
local function cantFallHere(ped)
    if IsPedInAnyVehicle(ped, false) or IsPedGettingIntoAVehicle(ped) then return true end
    if IsPedSwimming(ped) or IsPedFalling(ped) or IsPedClimbing(ped) then return true end
    if IsPedInParachuteFreeFall(ped) then return true end
    local parachute = GetPedParachuteState(ped)
    return parachute == 1 or parachute == 2
end

local function getUp()
    down = false
    upAt = GetGameTimer()
end

local function holdDown()
    CreateThread(function()
        local limit
        if Config.Mode == 'timed' then
            limit = (tonumber(Config.Seconds) or 4) * 1000
        else
            local max = tonumber(Config.MaxSeconds) or 0
            limit = max > 0 and max * 1000 or math.huge
        end

        while down do
            local ped = PlayerPedId()
            if IsPedDeadOrDying(ped, true) or IsPedInAnyVehicle(ped, false) or blocked then break end
            if GetGameTimer() - downSince >= limit then break end
            SetPedToRagdoll(ped, RAGDOLL_MS, RAGDOLL_MS, RELAX, false, false, false)
            Wait(HOLD_MS)
        end
        if down then getUp() end
    end)
end

local function fall()
    local ped = PlayerPedId()
    if blocked or IsPedDeadOrDying(ped, true) then
        notify('cant')
        return
    end
    if cantFallHere(ped) then
        notify('cant')
        return
    end
    local wait = (tonumber(Config.CooldownSeconds) or 0) * 1000 - (GetGameTimer() - upAt)
    if wait > 0 then
        notify('wait', { seconds = math.ceil(wait / 1000) })
        return
    end
    down, downSince = true, GetGameTimer()
    holdDown()
end

local function toggle()
    if down then
        if Config.Mode ~= 'timed' then getUp() end
    else
        fall()
    end
end

RegisterCommand(Config.Command, toggle, false)
RegisterKeyMapping(Config.Command, strings.key_description or Locales.en.key_description, 'keyboard', Config.Key)

---------------------------------------------------------------------------
-- Exports, for other resources in the player's game

--- True while the player is down.
exports('IsDown', function() return down end)

--- Stops the player falling over (true), for example while handcuffed, or lets them again (false).
--- Blocking also gets them up if they're down.
exports('SetBlocked', function(value)
    blocked = value == true
    if blocked and down then getUp() end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == RESOURCE then down = false end
end)
