#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

nginx -p $DIR -c $DIR/nginx.conf

