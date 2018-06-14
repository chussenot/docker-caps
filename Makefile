GOSS_VERSION := 0.3.6
caps := $(shell ls caps | sed -e 's/.yml//')

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

test: ## Run all the tests
	@make ${caps}

$(caps): %: ## Dynamic tasks
	@echo "Start test for $*"
	@docker run --rm -t \
		 -v `pwd`/bin/goss:/usr/local/bin/goss \
		 -v `pwd`/caps:/goss \
		 -w /goss \
		 --cap-drop $* \
		 alpine \
		 goss -g $*.yml \
		 validate --max-concurrent 5 \
		 --format documentation

list: ## List existing scenarii.
	@echo ${caps}
