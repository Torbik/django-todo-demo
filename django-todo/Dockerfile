FROM python:3.6-alpine3.11

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# DB vars should be overrided externally. Here they are for documentation purpose
ENV DB_HOST '127.0.0.1'
ENV DB_USER postgres
ENV DB_PASS postgres
ENV DB_PORT 5432
ENV DB_NAME todo
# Directory where staticfiles should be collected
ENV STATICFILES_ROOT '/staticfiles'

WORKDIR /

# install psycopg2
RUN apk update \
    && apk add --no-cache --virtual build-deps gcc python3-dev musl-dev \
    && apk add --no-cache postgresql-dev \
    && pip install psycopg2 \
    && apk del build-deps

COPY manage.py /
COPY entrypoint.sh /
COPY requirements.txt /

RUN chmod +x /entrypoint.sh \
    && pip install -r /requirements.txt \
    && pip install 'django-todo==2.4.9'

COPY todosite /todosite

RUN chown 1000:1000 /todosite

USER 1000

EXPOSE 8000

CMD ["/entrypoint.sh"]
