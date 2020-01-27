# Django-todo application site

This directory contains Django site for [django-todo application](https://github.com/shacker/django-todo).
Site used PostgreSQL as a database.

Site also has [`Dockerfile`](Dockerfile) for building docker image for Django site with django-todo application.
Built docker image uses [gunicorn](https://gunicorn.org/) as a WSGI web server.

## Parameters

Django site uses the following environment variables as a parameters: 

| Env var name       | Description                                      | Default        |
|:-------------------|:-------------------------------------------------|:--------------:|
| `DB_HOST`          | PostgreSQL FQDN/IP                               | `127.0.0.1`    |
| `DB_USER`          | PostgreSQL username                              | `postgres`     |
| `DB_PASS`          | PostgreSQL password                              | `postgres`     |
| `DB_PORT`          | PostgreSQL port                                  | `5432`         |
| `DB_NAME`          | PostgreSQL DB name                               | `todo`         |
| `STATICFILES_ROOT` | Directory where staticfiles should be collected  | `/staticfiles` |

## Building

Building docker image:

```
docker build -t <image-name> .
```

Pushing docker image to a repository:

```
docker tag <image-name> <repository-name>:<repository-tag>
docker tag <image-name> <repository-name>:latest
docker push <repository-name>:<repository-tag>
docker push <repository-name>:latest
```

Prebuilt image is available in [Docker Hub repository](https://hub.docker.com/r/torbik/django-todo)