#!/bin/bash

SBVERSION=$(git rev-parse --abbrev-ref HEAD)

SBPATH="SeaBreeze/os-support/windows"

# Add all files to project
SeaBreeze/os-support/windows/scripts/update-visual-studio-projects

cp ${SBPATH}/VisualStudio2010/SeaBreeze.sln ./SB.sln
sed '1s/11.0/10.0/' ./SB.sln > ${SBPATH}/VisualStudio2010/SeaBreeze.sln

# make new commit
git add SeaBreeze/os-support/windows/VisualStudio2005/VSProj/SeaBreeze.vcproj
git add SeaBreeze/os-support/windows/VisualStudio2010/SeaBreeze.sln
git add SeaBreeze/os-support/windows/VisualStudio2010/VSProj/SeaBreeze.vcxproj
git add SeaBreeze/os-support/windows/VisualStudio2010/VSProj/SeaBreeze.vcxproj.filters
git add SeaBreeze/os-support/windows/VisualStudio2015/VSProj/SeaBreeze.vcxproj
git add SeaBreeze/os-support/windows/VisualStudio2015/VSProj/SeaBreeze.vcxproj.filters
git commit -m "Hotfix visualstudio project files"

git tag -a libseabreeze-${SBVERSION} -m 'new libseabreeze version'

git push origin ${SBVERSION}
git push origin libseabreeze-${SBVERSION}
