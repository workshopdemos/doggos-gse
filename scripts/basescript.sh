#!/bin/bash
set -e
#***********************************
#Bash file for Automation methods.
#***********************************
upload(){
  dataset=${hlq}.${1}
  path=${2}
  type=${3}
  replace=${4}

  printf "Removing the already existing dataset\n"

  tempPath="$tempDirectoryName"/"$path"

  deleteDataset "$dataset"
#--Dataset creation START
  if [ "$type" == 'PDS' ]
  then
    createPDS "$dataset"
  fi

  if [ "$type" == 'DS' ]
  then
   createDS "$dataset"
  fi
#--Dataset creation END

#--Upload (without text replacement) START
  if [ "$replace" == 'N' ]
  then
    if [ "$type" == 'PDS' ]
    then
      uploadToPDS "$path" "$dataset"
    fi
    if [ "$type" == 'DS' ]
    then
      uploadToDS "$path" "$dataset"
    fi
  fi
#--Upload END
}
createPDS(){
  dataset=${1}
  if npx zowe zos-files create data-set-partitioned "$dataset" --storage-class "$storageClass"; then
      printf "\nCreating PDS dataset is succeeded for: %s \n" "$dataset"
  else
      errorMessage "$dataset" "Creating PDS dataset is failed for: "
  fi
}
createDS(){
  dataset=${1}
  if npx zowe zos-files create data-set-sequential "$dataset" --storage-class "$storageClass"; then
    printf "\nCreating dataset is succeeded for: %s \n" "$dataset"
  else
    errorMessage "$dataset" "Creating dataset is failed for: "
  fi
}
deleteDataset(){
 dataset=${1}
 datasetCheck=$(npx zowe zos-files list data-set "$dataset")
 if [ ! -z "$datasetCheck" ]; then
    npx zowe zos-files delete data-set "$dataset" -f || true
 fi
}
uploadToDS(){
  _path=${1}
  _dataset=${2}

  if npx zowe zos-files upload file-to-data-set "$_path" "$_dataset"; then
      printf "\nUpload dataset %s is succeeded\n" "$_dataset"
  else
      errorMessage "$_dataset" "Dataset upload failed for: "
  fi
}
