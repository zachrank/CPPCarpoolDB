build: stop
	docker build -t cppcarpool-db .
	-docker stop cppcarpool-db
	-docker rm cppcarpool-db
	docker run -d --name=cppcarpool-db -v `pwd`/data:/var/lib/postgresql/data -p 5432:5432 cppcarpool-db
	docker exec -it cppcarpool-db bash -c '/scripts/initdb.sh'
	-docker stop cppcarpool-db
	-docker rm cppcarpool-db

net:
	docker network ls | grep cppcarpool || docker network create cppcarpool

dev: net
	docker run --rm -it --net=cppcarpool --name=cppcarpool-db -v `pwd`/data:/var/lib/postgresql/data -p 5432:5432 cppcarpool-db

run: net
	docker run -d --net=cppcarpool --name=cppcarpool-db -v `pwd`/data:/var/lib/postgresql/data -p 5432:5432 cppcarpool-db

stop:
	-docker stop cppcarpool-db
	-docker rm cppcarpool-db
