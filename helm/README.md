# Helmsman state file for django-todo demo

[helmsman](https://github.com/Praqma/helmsman) is a Helm Charts as Code tool which allows to automate the
deployment/management of Helm charts. [`helmsman.yaml`](helmsman.yaml) is helmsman 
[desired state file](https://github.com/Praqma/helmsman/blob/master/docs/desired_state_specification.md) for 
[django-todo Helm chart](helm/charts/django-todo/README.md). In addition to django-todo Helm chart, the state file also 
contains [PostgreSQL Helm chart](https://github.com/helm/charts/tree/master/stable/postgresql). PostgreSQL used for
storing django-todo data.

The state file uses the following helm value files:

- [`django-todo-values.yaml`](django-todo-values.yaml) for django-todo Helm chart
- [`postgres-values.yaml`](postgres-values.yaml) for PostgreSQL Helm chart

Helmsman with this state file install all application to `demo` Kubernetes namespace (will be created if does not exist).

## Requirements

Helmsman requires the following software (should be installed prior to using helmsman):

- [kubectl](https://github.com/kubernetes/kubectl)
- [helm](https://github.com/helm/helm) (>=v3.0.0)
- [helm-diff](https://github.com/databus23/helm-diff)

The state file was tested for Helm v3 only and was not tested with Helm v2. 

## Parameters

This state file gets input parameters as the following environment variables:

- `TODO_ADMIN_LOGIN` - django-todo admin username
- `TODO_ADMIN_EMAIL` - django-todo admin email
- `TODO_ADMIN_PASSWORD` - django-todo admin password
- `TODO_DB_USER` - PostgreSQL user
- `TODO_DB_PASSWORD` - PostgreSQL password
- `TODO_DB_NAME` - PostgreSQL DB name

The above variables should be set before running helmsman with the state file.

## Installing 

Installing applications using the current Kubernetes cluster context: 
```
helmsman -apply -f helm/helmsman.yaml
```

Ununstalling applications using the current Kubernetes cluster context: 
```
helmsman -destroy -f helm/helmsman.yaml
```

django-todo web interface can be accessed via its service using Kubernetes port-forward:
```
kubectl -n demo port-forward svc/django-todo 8080
```

It can also be accessible using http://django-todo-demo.local if the cluster has ingress controller installed and
django-todo-demo.local domain points for the ingress controller external IP.
 