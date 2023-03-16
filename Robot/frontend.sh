 #!bin/bash

set -e
#validating whether the executed user is root user or not

ID=$(id -u)
if [ "$ID" -ne 0 ] ; then 
    echo -e "\e[31m You should execute this script as a root user or with a sudo as prefix \e[0m" 
    exit 1
fi 

echo "installing nginx" 
yum install nginx -y  &>>/tmp/frontend.log
if [ "$?" -eq 0 ] ; then
    echo  -e "\e[33m ngnix is succesfully installed \e[0m"
else
    echo -e "\e[32m ngnix is not installed \e[0m"
fi
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
 rm -rf *  &>> /tmp/frontend.log
 unzip /tmp/frontend.zip  &>> /tmp/frontend.log
 mv frontend-main/* .
 mv static/* .
 rm -rf frontend-main README.md
 mv localhost.conf /etc/nginx/default.d/roboshop.conf

 systemctl enable nginx &>> /tmp/frontend.log
 systemctl start nginx  &>> /tmp/frontend.log

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