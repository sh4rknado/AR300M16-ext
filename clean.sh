#!/bin/bash

# clean all old files
rm -rfv ./tmp
rm -rfv openwrt-imagebuilder
rm -rfv staging_dir/
rm -rfv  bin/
rm -rfv build_dir/
rm -rfv dl/
rm -rfv key-build*

git clean -xfd

