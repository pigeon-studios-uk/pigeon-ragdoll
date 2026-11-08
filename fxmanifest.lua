fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'pigeon-ragdoll'
author 'Pigeon Studios'
description 'A key to fall over and lie limp, and get back up, with a cooldown and no falling in vehicles or water.'
version '1.0.0'
repository 'https://github.com/pigeon-studios-uk/pigeon-ragdoll'

-- Pigeon Studios version registry entry, read by server/version_check.lua.
pigeon_slug 'pigeon-ragdoll'

client_scripts {
    'configuration/config.lua',
    'locales/*.lua',
    'client/main.lua',
}

server_scripts {
    'server/version_check.lua',
}
