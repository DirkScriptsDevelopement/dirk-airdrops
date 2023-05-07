fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

version '1.0.0'

client_script {
  'config.lua',
  
  'src/client/fw.lua',
  'src/client/utils.lua',
  'src/client/functions.lua'
}


server_script {
  'config.lua',
  'src/server/fw.lua',
  'src/server/utils.lua',
  'src/server/functions.lua'
}
