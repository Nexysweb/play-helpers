# before running this file, do not forget to do: 
# $ chmod +x prod.sh

# kill exsiting process
kill $(cat target/universal/stage/RUNNING_PID)
# pull latest version
git pull
# launch application with options
# java_opts: set less memory
# port: defines the port
# config file: the conf file to use (does not seem to work)
java_opts="-Xms128M -Xmx512M" ./activator -Dhttp.port=${1:-9025} -Dconfig.file=/srv/johan/startups/look-good-london/conf/prod.conf start

## will need to do Ctrl+D to quit application (while process is still running)

# reload Apache
/etc/init.d/apache2 reload