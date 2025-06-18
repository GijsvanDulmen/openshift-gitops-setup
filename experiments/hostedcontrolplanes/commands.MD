

export KUBECONFIG=/Users/gijs/Documents/repos/proxmox-terraform/openshift-upi/installation/auth/kubeconfig
oc create ns hcp-cluster03
oc create ns clusters-example

./hcp create cluster agent \
    --name=cluster03 \
    --pull-secret=/Users/gijs/Documents/repos/proxmox-terraform/openshift-upi/pull-secret-file \
    --agent-namespace=clusters-example \
    --base-domain=ticq.org \
    --api-server-address=api.os3.ticq.org \
    --etcd-storage-class=lvms-vg1 \
    --ssh-key /Users/gijs/Documents/repos/proxmox-terraform/openshift-upi/ssh/id_rsa_worker.pub \
    --namespace hcp-cluster03 \
    --control-plane-availability-policy SingleReplica \
    --release-image=quay.io/openshift-release-dev/ocp-release:4.18.1-x86_64 \
    --node-pool-replicas 1