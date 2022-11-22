#!/bin/bash

# clean all old files
rm ./tmp -rf
git clean -xfd

# Making files
./scripts/feeds update -a
./scripts/feeds install -a

cp scripts/configurations .config
make V=s -j5
