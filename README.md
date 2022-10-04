# cloudflare-ddns-update
Custom K8s Cron Image to Update CloudFlare Record for DDNS

```bash
$ docker run --env-file ./.env --rm -it feedsbrain/cloudflare-ddns-update:latest /bin/bash -c /cron/update-ddns.sh
```

Example of `.env` file:
```
AUTH_TOKEN=<cloudflare auth token>
CF_ZONE_ID=<cloudflare zone id>
CF_RECORD_ID=<cloudflare record id to update>
CF_RECORD_NAME=<cloudflare subdomain name>
```
