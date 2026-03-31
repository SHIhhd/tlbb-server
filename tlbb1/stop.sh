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

###### stop Server ######
cd /home/tlbb1/Server && touch quitserver.cmd
echo " stopping Server1 ......"
until [ "$?" = "1" ]
do
  ps aux | grep -i "./Server1 " | grep -v grep >/dev/null 2>&1
done
echo " Server1 stoped completely !!!!!!"
sleep 3

###### stop Login ######
LOGINPID=`ps aux | grep "./Login1" | grep -v grep | awk '{print $2}'`
kill -9 $LOGINPID
echo " Login1 is stopping ......"
until [ "$?" = "1" ]
do
  ps aux | grep -i "./Login1" | grep -v grep >/dev/null 2>&1
done
echo " Login1 stoped completely !!!!!!"
sleep 2

###### stop World ######
WORLDPID=`ps aux | grep -i "./World1" | grep -v grep | awk '{print $2}'`
kill -9 $WORLDPID
echo " World1 is stopping ......"

until [ "$?" = "1" ]
do
  ps aux | grep -i "./World1" | grep -v grep >/dev/null 2>&1
done
echo " World1 stoped completely !!!!!!"
sleep 2

###### stop ShareMemory ######
cd /home/tlbb1/Server/ && touch exit.cmd
echo " ShareMemroy1 is saving data ......"

until [ "$?" = "1" ]
do
  ps aux | grep -i "./ShareMemory1" | grep -v grep >/dev/null 2>&1 
done
echo " ShareMemory1 stoped completely !!!!!!"
sleep 2

###### stop CenterServer  ######
cd /home/tlbb1/Server/ && touch exit_center.cmd
echo " CenterServer1 is saving data ......"
until [ "$?" = "1" ]
do
    ps aux | grep -i "./CenterServer1" | grep -v grep >/dev/null 2>&1
done
echo " CenterServer1 stoped completely !!!!!!"
sleep 3

###### transfer logs ######
DIR=`date +%Y%m%d-%H%M`
mkdir -p /home/tlbb1/logbak/$DIR
mv /home/tlbb1/Server/Log/* /home/tlbb1/logbak/$DIR
cd /home/tlbb1/logbak
tar -czf $DIR.tar.gz $DIR
rm -rf $DIR
echo "Log transfer and compression to /home/tlbb1/logbak/ completely !!!!!!"
