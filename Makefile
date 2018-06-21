GOSS_VERSION := 0.3.6
caps := $(shell ls caps | sed -e 's/.yml//')
IMAGE = chussenot/event-generator

.PHONY: help
.DEFAULT_GOAL := test

help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
	@make list

# https://github.com/aelsabbahy/goss#installation
bin/goss:
	@mkdir -p bin
	@curl -o bin/goss -L \
		https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64
	@chmod +x bin/goss

test: bin/goss build-event-generator-image run-event-generator ## Run all the tests
	@make ${caps}

$(caps): %: build-event-generator-image ## Dynamic tasks
	@echo "Start test for $*"
	@docker run --rm -t \
		 -v `pwd`/bin/goss:/usr/local/bin/goss \
		 -v `pwd`/caps:/goss \
		 -v `pwd`/tests:/goss/tests \
		 -w /goss \
		 --cap-drop $* \
		 $(IMAGE) \
		 goss -g $*.yml \
		 validate --max-concurrent 5 \
		 --format documentation

list: ## List existing scenarii.
	@echo ${caps}

build-event-generator-image:
	@docker build -t $(IMAGE):latest docker/event-generator

run-event-generator: ## Run the falco event generator
	@docker-compose -f event-generator.yml up --remove-orphans
