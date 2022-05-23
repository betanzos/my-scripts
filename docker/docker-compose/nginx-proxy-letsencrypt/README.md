# Version 2 - HTTPS reverse proxy with path-based routing
The `docker-compose-v2.yaml` file define all requires configuration that allows us to use
a NGINX reverse proxy which use Let's Encrypt to automatically generate SSL certs for all
containers behind this proxy and enables path-based routing to these.

## Usage
1. Edit the environment variable `DEFAULT_EMAIL` under `acme-companion` service and set
your email as its value, so that Let's Encrypt can warn you about expiring certificates
and allow you to recover your account.

2. Add yours web containers. Current file contains two Apache2 web server containers
(`www1` and `www2` services) but you can add as many as you want. For each web server
service, we need to add the `VIRTUAL_HOST` and `LETSENCRYPT_HOST` environment variables
and set their values as a comma separated list of domains.

3. The environment variable `VIRTUAL_PATH` defines the path through which the service
can be accessed using the URL https://`VIRTUAL_HOST`/`VIRTUAL_PATH`.

4. The environment variable `VIRTUAL_DEST` can be used to rewrite the `VIRTUAL_PATH` part
of the requested URL to proxied application.

5. For each web server container, define an environment variable called `LETSENCRYPT_EMAIL`
and set your email as its value, so that Let's Encrypt can warn you about expiring certificates
and allow you to recover your account.

6. Run the following command: `$ docker-compose -f docker-compose-v2.yaml up -d`


# Version 1 - HTTPS reverse proxy (deprecated)
The `docker-compose.yaml` file define all requires configuration that allows us to use a 
NGINX reverse proxy which use Let's Encrypt to automatically generate SSL certs for all
containers behind this proxy.

## Usage
1. Edit the environment variable `DEFAULT_EMAIL` under `letsencrypt` service and set your
email as its value, so that Let's Encrypt can warn you about expiring certificates and
allow you to recover your account.

2. Add yours web containers. Current file contains only one NGINX web server container
(`www` service) but you can add as many as you want. For each web server service, we need
to add the `VIRTUAL_HOST` and `LETSENCRYPT_HOST` environment variables and set their values
as a comma separated list of domains.

3. For each web server container, define an environment variable called `LETSENCRYPT_EMAIL`
and set your email as its value, so that Let's Encrypt can warn you about expiring certificates
and allow you to recover your account.

4. Run the following command: `$ docker-compose up -d`