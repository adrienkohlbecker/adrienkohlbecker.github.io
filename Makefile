build:
	node_modules/.bin/resume export --format html --theme spartan index.html
	sed -i "s|<body>|<meta name=\"description\" content=\"$(shell jq -r ".basics.summary" resume.json)\" />\n<body>|" index.html
	sed -i "s|<body>|<link rel="stylesheet" href=\"overrides.css\" />\n<body>|" index.html
	sed -i 's|<body>|$(shell cat icons/html_code.html)\n<body>|' index.html
	sed -i "s|+44 7432 562897|<a href="tel:+447432562897">+44 7432 562897</a>|" index.html
