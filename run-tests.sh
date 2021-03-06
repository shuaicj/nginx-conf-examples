#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function test
{
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NONE='\033[0m'

    if [ $(echo "$2" | grep "$3" | wc -l) -gt 0 ]; then
        echo -e " ${GREEN}Passed: ${NONE}$1"
    else
        echo -e " ${RED}Failed: ${NONE}$1"
    fi
}

# start nginx
sh $DIR/start-nginx.sh

# tests
test "http server"   "$(curl -v http://localhost:8080 2>&1)" "200 OK"
test "https server"  "$(curl -v --cacert $DIR/ssl/nginx.crt https://localhost:8081 2>&1)" "200 OK"
test "https to http" "$(curl -v --cacert $DIR/ssl/nginx.crt https://localhost:8082 2>&1)" "200 OK"
test "allow" "$(curl -v http://127.0.0.1:8083 2>&1)" "200 OK"
test "deny"  "$(curl -v http://localhost:8083 2>&1)" "403 Forbidden"
test "lua echo"  "$(curl -v http://localhost:8084 2>&1)" "Hello World"
test "lua block" "$(curl -v http://localhost:8085 2>&1)" "Hello World"
test "lua auth unauthorized" "$(curl -v http://localhost:8086 2>&1)" "401 Unauthorized"
test "lua auth forbidden"    "$(curl -v -H 'USERNAME: shuaicj' http://localhost:8086 2>&1)" "403 Forbidden"
test "lua auth ok"           "$(curl -v -H 'USERNAME: admin' http://localhost:8086 2>&1)" "200 OK"
test "auth request unauthorized" "$(curl -v http://localhost:8087 2>&1)" "401 Unauthorized"
test "auth request forbidden"    "$(curl -v -H 'USERNAME: shuaicj' http://localhost:8087 2>&1)" "403 Forbidden"
test "auth request ok"           "$(curl -v -H 'USERNAME: admin' http://localhost:8087 2>&1)" "200 OK"
test "cors regular deny"   "$(curl -v -H 'Origin: http://localhost:9090' http://localhost:8088/api/ 2>&1)" "CORS deny"
test "cors regular ok"     "$(curl -v -H 'Origin: http://localhost:8080' http://localhost:8088/api/ 2>&1)" "Access-Control-Allow-Origin"
test "cors preflight deny" "$(curl -v -X OPTIONS -H 'Origin: http://localhost:9090' http://localhost:8088/api/ 2>&1)" "CORS deny"
test "cors preflight ok"   "$(curl -v -X OPTIONS -H 'Origin: http://localhost:8080' http://localhost:8088/api/ 2>&1)" "Access-Control-Allow-Origin"

# stop nginx
sh $DIR/stop-nginx.sh
