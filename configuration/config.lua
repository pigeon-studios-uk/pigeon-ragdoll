Config = {}

-- Language for the text players see. 'auto' follows ox_lib's language (setr ox:locale "de" in
-- server.cfg) and is English when that isn't set. Or name a file from locales/, such as 'de' or 'pt-br'.
Config.Locale = 'auto'

-- The key players press to fall over. Players can change it in GTA's Settings -> Key Bindings -> FiveM.
-- Codes: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
-- The command (/ragdoll) works too.
Config.Key = 'U'
Config.Command = 'ragdoll'

-- 'toggle'  the key makes the player fall over, and pressing it again gets them up.
-- 'timed'   the key makes them fall over for Config.Seconds, then they get up by themselves.
Config.Mode = 'toggle'

-- How long they stay down with 'timed', in seconds.
Config.Seconds = 4

-- With 'toggle', the longest they can stay down, in seconds, before getting up by themselves. 0 for no limit.
Config.MaxSeconds = 60

-- Seconds after getting up before they can fall over again. 0 for none.
Config.CooldownSeconds = 5

-- Tell players why they can't fall over: still in the cooldown, or somewhere they can't (in a vehicle,
-- swimming, falling or parachuting).
Config.ShowMessages = true

-- How messages are shown.
-- 'auto' uses ox_lib notifications if ox_lib is running, otherwise GTA's notification feed.
-- 'ox_lib' or 'gta' to force one.
Config.Notifications = 'auto'

-- Update checks are controlled in server.cfg for every Pigeon Studios resource at once:
--     set pigeon_update_check "on"      (default)  |  "quiet"  |  "off"
