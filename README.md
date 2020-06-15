# Automate Version Management

Version format should be Version: 1.0.0

Version Format [1.0.0] [major.minor.build]
--------------------------------------------------

When version will bump
-------------------------------------------------
1. If release branch merge on develop branch then it increment the major version
2. If feature branch merge on develop branch then it increment the minor version
3. If bugfix, patch, or hotfix branch merge on develop branch then it increment the build version


How Script Works:
----------------------------------------------------
* Get the current version from the file
* Check Develop commit is merge commit or not, if yes
* Then Get the merged source branch on develop 
* Bump the version as per the merged source branch
* Commit that version 
* push the new version to the develop branch

How to Run:
----------------------------------------------------

./versioning.sh {Filename that contain Version}

For Example:
versioning.sh version
