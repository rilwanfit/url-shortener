.DEFAULT_GOAL:=help
.DOCKER_COMPOSE := docker-compose -f docker-compose.yml -f docker-compose-dev.yml
.DOCKER_RUN_PHP := $(.DOCKER_COMPOSE) run --rm php
.RUN=

ifneq ($(AM_I_INSIDE_DOCKER),true)
    .RUN := $(.DOCKER_RUN_PHP)
endif


# -- Default -- #
.PHONY: setup destroy start stop restart test
setup: setup dependencies up-api migrate up-frontend ## Setup the Project
destroy: down-with-volumes ## Destroy the project
start: up ## Start the application
stop: down ## Stop the docker containers
restart: down up ## Restart the docker containers
test: test ## Run the test suite
shell: shell-bash ## Start a shell in docker container
# -- // Default -- #

.PHONY: setup
setup:
	cd ./api && $(.DOCKER_COMPOSE) pull

.PHONY: up-api
up-api:
	cd ./api && $(.DOCKER_COMPOSE) up -d

.PHONY: up-frontend
up-frontend:
	cd ./front-end && docker-compose up -d

.PHONY: down
down:
	cd ./api && $(.DOCKER_COMPOSE) down

.PHONY: down-with-volumes
down-with-volumes:
	cd ./api && $(.DOCKER_COMPOSE) down --remove-orphans --volumes

dependencies:
	cd ./api && $(.RUN) composer install --no-interaction --no-scripts --ansi
	cd ./front-end

.PHONY: migrate
migrate: ## Runs the migrations
	cd ./api && $(.RUN) bin/console doctrine:migrations:migrate

test:
	cd ./api && $(.RUN) bin/phpunit --configuration phpunit.xml.dist --stop-on-failure --testdox

shell-bash:
	cd ./api && $(.RUN) bash

# Based on https://suva.sh/posts/well-documented-makefiles/
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
