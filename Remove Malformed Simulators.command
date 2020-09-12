#!/bin/bash

#Self Obtaining Script Path for Directory
    SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

    scriptfilename=$(basename -- "$0")
#Showing All Path Names and file names:
echo -n "Script name: $scriptfilename"
echo
echo
echo -n "Directory address: $SCRIPTPATH"
echo
echo



if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root, to successfully remove Malformed Bundles run with command: sudo $SCRIPTPATH/$scriptfilename"
    
fi


xcrun simctl help&> ${SCRIPTPATH}/outfile.txt
sed -n '/usage/q;p' <${SCRIPTPATH}/outfile.txt> $SCRIPTPATH/final.txt
#Simurm $SCRIPTPATH/outfile.txt

sed 's/^[^/]*//' $SCRIPTPATH/final.txt > $SCRIPTPATH/outfile.txt
filename="$SCRIPTPATH/outfile.txt"
IFS=$'\n'       # make newlines the only separator
for j in $(cat $SCRIPTPATH/outfile.txt)
do
    echo "Removing file: $j"
    sudo rm -rf $j
done


xcrun simctl help&> ${SCRIPTPATH}/outfile.txt
sed -n '/usage/q;p' <${SCRIPTPATH}/outfile.txt> $SCRIPTPATH/final_check.txt
if [ -s $SCRIPTPATH/final_check.txt ]
then
    
    for j in $(cat $SCRIPTPATH/final_check.txt)
    do
        echo "This file needs to be manually removed: $j"
    
    done
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then
        echo "Not running as root, to successfully remove Malformed Bundles run with command: Sudo $SCRIPTPATH/$scriptfilename"
        admin = '0'
    fi

    
else
    echo "Malformed Bundles Found: 0"
    echo "All Malformed Bundles were removed successfully!"
fi


exit 0
