#!/bin/bash
tmp_files=0
echo $tmp_files
if [ $tmp_files=0 ]
then
    echo "$(date) Nothing to del"  > /var/removed_file.log
else
    for LI in tmp_files;do
        rm -rf /tmp/$LI && echo "$(date) | Removed file /tmp/$LI" > /var/removed_file.log;done
fi