FROM traefik:v2.0

LABEL traefik.enable="true"
LABEL traefik.http.routers.traefik.entrypoints="http"
LABEL traefik.http.routers.traefik.rule="Host(\`traefik.thiagosol.com\`)"
LABEL traefik.http.middlewares.traefik-auth.basicauth.users="${TRAEFIK_AUTH}"
LABEL traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme="https"
LABEL traefik.http.routers.traefik.middlewares="traefik-https-redirect"
LABEL traefik.http.routers.traefik-secure.entrypoints="https"
LABEL traefik.http.routers.traefik-secure.rule="Host(\`traefik.thiagosol.com\`)"
LABEL traefik.http.routers.traefik-secure.middlewares="traefik-auth"
LABEL traefik.http.routers.traefik-secure.tls="true"
LABEL traefik.http.routers.traefik-secure.tls.domains[0].main="thiagosol.com"
LABEL traefik.http.routers.traefik-secure.tls.domains[0].sans="traefik.thiagosol.com"
LABEL traefik.http.routers.traefik-secure.service="api@internal"

COPY traefik.yml /traefik.yml
COPY dynamic-conf.yml /etc/traefik/dynamic-conf.yml

CMD ["traefik", "--configFile=/traefik.yml"]
