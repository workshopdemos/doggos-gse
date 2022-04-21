#!/usr/bin/env bash
DEBUG=false

echo "CA Endevor Bridge for Git - Setup"

scripts_dir=$(
    cd "$(dirname "${BASH_SOURCE[0]}")"
    pwd -P
)
cd "$scripts_dir" || exit 1

echo "Installing pre-push hook"
GH_SETUP=../.git/gh-setup
GIT_URL_REGEX="^(http(s)?)(:\/\/)((([^\/:]+)(\:)([^\/:]+)(\@))|(([^\/:]+)(\@))?)([^\/:]+)\/(.+).git$"
## Application secure mode
PRE_PUSH_HOOK_AUTH="NONE"
if [ ! -f $GH_SETUP ]; then
    ############ Get username from remote url ##############
    if [[ (-z "$GITHUB_USER_LOGIN") && ("$PRE_PUSH_HOOK_AUTH" != "GIT_PERSONAL_ACCESS_TOKEN") ]]; then
        REMOTE_URL=$(git config --get remote.origin.url)
        $DEBUG && echo "DEBUG: Git remote url: $REMOTE_URL"

        if [[ $REMOTE_URL =~ $GIT_URL_REGEX ]]; then
            URL_PROTOCOL=${BASH_REMATCH[1]}
            URL_USER=${BASH_REMATCH[6]}
            GH_HOSTNAME=${BASH_REMATCH[13]}
            GITHUB_REPO_NAME=${BASH_REMATCH[5]}
            $DEBUG && echo "DEBUG: URL_PROTOCOL $URL_PROTOCOL HOSTNAME $GH_HOSTNAME URL_USER $URL_USER GITHUB_REPO_NAME $GITHUB_REPO_NAME"
        fi
        if [ ! -z "$URL_USER" ]; then
            $DEBUG && echo "DEBUG: Read Git username from clone URL: $URL_USER"
            GITHUB_USER_LOGIN=$URL_USER
        fi
    fi
    ########################################################
    ########## Get username with git gui prompt ############
    if [ -z "$GITHUB_USER_LOGIN" ]; then
        if [[ "$PRE_PUSH_HOOK_AUTH" == "GIT_PERSONAL_ACCESS_TOKEN" ]]; then
            GITHUB_USER_LOGIN=$(git gui--askpass "Please enter your Git personal access token:")
        else
            echo "Please enter your Git username: "
            GITHUB_USER_LOGIN=$(git gui--askpass "Please enter your Git username:")
        fi
        $DEBUG && echo "DEBUG: Read Git username from GIT GUI: $GITHUB_USER_LOGIN"
    fi
    ########################################################
    ############# Get username from stdin ##################
    if [ -z "$GITHUB_USER_LOGIN" ]; then
        exec </dev/tty
        read GITHUB_USER_LOGIN
        exec <&-
        $DEBUG && echo "DEBUG: Read Git username read from STDIN: $GITHUB_USER_LOGIN"
    fi
    if [ ! -z "$GITHUB_USER_LOGIN" ]; then
        echo "$GITHUB_USER_LOGIN" >"$GH_SETUP"
    fi
else
    GITHUB_USER_LOGIN=$(head -n 1 $GH_SETUP)
    echo "Settings detected. Git username is: $GITHUB_USER_LOGIN"
fi

mkdir -p ../.git/hooks || exit 1
cp resources/pre-push ../.git/hooks/pre-push || exit 1
chmod +x ../.git/hooks/pre-push || exit 1

echo "Pre-push hook installed successfully!"
