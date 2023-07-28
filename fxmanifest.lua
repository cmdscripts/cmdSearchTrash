fx_version 'cerulean'
games { 'gta5' };
lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    '@msk_core/import.lua',
    "config.lua"
}

client_scripts {
    "source/client.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "source/server.lua"
}

dependency {'msk_core'}
