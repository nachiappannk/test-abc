#!/bin/bash

ref1=$1
ref2=$2

echo "Checking Version File is Modified"
numberOfFilesModified=$(git diff --name-only "$ref1..$ref2" | wc -l)
isVersionFileModified=$(git diff --name-only "$ref1..$ref2" version.txt | wc -l)


initialVersion=$(git show $ref1:version.txt)
finalVersion=$(git show $ref2:version.txt)
echo $initialVersion
echo $finalVersion


[ $numberOfFilesModified -gt 1 ] && [ $isVersionFileModified  -eq 1 ] &&  { echo 'Version file modified along with other files. To Change version, no other file should be modified' ; exit 1; }


if [ $isVersionFileModified  -eq 1 ]
then
  if (( $(echo "$initialVersion > $finalVersion" |bc -l) ))
  then
	echo 'Version number is not properly incremented'
	exit 1;
  fi
fi
