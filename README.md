# cloudflare-ddns-update
Custom K8s Cron Image to Update CloudFlare Record for DDNS

```bash
$ docker run --env-file ./.env --rm -it cloudflare-ddns-update:latest /cron/update-ddns.sh
```

Example of `.env` file:
```
AUTH_TOKEN=
CF_ZONE_ID=
CF_RECORD_ID=
CF_RECORD_NAME=
```
