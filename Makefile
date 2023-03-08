.PHONY: help \
hostfile \
install \
up upd stop

.DEFAULT_GOAL := help

# Set dir of Makefile to a variable to use later
MAKEPATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PWD := $(dir $(MAKEPATH))

USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

help: ## * Show help (Default task)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

hostfile: ## Add entries to /etc/hosts file if needed
	$(shell grep admin.kremmania.local /etc/hosts > /dev/null)
	@if [ "$(.SHELLSTATUS)" -eq 0 ]; then\
		echo "[INFO] Hosts file already contains the necessary entries!";\
	else\
		echo ""[INFO] Add necessary entries to /etc/hosts!"";\
		(\
			echo;\
			echo "# Szállás";\
			echo "127.0.0.1    frontend.szallas.local";\
			echo;\
		) | sudo tee -a /etc/hosts;\
	fi

install: upd ## Run make install on base projects
	cd ../frontend && make install && cd -

up: ## Run docker-compose up with
	docker-compose -p szallas up

upd: ## Run docker-compose up with -d
	docker-compose -p szallas up -d

stop: ## Stop docker containers
	docker-compose -p szallas stop
