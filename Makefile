IMAGE_NAME := shadas/laravel
CI = 

define HELP_MSG

Run "make build" to create docker image.
Run "make run" to run a docker container.
Run "make enter CI=xxx" to enter a docker container with its container id.

Run "make help" to get help information.

endef

export HELP_MSG
.PHONY: build help

help:
	@echo "$$HELP_MSG"

build:
	@echo "build docker image..."
	docker build -t ${IMAGE_NAME} .

run:
	@echo "run docker container..."
	docker run \
		-d \
		${IMAGE_NAME} /bin/sh -c /usr/local/bin/keep_alive.sh

enter:
	@echo "enter docker container..."
	docker exec -it ${CI} /bin/bash