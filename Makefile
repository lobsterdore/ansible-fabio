SHELL:=/bin/bash

VAGRANT_BOX ?= ubuntu/trusty64

.DEFAULT_GOAL := help
.PHONY: help

## Prints this help
help:
	@awk -v skip=1 \
		'/^##/ { sub(/^[#[:blank:]]*/, "", $$0); doc_h=$$0; doc=""; skip=0; next } \
		 skip  { next } \
		 /^#/  { doc=doc "\n" substr($$0, 2); next } \
		 /:/   { sub(/:.*/, "", $$0); printf "\033[34m%-30s\033[0m\033[1m%s\033[0m %s\n\n", $$0, doc_h, doc; skip=1 }' \
		$(MAKEFILE_LIST)

## Test role locally using Vagrant
test: lint test_deps
	./bin/kitchen test -c 1

test_deps:
	bundle install
	virtualenv .venv
	.venv/bin/pip install -r requirements.txt
	.venv/bin/docker-compose up -d

lint:
	find defaults/ meta/ tasks/ templates/ vars/ -name "*.yml" | xargs -I{} ansible-lint {}

## Remove test Vagrant machine
clean:
	vagrant destroy -f
	./bin/kitchen destroy
	.venv/bin/docker-compose down
