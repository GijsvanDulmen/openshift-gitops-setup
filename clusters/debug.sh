#!/bin/bash
# helm template . -f ./debug.yaml -f ./values.yaml -f ./clusters/dev.yaml --debug

helm template . -f ./debug.yaml \
    -f ../../openshift-gitops-config/config/values.yaml \
    -f ../../openshift-gitops-config/config/onprem-dev/values.yaml \
    -f ../../openshift-gitops-config/config/onprem-dev/onprem-dev-1/values.yaml \
    --debug -s templates/operators.yaml