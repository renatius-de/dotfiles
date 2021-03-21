ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

clean:
	rm -f ${HOME}/.bash_history
	rm -f ${HOME}/.bash_logout
	rm -f ${HOME}/.bash_profile
	rm -f ${HOME}/.bashrc
	rm -f ${HOME}/.liquidpromptrc
	rm -fr LiquidPrompt

install:
	ln -snf ${ROOT_DIR}/bash_logout ${HOME}/.bash_logout
	ln -snf ${ROOT_DIR}/bash_profile ${HOME}/.bash_profile
	ln -snf ${ROOT_DIR}/bashrc ${HOME}/.bashrc
