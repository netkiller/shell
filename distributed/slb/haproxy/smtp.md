listen stmp *:25
	mode tcp
	balance leastconn
	option smtp-check
	server smtp1 13.24.223.53:25 check
	server smtp2 45.33.242.42:25 check