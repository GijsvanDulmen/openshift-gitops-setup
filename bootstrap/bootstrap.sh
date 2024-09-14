#!/bin/bash

export KUBECONFIG=/Users/gijs/Documents/repos/proxmox-terraform/openshift/kubeconfig-noingress

# make more room on cluster
kubectl patch --type=merge scheduler cluster -p '{"spec":{"mastersSchedulable":true}}'

# needed for istio
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd/experimental?ref=v1.1.0" | kubectl apply -f -; }

# install gitops operators
cd gitops-operator
helm dependency build
helm template . -f ./values.yaml | kubectl apply -f -

cd ..
sleep 5

source secrets.sh
cd resources
helm template . -f ./values.yaml \
    --set "githubClientId=$GITHUB_CLIENT_ID" \
    --set "githubClientSecret=$GITHUB_CLIENT_SECRET" \
    --set "cloudFlareApiToken=$CLOUDFLARE_API_TOKEN" \
    | kubectl apply -f -