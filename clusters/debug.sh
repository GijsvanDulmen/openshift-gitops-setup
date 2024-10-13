#!/bin/bash
# helm template . -f ./debug.yaml -f ./values.yaml -f ./clusters/dev.yaml --debug

helm template . -f ./debug.yaml \
    -f ./config/values.yaml \
    -f ./config/onprem-dev/values.yaml \
    -f ./config/onprem-dev/onprem-dev-1/values.yaml \
    --debug -s templates/tenants.yaml