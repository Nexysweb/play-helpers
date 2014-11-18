/play-2.1.3/play stop
git pull
/play-2.1.3/play -Dhttp.port=${1:-9000} -Dconfig.resource=prod.conf start
/etc/init.d/apache2 reload