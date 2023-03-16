#!bin/bash


echo "simple if condition"
 ACTION=$1
   
   if[$ACTION == start] ; 
    echo "service payment is starting"
   else
   echo "payment is stopping"
   fi 