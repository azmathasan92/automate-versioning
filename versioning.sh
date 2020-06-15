#!/bin/bash

FileName=$1
SourceBranchType=""
IsMergeCommit=""

getMergeSourceBranch() {

commitMessage=$(git log origin/develop -1 --format=%B)

if [[ $(echo $commitMessage | grep 'feature/') != "" ]] ; then
  SourceBranchType="feature"
elif [[ $(echo $commitMessage | grep 'release/') != "" ]] ; then
  SourceBranchType="release" 
elif [[ $(echo $commitMessage | grep 'bugfix/') != "" || $(echo $commitMessage | grep 'patch/') != "" || $(echo $commitMessage | grep 'hotfix/') != "" ]] ; then
  SourceBranchType="build"
else
  echo "no need to update version"
fi

}

isMergeCommit() {

currentCommitId="\"$(git log --format="%H" -n 1)"\"
lastMergeCommitHash=$(git log origin/develop --merges -1 --pretty=format:\"%H\")

if [[ $currentCommitId == $lastMergeCommitHash ]] ; then
  IsMergeCommit="true"
else
  IsMergeCommit="false"
fi

}

bump_version() {

CURRENT_VERSION=$(grep Version $FileName | awk '{print $2}')
echo "Current Version: $CURRENT_VERSION"

major=$(echo $CURRENT_VERSION | awk -F. '{print $1}')
minor=$(echo $CURRENT_VERSION | awk -F. '{print $2}')
build=$(echo $CURRENT_VERSION | awk -F. '{print $3}')

if [[ $SourceBranchType =~ "release" ]] ; then
  major=$((major +1)) 
elif [[ $SourceBranchType =~ "feature" ]] ; then
  minor=$((minor +1)) 
elif [[ $SourceBranchType =~ "bugfix" || $SourceBranchType =~ "patch" || $SourceBranchType =~ "hotfix" ]] ; then
  build=$((build +1)) 
else
  echo "no need to update version"
fi

NEW_VERSION="${major}.${minor}.${build}"

echo "Release Version: $NEW_VERSION"

sed -i -e "s/^Version:.*/Version: $NEW_VERSION/" $FileName

git add $FileName
git commit -m "Update version to ${VERSION}"
git push origin develop

}

isMergeCommit

if [[ $IsMergeCommit == "true" ]] ; then
  getMergeSourceBranch
else
  echo "This is not a merge commit"
fi

if [[ $SourceBranchType != "" ]] ; then
  bump_version
fi
