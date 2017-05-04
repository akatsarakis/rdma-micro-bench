#!/usr/bin/env bash

#either server or client
#COMPONENT="server" 
COMPONENT="client" 
SERVER_IP=""
SLEEP_TIME="1"
if [ $COMPONENT = "client" ]
then
    SERVER_IP="10.148.0.149"
    SLEEP_TIME="2"
fi

# declare the parameters of the runing tests
declare -a OPERATIONS=("atomic" "read" "send" "write")
declare -a CONNECTIONS=("RC" "XRC" "UC")  # "DC")

for OPERATION in "${OPERATIONS[@]}"
do
    for CONNECTION in "${CONNECTIONS[@]}"
    do 
        echo "Latency of ${OPERATION} on ${CONNECTION} connection:"
        ib_${OPERATION}_lat -d mlx4_0 -i 1 -F -a -c ${CONNECTION} ${SERVER_IP} \
            2> /dev/null > results/latency/${OPERATION}_${CONNECTION}.txt
        sleep ${SLEEP_TIME};
    done
done

rm -rf results/latency/read_UC.txt
rm -rf results/latency/atomic_UC.txt
