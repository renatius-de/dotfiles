ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: clean
clean:
	rm -f ${HOME}/.editrc
	rm -f ${HOME}/.hushlogin
	rm -f ${HOME}/.inputrc
	rm -f ${HOME}/.logout
	rm -f ${HOME}/.my.cnf
	rm -f ${HOME}/.profile
	rm -f ${HOME}/.shell
	rm -f ${HOME}/.sudo_as_admin_successful
	#
	rm -f $(ROOT_DIR)/nvm.sh

.PHONY: install
install: ${HOME}/.shell
	ln -snf ${ROOT_DIR}/logout ${HOME}/.logout
	ln -snf ${ROOT_DIR}/my.cnf ${HOME}/.my.cnf
	#
	touch ${HOME}/.hushlogin
	touch ${HOME}/.sudo_as_admin_successful

${HOME}/.shell:
	ln -snf ${ROOT_DIR} ${HOME}/.shell

.PHONY: default
default: | clean install
