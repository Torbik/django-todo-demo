#!/bin/sh

set -ex

python /manage.py migrate
python manage.py collectstatic --no-input
gunicorn --log-level debug --bind 0.0.0.0:8000 todosite.wsgi
