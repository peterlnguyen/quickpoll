all:
	coffee -c public/javascripts/*.coffee
	npm start
mocha::
	mocha --compilers coffee:coffee-script test/* -t 5000
