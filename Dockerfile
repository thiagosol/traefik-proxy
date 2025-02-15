FROM traefik:v2.0

RUN apk add --no-cache apache2-utils

ARG TRAEFIK_USER
ARG TRAEFIK_PASS

RUN htpasswd -nbB "${TRAEFIK_USER}" "${TRAEFIK_PASS}" > /traefik-auth.txt

RUN mkdir -p /etc/traefik && mv /traefik-auth.txt /etc/traefik/traefik-auth.txt
COPY traefik.yml /traefik.yml
COPY dynamic-conf.yml /etc/traefik/dynamic-conf.yml

CMD ["traefik", "--configFile=/traefik.yml"]
