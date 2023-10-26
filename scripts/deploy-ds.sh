#!/bin/bash

LOCAL_DIR=/home/developer/doggos-gse/scripts/files

user=$(env | grep OWNER_EMAIL | sed 's/@.*//' | sed 's/^.*=//')
value="${user#mfwsuser}"
formatted_value=$(printf "%02d" $value)

USERN="CUST0$formatted_value"
USERL="cust0$formatted_value"
LSTPRF="LSTPRF$formatted_value"
RUNDOG="RUNDOG$formatted_value"
DBGDOG="DBGDOG$formatted_value"
NDDBGDOG="DOGGOS$formatted_value"

mkdir "$LOCAL_DIR/tmp"

sed "s|<USERN>|$USERN|g" "$LOCAL_DIR/jcl/DBGDOG.jcl" > "$LOCAL_DIR/tmp/DBGDOG.jcl"
sed -i "s|<DBGDOG>|$DBGDOG|g" "$LOCAL_DIR/tmp/DBGDOG.jcl"

sed "s|<LSTPRF>|$LSTPRF|g" "$LOCAL_DIR/jcl/LSTPRF.jcl" > "$LOCAL_DIR/tmp/LSTPRF.jcl"

sed "s|<RUNDOG>|$RUNDOG|g" "$LOCAL_DIR/jcl/RUNDOG.jcl" > "$LOCAL_DIR/tmp/RUNDOG.jcl"

#Endevor files----
sed "s|<USERN>|$USERN|g" "$LOCAL_DIR/jcl/NDDBGDOG.jcl" > "$LOCAL_DIR/tmp/NDDBGDOG.jcl"
sed -i "s|<NDDBGDOG>|$NDDBGDOG|g" "$LOCAL_DIR/tmp/NDDBGDOG.jcl"
sed -i "s|<DBGDOG>|$DBGDOG|g" "$LOCAL_DIR/tmp/NDDBGDOG.jcl"

sed "s|<NDDBGDOG>|$NDDBGDOG|g" "$LOCAL_DIR/jcl/NDRUNDOG.jcl" > "$LOCAL_DIR/tmp/NDRUNDOG.jcl"
sed -i "s|<RUNDOG>|$RUNDOG|g" "$LOCAL_DIR/tmp/NDRUNDOG.jcl"
#Endevor files----

zowe files delete data-set "$USERN.PUBLIC.JCL" -f
zowe files delete data-set "$USERN.PUBLIC.INPUT" -f

# # Remove artifacts
zowe uss iss ssh "rm -r /u/users/$USERL/doggos"
zowe files delete data-set "$USERN.DOGGOS.COPYBOOK" -f
zowe files delete data-set "$USERN.PUBLIC.LOADLIB" -f
zowe files delete data-set "$USERN.PUBLIC.PROFLIB" -f

zowe files delete data-set-vsam "$USERN.PUBLIC.PROTSYM" -f

zowe files cre pds "$USERN.PUBLIC.JCL"
zowe files ul dtp "$LOCAL_DIR/tmp" "$USERN.PUBLIC.JCL"
zowe files cre data-set-sequential "$USERN.PUBLIC.INPUT"
zowe files ul ftds "$LOCAL_DIR/DOGGOS.INPUT" $USERN.PUBLIC.INPUT

rm -r "$LOCAL_DIR/tmp"

export PATH="$PATH:/home/developer/sandbox-env/syncz_v1.11.0/bin/linux_amd64/"
syncz -c "bldz"
zowe uss iss ssh "rm -r /u/users/$USERL/doggos"
#zowe files delete data-set "$USERN.PUBLIC.LOADLIB(DOGGOS)" -f

