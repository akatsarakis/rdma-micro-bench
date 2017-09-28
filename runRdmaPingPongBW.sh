#!/usr/bin/env bash

#either server or client
COMPONENT="server" 
SERVER_IP=""
SLEEP_TIME="1"
QPS="10"
SIZE="64"
ITER="100000000"
if [ $COMPONENT = "client" ]
then
    SERVER_IP="10.10.100.9"
    SLEEP_TIME="2"
fi

# declare the parameters of the runing tests
declare -a OPERATIONS=("send")
#declare -a OPERATIONS=("atomic" "read" "send" "write")
declare -a CONNECTIONS=("UD")
#declare -a CONNECTIONS=("RC" "XRC") # "DC")  
declare -a DIRECTIONS=("") 
#declare -a DIRECTIONS=("-b" "") 

for OPERATION in "${OPERATIONS[@]}"
do
    for CONNECTION in "${CONNECTIONS[@]}"
    do 
    	for DIRECTION in "${DIRECTIONS[@]}"
    	do 
             echo "Bandwidth of ${OPERATION} on ${CONNECTION} connection:"
       	     ib_${OPERATION}_bw ${DIRECTION} -d mlx5_0 -i 1 -s $SIZE -I 128 -q $QPS -n $ITER -F -c ${CONNECTION} ${SERVER_IP} # \
            	 #2> /dev/null > results/bandwidth/${OPERATION}_${DIRECTION}_${CONNECTION}.txt
             sleep ${SLEEP_TIME};
	done
    done
done
