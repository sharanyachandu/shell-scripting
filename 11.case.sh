#/bin/bash
#case condition

ACTION=$1

if [ -z "$1" ]
then
    echo "No argument passed."
else
    echo "Argument passed: $1"
fi


case $ACTION in
start)
         echo -e "\e[33m starting payment service \e[0m"
;;
stop)
        echo "stoping payment process"
;;
restart)
        echo "restarting the payment process"
;;
esac 