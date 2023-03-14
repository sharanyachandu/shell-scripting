#!bin/bash
#there are 4 types of commands available
#1.binary   (/bin ,/sbin)
#2.Aliases  (alias are shotcuts,alias net="netstat -tulpn")
#3.shell-builtin commands
#4.Functions functions are commands that can be written in sequence and called n number of times

#declaring a function
 #ex:function(){
  #  echo""msg to be called"
# } To call function in commad line syntax:function
#ex
sample(){
    echo "This is the sample function to call"
}
#THIS IS HOW WE CALL A FUNCTION
    #sample

    test(){
        echo "Total number of sessions: $(who | wc -l)"
        echo "Todays date is: $(date +%F)"
        echo "calling sample function"
        sample
    }
    test
    #In a function we can call another function
    #awk is used to display the field dividers
    #ex:$uptime | awk -F : '{print $1}' -->it prints value of firstcolon,here the field seperator is :
     #ex:$uptime | awk -F : '{print $NF}' -->it prints the last values
     #ex::$uptime | awk -F : '{print $NF}' | awk -F , '{print $1}' -->which prints load avarage first value with field seperator,