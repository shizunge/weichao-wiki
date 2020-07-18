docker-compose -f ./compose/network.yml up -d
docker-compose -f ./compose/traefik.yml up -d
docker-compose -f ./compose/authelia.yml up -d
docker-compose -f ./compose/gollum.yml up -d
docker-compose -f ./compose/bookstack.yml up -d
docker-compose -f ./compose/documize.yml up -d
docker-compose -f ./compose/xwiki.yml up -d

