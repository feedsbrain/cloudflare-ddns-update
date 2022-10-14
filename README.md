# cloudflare-ddns-update
Custom K8s Cron Image to Update CloudFlare Record for DDNS

```bash
$ docker run --env-file ./.env --rm -it feedsbrain/cloudflare-ddns-update:latest /bin/bash -c /cron/update-ddns.sh
```

Example of `.env` file:
```
AUTH_TOKEN=<cloudflare auth token>
CF_ZONE_ID=<zone id>
CF_RECORD_TYPE=<record type (optional, default = A)>
CF_RECORD_ID=<record id to update>
CF_RECORD_NAME=<subdomain name>
CF_RECORD_TTL=<record ttl (optional, default = 300)>
CF_PROXY_ENABLE=<proxied (optional, default = false)>
```
