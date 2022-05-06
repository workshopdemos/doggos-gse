#!/bin/bash
set -e
source ./basescript.sh

printf "\nDeploying the input file to the Mainframe\n\n"

printf "Enter username: "
read hlq
tempDirectoryName="FILES_TEMP";
DOGGOS_INPUT="DOGGOS.INPUT";
DOGGOS_INPUT_NEW="DOGGOS.INPUT.NEW";
DOGGOS_RUNAPP="DOGGOS.RUNAPP"
storageClass="CAEDS6";
upload "$DOGGOS_INPUT" files/DOGGOS.INPUT DS N
printf "Datasets successfully deployed to the Z/OS system\n\n";
printf "\n###########################################################"
printf "\n#### Datasets successfully deployed to the Z/OS system ####"
printf "\n###########################################################\n"
