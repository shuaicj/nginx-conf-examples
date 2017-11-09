# Nginx Conf Examples
Nginx configuration examples.

#### Configurations
- **http.conf** - http server
- **https.conf** - https server
- **https-to-http.conf** - convert https request to http
- **allow-deny.conf** - IP whitelist and blacklist
- **lua-echo.conf** - lua `echo` directive
- **lua-block.conf** - lua code block
- **lua-auth.conf** - simple auth by verifying request header

#### Get Started
1. Install Nginx with lua support.
> `$ brew tap homebrew/nginx`
> `$ brew install nginx-full --with-lua-module --with-echo-module --with-set-misc-module`
2. Run all tests.
> `$ ./run-tests.sh`
