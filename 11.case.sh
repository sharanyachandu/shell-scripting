#/bin/bash
#case condition
ACTION=$1
case $ACTION in
start)
echo "starting payment service"
;;
stop)
echo "stoping payment process"
;;
restart)
echo "restarting the payment process"
;;
esac 