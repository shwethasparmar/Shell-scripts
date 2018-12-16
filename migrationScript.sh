#!/bin/bash
echo "-----------------------Enter old repo url-----------------------"
read oldRepoUrl
echo "-----------------------Enter new repo url-----------------------"
read newRepoUrl
echo "-----------------------CLONING OLD GIT REPO-----------------------"
git clone "$oldRepoUrl"
echo "-----------------------FETCHING FROM OLD GIT REPO-----------------------"
urlRe='https://github.homedepot.com/(.*)/(.*).git'
if [[ $oldRepoUrl =~ $urlRe ]]
	then
	folderName=${BASH_REMATCH[2]}
	cd $folderName
	git fetch origin
	echo "-----------------------CHECKING OUT ALL BRANCHES FROM OLD GIT REPO-----------------------"
	branchRe='remotes/origin/(.*)'
	for eachBranch in $(git branch -a); do
 		if [[ $eachBranch =~ remotes/origin/(.*) ]]
 			then git checkout ${BASH_REMATCH[1]}
 		fi
	done
	echo "-----------------------ALL THE LOCAL BRANCHES-----------------------"
	git branch -a

fi

echo "-----------------------MOVING TO THE NEW REPO-----------------------"
git remote add new-origin "$newRepoUrl"
git push --all "$newRepoUrl"
git push --tags "$newRepoUrl"
git remote -v
git remote rm origin
git remote rename new-origin origin
echo "-----------------------DONE SUCCESSFULLY-----------------------"