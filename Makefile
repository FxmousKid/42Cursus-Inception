DC := docker compose
DC_FILE := ./srcs/docker-compose.yml
MKDIR := mkdir -p
RM := rm -rf

build:
	$(MKDIR) /home/inazaria/data/mysql
	$(MKDIR) /home/inazaria/data/wordpress
	@$(DC)  -f $(DC_FILE) up --build -d

kill:
	@$(DC) -f $(DC_FILE) kill

down:
	@$(DC) -f $(DC_FILE) down

clean:
	@$(DC) -f $(DC_FILE) down -v

fclean: clean
	$(RM) /home/inazaria/data/mysql
	$(RM) /home/inazaria/data/wordpress
	docker system prune -a -f

restart: clean build

.PHONY: kill build down clean restart
.DEFAULT_GOAL := build
