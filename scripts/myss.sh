#!/bin/bash
#
# Define some colors first: Capitals denote bold
#
red='\033[0;31m'
RED='\033[1;31m'
green='\033[0;32m'
GREEN='\033[1;32m'
yellow='\033[0;33m'
YELLOW='\033[1;33m'
blue='\033[0;34m'
BLUE='\033[1;34m'
magenta='\033[0;35m'
MAGENTA='\033[1;35m'
cyan='\033[0;36m'
CYAN='\033[1;36m'
BOLD='\033[1;37m' 
NC='\033[0m'              # No Color
if [ $1 ] ; then
 U=$1
else 
 U=$USER
fi

echo "" | awk "{printf \"\t%7s  | %6s | %11s | %15s\n\",\"${BLUE}PID   ${NC}\",\"${YELLOW}Size  ${NC}\",\"${GREEN}Starts In  ${NC}\",\"${RED}Start Time${NC}\"}"
echo "" | awk '{printf "\t--------|--------|-------------|--------------------\n"}'
for pid in `qstat -a -u $U| grep $U| grep 'Q' | awk ' {print $1}'` ; do 
  showstart $pid 2>&1 | awk -f ~jlarkin/src/awk/ss.awk | grep -v 'cannot locate job' ; 
done
