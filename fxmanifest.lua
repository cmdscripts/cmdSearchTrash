fx_version 'cerulean'
games { 'gta5' };
lua54 'yes'
version '1.1'

shared_scripts {
    '@es_extended/imports.lua',
    "config.lua"
}

client_scripts {
    "source/client.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "source/server.lua"
}