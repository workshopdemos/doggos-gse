set -e

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
printf "\n#########################################"
