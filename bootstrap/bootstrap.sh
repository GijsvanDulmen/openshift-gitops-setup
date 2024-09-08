#!/bin/bash

export KUBECONFIG=/Users/gijs/Documents/repos/proxmox-terraform/openshift/kubeconfig-noingress

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