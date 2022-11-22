#!/bin/bash
umask 027
cd "$(dirname $0)"
if [ ! -f random ]; then
	ln -sf /dev/urandom random
fi
if [ ! -f server.key ]; then
	openssl req -new -out /etc/pineape/certs/server.csr -newkey rsa:2048 -nodes -keyout /etc/pineape/certs/server.key -config /etc/pineape/certs/server.cnf
fi
if [ ! -f ca.key ]; then
	openssl req -new -x509 -keyout /etc/pineape/certs/ca.key -out /etc/pineape/certs/ca.pem -days "$(grep default_days /etc/pineape/certs/ca.cnf | sed 's/.*=//;s/^ *//')" -config /etc/pineape/certs/ca.cnf
fi
if [ ! -f index.txt ]; then
	touch index.txt
fi
if [ ! -f serial ]; then
	echo '01' > /etc/pineape/certs/serial
fi
if [ ! -f server.crt ]; then
	openssl ca -batch -keyfile /etc/pineape/certs/ca.key -cert /etc/pineape/certs/ca.pem -in /etc/pineape/certs/server.csr  -key "$(grep output_password /etc/pineape/certs/ca.cnf | sed 's/.*=//;s/^ *//')" -out /etc/pineape/certs/server.crt -extensions xpserver_ext -extfile xpextensions -config /etc/pineape/certs/server.cnf
fi
if [ ! -f server.p12 ]; then
	openssl pkcs12 -export -in /etc/pineape/certs/server.crt -inkey /etc/pineape/certs/server.key -out /etc/pineape/certs/server.p12  -passin pass:"$(grep output_password /etc/pineape/certs/server.cnf | sed 's/.*=//;s/^ *//')" -passout pass:"$(grep output_password /etc/pineape/certs/server.cnf | sed 's/.*=//;s/^ *//')"
fi
if [ ! -f server.pem ]; then
	openssl pkcs12 -in /etc/pineape/certs/server.p12 -out /etc/pineape/certs/server.pem -passin pass:"$(grep output_password /etc/pineape/certs/server.cnf | sed 's/.*=//;s/^ *//')" -passout pass:"$(grep output_password /etc/pineape/certs/server.cnf | sed 's/.*=//;s/^ *//')"
	openssl verify -CAfile /etc/pineape/certs/ca.pem /etc/pineape/certs/server.pem
fi
if [ ! -f ca.der ]; then
	openssl x509 -inform PEM -outform DER -in /etc/pineape/certs/ca.pem -out /etc/pineape/certs/ca.der
fi
if [ ! -f client.key ]; then
	openssl req -new -out /etc/pineape/certs/client.csr -keyout /etc/pineape/certs/client.key -config /etc/pineape/certs/client.cnf
fi
if [ ! -f client.crt ]; then
	openssl ca -batch -keyfile /etc/pineape/certs/ca.key -cert /etc/pineape/certs/ca.pem -in /etc/pineape/certs/client.csr  -key "$(grep output_password /etc/pineape/certs/ca.cnf | sed 's/.*=//;s/^ *//')" -out /etc/pineape/certs/client.crt -extensions xpclient_ext -extfile xpextensions -config /etc/pineape/certs/client.cnf
fi
