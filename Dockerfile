FROM traefik:v2.0

RUN apk add --no-cache apache2-utils

ARG TRAEFIK_USER
ARG TRAEFIK_PASS

RUN echo "${TRAEFIK_USER}:$(htpasswd -nbB ${TRAEFIK_USER} ${TRAEFIK_PASSWORD} | sed 's/\$/\$\$/g')" > /auth.txt

LABEL traefik.http.middlewares.traefik-auth.basicauth.users="$(cat /auth.txt)"

COPY traefik.yml /traefik.yml
COPY dynamic-conf.yml /etc/traefik/dynamic-conf.yml

CMD ["traefik", "--configFile=/traefik.yml"]
