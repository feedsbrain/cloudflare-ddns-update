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
  CURRENT_IP_ADDRESS="-"

  # read from .current_ip if exist
  if test -f "./config/.current_ip"; then
    CURRENT_IP_ADDRESS=$(cat ./config/.current_ip)
  fi
  DDNS_IP_ADDRESS="$(curl -s ifconfig.me)"
  echo "Current IP: $CURRENT_IP_ADDRESS, DDNS IP: $DDNS_IP_ADDRESS"

  if [ "$DDNS_IP_ADDRESS" != "$CURRENT_IP_ADDRESS" ]; then
    CF_API_URL="https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/dns_records/$CF_RECORD_ID"
    CF_REQUEST_PAYLOAD="{\"type\":\"A\", \"name\":\"$CF_RECORD_NAME\", \"content\":\"$DDNS_IP_ADDRESS\", \"ttl\": 300, \"proxied\": false}"

    echo "------------------------------------------------"
    echo "Updating DDNS Record to IP: $DDNS_IP_ADDRESS ..."
    echo "API URL: $CF_API_URL"
    echo "------------------------------------------------"
    echo "Payload: $CF_REQUEST_PAYLOAD"
    echo "------------------------------------------------"

    curl --http1.1 -X PATCH -H "Authorization: Bearer $AUTH_TOKEN" -H "Content-Type: application/json" -H 'Accept: application/json' --data "$CF_REQUEST_PAYLOAD" "$CF_API_URL"
    echo $DDNS_IP_ADDRESS > ./config/.current_ip
  else
    echo "---------------------------------------------------------"
    echo "No changes in current IP Address. Skipping DNS update ..."
    echo "---------------------------------------------------------"
  fi
fi

