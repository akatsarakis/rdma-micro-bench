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
declare -a CONNECTION=("ibv_rc_pingpong" "ibv_uc_pingpong" "ibv_ud_pingpong" "ibv_srq_pingpong")
#declare -a MESSAGE_SIZE=("2" "4" "8" "16" "32" "64" "128" "256" "512" "1024" "2048" "4096" "8192" "16384")
declare -a MESSAGE_SIZE=("2" "16" "128" "512" "1024" "4096" "16384")
declare -a MTU=("1024")

for CONN in "${CONNECTION[@]}"
do 
    for MT in "${MTU[@]}"
    do
        for SIZE in "${MESSAGE_SIZE[@]}"
        do
            echo "Running ${CONN} ${COMPONENT} -m ${MT} -s ${SIZE} "
            ${CONN} -d mlx4_0 -i 1 -g 0 -m ${MT} -s ${SIZE} ${SERVER_IP}
            sleep ${SLEEP_TIME};
        done
    done
done
