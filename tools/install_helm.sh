#!/bin/bash
set -ex

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
kubectl create -f configs/k8s/helm/rbac-config.yaml
helm init --service-account tiller
helm version
