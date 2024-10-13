#!/bin/bash
# helm template . -f ./debug.yaml -f ./values.yaml -f ./clusters/dev.yaml --debug

helm template . -f ./debug.yaml \
    -f ./values.yaml \
    -f ./cluster-types/onprem.yaml \
    -f ./clusters/onprem-dev-1.yaml \
    --debug -s templates/tenants.yaml