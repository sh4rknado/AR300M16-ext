#!/bin/bash

rm ./tmp -rf
cp scripts/configurations .config
make V=s -j5
