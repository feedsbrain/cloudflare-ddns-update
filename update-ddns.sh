#!/bin/bash

# read from .env if exist
if test -f ".env"; then
    source .env
fi

# execute only when all required environment variables exist
if [[ -z $AUTH_TOKEN || -z $CF_ZONE_ID || -z $CF_RECORD_ID || -z $CF_RECORD_NAME ]]; then
  echo "--------------------------------------------"
  echo "Required environment variable is not set ..."
  echo "--------------------------------------------"
else
  DDNS_IP_ADDRESS="$(curl -s ifconfig.me)"
  CF_API_URL="https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/dns_records/$CF_RECORD_ID"

  # generating post request data
  generate_post_data()
  {
cat <<EOF
  {
    "type":"A",
    "name":"$CF_RECORD_NAME",
    "content":"$DDNS_IP_ADDRESS",
    "ttl": 300,
    "proxied": false
  }
EOF
  }

  echo "------------------------------------------------"
  echo "Updating DDNS Record to IP: $DDNS_IP_ADDRESS ..."
  echo "API URL: $CF_API_URL"
  echo "------------------------------------------------"

  curl --http1.1 -X PATCH -H "Authorization: Bearer $AUTH_TOKEN" -H "Content-Type: application/json" -H 'Accept: application/json' --data "$(generate_post_data)" "$CF_API_URL"
fi

