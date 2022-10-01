FROM alpine:3.14
WORKDIR /cron

RUN apk add --no-cache bash curl

COPY ./update-ddns.sh .
RUN chmod +x update-ddns.sh

CMD ["update-ddns.sh"]
