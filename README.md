# Flarum

Docker container for Flarum adopted to higher education in Norway, including plugins for authentication via Dataporten.


Existing work:



Flarum-docker

<https://github.com/spujadas/flarum-docker>

Vi tar utangspunkt i denne først.





<https://github.com/docker-related/flarum-ubuntu>


Docker-flarum

<https://github.com/machado2/docker-flarum>

Setter opp mysql. Vi ser bort i fra denne.



## Configuration


	cat >> ENV
	APPURL=http://192.168.99.100
	MYSQL_HOST=blah.mysql.example.org
	MYSQL_DB=flarum
	MYSQL_USER=flarum
	MYSQL_PASSWD=xxxxxx




## Build



	docker build -t skrodal/flarum-docker-uh .


	docker run -d --env-file=./ENV --name flarum skrodal/flarum-docker-uh
