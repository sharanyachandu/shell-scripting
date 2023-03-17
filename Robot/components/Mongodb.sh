#!bin/bash
set -e
    COMPONENT=mongodb
    LOGFILE="/tmp/$COMPONENT.log"

ID=$(id -u)  #validating whether the executed user is root user or not

if [ "$ID" -ne 0 ] ; then 
    echo -e "\e[31m You should execute this script as a root user or with a sudo as prefix \e[0m" 
    exit 1
fi 

stat(){
if [ "$?" -eq 0 ] ; then
    echo  -e "\e[33m sucess \e[0m"
else
    echo -e "\e[32m Failure \e[0m"
fi
}

echo -n "downloading $COMPONENT repo"
  curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/mongo.repo
stat $?

echo "Installing $COMPONENT :"
  yum install -y mongodb-org &>> LOGFILE
  stat $?

echo "enable and starting $COMPONENT"
   systemctl enable mongod &>> LOGFILE
   systemctl start mongod &>> LOGFILE
   stat $?
 
 echo "updating the $COMPONENT visibility"
  sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
  stat $?

  echo "Performing Daemon-reload"
   systemctl daemon-reload &>> LOGFILE
   systemctl restart $COMPONENT &>> LOGFILE
   stat $?

# 1. Setup MongoDB repos.

# ```bash
# # curl -s -o /etc/yum.repos.d/$COMPONENT.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/mongo.repo
# ```

# 1. Install Mongo & Start Service.

# echo -n "installing MongoDB"
# # yum install -y mongodb-org
# # systemctl enable mongod
# # systemctl start mongod

# ```

# 1. Update Listen IP address from 127.0.0.1 to 0.0.0.0 in the config file, so that MongoDB can be accessed by other services.

# Config file:   `# vim /etc/mongod.conf`

# ![mongodb-update.JPG](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/87c01042-0f64-4ac4-ae5a-ffaf62836290/mongodb-update.jpg)

# - Then restart the service

# ```bash
# # systemctl restart mongod
# ```

  

# - Every Database needs the schema to be loaded for the application to work.

# ---

#       `Download the schema and inject it.`

# ```
# # curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# # cd /tmp
# # unzip mongodb.zip
# # cd mongodb-main
# # mongo < catalogue.js
# # mongo < users.js
# ```

# Symbol `<` will take the input from a file and give that input to the command.

# - Now proceed with the next component `CATALOGUE`
