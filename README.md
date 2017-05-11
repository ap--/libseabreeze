# libseabreeze

Github clone of [SeaBreeze](https://sourceforge.net/p/seabreeze) for building seabreeze shared library used as backend in [python-seabreeze](https://github.com/ap--/python-seabreeze).

**If you arrived here looking for how to run your spectrometer, you're definitely wrong.**

## Notes to future self (ignore this) ##

To start a new build:
 1. `git svn fetch`
 2. create a branch at the commit you want to build:
     - stick to OceanOptics versioning, but extend in-between builds, i.e. 3.0.10.X
 3. merge deploy branch into the created branch.
 4. create tag called, i.e. `libseabreeze-3.0.10.X`
 5. done.

