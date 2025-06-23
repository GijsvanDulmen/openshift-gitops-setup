

export KUBECONFIG=/Users/gijs/Documents/repos/proxmox-terraform/openshift-upi/installation/auth/kubeconfig
oc create ns hcp-os3
oc create ns clusters-example

./hcp create cluster agent \
    --name=os3 \
    --pull-secret=/Users/gijs/Documents/repos/proxmox-terraform/openshift-upi/pull-secret-file \
    --agent-namespace=infra01 \
    --base-domain=ticq.org \
    --api-server-address=api.os3.ticq.org \
    --etcd-storage-class=lvms-vg1 \
    --ssh-key /Users/gijs/Documents/repos/proxmox-terraform/openshift-upi/ssh/id_rsa_worker.pub \
    --namespace hcp-os3 \
    --control-plane-availability-policy SingleReplica \
    --release-image=quay.io/openshift-release-dev/ocp-release:4.18.9-x86_64 \
    --node-pool-replicas 1