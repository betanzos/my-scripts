# Sources
https://github.com/kylemanna/docker-openvpn/blob/master/docs/docker-compose.md
https://github.com/pablokbs/peladonerd/tree/master/varios/6/README.md

# Installation process
## 1. Create the docker-compose.yaml file

```yaml
version: '2'
services:
  openvpn:
    image: kylemanna/openvpn
    container_name: openvpn
    cap_add:
     - NET_ADMIN
    ports:
     - "1194:1194/udp"
    restart: always
    volumes:
     - ./openvpn/data/conf:/etc/openvpn
```

## 2. Init the config files and certificates

```bash
docker compose run --rm openvpn ovpn_genconfig -u udp://<SERVER-IP-OR-DNS>
docker compose run --rm openvpn ovpn_genconfig
docker compose run --rm openvpn ovpn_initpki
```

## 3. Fix your permissions (may not be necessary if you are already doing everything with root)

```bash
sudo chown -R $(whoami): ./openvpn/data
```

## 4. Start the OpenVPN container

```bash
docker compose up -d
```

NOTE: You can see the logs using:

```bash
docker compose logs -f
```

## 5. Generate the client certificate

```bash
export CLIENTNAME="clinet-name"
# with password
docker compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
# without password
docker compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass
```

## 6. Export the client config file

```bash
docker compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
```

## BONUS

### List clients

```bash
docker compose run --rm openvpn ovpn_listclients
```

### Revoke the client certificate

```bash
# Keeping all files: crt, key and req
docker compose run --rm openvpn ovpn_revokeclient $CLIENTNAME
# Removing all files: crt, key and req
docker compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove
```
