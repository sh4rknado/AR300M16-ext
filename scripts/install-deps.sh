#!/bin/bash

sudo apt-get update
sudo apt-get install build-essential subversion libncurses5-dev zlib1g-dev gawk gcc-multilib flex git-core gettext libssl-dev

# updating feeds
./feeds update -a
./feeds install -a


