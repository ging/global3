SocialStream::Presence.setup do |config| 
  #Configures XMPP Server Domain
  config.domain = "localhost"
  #Configures Bosh Service Path
  config.bosh_service = "http://localhost:8080/http-bind"
  #Configures Authentication Method: "cookie" or "password"
  config.auth_method = "cookie"
  #Configures XMPP Server Password
  config.xmpp_server_password = "G&s6GBnO)anw2Ene%K12Cb=0quj@uDmA"
  #Remote or local mode
  config.remote_xmpp_server = false
  #Scripts path of ejabberd scripts (local or remote)
  config.scripts_path = "/home/aldo/ejabberd-2.1.8_scripts" 
  #False to disable Social Stream Presence
  #config.enable = false
  
  #Parameters for remote mode
  #config.ssh_domain = "trapo"
  #config.ssh_user = "aldo"
  #config.ssh_password= "*******"
  

  #Configure to use a Xmpp Client on Rails App
  #Username of the the Social Stream Admin sid
  config.social_stream_presence_username = "social_stream-presence"
  #Configures Social Stream Rails App Password
  config.password = "DnVCB8G|R$VGmZ@2?5=CYS8z)NrL@LuQ&LTCUh^9B(DF4gC&sQpfbCMbaNKEdNrGYkT4L5zxM0wNWs5q3?ww(b&0d5fK87z^BmgJMMF2SKXT9pEk^UEcch!GX!Avf5GT9)j@FpHe)4RH)BK7J98u!sUmJHUN(Je6aBmn!FtZ4Ab5h8$|nsvUt3Jkq?21HOH$r0sDyJZZvGOCgFS2EKw@0wXsJRHYVRPBe&Eb!1X55e55bQ^h2AW&^R70TK0m)Fu8" 
end