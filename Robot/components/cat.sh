#!bin/bash

LOGFILE="/tmp/$COMPONENT.log"
APPUSER=roboshop

# Validting whether the executed user is a root user or not 
ID=$(id -u)

if [ "$ID" -ne 0 ] ; then 
    echo -e "\e[34m You should execute this script as a root user or with a sudo as prefix \e[0m" 
    exit 1
fi 


stat() {
    if [ $1 -eq 0 ] ; then 
        echo -e "\e[32m Success \e[0m"
    else 
        echo -e "\e[31m Failure \e[0m"
        exit 2
    fi 
}

CREATE_USER() {

    id $APPUSER  &>> $LOGFILE
    if [ $? -ne 0 ] ; then 
        echo -n "Creating the Application User Account :" 
        useradd roboshop &>> $LOGFILE
        stat $? 
    fi 

}
