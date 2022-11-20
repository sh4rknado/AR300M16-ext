#!/bin/bash

rm ./tmp -rf
cp scripts/config .config
make V=s -j5
