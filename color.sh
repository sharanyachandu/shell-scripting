#bin/bash

#Color	Foreground	Background
#Black	30m	\033[40m
#Red	\033[31m	\033[41m
#Green	\033[32m	\033[42m
#Orange	\033[33m	\033[43m
#Blue	\033[34m	\033[44m
#Magenta	\033[35m	\033[45m
#Cyan	\033[36m	\033[46m
#Light gray	\033[37m	\033[47m
#Fallback to distro's default	\033[39m	\033[49m

#SYNTAX:
#    echo -e "\ecolorcodem msg to print \e[0m"
#for background color ex:  echo -e "\e[bckgndclor;forgrndclr msg \e[0m"
 echo -e "\e[31m this is red color \e[0m"
 echo -e "\e[34m this is blue color \e[0m"
 echo -e "\e[41;34m this is blue color \e[0m"
 

