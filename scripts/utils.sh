#!/usr/bin/env bash
set -euxo pipefail

# dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml
#  namespace/kubernetes-dashboard created
#  serviceaccount/kubernetes-dashboard created
#  service/kubernetes-dashboard created
#  secret/kubernetes-dashboard-certs created
#  secret/kubernetes-dashboard-csrf created
#  secret/kubernetes-dashboard-key-holder created
#  configmap/kubernetes-dashboard-settings created
#  role.rbac.authorization.k8s.io/kubernetes-dashboard created
#  clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
#  rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
#  clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
#  deployment.apps/kubernetes-dashboard created
#  service/dashboard-metrics-scraper created
#  deployment.apps/dashboard-metrics-scraper created

pushd cluster
k apply -f dashboard.admin-user.yaml
# serviceaccount/admin-user created
k apply -f dashboard.admin-user-role.yaml
# clusterrolebinding.rbac.authorization.k8s.io/admin-user created
popd

kubectl -n kubernetes-dashboard describe secret admin-user-token | grep '^token'
kubectl proxy
# open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
# enter token
