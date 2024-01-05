#!/bin/bash

echo "Do you want to create the output file with this data? [y/n]"
read answer

if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then
  . ./output.sh >> $(date "+%d_%m_%y_%H_%M_%S").txt
else
  exit 0
fi
