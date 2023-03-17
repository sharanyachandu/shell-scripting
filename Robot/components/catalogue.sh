#!bin/bash
set -e
    COMPONENT=catalogue
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

echo -n "Installing NodeJS"
yum install nodejs -y  &>> $LOGFILE
stat $?

echo -n "creating $USERAPP"
useradd roboshop  &>> $LOGFILE
stat $?
 
echo -n "Downloading the $COMPONENT "
 curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
 stat $?

echo -n "Extracting the $COMPONENT in the $APPUSER directory"
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip    &>> $LOGFILE
stat $?
# $ mv catalogue-main catalogue
# $ cd /home/roboshop/catalogue
# $ npm install



