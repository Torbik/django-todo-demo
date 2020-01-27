#!/bin/bash

if [[ -z "$TODO_ADMIN_LOGIN" || -z "$TODO_ADMIN_EMAIL" || -z "$TODO_ADMIN_PASSWORD" || \
      -z "$TODO_DB_USER" || -z "$TODO_DB_PASSWORD" || -z "$TODO_DB_NAME" ]]; then
    echo 'Some of the following env variable are not defined:'
    echo 'TODO_ADMIN_LOGIN    - django-todo admin username'
    echo 'TODO_ADMIN_EMAIL    - django-todo admin email'
    echo 'TODO_ADMIN_PASSWORD - django-todo admin password'
    echo 'TODO_DB_USER        - PostgreSQL user'
    echo 'TODO_DB_PASSWORD    - PostgreSQL password'
    echo 'TODO_DB_NAME        - PostgreSQL DB name'
    exit 1
fi

echo "Starting Minikube for demo..."
minikube start -p minikube-1.17.0 --kubernetes-version='v1.17.0' --memory='2000mb'

echo "Enabling Nginx Ingress Controller..."
minikube -p minikube-1.17.0 addons enable ingress

echo -n "Waiting for Nginx Ingress Controller... "
while [[ $(kubectl -n kube-system get pods -l 'app.kubernetes.io/name'=nginx-ingress-controller \
                   -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do
  sleep 1
done
echo 'Ready!'

echo "Installing Helm Charts..."
helmsman -apply -f helm/helmsman.yaml -no-banner

URL=$(minikube -p minikube-1.17.0 service -n demo django-todo --url)
IP=$(echo $URL | sed 's/http:\/\/\(.\+\):[0-9]\+/\1/')

echo ""
echo "======================================================================================================="
echo "Django-todo is available on $URL"
echo "Also it will be available on http://django-todo-demo.local if you add the following line to /etc/hosts:"
echo "$IP django-todo-demo.local"
echo ""
echo "Run 'minikube start -p minikube-1.17.0' to stop minikube"
echo "======================================================================================================="



