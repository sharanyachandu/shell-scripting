#!bin/bash
<<COMMENT

echo "simple if condition"
 ACTION=$1
   
   if["$ACTION "== "start"]; then
    echo "service payment is starting"
   else
   echo "payment is stopping"
   fi 
COMMENT

   echo "Demonstrating Simple If Condiitons" 
   ACTION=$1

if [ "$ACTION" == "start" ]; then
    echo -e "\e[32m Service Payment is Starting \e[0m" 
    exit 0

elif [ "$ACTION" == "stop" ]; then 
    echo -e "\e[31m Service Payment is stopping \e[0m" 
    exit 1

else 
    echo -e "\e[33m Service Payment Status is unknown \e[0m"
    exit 3

fi 