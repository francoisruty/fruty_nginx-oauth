This tutorial explains how to use an oauth proxy with Nginx, to secure your internal services.

This refers to https://fruty.io/2018/04/16/protecting-your-internal-services-with-nginx-and-oauth2/

### Install Docker and Docker-compose

Install Docker and Docker-compose, just follow the official procedures.

### Choose a domain name

Google Oauth client require to specify authorized origin domain names.
This is a dev environment, so in order not to bother setting up a real domain name, just edit
your /etc/hosts (OsX and Linux, use the equivalent on Windows) and add this record:
127.0.0.1 tuto.com

Now if on your computer you try to access tuto.com, all traffic will be forwarded on your local port 80 by your computer.

### Set up your google oauth client

First of all, go to your google cloud console (create an account if you don't have one), go to
"APIs & Services" and then "Credentials".
Click on "create credentials" and on "Oauth client id".

NOTE: you can also google your way around to create a google oauth client, it's not complicated.

For both authorized javascript origins, enter:
http://tuto.com
It will ask you to enter this domain in your list of authorized domains (configurable in an adjacent menu in your google console), do it.

For authorized redirect URIs, enter:
http://tuto.com
http://tuto.com/oauth2/callback

You will be prompted with your Oauth2 client id and secret, write them down in the .env file.

### Adapt .env

Edit the EMAIL_DOMAIN and COOKIE_SECRET parameters in .env


### Test
In your browser, go to http://tuto.com
You should be redirected to Oauth login screen, and upon successful login, be redirected to a "hello world" white page (our index.html)

If you want to use another domain name, change your /etc/hosts, change server name in example.conf, change REDIRECT_URL in .env, and change the URIs configured in your oauth client in Google console.

### NOTES
This is a dev setup.
When you deploy this in production, always use https and remove the "--cookie-secure=false" option from docker-compose.yml authproxy block "command" section.

In docker-compose.yml:
--upstream refers to where the user will be taken after successful auth.
--http-address refers to where the oauth proxy binary listens to, inside its docker container.

Also, don't forget that docker ports binding that do not specify a network interface usually pierce your local firewall.
