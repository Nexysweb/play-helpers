# before running this file, do not forget to do: 
# $ chmod +x prod.sh

# kill exsiting process
kill $(cat target/universal/stage/RUNNING_PID)
# pull latest version
git pull origin master
# launch application with options

# compiles
java_opts="-Xms128M -Xmx256M" ./activator clean stage 

# java_opts: set less memory
# port: defines the port
# config file: the conf file to use (does not seem to work)
# & in the end: runs process in background
java_opts="-Xms128M -Xmx256M" ./target/universal/stage/bin/tempy -Dhttp.port=${1:-9026} -Dconfig.file=conf/prod.conf -Dapplication.secret=abcdhtrkbj787efghijk &

## will not need to do Ctrl+D to quit application (while process is still running)

# reload Apache
/etc/init.d/apache2 reload
