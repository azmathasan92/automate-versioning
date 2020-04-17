# automate-versioning

Version format should be version: 1.0.0

Increment Version
--------------------------------------------------
version: 1.0.0 -> version: 1.0.1 

version: 1.0.9 -> version: 1.1.0

version: 1.9.9 -> version: 1.10.0

This is an automation script to increment project version.


How Script Works:
----------------------------------------------------
* Get the current version from the file
* Increment the version
* Commit that version 
* push the new version to the repo

How to Run:
----------------------------------------------------

./versioning.sh {Filename which contain version} {git branch where you want to push}

For Example:

versioning.sh version master