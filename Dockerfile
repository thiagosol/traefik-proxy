FROM traefik:v2.0

LABEL traefik.http.middlewares.traefik-auth.basicauth.users="${TRAEFIK_AUTH}"

COPY traefik.yml /traefik.yml
COPY dynamic-conf.yml /etc/traefik/dynamic-conf.yml

CMD ["traefik", "--configFile=/traefik.yml"]
