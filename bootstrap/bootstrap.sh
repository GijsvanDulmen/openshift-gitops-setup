#!/bin/bash

export KUBECONFIG=/Users/gijs/Documents/repos/proxmox-terraform/openshift/kubeconfig-noingress

cd gitops-operator
helm dependency build
helm template . -f ./values.yaml | kubectl apply -f -

cd ..
sleep 5

cd resources
helm template . -f ./values.yaml | kubectl apply -f -