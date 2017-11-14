# Nginx Conf Examples
Nginx configuration examples.

#### Configurations
- **8080-http.conf** - http server
- **8081-https.conf** - https server
- **8082-https-to-http.conf** - convert https request to http
- **8083-allow-deny.conf** - IP whitelist and blacklist
- **8084-lua-echo.conf** - lua `echo` directive
- **8085-lua-block.conf** - lua code block
- **8086-lua-auth.conf** - simple auth by verifying request header
- **8087-auth-request.conf** - auth by subrequest
- **8088-cors-api.conf** - allow CORS

#### Get Started
1. Install Nginx with lua support.
```
$ brew tap homebrew/nginx
$ brew install nginx-full --with-lua-module --with-echo-module --with-set-misc-module --with-auth-req
```
2. Run all tests.
```
$ ./run-tests.sh
```
3. Verify CORS in browser. (Optional)
```
$ ./start-nginx.sh
```
Access `http://localhost:8080/cors/` in browser.
If you can see `Hello World`, everything is going fine.
See `support/cors` for details.
