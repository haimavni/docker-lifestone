
build:
	docker-compose build
up: build
	docker-compose up -d
start:
	docker-compose start
down:
	docker-compose down
destroy:
	docker-compose down -v
stop:
	docker-compose stop
restart:
	docker-compose stop
	docker-compose up -d
logs:
	docker-compose logs --tail=100 -f
logs-api:
	docker-compose logs --tail=100 -f api
ps:
	docker-compose ps
login-db:
	docker-compose exec database /bin/bash
login-api:
	docker-compose exec api /bin/bash
db-shell:
	docker-compose exec database psql -Upostgres