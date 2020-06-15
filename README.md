# automate-versioning

Version format should be Version: 1.0.0

Version Format [1.0.0] [major.minor.build]
--------------------------------------------------
Major Version 

Minior Version

Build Version

Process
--------------------------------------------------
1. When branch is release then this script will increment the major version.
2. When branch is feature then this script will increment the minor version.
3. Whne branch is bugfix, patch or hotfix then this script will increment the build version.


How Script Works:
----------------------------------------------------
* Get the current version from the file
* Increment the version as per the branching startegy
* Commit that version 
* push the new version to the repo

How to Run:
----------------------------------------------------

./versioning.sh {Filename that contain Version} {git branch for the versioning}

For Example:
versioning.sh version release-v1.0 # Will increment the major version
versioning.sh version feature/test # Will increment the minior version
versioning.sh version patch # Will increment the build version
