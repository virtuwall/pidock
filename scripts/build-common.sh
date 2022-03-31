source .env

docker build --build-arg "ADMIN_PASSWORD=${ADMIN_PASSWORD}" --build-arg "SSH_PUB_KEY=${SSH_PUB_KEY}" -t rpi-common .  