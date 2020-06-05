#!/bin/bash

FILE_NAME=$1
BRANCH=$2

git checkout $BRANCH
if [ $? -ne 0 ]; then
  echo "FAILURE: Branch Does not exist"
  exit 1
fi

CURRENT_VERSION=$(grep Version $FILE_NAME | awk '{print $2}')

echo "Current Version: $CURRENT_VERSION"

major=$(echo $CURRENT_VERSION | awk -F. '{print $1}')
minor=$(echo $CURRENT_VERSION | awk -F. '{print $2}')
build=$(echo $CURRENT_VERSION | awk -F. '{print $3}')

if [[ $BRANCH =~ "release" ]] ; then
  major=$((major +1)) 
elif [[ $BRANCH =~ "feature" ]] ; then
  minor=$((minor +1)) 
elif [[ $BRANCH =~ "bugfix" || $BRANCH =~ "patch" || $BRANCH =~ "hotfix" ]] ; then
  build=$((build +1)) 
else
  echo "no need to update version"
fi

NEW_VERSION="${major}.${minor}.${build}"

echo "Release Version: $NEW_VERSION"

sed -i -e "s/^Version:.*/Version: $NEW_VERSION/" $FILE_NAME

git add $FILE_NAME
git commit -m "Update version to ${VERSION}"
git push origin $BRANCH
