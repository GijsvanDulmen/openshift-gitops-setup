#!/bin/bash
helm template . -f ./debug.yaml -f ../clusters/tenants/defaults.yaml \
    -f ../clusters/cluster-tenants/dev.yaml \
    -f ../clusters/tenants/dev/team-backend.yaml --debug