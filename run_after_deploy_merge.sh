#!/bin/bash

SBVERSION=$(git rev-parse --abbrev-ref HEAD)

# Add all files to project
SeaBreeze/os-support/windows/scripts/update-visual-studio-projects

# make new commit

git add SeaBreeze/os-support/windows/VisualStudio2005/VSProj/SeaBreeze.vcproj
git add SeaBreeze/os-support/windows/VisualStudio2015/VSProj/SeaBreeze.vcxproj
git add SeaBreeze/os-support/windows/VisualStudio2015/VSProj/SeaBreeze.vcxproj.filters
git commit -m "Hotfix visualstudio project files"

git tag -a libseabreeze-${SBVERSION} -m 'new libseabreeze version'

git push origin ${SBVERSION}
git push origin libseabreeze-${SBVERSION}
