.PHONY: clean
clean:
	rm -f ${HOME}/.docker/cli-plugins/docker-compose

.PHONY: install
install: | ${HOME}/.docker/cli-plugins
	curl -SsL https://github.com/docker/compose/releases/latest/download/docker-compose-$(shell uname -s)-$(shell uname -m) -o ${HOME}/.docker/cli-plugins/docker-compose
	#
	chmod 0700 ${HOME}/.docker/cli-plugins/docker-compose

${HOME}/.docker/cli-plugins: | ${HOME}/.docker
	mkdir -m 0700 ${HOME}/.docker/cli-plugins

${HOME}/.docker:
	mkdir -m 0700 ${HOME}/.docker

.PHONY: default
default: | clean install
