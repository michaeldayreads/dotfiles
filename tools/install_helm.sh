#!/bin/bash
set -ex

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
sleep 1s
rm get_helm.sh
helm init --service-account tiller
sleep 10s # Give helm a little time to come up before asking for version
helm version

