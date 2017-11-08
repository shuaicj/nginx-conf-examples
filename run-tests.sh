#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function test
{
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NONE='\033[0m'

    if [ $(echo $2 | grep '200 OK' | wc -l) -gt 0 ]; then
        echo -e " ${GREEN}Passed: ${NONE}$1"
    else
        echo -e " ${RED}Failed: ${NONE}$1"
    fi
}

# start nginx
nginx -c $DIR/nginx.conf

# tests
test "http server" "$(curl -v http://localhost:8080 2>&1)"
test "https server" "$(curl -v --cacert $DIR/ssl/nginx.crt https://localhost:8081 2>&1)"
test "https to http" "$(curl -v --cacert $DIR/ssl/nginx.crt https://localhost:8082 2>&1)"

# stop nginx
nginx -s stop
