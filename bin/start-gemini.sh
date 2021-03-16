#!/bin/sh
agate --content ~/src/strahinja.srht.site --key ~/gemini/key.rsa \
	--cert ~/gemini/cert.pem --addr [::]:1965 --addr 0.0.0.0:1965 \
	--hostname localhost --lang en-US

