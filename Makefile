build:
	node_modules/.bin/resume export --format html --theme spartan index.html
	sed -i.bak "s|<body>|<meta name=\"description\" content=\"$(shell jq -r ".basics.summary" resume.json)\" />\n<body>|" index.html
	sed -i.bak "s|<body>|<link rel="stylesheet" href=\"overrides.css\" />\n<body>|" index.html
	sed -i.bak 's|<body>|$(shell cat icons/html_code.html)\n<body>|' index.html
	sed -i.bak 's|(NL),|(NL)|' index.html
	sed -i.bak 's%<body>%<script async src="https://www.googletagmanager.com/gtag/js?id=UA-90740-8"></script><script>window.dataLayer = window.dataLayer || [];function gtag(){dataLayer.push(arguments)};gtag("js", new Date());gtag("config", "UA-90740-8");</script><body>%' index.html
	rm index.html.bak
