#!/bin/bash

make image \
     PROFILE="gl-ar300m" \
     FILES="overlay" \
     PACKAGES="python-logging python-openssl python-sqlite3 python-codecs"
