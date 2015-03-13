#!/bin/bash
echo -e "# SEABREEZE: building shared library"
cd SeaBreeze
make lib/libseabreeze.so
cd ..

echo -e "# SEABREEZE: installing to /usr/local/lib"
sudo install SeaBreeze/lib/libseabreeze.so /usr/local/lib/
