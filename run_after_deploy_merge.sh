#!/bin/bash

SBVERSION=$(git rev-parse --abbrev-ref HEAD)

# Add all files to project
SeaBreeze/os-support/windows/scripts/update-visual-studio-projects

# make new commit
git add SeaBreeze/os-support/windows/VisualStudio2005/VCProj/*
git add SeaBreeze/os-support/windows/VisualStudio2015/VCProj/*
git commit -m "Hotfix visualstudio project files"

git tag -a libseabreeze-${SBVERSION}

git push origin ${SBVERSION}
git push origin libseabreeze-${SBVERSION}
