#!bin/bash
todaydate="14-03-23"
echo -e "today date is ${todaydate}" #this is called hardcoding
#To know the exact date we can use option {date +%F}
#ex
todaydate=$(date +%F)
echo -e "today date is ${todaydate}"
echo -e "no of users in the system are: \e[34m $(who | wc -l) \e[0m"
