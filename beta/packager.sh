#!/bin/bash
echo "PackageGen running.."

#Defines
GIT_REPO_URL="https://github.com/SciencyScience/repo.git"
GIT_REPO_PASS="" #Put your github password here, don't worry, I don't want your login info.

#Metadata is grody
echo "Cleaning"
find . -name ".DS_Store" -print0 | xargs -0 rm -rf > /dev/null
find . -name "._*" -print0 | xargs -0 rm -rf > /dev/null

git pull

echo "Cleaning"
find . -name ".DS_Store" -print0 | xargs -0 rm -rf > /dev/null
find . -name "._*" -print0 | xargs -0 rm -rf > /dev/null

echo "Creating Packages file.."
dpkg-scanpackages -m . /dev/null >Packages
rm -f Packages.bz2
bzip2 Packages
rm -f Packages
DT=$(date "+[%m-%d-%Y][%H:%M:%S]");
M="Added Packages file from packager.sh on ${DT}"
echo  "Pushing with commit \"${M}\".";
git add --all;
git commit -m "${M}";
echo $GIT_REPO_PASS | git push --set-upstream origin master
