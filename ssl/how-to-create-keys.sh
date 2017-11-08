#!/bin/bash

# Create private key without password and self-signed certificate.
# FQDN = 'localhost', leave others by default.
openssl req -x509 -nodes -days 36500 -newkey rsa:2048 -keyout nginx.key -out nginx.crt

