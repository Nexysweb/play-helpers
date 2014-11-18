#create package and then deploy -. should be the way to go
#https://www.playframework.com/documentation/2.3.4/ProductionDist
#https://www.playframework.com/documentation/2.3.x/ProductionConfiguration
#https://www.playframework.com/documentation/2.3.x/Production
#https://www.playframework.com/documentation/2.3.4/PlayConsole
target/universal/stage/bin/lookgood -Dhttp.port=9026 -Dpidfile.path=/var/run/lookgood.pid
