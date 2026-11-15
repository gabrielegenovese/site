# Personal site

## Build

```sh
./build.sh
```

## Deploy

Every push to `main` builds the site and publishes the compiled output to the
`deploy` branch. The home server pulls that branch every 5 minutes through the
`cappuccino-ansible` playbook (`--tags deploy_site`).

Manual deploy on the server:

```sh
systemctl start site-deploy.service
```
