GOSS_VERSION := 0.3.6

.PHONY: help

help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

# https://github.com/aelsabbahy/goss#installation
bin/goss:
	@mkdir -p bin
	@curl -o bin/goss -L \
		https://github.com/aelsabbahy/goss/releases/download/v$\{GOSS_VERSION}/goss-linux-amd64
	@chmod +x bin/goss

test: bin/goss
	@rm -rf tests/vendor
	@docker run --rm -t \
		 -v `pwd`/bin/goss:/usr/local/bin/goss \
		 -v `pwd`/tests:/goss \
		 -w /goss \
		 alpine \
		 goss -g gossfile.yml \
		 validate --max-concurrent 4 --format documentation
