#!/bin/bash

end=$1

for ((i=end; i>0; i--))
do
    printf "\r$i remaining...     "
    sleep 60
done

echo -ne '\007'
sleep 0.2
echo -ne '\007'
sleep 0.1
echo -ne '\007'
