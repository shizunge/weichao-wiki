source .env
echo ${VOLUMEPATH}
mkdir -p ${VOLUMEPATH}/traefik/letsencrypt
touch ${VOLUMEPATH}/traefik/letsencrypt/acme.json
chmod 600 ${VOLUMEPATH}/traefik/letsencrypt/acme.json
