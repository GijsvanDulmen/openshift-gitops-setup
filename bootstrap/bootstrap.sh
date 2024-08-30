#!/bin/bash

export KUBECONFIG=/Users/gijs/Documents/repos/proxmox-terraform/openshift/kubeconfig-noingress

helm install gitops-operator ./gitops-operator/values.yaml | kubectl apply -f -
sleep 5
helm template . -f ./values.yaml | kubectl apply -f -