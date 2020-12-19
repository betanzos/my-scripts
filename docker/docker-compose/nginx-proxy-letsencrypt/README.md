# Description
The `docker-compose.yml` file define all requires configuration that allows us to use and NGINX proxy which use Let's Encrypt to automatically generate SSL certs for all containers behind this proxy.

# Usage
1. Edit the environment variable `DEFAULT_EMAIL` under `letsencrypt` service and set your email as its value, so that Let's Encrypt can warn you about expiring certificates and allow you to recover your account.

2. Add yours web containers. Current file contains only one NGINX web server container (`www` service) but you can add as many as you want. For each web server service, we need to add the `VIRTUAL_HOST` and `LETSENCRYPT_HOST` environment variables and set their values as a comma separated list of domains.

3. For each web server container, define an environment variable called `LETSENCRYPT_EMAIL` and set your email as its value, so that Let's Encrypt can warn you about expiring certificates and allow you to recover your account.

4. Run the following command: `$ docker-compose up -d`