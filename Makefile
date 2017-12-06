# Load Environment variables
include .env
export $(shell sed 's/=.*//' .env)

# Get OS Information
OS := $(shell uname)

# Start Development
start:
ifeq ($(SYNC)$(OS),trueDarwin)
	docker volume create --name=$(APP_NAME)-sync
	docker-compose -f docker-compose.yml -f docker-compose.sync.yml up -d
	docker-sync start
else
	docker-compose -f docker-compose.yml up -d
endif

stop:
ifeq ($(SYNC)$(OS),trueDarwin)
	docker-sync stop
	docker-compose -f docker-compose.yml -f docker-compose.sync.yml stop
else
	docker-compose -f docker-compose.sync.yml stop
endif

destroy:
ifeq ($(SYNC)$(OS),trueDarwin)
	docker-sync stop
	docker-compose -f docker-compose.yml -f docker-compose.sync.yml down
	docker rm $(APP_NAME)-sync
	docker volume rm $(APP_NAME)-sync
else
	docker-compose -f docker-compose.sync.yml down
endif

install:
	docker exec $(APP_NAME)_workspace composer install
	docker exec $(APP_NAME)_workspace npm install --no-optional

watch:
	docker exec $(APP_NAME)_workspace npm run watch