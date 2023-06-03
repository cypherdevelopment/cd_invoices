fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_script 'client.lua'
server_script '@oxmysql/lib/MySQL.lua'
server_script 'server.lua'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/index.js',
    'html/index.css'
}