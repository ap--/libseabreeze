# UNOFFICIAL libseabreeze builds #

Github clone of https://sourceforge.net/p/seabreeze for automated library
compilation.

This repository creates automated builds for windows and osx using appveyor and
travis-ci. Download [here](https://github.com/ap--/libseabreeze/releases).


## Windows ##

Download the correct msi isntaller, and install.

## OSX ##

Download the dmg file and copy the dylib to "/usr/local/lib".

## Linux ##

Download the Source Code archive and run "linux_install_libseabreeze.sh" and
"linux_install_udev_rules.sh".


## extra notes (ignore this) ##

The whole repository is a mess. The (_appveyor_, _travis_, _linux_) branches
contain the (appveyor, travis-ci, linux) configuration and scripts. With every
version increase of the seabreeze-library a new branch named "vX.Y.Z" gets
created and the three build branches get merged in. The last commit on this
branch gets tagged and starts the build process.

To sync with svn remote:

```
git svn fetch
git svn rebase
```
