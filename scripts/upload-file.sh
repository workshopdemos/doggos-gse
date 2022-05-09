#!/bin/bash
set -e
source ./basescript.sh
printf "Enter username: "
read hlq
printf "\nDeploying the input file to the Mainframe\n\n"
tempDirectoryName="FILES_TEMP";
DOGGOS_INPUT="DOGGOS.INPUT";
DOGGOS_INPUT_NEW="DOGGOS.INPUT.NEW";
DOGGOS_RUNAPP="DOGGOS.RUNAPP"
storageClass="CAEDS6";
upload "$DOGGOS_INPUT" files/DOGGOS.INPUT DS N
printf "\n###########################################################"
printf "\n# Input dataset successfully deployed to the Z/OS system #"
printf "\n###########################################################\n"
