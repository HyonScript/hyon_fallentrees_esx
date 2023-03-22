fx_version 'cerulean'
game 'gta5'
name 'hyon_fallentrees'
version      '1.1.0'
description 'Fallen Trees'

lua54 'yes'

shared_script 'config.lua'

client_scripts {
	'@es_extended/imports.lua',
    'client/main.lua'
}

server_scripts {
	'@es_extended/imports.lua',
    'server/main.lua'
}

dependency 'es_extended'