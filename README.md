
[![Travis](https://img.shields.io/travis/ap--/libseabreeze.svg?label=osx)](https://travis-ci.org/ap--/libseabreeze)
[![AppVeyor](https://img.shields.io/appveyor/ci/ap--/libseabreeze.svg?label=windows)](https://ci.appveyor.com/project/ap--/libseabreeze)
[![CircleCI](https://img.shields.io/circleci/project/github/ap--/libseabreeze.svg?label=linux)](https://circleci.com/gh/ap--/libseabreeze)


# libseabreeze

Github clone of [SeaBreeze](https://sourceforge.net/p/seabreeze) for building seabreeze shared library used as backend in [python-seabreeze](https://github.com/ap--/python-seabreeze).

**If you arrived here looking for how to run your spectrometer, you're definitely wrong.**

## Notes to future self ##

To start a new build:
 1. `git svn fetch`
 2. create a branch at the commit you want to build:
     - stick to OceanOptics versioning, but extend in-between builds, i.e. 3.0.10.X
 3. merge deploy branch into the created branch.
     - `git merge deploy --allow-unrelated-histories`
 4. ./run_after_deploy_merge.sh
 5. done.

