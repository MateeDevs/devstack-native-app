#!/bin/bash


#TODO change
APPLICATION_ID=$1

DEFAULT_APPLICATION_ID="cz.matee.devstack" # default application id
DEFAULT_APPLICATION_PATH=`echo $DEFAULT_APPLICATION_ID | tr -s "." "/"`
DEFAULT_APPLICATION_START_PATH=`echo $DEFAULT_APPLICATION_ID | cut -d"." -f1`

function moveFiles(){
	TMP_FOLDER="./tmp"
	FROM_FOLDER=$1
	FROM_BASE_FOLDER=$2
	TO_FOLDER=$3
	mkdir -p ${TMP_FOLDER} #create tmp dir

	#move all files to tmp dir and delete origin dir
	cp -r ${FROM_FOLDER}/* ${TMP_FOLDER}/
	rm -rf ${FROM_BASE_FOLDER}

	#create new dir and move files from tmp dir
	mkdir -p $TO_FOLDER
	cp -r ${TMP_FOLDER}/* ${TO_FOLDER}/
	rm -rf ${TMP_FOLDER}
}

function refactorStage(){
	MODULE=$1
	STAGE=$2
	echo "| "
	echo "| refactoring stage ***$STAGE***"

	PREFIX="./$MODULE/src"
	SUFFIX="/$MODULE"

	DEFAULT_FOLDER=`echo $DEFAULT_APPLICATION_PATH | sed -e "s|^|${PREFIX}/${STAGE}/kotlin/|" -e "s|$|${SUFFIX}|"`
	DEFAULT_START_FOLDER=`echo $DEFAULT_APPLICATION_START_PATH | sed -e "s|^|${PREFIX}/${STAGE}/kotlin/|"`
	NEW_FOLDER=`echo $BASE_APPLICATION_PATH | sed -e "s|^|${PREFIX}/${STAGE}/kotlin/|" -e "s|$|${SUFFIX}|"`
	echo "| process ->"
	echo "| from: $DEFAULT_FOLDER"
	echo "| to: $NEW_FOLDER"
	echo "| folder to delete: $DEFAULT_START_FOLDER"
	moveFiles ${DEFAULT_FOLDER} ${DEFAULT_START_FOLDER} ${NEW_FOLDER}
}

function refactorModule(){
	echo "+--------------------------------------------------------------+"
	local MODULE=$1
	shift
	local STAGES=("$@")
	echo "| Changing module `echo "$MODULE" | tr a-z A-Z`"

   	for stage in "${STAGES[@]}";
      	do
          refactorStage $MODULE $stage
      	done

	echo "| done..."
	echo "+--------------------------------------------------------------+"
}

function replaceApplicationId(){
	FROM_APP_ID=$1
	TOP_APP_ID=$2
	find . -not \( -path '*/\.*' -o -path '*/build/*' \) -type f \( -name "*.xml" -o -name "*.kt" -o -name "*.java" -o -name "*.gradle" -o -name "*.kts" \) -print | xargs sed -i '' -e "s|${FROM_APP_ID}|${TOP_APP_ID}|g"
}

while [ $# -gt 0 ]; do
  case "$1" in
    --applicationId=*)
      APPLICATION_ID="${1#*=}"
      ;;
    --defaultApplicationId=*)
      DEFAULT_APPLICATION_ID="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument.*\n"
      printf "* --applicationId         *\n"
      printf "* --defaultApplicationId  *\n"
      printf "***************************\n"
      exit 1
  esac
  shift
done

if [ -z "$APPLICATION_ID" ]; then
	echo "Please specify --applicationId argument."
	exit 1
fi

BASE_APPLICATION_PATH=`echo $APPLICATION_ID | tr -s "." "/"`
echo "+--------------------------------------------------------------+"
echo "| default applicationId = $DEFAULT_APPLICATION_ID"
echo "| new applicationId = $APPLICATION_ID                          "
echo "| new base path = $BASE_APPLICATION_PATH                       "
echo "+--------------------------------------------------------------+"

read -p "Do you wish to refactor project wit specified applicationIds? [Yes|No]: " answer
case ${answer:0:1} in
    y|Y|yes|Yes|YES )
        echo "Continue..."
    ;;
    * )
        echo "Canceling..."
        exit 1
    ;;
esac

MODULE="core"
STAGES=("androidMain" "androidTest" "commonMain" "iosMain" "main")
refactorModule $MODULE "${STAGES[@]}"

MODULE="app"
STAGES=("main" "test" "release" "androidTest")
refactorModule $MODULE "${STAGES[@]}"


replaceApplicationId $DEFAULT_APPLICATION_ID $APPLICATION_ID





