# laravel_base_in_docker
Create Laravel development environment with Docker.

## Usage

### If Laravel has not installed yet
1. Run the following command.

```shell
$ git clone git@github.com:ap-gun/laravel_base_in_docker.git
$ cd laravel_base_in_docker
$ make create-project
```

### If Laravel has already installed
1. Run the following command.

```shell
$ git clone git@github.com:ap-gun/laravel_base_in_docker.git
$ cd laravel_base_in_docker

# Move Laravel src code in your project to `backend` directory in this project.
# ex. mv ~/laravel-src ./backend

$ make create-except-laravel
```

http://localhost:80


## Tips

Read project [Wiki](https://github.com/ap-gun/laravel_base_in_docker/wiki) and [Makefile](https://github.com/ap-gun/laravel_base_in_docker/blob/main/Makefile)

## Docker containers

```
- app(PHP)
- web(NGINX)
- db(MySQL)
```

## Reference
https://github.com/ucan-lab/docker-laravel
