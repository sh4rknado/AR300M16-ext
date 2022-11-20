#!/bin/bash

rm ./tmp -rf
cp scripts/configuration .config
make V=s -j5
