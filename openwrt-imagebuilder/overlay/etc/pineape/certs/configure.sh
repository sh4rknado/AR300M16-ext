#!/bin/bash

cd "$(dirname $0)"

# Sane defaults
password="pineapplesareyummy"
country="US"
state="California"
locality="Oakland"
organization="Hak5 LLC"
email="bounce@hak5.org"
commonname="WiFi Pineapple Cetificate Authority"

setconfigopt() {
    key=$1
    val=$2
    file=$3
    line=$4
    if [[ -z $line || -z $file ]]; then
        for f in ca.cnf client.cnf server.cnf; do
            sed -i '/dev/null' -e 's/\('"$key"'[[:space:]]*\=[[:space:]]*\).*\s*/\1'"$val"'/g' "$f"
        done
    else
        sed -i '/dev/null' -e "$line"'s/\('"$key"'[[:space:]]*\=[[:space:]]*\).*\s*/\1'"$val"'/g' "$file"
    fi
}

while getopts ":p:c:s:l:o:e:n:" opt; do
  case ${opt} in
    p )
      password=$OPTARG
      ;;
    c )
      country=$OPTARG
      ;;
    s )
      state=$OPTARG
      ;;
    l )
      locality=$OPTARG
      ;;
    o )
      organization=$OPTARG
      ;;
    e )
      email=$OPTARG
      ;;
    n )
      commonname=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))

./reset.sh

echo "[-] Password (-p): $password"
echo "[-] Country (-c): $country"
echo "[-] State/province (-s): $state"
echo "[-] Locality (-l): $locality"
echo "[-] Organization (-o): $organization"
echo "[-] Email (-e): $email"
echo "[-] Common name (-n): $commonname"

echo "[*] Writing configuration"
setconfigopt "input_password" "$password"
setconfigopt "output_password" "$password"
setconfigopt "countryName" "$country" ca.cnf 50
setconfigopt "countryName" "$country" server.cnf 48
setconfigopt "countryName" "$country" client.cnf 48
setconfigopt "stateOrProvinceName" "$state" ca.cnf 51
setconfigopt "stateOrProvinceName" "$state" server.cnf 49
setconfigopt "stateOrProvinceName" "$state" client.cnf 49
setconfigopt "localityName" "$locality" ca.cnf 52
setconfigopt "localityName" "$locality" server.cnf 50
setconfigopt "localityName" "$locality" client.cnf 50
setconfigopt "organizationName" "$organization" ca.cnf 53
setconfigopt "organizationName" "$organization" server.cnf 51
setconfigopt "organizationName" "$organization" client.cnf 51
setconfigopt "emailAddress" "$email" ca.cnf 54
setconfigopt "emailAddress" "$email" server.cnf 52
setconfigopt "emailAddress" "$email" client.cnf 52
setconfigopt "commonName" "$commonname" ca.cnf 55
setconfigopt "commonName" "$commonname" server.cnf 53
setconfigopt "commonName" "$commonname" client.cnf 53
echo "[+] Configuration complete"

rm -f *.bak
