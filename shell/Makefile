ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

clean:
	rm -f $(ROOT_DIR)/nvm.sh
	rm -f ${HOME}/.editrc
	rm -f ${HOME}/.hushlogin
	rm -f ${HOME}/.inputrc
	rm -f ${HOME}/.logout
	rm -f ${HOME}/.my.cnf
	rm -f ${HOME}/.profile

install: ${HOME}/.shell
	ln -snf ${ROOT_DIR}/editrc ${HOME}/.editrc
	ln -snf ${ROOT_DIR}/inputrc ${HOME}/.inputrc
	ln -snf ${ROOT_DIR}/logout ${HOME}/.logout
	ln -snf ${ROOT_DIR}/my.cnf ${HOME}/.my.cnf
	ln -snf ${ROOT_DIR}/profile ${HOME}/.profile
	touch ${HOME}/.hushlogin

${HOME}/.shell:
	ln -snf ${ROOT_DIR} ${HOME}/.shell
