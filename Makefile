# Docker setup
up:
	docker-compose up -d
build:
	docker-compose build --no-cache --force-rm
stop:
	docker-compose stop
down:
	docker-compose down --remove-orphans
destroy:
	docker-compose down --rmi all --volumes --remove-orphans
destroy-volumes:
	docker-compose down --volumes --remove-orphans
restart:
	@make down
	@make up
remake:
	@make destroy
	@make init
create-project:
	mkdir backend
	@make build
	@make up
	@make laravel-install
	@make laravel-setup
	@make fresh
create-except-laravel:
	@make build
	@make up
	docker-compose exec app composer install
	@make laravel-setup
	@make fresh

# Laravel install
laravel-install:
	docker-compose exec app composer create-project --prefer-dist laravel/laravel .
laravel-setup:
	docker-compose exec app cp --no-clobber .env.example .env
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan storage:link
	docker-compose exec app chmod -R 777 storage bootstrap/cache
install-recommend-packages:
	docker-compose exec app composer require doctrine/dbal
	docker-compose exec app composer require --dev barryvdh/laravel-ide-helper
	docker-compose exec app composer require --dev barryvdh/laravel-debugbar
	docker-compose exec app composer require --dev roave/security-advisories:dev-master
	@make ide-helper

# Docker additional commands
ps:
	docker-compose ps
logs:
	docker-compose logs
logs-watch:
	docker-compose logs --follow
log-web:
	docker-compose logs web
log-web-watch:
	docker-compose logs --follow web
log-app:
	docker-compose logs app
log-app-watch:
	docker-compose logs --follow app
log-db:
	docker-compose logs db
log-db-watch:
	docker-compose logs --follow db
web:
	docker-compose exec web ash
app:
	docker-compose exec app bash
db:
	docker-compose exec db bash

# Laravel commands
migrate:
	docker-compose exec app php artisan migrate
rollback:
	docker-compose exec app php artisan migrate:rollback
rollback-all:
	docker-compose exec app php artisan migrate:reset
fresh:
	docker-compose exec app php artisan migrate:fresh --seed
seed:
	docker-compose exec app php artisan db:seed
tinker:
	docker-compose exec app php artisan tinker
test:
	docker-compose exec app php artisan test
optimize:
	docker-compose exec app php artisan optimize
optimize-clear:
	docker-compose exec app php artisan optimize:clear
cache:
	docker-compose exec app composer dump-autoload -o
	@make optimize
	docker-compose exec app php artisan event:cache
	docker-compose exec app php artisan view:cache
cache-clear:
	docker-compose exec app composer clear-cache
	@make optimize-clear
	docker-compose exec app php artisan event:clear
ide-helper:
	docker-compose exec app php artisan vendor:publish --provider="Barryvdh\Debugbar\ServiceProvider"
	docker-compose exec app php artisan clear-compiled
	docker-compose exec app php artisan ide-helper:generate
	docker-compose exec app php artisan ide-helper:meta
	docker-compose exec app php artisan ide-helper:models --nowrite

# Database
sql:
	docker-compose exec db bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE'
