#!/bin/bash

#=============================================================
#                                                             
#   ██╗  ██╗██╗   ██╗███████╗██╗    ██╗██╗   ██╗            
#   ╚██╗██╔╝██║   ██║██╔════╝██║    ██║██║   ██║            
#    ╚███╔╝ ██║   ██║█████╗  ██║ █╗ ██║██║   ██║            
#    ██╔██╗ ██║   ██║██╔══╝  ██║███╗██║██║   ██║            
#   ██╔╝ ██╗╚██████╔╝███████╗╚███╔███╔╝╚██████╔╝            
#   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝ ╚══╝╚══╝  ╚═════╝            
#                                                             
#                    XUEWU TLBB Server                        
#              Copyright (C) 2026 XUEWU TLBB                  
#                  All Rights Reserved                        
#                                                             
#=============================================================

ulimit -n 65535

if ps aux | grep -i "./ShareMemory1" | grep -v grep > /dev/null 2>&1;then
	echo " ShareMemory1  is running !!!!!!"
else 
	###### start ShareMemory ######
	cd /home/tlbb1/Server/
	./shm clear > /dev/null 2>&1
	rm -rf exit.cmd quitserver.cmd exit_center.cmd
	./shm start > /dev/null 2>&1
	echo " start ShareMemory1 ......"
	sleep 10
	echo " ShareMemory1 started completely !!!!!!"

	###### start CenterServer1 (需要共享内存) ######
    cd /home/tlbb1/Server/
    unset LD_PRELOAD
    export LD_PRELOAD="/home/tlbb/Server/libNewCenterServer.so"
    ./CenterServer1 > /dev/null 2>&1 &
    center_pid=$!
    unset LD_PRELOAD
    echo " start CenterServer1 ......"
    sleep 5
    if ps -p $center_pid > /dev/null; then
        echo " CenterServer1 started completely !!!!!! (PID: $center_pid)"
    else
        echo " CenterServer1 started fail !!!!!!"
    fi
	
	###### start World ######
	cd /home/tlbb1/Server/
	unset LD_PRELOAD 
	export LD_PRELOAD="/home/tlbb/Server/libNewWorld.so"
	./World1 > /dev/null 2>&1 &
	world_pid=$!
	unset LD_PRELOAD
	echo " start World1 ......"
	sleep 5
	if ps -p $world_pid >/dev/null; then
		echo " World1 started completely !!!!!! (PID: $world_pid)"
	else
		echo " World1 started fail !!!!!!"
	fi
	
	###### start Server ######
    cd /home/tlbb1/Server/
	unset LD_PRELOAD
	export LD_PRELOAD="/home/tlbb/Server/libNewServer.so"
	export ASAN_OPTIONS=halt_on_error=0:abort_on_error=0:log_path='/home/tlbb1/Server/assert_core.log'
	# 是否热更新 -loadscriptonce
	./Server1  > /dev/null 2>&1 &  
	server_pid=$!
	unset LD_PRELOAD
    echo " start Server1 ......"
	sleep 10
	if ps -p $server_pid >/dev/null; then
		echo " Server1 started completely !!!!!! (PID: $server_pid)"
	else
		echo " Server1 started fail !!!!!!"
	fi

	###### start Login ######
    cd /home/tlbb1/Server/
	unset LD_PRELOAD
	export LD_PRELOAD="/home/tlbb/Server/libNewLogin.so"
	./Login1 > /dev/null 2>&1 &
	login_pid=$!
	unset LD_PRELOAD
	echo " start Login1 ......"
	sleep 1
	if ps -p $login_pid >/dev/null; then
		echo " Login1 started completely !!!!!! (PID: $login_pid)"
	else
		echo " Login1 started fail !!!!!!"
	fi

    exit
fi
