 #!bin/bash
# set -e
#     COMPONENT=catalogue
#     LOGFILE="/tmp/$COMPONENT.log"
#     USERAPP=roboshop

# ID=$(id -u)  #validating whether the executed user is root user or not

# if [ "$ID" -ne 0 ] ; then 
#     echo -e "\e[31m You should execute this script as a root user or with a sudo as prefix \e[0m" 
#     exit 1
# fi 

# stat(){
# if [ "$?" -eq 0 ] ; then
#     echo  -e "\e[33m sucess \e[0m"
# else
#     echo -e "\e[32m Failure \e[0m"
# fi
# }

# echo -n "downloading $COMPONENT repo"
# #   curl -s -o /etc/yum.repos.d/$COMPONENT.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/mongo.repo
# curl --silent --location https://rpm.nodesource.com/setup_16.x | bash -
# stat $?
 
# echo -n "Installing NodeJS"
# yum install nodejs -y  &>> $LOGFILE
# stat $?

# echo -n "creating $USERAPP"
# # useradd roboshop  &>> $LOGFILE
# stat $?

# echo -n "swithing to roboshop user"
# #su - $USERAPP
# stat $?

 
# echo -n "Downloading the $COMPONENT "
#  curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
#  stat $?

# echo -n "Extracting the $COMPONENT in the $USERAPP directory"
# unzip -o /tmp/$COMPONENT.zip /home/$USERAPP/   &>> $LOGFILE
# stat $?

# echo -n "Configuring the permissions :"
# mv /home/$USERAPP/$COMPONENT-main /home/$USERAPP/$COMPONENT
# mv catalogue-main catalogue
# chown -R $USERAPP:$USERAPP /home/$USERAPP/$COMPONENT
# stat $?

# echo -n "Installing the $COMPONENT Application :"
#     cd /home/$USERAPP/$COMPONENT/ 
#     npm install &>> $LOGFILE
#     stat $?



LOGFILE="/tmp/$COMPONENT.log"
APPUSER=roboshop

# Validting whether the executed user is a root user or not 
ID=$(id -u)

if [ "$ID" -ne 0 ] ; then 
    echo -e "\e[31m You should execute this script as a root user or with a sudo as prefix \e[0m" 
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

DOWNLOAD_AND_EXTRACT() {

    echo -n "Downloading the $COMPONENT component :"
    curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
    stat $? 

    echo -n "Extracting the $COMPONENT in the $APPUSER directory"
    cd /home/$APPUSER 
    rm -rf /home/$APPUSER/$COMPONENT &>> $LOGFILE
    unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
    stat $? 

    echo -n "Configuring the permissions :"
    mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT
    chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
    stat $?

}

# NPM_INSTALL() {

#     echo -n "Installing the $COMPONENT Application :"
#     cd /home/$APPUSER/$COMPONENT/ 
#     npm install &>> $LOGFILE
#     stat $? 

# }

# CONFIG_SVC() {

#     echo -n "Updating the systemd file with DB Details :"
#     sed -i -e 's/AMQPHOST/rabbitmq.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/'  -e  's/CARTHOST/cart.roboshop.internal/' -e  's/DBHOST/mysql.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/$APPUSER/$COMPONENT/systemd.service
#     mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
#     stat $? 

#     echo -n "Starting the $COMPONENT service : "
#     systemctl daemon-reload &>> $LOGFILE
#     systemctl enable $COMPONENT &>> $LOGFILE
#     systemctl restart $COMPONENT &>> $LOGFILE
#     stat $?

# }

# MVN_PACKAGE() {
#     echo -n "Creating the $COMPONENT Package :"
#     cd /home/$APPUSER/$COMPONENT/ 
#     mvn clean package  &>> $LOGFILE
#     mv target/shipping-1.0.jar shipping.jar
#     stat $?   
# }

# PYTHON() {
#     echo -n "Installing Python and dependencies :"
#     yum install python36 gcc python3-devel -y  &>> $LOGFILE
#     stat $?

#     # Calling Create-User Functon 
#     CREATE_USER

#     # Calling Download_And_Extract Function
#     DOWNLOAD_AND_EXTRACT

#     echo -n "Installing $COMPONENT :"
#     cd /home/roboshop/$COMPONENT/ 
#     pip3 install -r requirements.txt   &>> $LOGFILE 
#     stat $? 

#     USERID=$(id -u roboshop)
#     GROUPID=$(id -g roboshop)
    
#     echo -n "Updating the $COMPONENT.ini file :"
#     sed -i -e "/^uid/ c uid=${USERID}" -e "/^gid/ c gid=${GROUPID}"  /home/$APPUSER/$COMPONENT/$COMPONENT.ini 

#     # Calling Config-Svc Function
#     CONFIG_SVC

# }

# JAVA() {
#     echo -n "Installing Maven  :" 
#     yum install maven -y &>> $LOGFILE
#     stat $?

#     # Calling Create-User Functon 
#     CREATE_USER

#     # Calling Download_And_Extract Function
#     DOWNLOAD_AND_EXTRACT

#     # Calling Maven Package Functon
#     MVN_PACKAGE

#     # Calling Config-Svc Function
#     CONFIG_SVC

# }






NODEJS() {

    echo -n "Configuring the nodejs repo :"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | bash - &>> $LOGFILE
    stat $?  

    echo -n "Installing NodeJS :"
    yum install nodejs -y &>> $LOGFILE
    stat $?

    # Calling Create-User Functon 
    CREATE_USER

    # Calling Download_And_Extract Function
    DOWNLOAD_AND_EXTRACT

    # Calling NPM Install Function
    NPM_INSTALL

    # Calling Config-Svc Function
    CONFIG_SVC

}