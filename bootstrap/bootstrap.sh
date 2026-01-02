#!/bin/bash

# Examples
# $1 = hc02
# $2 = onprem-dev
# $3 = onprem-dev-1

# ./bootstrap.sh hc02 onprem-dev onprem-dev-1
# ./bootstrap.sh hc03 onprem-prod onprem-prod-1

# export KUBECONFIG=/Users/gijs/Documents/repos/proxmox-terraform/openshift/kubeconfig-noingress
export KUBECONFIG="/Users/gijs/Documents/repos/homelab/openshift-virtualization/osv-resources/hcp/kubevirt-based/credentials/$1.yaml"

# add helm repos
helm repo add redhat-cop https://redhat-cop.github.io/helm-charts

# make more room on cluster
# kubectl patch --type=merge scheduler cluster -p '{"spec":{"mastersSchedulable":true}}'

# needed for istio
# from 4.18 this is done by OpenShift itself
# kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
#   { kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd/experimental?ref=v1.1.0" | kubectl apply -f -; }

# install gitops operators
cd ../operators/gitops-operator
helm dependency build
helm template . \
    -f ../../../openshift-gitops-config/clusters/$2/values.yaml \
    -f ../../../openshift-gitops-config/clusters/$2/$3/values.yaml \
    --name-template gitops-operator | kubectl apply -f -

cd ../../bootstrap/
sleep 5

source secrets.sh
helm template . -f ./values.yaml \
    --set "githubClientId=$GITHUB_CLIENT_ID" \
    --set "githubClientSecret=$GITHUB_CLIENT_SECRET" \
    --set "cloudFlareApiToken=$CLOUDFLARE_API_TOKEN" \
    | kubectl apply -f -