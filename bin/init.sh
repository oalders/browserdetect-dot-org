#!/bin/sh

# set up init scripts

NAME=browser-detect-dot-org

carton exec -- bin/daemon-control.pl get_init_file > $NAME
chmod 755 $NAME
sudo chown root.root $NAME
sudo mv $NAME /etc/init.d/
sudo update-rc.d browser-detect-dot-org defaults
