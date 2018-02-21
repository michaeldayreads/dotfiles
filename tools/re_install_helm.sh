#!/bin/bash
set -ex

kubectl delete deploy tiller-deploy -n kube-system
kubectl delete -f configs/k8s/helm/rbac-config.yaml
sleep 5s
kubectl create -f configs/k8s/helm/rbac-config.yaml
sleep 5s
helm init --upgrade --service-account tiller
sleep 5s
helm version
