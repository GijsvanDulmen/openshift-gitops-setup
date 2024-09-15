#!/bin/bash

export KUBECONFIG=/Users/gijs/Documents/repos/proxmox-terraform/openshift/kubeconfig-noingress

# spin up containers in namespace
namespaces=("team-backend-accept" "istio-ingress" "openshift-monitoring" "team-backend-test")

echo "------"
echo "starting up:"
echo "------"
for (( i=0; i<=${#namespaces[@]}; i++ ));
do
    echo "starting up curl in ${namespaces[$i]}"
    kubectl apply -n "${namespaces[$i]}" -f ./curl.yaml
    kubectl wait --for=condition=ready pod curl -n "${namespaces[$i]}"
    # kubectl run -n "${namespaces[$i]}" --restart=Never curl --image=alpine/curl --command -- sleep 365d
done


# start curl container
# kubectl run --restart=Never curl --image=alpine/curl --command -- sleep 365d

function test() {
    kubectl exec -n $2 -it curl -- /bin/sh -c "curl --max-time 3 -sS -o /dev/null $1"
    success=$?

    zero=0;
    if [ $success -eq $zero ]; then
        echo "[V] test from $2 to $1 succeeded";
    fi

    if [ $success -ne $zero ]; then
        echo "[X] test from $2 to $1 failed";
    fi
}

# should work!
echo "------"
echo "should succeed:"
echo "------"
test "https://tweakers.net" "team-backend-accept"
test "http://istiod.istio-system.svc.cluster.local:15010" "team-backend-accept"
test "http://egress-gateway-istio.istio-egress.svc.cluster.local:443" "team-backend-accept"
test "http://application-a.team-backend-accept.svc.cluster.local:8080" "istio-ingress"
test "http://application-a.team-backend-accept.svc.cluster.local:8080" "openshift-monitoring"
test "http://application-a.team-backend-accept.svc.cluster.local:8080" "openshift-monitoring"
test "http://application-a.team-backend-accept.svc.cluster.local:8080" "team-backend-test"

# should not work
echo "------"
echo "should fail:"
echo "------"
test "google.com" "team-backend-accept"
# deny other services in cluster from team-backend-accept


echo "------"
echo "cleaning up:"
echo "------"
# cleanup again
for (( i=0; i<=${#namespaces[@]}; i++ ));
do
    echo "cleaning up curl in ${namespaces[$i]}"
    kubectl delete pod -n "${namespaces[$i]}" curl
done