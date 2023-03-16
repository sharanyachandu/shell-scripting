 #!bin/bash

set -e
    COMPONENT=frontend
    LOGFILE="/tmp/frontend.log"
#validating whether the executed user is root user or not

ID=$(id -u)
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

echo  -n "installing nginx" 
yum install nginx -y  &>> LOGFILE
stat $?

echo -n "Downloading the $COMPONENT component"
curl -s -L -o /tmp/f$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "performing cleanup of old $COMPONENT component"
cd /usr/share/nginx/html
 rm -rf *  &>> LOGFILE
 stat $?

echo -n "copying the download $COMPONENT content"
 unzip /tmp/$COMPONENT.zip  &>> LOGFILE
 stat $?

echo -n "Updating the proxy details in the reverse proxy file :"
 mv $COMPONENT-main/* .
 mv static/* .
 rm -rf $COMPONENT-main README.md
 mv localhost.conf /etc/nginx/default.d/roboshop.conf
 stat $?

echo -n "starting nginx"
 systemctl enable nginx &>> LOGFILE
 systemctl start nginx  &>> LOGFILE
 stat $?
