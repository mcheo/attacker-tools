#!/bin/bash

# v1.0 by sVen Mueller
## This script creates dynamic basline traffic

clear
echo "Traffic Baselining"
echo
#IP=$1
IP=$APP_ADDR
#if [ "$IP" == "" ]
# then
#        #echo -n "Enter Target IP as an Argument"
#        #exit
#fi

BASELINE='Please enter your type of baslining: '
options=("increasing" "alternate" "Quit")
select opt in "${options[@]}"
do
        case $opt in
                "increasing")
                        while true; do
                                clear
                                echo "Hourly increasing traffic: $IP"   
                                echo
				for i in $(eval echo "{0..`date +%M`}")
                                        do
                                                curl -0 -s -o /dev/null -A "`shuf -n 1 ./resource/useragents_with_bots.txt`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 ./resource/urls.txt`
                                                curl -0 -s -o /dev/null -A "`shuf -n 1 ./resource/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./resource/urls.txt`
                                                curl -0  -s -o /dev/null -A "`shuf -n 1 ./resource/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./resource/urls.txt`
                                        done
                                #sleep 0.1
                        done    
                ;;
                "alternate")
                        while true; do
                                clear
                                echo "Hourly alternate traffic: $IP"
                                echo
                                #if (( {`date +%k` % 2} )); then
                                if (( `date +%k` % 2 )); then
                                        for i in {1..100};
                                                do
                                                        curl -0 -s -o /dev/null -A "`shuf -n 1 ./resource/useragents_with_bots.txt`" -w "High:\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 ./resource/urls.txt`
                                                        curl -0 -s -o /dev/null -A "`shuf -n 1 ./resource/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./resource/urls.txt`
                                                        curl -0 -s -o /dev/null -A "`shuf -n 1 ./resource/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./resource/urls.txt`
                                                done
                                else
                                        for i in {1..50};
                                                do
                                                        curl -s -o /dev/null -A "`shuf -n 1 ./resource/useragents_with_bots.txt`" -w "High:\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 ./resource/urls.txt`
                                                        curl -s -o /dev/null -A "`shuf -n 1 ./resource/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./resource/urls.txt`
                                                        curl  -s -o /dev/null -A "`shuf -n 1 ./resource/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./resource/urls.txt`
                                                done
                                fi
                                #sleep 0.1
                                clear
                        done
                ;;
                "Quit")
                        break
                ;;
        *) echo invalid option;;
    esac
done
