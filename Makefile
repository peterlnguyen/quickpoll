all:
	npm start
mocha:
	mocha --compilers coffee:coffee-script test/*
