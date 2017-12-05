include .env
export $(shell sed 's/=.*//' .env)

OS := $(shell uname)

start:
	docker-compose -f docker-compose.yml up -d

stop:
	docker-compose -f docker-compose.yml stop

install:
	docker exec $(APP_NAME)_workspace composer install
	docker exec $(APP_NAME)_workspace npm install --no-optional

watch:
	docker exec $(APP_NAME)_workspace npm run watch

startsync:
ifeq ($(OS),Darwin)
	docker volume create --name=app-sync
	docker-compose -f docker-compose-dev.yml up -d
	docker-sync start
else
	docker-compose up -d
endif

stopsync:
ifeq ($(OS),Darwin)
	docker-compose stop
	docker-sync stop
else
	docker-compose stop
endif