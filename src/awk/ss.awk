#
# Define some colors first: Capitals denote bold
#
BEGIN {
red="\033[0;31m";
RED="\033[1;31m";
green="\033[0;32m";
GREEN="\033[1;32m";
yellow="\033[0;33m";
YELLOW="\033[1;33m";
blue="\033[0;34m";
BLUE="\033[1;34m";
magenta="\033[0;35m";
MAGENTA="\033[1;35m";
cyan="\033[0;36m";
CYAN="\033[1;36m";
BOLD="\033[1;37m";
NC="\033[0m";              # No Color
}

/^job/ { j=$2; p=$4;}
/^Estimated Rsv based start in/ { printf "\t%s%6d | %s%6d | %s%11s | %s%s %s %s %s%s\n",BLUE,j,YELLOW,p,GREEN,$6,RED,$8,$9,$10,$11,NC;}
