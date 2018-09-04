build:
	node_modules/.bin/resume export --format html --theme slick index.html
	sed -i 's|http://fonts.googleapis.com|https://fonts.googleapis.com|' index.html
	sed -i 's|http://bootswatch.com/lumen/bootstrap.min.css|https://bootswatch.com/3/lumen/bootstrap.css|' index.html
	sed -i "s|</head>|<meta name=\"description\" content=\"$(shell jq -r ".basics.summary" resume.json)\" />\n</head>|" index.html
