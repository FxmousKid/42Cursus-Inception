DC := docker compose
DC_FILE := ./srcs/docker-compose.yml
MKDIR := mkdir -p
RM := rm -rf

build:
	$(MKDIR) /home/famouskid/inazaria/data/mysql
	$(MKDIR) /home/famouskid/inazaria/data/wordpress
	@$(DC)  -f $(DC_FILE) up --build 

up:
	@$(DC) -f $(DC_FILE) up 

all: build up

kill:
	@$(DC) -f $(DC_FILE) kill

down:
	@$(DC) -f $(DC_FILE) down

clean:
	@$(DC) -f $(DC_FILE) down -v

fclean: clean
	$(RM) /home/famouskid/inazaria/data/mysql
	$(RM) /home/famouskid/inazaria/data/wordpress
	docker system prune -a -f

restart: clean build

.PHONY: kill build down clean restart
.DEFAULT_GOAL := all
