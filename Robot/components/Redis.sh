#! bin/bash
COMPONENT=redis
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

echo -n "installing $COMPONENT repo"   &>> $LOGFILE
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
stat $?
echo -n "installing $COMPONENT"   &>> $LOGFILE
yum install redis-6.2.11 -y 
stat $?
echo -n "updating the $COMPONENT visibility"
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf
stat $?
echo -n "enabling and startin the $COMPONENT"
systemctl enable redis  &>> $LOGFILE
systemctl start redis   &>> $LOGFILE
stat $?



# 1. Install Redis.

# ```bash

# # curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
# # yum install redis-6.2.11 -y
# ```

# 2. Update the BindIP from `127.0.0.1` to `0.0.0.0` in config file `/etc/redis.conf` & `/etc/redis/redis.conf`

# ```sql
# # vim /etc/redis.conf
# # vim /etc/redis/redis.conf
# ```

# ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4591fa90-1013-44a3-92e6-bf851cd2e213/Untitled.png)

    

# 3. Start Redis Database

# ```bash
# # systemctl enable redis
# # systemctl start redis
# # systemctl status redis -l
# ```

# - And the status should show as started
# 1. This completes the Redis component. Next move to the `User` Component