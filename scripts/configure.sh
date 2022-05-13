#!/bin/bash
set -e
printf "\nConfiguring Test4z...\n\n"
npx zowe config set profiles.lpar1.profiles.test4z.properties.hlq "$1"
npx zowe config set profiles.lpar1.profiles.test4z.properties.user "$1"
npx zowe config set profiles.lpar1.profiles.test4z.properties.password "$1"
npx zowe config set profiles.lpar1.profiles.zosmf.properties.user "$1"
npx zowe config set profiles.lpar1.profiles.zosmf.properties.password "$1"
printf "\n#### Test4z configuration successful ####"
