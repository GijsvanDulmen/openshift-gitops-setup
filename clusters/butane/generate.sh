#!/bin/bash

curl -s https://mirror.openshift.com/pub/openshift-v4/clients/butane/latest/butane-darwin-amd64 --output butane
chmod +x butane

# real stuff
./butane 99-master-chrony-conf-override.bu -o ../templates/machineconfig/99-master-chrony-conf-override.yaml
./butane 99-worker-chrony.bu -o ../templates/machineconfig/99-worker-chrony.yaml

# testing
./butane 101-test-file-gijs.bu -o ../templates/machineconfig/101-test-file-gijs.yaml
