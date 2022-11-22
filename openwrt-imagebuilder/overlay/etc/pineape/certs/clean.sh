#!/bin/bash
echo "[*] Removing certificates and associated files"
rm -fv *.pem
rm -fv *.der
rm -fv *.key
rm -fv *.crt
rm -fv *.csr
rm -fv index.txt*
rm -fv random
rm -fv serial*
rm -fv *.p12
./reset.sh
