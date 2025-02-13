FROM traefik:v2.0

RUN apk add --no-cache apache2-utils

ARG TRAEFIK_USER
ARG TRAEFIK_PASS

RUN echo "$(htpasswd -nbB ${TRAEFIK_USER} ${TRAEFIK_PASS} | sed 's/\$/\$\$/g')" > /auth.txt

ARG TRAEFIK_AUTH
RUN export TRAEFIK_AUTH=$(cat /auth.txt) && \
    echo "traefik.http.middlewares.traefik-auth.basicauth.users=${TRAEFIK_AUTH}" > /labels.env

LABEL traefik.http.middlewares.traefik-auth.basicauth.users-file="/labels.env"

COPY traefik.yml /traefik.yml
COPY dynamic-conf.yml /etc/traefik/dynamic-conf.yml

CMD ["traefik", "--configFile=/traefik.yml"]
