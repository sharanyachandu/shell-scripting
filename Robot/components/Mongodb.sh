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

echo -n "Installing $COMPONENT :"
  yum install -y mongodb-org &>> $LOGFILE
stat $?

echo -n "enable and starting $COMPONENT"
   systemctl enable mongod &>> $LOGFILE
   systemctl start mongod &>> $LOGFILE
stat $?
 
 echo -n "updating the $COMPONENT visibility"
  sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
stat $?

echo -n "Performing Daemon-reload"
   systemctl daemon-reload &>> $LOGFILE
   systemctl restart mongod
stat $?

echo -n "downloading $COMPONENT scheme"
 curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "extracting the $COMPONENT scheme"
cd /tmp
unzip $COMPONENT.zip    &>> $LOGFILE
stat $?
 
 echo -n "injecting the scheme"
 cd $COMPONENT-main
 mongo < catalogue.js   &>> $LOGFILE
 mongo < users.js       &>> $LOGFILE
stat $?

# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js

