#!/bin/bash
set -e

hostname=35.245.180.49
protocol=https
port=1443
rejectUnauthorized=false

username="$1"

printf "\nDeploying the input file to the Mainframe\n\n"
zowe zos-files upload file-to-data-set scripts/files/DOGGOS.INPUT "$username".DOGGOS.INPUT --host "$hostname" --port "$port" --protocol "$protocol" --rejectUnauthorized "$rejectUnauthorized" --user "$username" --password "$username"
printf "\n# Input dataset successfully deployed to the Z/OS system #"
