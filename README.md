# Django-todo application Demo

This repository contains demo for [django-todo application](https://github.com/shacker/django-todo) application.
It consists of:

- [django-todo Django site with Dockerfile](django-todo/README.md)
- [django-todo Helm chart](helm/charts/django-todo/README.md)
- [Helmsman state file for django-todo demo](helm/README.md)
- [`deploy-minikube.sh`](deploy-minikube.sh) script rolling out minikube Kubernets cluster with django-todo application.

## Requirements

Demo was tested on Ubuntu 16.04.6 LTS. Other OS were not tested.

The following software should be installed before running deployment for the demo:

- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
- [helmsman](https://github.com/Praqma/helmsman) (>=v3.0.0)
- [kubectl](https://github.com/kubernetes/kubectl)
- [helm](https://github.com/helm/helm) (>=v3.0.0)
- [helm-diff](https://github.com/databus23/helm-diff)

# Configuring

Input parameters should be set as environment variables. All necessary variables described [here](helm/README.md#Parameters).

# Running deployment

Clone [django-todo-demo repository](https://github.com/Torbik/django-todo-demo):
```
git clone https://github.com/Torbik/django-todo-demo.git
cd django-todo-demo/
```

Setting [`deploy-minikube.sh`](deploy-minikube.sh) as executable:
```
chmod +x deploy-minikube.sh
```

Setting environment variables:
```
export TODO_ADMIN_LOGIN=...
export TODO_ADMIN_EMAIL=...
export TODO_ADMIN_PASSWORD=...
export TODO_DB_USER=...
export TODO_DB_PASSWORD=...
export TODO_DB_NAME=...
```

Starting deployment:
```
./deploy-minikube.sh
```

After starting minikube and installing application to it, the script will show the link for accessing django-todo web
interface. 

An example of the deployment with `deploy-minikube.sh`:
```
$ export TODO_ADMIN_LOGIN=admin
$ export TODO_ADMIN_EMAIL='admin@example.com'
$ export TODO_ADMIN_PASSWORD=demoAdminPass
$ export TODO_DB_USER=postgres
$ export TODO_DB_PASSWORD=demoDbPass
$ export TODO_DB_NAME=todo

$ ./deploy-minikube.sh 
Starting Minikube for demo...
😄  [minikube-1.17.0] minikube v1.4.0 on Ubuntu 16.04
🔥  Creating virtualbox VM (CPUs=2, Memory=2000MB, Disk=20000MB) ...
🐳  Preparing Kubernetes v1.17.0 on Docker 18.09.9 ...
🚜  Pulling images ...
🚀  Launching Kubernetes ... 
⌛  Waiting for: apiserver proxy etcd scheduler controller dns
🏄  Done! kubectl is now configured to use "minikube-1.17.0"
Enabling Nginx Ingress Controller...
💥  addon ingress was already enabled
Waiting for Nginx Ingress Controller... Ready!
Installing Helm Charts...
2020-01-24 20:31:50 INFO: Parsed YAML [[ helm/helmsman.yaml ]] successfully and found [ 2 ] apps
2020-01-24 20:31:50 INFO: Validating desired state definition...
2020-01-24 20:31:50 INFO: Setting up kubectl...
2020-01-24 20:31:50 INFO: Setting up helm...
2020-01-24 20:31:58 INFO: Setting up namespaces...
2020-01-24 20:31:58 INFO: Namespace [ demo ] created
2020-01-24 20:31:58 INFO: Validating charts...
2020-01-24 20:32:00 INFO: Preparing plan...
2020-01-24 20:32:00 INFO: Acquiring current Helm state from cluster...
2020-01-24 20:32:00 INFO: Checking if any Helmsman managed releases are no longer tracked by your desired state ...
2020-01-24 20:32:00 INFO: No untracked releases found
2020-01-24 20:32:00 NOTICE: -------- PLAN starts here --------------
2020-01-24 20:32:00 NOTICE: Release [ postgresql ] will be installed in [ demo ] namespace -- priority: -20
2020-01-24 20:32:00 NOTICE: Release [ django-todo ] will be installed in [ demo ] namespace -- priority: -10
2020-01-24 20:32:00 INFO: Release [ django-todo ] in namespace [ demo ] is required to be tested during installation -- priority: -10
2020-01-24 20:32:00 NOTICE: -------- PLAN ends here --------------
2020-01-24 20:32:00 INFO: Executing plan... 
2020-01-24 20:32:00 NOTICE: Installing release [ postgresql ] in namespace [ demo ]
2020-01-24 20:33:04 NOTICE: NAME: postgresql
LAST DEPLOYED: Fri Jan 24 20:32:07 2020
NAMESPACE: demo
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

PostgreSQL can be accessed via port 5432 on the following DNS name from within your cluster:

    postgres.demo.svc.cluster.local - Read/Write connection

To get the password for "postgres" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace demo postgres -o jsonpath="{.data.postgresql-password}" | base64 --decode)

To connect to your database run the following command:

    kubectl run postgres-client --rm --tty -i --restart='Never' --namespace demo --image docker.io/bitnami/postgresql:11.6.0-debian-10-r0 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- psql --host postgres -U postgres -d todo -p 5432



To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace demo svc/postgres 5432:5432 &
    PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d todo -p 5432

2020-01-24 20:33:04 NOTICE: Finished: Installing release [ postgresql ] in namespace [ demo ]
2020-01-24 20:33:04 NOTICE: Installing release [ django-todo ] in namespace [ demo ]
2020-01-24 20:34:48 NOTICE: NAME: django-todo
LAST DEPLOYED: Fri Jan 24 20:33:09 2020
NAMESPACE: demo
STATUS: deployed
REVISION: 1
NOTES:
1. Get the django-todo URL by running these commands:
  http://django-todo-demo.local/

2020-01-24 20:34:48 NOTICE: Finished: Installing release [ django-todo ] in namespace [ demo ]
2020-01-24 20:34:48 NOTICE: Running tests for release [ django-todo ] in namespace [ demo ]
2020-01-24 20:36:12 NOTICE: Pod django-todo-test-login pending
Pod django-todo-test-login pending
Pod django-todo-test-login running
Pod django-todo-test-login succeeded
NAME: django-todo
LAST DEPLOYED: Fri Jan 24 20:33:09 2020
NAMESPACE: demo
STATUS: deployed
REVISION: 1
TEST SUITE:     django-todo-test-login
Last Started:   Sun Jan 26 20:34:48 2020
Last Completed: Sun Jan 26 20:36:12 2020
Phase:          Succeeded
NOTES:
1. Get the django-todo URL by running these commands:
  http://django-todo-demo.local/

2020-01-24 20:36:12 NOTICE: Finished: Running tests for release [ django-todo ] in namespace [ demo ]
2020-01-24 20:36:12 INFO: Plan applied

=======================================================================================================
Django-todo is available on http://192.168.99.100:32099
Also it will be available on http://django-todo-demo.local if you add the following line to /etc/hosts:
192.168.99.100 django-todo-demo.local

Run 'minikube stop -p minikube-1.17.0' to stop minikube
=======================================================================================================
```