# Dockerfile PHP-Nginx
Dockerfile basis for image building with php and nginx.
## Build

```bash
$ git clone https://github.com/jacksonveroneze/dockerPhpNginx.git
$ cd dockerPhpNginx
$ docker build -t name/tag .
```

## Basic Usage

### Load container
```shell
$ docker run -d -i --name CONTAINER_NAME -p 443:443 -v DIRECTORY_YOUR_HOST:/home/www/ IMAGE_NAME && docker exec -it CONTAINER_NAME service nginx start && docker exec -it CONTAINER_NAME service php5-fpm start
```

## Documentation

### Author

Jackson Veroneze - <jackson@jacksonveroneze.com> - <http://jacksonveroneze.com>
See also the list of [contributors](https://github.com/jacksonveroneze/dockerPhpNginx/graphs/contributors) which participated in this project.

### License

Content is licensed under the MIT License - see the `LICENSE` file for details

### References
* [Docker](https://www.docker.com/)
* [DockerHub](https://hub.docker.com/)
