#!/bin/bash

SBVERSION=$(git rev-parse --abbrev-ref HEAD)

SBPATH="SeaBreeze/os-support/windows"

echo "Patching vc9 compatibility"
git am --ignore-whitespace --signoff 0001-vc9-if-false-is-incompatible.-Fatal-Error-C1017.patch
git am --ignore-whitespace --signoff 0002-vc9-vector.data-not-supported.patch
git am --ignore-whitespace --signoff 0003-vc9-Fix-snprintf-not-defined.patch
git am --ignore-whitespace --signoff 0004-Providing-VisualStudio2008-sln-for-python2.7-builds.patch

# Add all files to project
echo "Updating project resources"
SeaBreeze/os-support/windows/scripts/update-visual-studio-projects

# make new commit
echo "commiting updated resources"
git add SeaBreeze/os-support/windows/VisualStudio2008/VSProj/SeaBreeze.vcproj
git add SeaBreeze/os-support/windows/VisualStudio2015/VSProj/SeaBreeze.vcxproj
git add SeaBreeze/os-support/windows/VisualStudio2015/VSProj/SeaBreeze.vcxproj.filters
git commit -m "Hotfix visualstudio project files"

echo "tag"
git tag -a libseabreeze-${SBVERSION} -m 'new libseabreeze version'

echo "push"
echo "git push origin ${SBVERSION}"
echo "git push origin libseabreeze-${SBVERSION}"
