include .env
export

# START::APP COMMANDS

# Executa os testes automatizados no modo verboso
test: 
	go test ./... $(ARGS)

# Executa os testes automatizados no modo verboso e cria um .html de coverage
test-cov: 
	go test -coverprofile cover.out ./... -v && go tool cover -html=cover.out -o coverage.html

# Inicializa / sobe / coloca pra rodar a API
run:
	go run ./cmd/server/
	
# Faz o build da aplicação e cria o arquivo em /build/server/
build: 
	go build -o ./build/server ./cmd/server

# END::APP COMMANDS
# START::DOCKER-COMPOSE COMMANDS

# Sobe os containers com base no docker-compose.yml
docker-compose-up:
	sudo docker compose up -d

# Derruba os containers com base no docker-compose.yml
docker-compose-down:
	sudo docker compose down

# Mostra os logs em tempo real dos containers definidos no docker-compose.yml
docker-compose-logs:
	sudo docker compose logs -f

# END::DOCKER-COMPOSE COMMANDS
# START::GOLANG-MIGRATE COMMANDS

# Cria os arquivos .up.sql e down.sql dentro de /migrations/db_users
migrate-users-create:
	migrate create -ext sql -dir migrations/db_users/ -seq $(MIG_NAME)

# Faz o upgrade do banco de dados conforme última versão do migrate
migrate-users-up:
	migrate \
	-path migrations/db_users \
	-database "postgres://$(DB_USERS_USERNAME):$(DB_USERS_PASSWORD)@$(DB_USERS_HOST):$(DB_USERS_PORT)/$(DB_USERS_NAME)?sslmode=disable" \
	up 

# Faz o upgrade do banco de dados conforme última versão do migrate
migrate-users-down:
	migrate \
	-path migrations/db_users \
	-database "postgres://$(DB_USERS_USERNAME):$(DB_USERS_PASSWORD)@$(DB_USERS_HOST):$(DB_USERS_PORT)/$(DB_USERS_NAME)?sslmode=disable" \
	down 

# Ignore a falha anterior, e considere o banco no estado da versão $(VERSION).
migrate-users-force-version:
	migrate \
	-path migrations/db_users \
	-database "postgres://$(DB_USERS_USERNAME):$(DB_USERS_PASSWORD)@$(DB_USERS_HOST):$(DB_USERS_PORT)/$(DB_USERS_NAME)?sslmode=disable" \
	force $(VERSION) 


# Cria os arquivos .up.sql e down.sql dentro de /migrations/db_users
migrate-auth-create:
	migrate create -ext sql -dir migrations/db_auth/ -seq $(MIG_NAME)

# Faz o upgrade do banco de dados conforme última versão do migrate
migrate-auth-up:
	migrate \
	-path migrations/db_auth \
	-database "postgres://$(DB_AUTH_USERNAME):$(DB_AUTH_PASSWORD)@$(DB_AUTH_HOST):$(DB_AUTH_PORT)/$(DB_AUTH_NAME)?sslmode=disable" \
	up 

# Faz o upgrade do banco de dados conforme última versão do migrate
migrate-auth-down:
	migrate \
	-path migrations/db_auth \
	-database "postgres://$(DB_AUTH_USERNAME):$(DB_AUTH_PASSWORD)@$(DB_AUTH_HOST):$(DB_AUTH_PORT)/$(DB_AUTH_NAME)?sslmode=disable" \
	down 

# Ignore a falha anterior, e considere o banco no estado da versão $(VERSION).
migrate-auth-force-version:
	migrate \
	-path migrations/db_auth \
	-database "postgres://$(DB_AUTH_USERNAME):$(DB_AUTH_PASSWORD)@$(DB_AUTH_HOST):$(DB_AUTH_PORT)/$(DB_AUTH_NAME)?sslmode=disable" \
	force $(VERSION) 
# END::GOLANG-MIGRATE  COMMANDS


