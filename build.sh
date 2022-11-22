#!/bin/bash

# clean all old files
rm ./tmp -rf
git clean -xfd

# Making files
cp scripts/configurations .config
make V=s -j5
