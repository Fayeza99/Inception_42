all:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

re:
	@docker compose -f scrs/docker-compose.yml up -d --build

clean:
	@docker stop $$(docker ps -qa) 2>/dev/null || true\
	docker rm $$(docker ps -qa)  2>/dev/null || true\
	docker rmi -f $$(docker images -qa) 2>/dev/null || true\
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true\
	docker network rm $$(docker network ls -q) 2>/dev/null || true\

.PHONY: all re down clean

