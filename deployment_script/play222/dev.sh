/play-2.1.3/play stop
git pull
/play-2.1.3/play -Dhttp.port=${1:-9002} -Dconfig.resource=dev.conf run
/etc/init.d/apache2 reload
