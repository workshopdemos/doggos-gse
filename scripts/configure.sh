#!/bin/bash
set -e
source ./basescript.sh

printf "\nConfiguring Test4z...\n\n"
printf "Enter username: "
read USER_NAME
npx zowe config set profiles.lpar1.profiles.test4z.properties.hlq "$USER_NAME"
npx zowe config set --secure profiles.lpar1.profiles.test4z.properties.user "$USER_NAME"
npx zowe config set --secure profiles.lpar1.profiles.test4z.properties.password "$USER_NAME"
npx zowe config set --secure profiles.lpar1.profiles.zosmf.properties.user "$USER_NAME"
npx zowe config set --secure profiles.lpar1.profiles.zosmf.properties.password "$USER_NAME"
printf "\n#########################################"
printf "\n#### Test4z configuration successful ####"
printf "\n#########################################\n\n"

printf "Deploying the input file to the Mainframe\n\n"

hlq=$USER_NAME
tempDirectoryName="FILES_TEMP";
DOGGOS_INPUT="DOGGOS.INPUT";
DOGGOS_INPUT_NEW="DOGGOS.INPUT.NEW";
DOGGOS_RUNAPP="DOGGOS.RUNAPP"
storageClass="CAEDS6";
upload "$DOGGOS_INPUT" files/DOGGOS.INPUT DS N
printf "\n###########################################################"
printf "\n# Input dataset successfully deployed to the Z/OS system #"
printf "\n###########################################################\n"
