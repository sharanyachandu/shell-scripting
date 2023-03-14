#!bin/bash
#speacial characters $0-$9,$*,$#,$$
#$*,$@ prints the used variables
#echo $$ prints the current processId
#$# gives number of arguments that are used

a=10
echo "value of a is $a"
echo "name of the script is :$0"
echo first value is $1
echo "processid:$$"
echo first value is $2
echo first value is $3
#bash scriptname.sh val1 val2 val3 till 9
echo "supplied variables are: $* "
echo "no of arguments that are used: $#"