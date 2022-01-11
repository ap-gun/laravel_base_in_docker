# laravel_base_in_docker
Create Laravel development environment with Docker.

## Usage

### Case...Laravel not installed
1. Run the following command.

```bash
make create-project
```

2. http://localhost:80

### Case...Laravel already installed
1. Move Laravel src code to `backend` directory in this project.
2. Run the following command.

```bash
make create-except-laravel
```

3. http://localhost:80

## Tips

Read project [Wiki](https://github.com/ap-gun/laravel_base_in_docker/wiki) and [Makefile](https://github.com/ap-gun/laravel_base_in_docker/blob/main/Makefile)

## Docker containers

```
- app(PHP)
- web(NGINX)
- db(MySQL)
```
