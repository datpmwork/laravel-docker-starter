# Install Docker
(For Mac): https://www.docker.com/docker-windows

(For Windows): https://www.docker.com/docker-mac

# Start Docker via Git Bash

Start Docker container by using this command

`make start`

In case of Makefile is not available, run this command instead

`docker-compose -f docker-compose.yml up -d`

After that, visit [http://localhost:3000](http://localhost:3000) to check if everything works fine.