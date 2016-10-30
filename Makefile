build:
	docker build -t cppcarpool-db .
	-docker stop cppcarpool-db
	-docker rm cppcarpool-db
	docker run -d --name=cppcarpool-db -v `pwd`/data:/var/lib/postgresql/data -p 5432:5432 cppcarpool-db
	docker exec -it cppcarpool-db bash -c '/scripts/initdb.sh'
	-docker stop cppcarpool-db
	-docker rm cppcarpool-db

dev:
	docker run --rm -it --name=cppcarpool-db -v `pwd`/data:/var/lib/postgresql/data -p 5432:5432 cppcarpool-db
