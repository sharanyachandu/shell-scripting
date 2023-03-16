 #!bin/bash

set -e
    COMPONENT=frontend
    LOG-FILE="/tmp/frontend.log"
#validating whether the executed user is root user or not

ID=$(id -u)
if [ "$ID" -ne 0 ] ; then 
    echo -e "\e[31m You should execute this script as a root user or with a sudo as prefix \e[0m" 
    exit 1
fi 

stat(){
if [ "$?" -eq 0 ] ; then
    echo  -e "\e[33m ngnix is succesfully installed \e[0m"
else
    echo -e "\e[32m ngnix is not installed \e[0m"
fi
}

echo  -n "installing nginx" 
yum install nginx -y  &>> LOG-FILE
stat $?

echo "Downloading the $COMPONENT component"
curl -s -L -o /tmp/f$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo "performing cleanup of old $COMPONENT component"
cd /usr/share/nginx/html
 rm -rf *  &>> LOG-FILE
 stat $?

echo "copying the download $COMPONENT content"
 unzip /tmp/$COMPONENT.zip  &>> LOG-FILE
 stat $?
 
 mv $COMPONENT-main/* .
 mv static/* .
 rm -rf $COMPONENT-main README.md
 mv localhost.conf /etc/nginx/default.d/roboshop.conf
 stat $?


 systemctl enable nginx &>> LOG-FILE
 systemctl start nginx  &>> LOG-FILE
 stat $?
# ```

# Let's download the HTDOCS content and deploy it under the Nginx path.

# ```
# # curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

# ```

# Deploy in Nginx Default Location.

# ```
# # cd /usr/share/nginx/html
# # rm -rf *
# # unzip /tmp/frontend.zip
# # mv frontend-main/* .
# # mv static/* .
# # rm -rf frontend-main README.md
# # mv localhost.conf /etc/nginx/default.d/roboshop.conf

# ```

# - Finally, restart the service once to effect the changes.
# - Now, you should be able to access the ROBOSHOP e-commerce webpage as shown below