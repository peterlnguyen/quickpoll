all:
	make mocha &&\
	grunt default &&\
	coffee -c public/javascripts/*.coffee &&\
	npm start
mocha:
	mocha --compilers coffee:coffee-script test/* test/integration/* test/unit/* test/routes/* -t 5000
build:
	npm start
