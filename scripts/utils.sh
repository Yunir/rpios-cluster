#!/usr/bin/env bash
set -euxo pipefail

# run after burning iso image to micro-sd card
pushd ../cloud-init
cp * /Volumes/system-boot/
popd

diskutil umount /Volumes/system-boot


# on rpios server node
sudo echo "net.ifnames=0 dwc_otg.lpm_enable=0 console=serial0,115200 cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 console=tty1 root=LABEL=writable rootfstype=ext4 elevator=deadline rootwait fixrtc" > /boot/firmware/cmdline.txt
curl -sfL https://get.k3s.io | sh -

# for agent node
sudo echo "net.ifnames=0 dwc_otg.lpm_enable=0 console=serial0,115200 cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 console=tty1 root=LABEL=writable rootfstype=ext4 elevator=deadline rootwait fixrtc" > /boot/firmware/cmdline.txt
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.0.211:6443 K3S_TOKEN=K10aca3879dbf9e02b43bb9cea51828b904889de3c7d399db5ed638f68415a99424::server:c0dca1addf14cf837fcdc19e25ba023a sh -


# dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml
#  namespace/kubernetes-dashboard created
#  serviceaccount/kubernetes-dashboard created
#  service/kubernetes-dashboard created
#  secret/kubernetes-dashboard-certs created
#  secret/kubernetes-dashboard-csrf created
#  secret/kubernetes-dashboard-key-holder created
#  configmap/kubernetes-dashboard-settings created
#  role.rbac.authorization.k8s.io/kubernetes-dashboard created
#  clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
#  rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
#  clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
#  deployment.apps/kubernetes-dashboard created
#  service/dashboard-metrics-scraper created
#  deployment.apps/dashboard-metrics-scraper created

pushd cluster
k apply -f dashboard.admin-user.yaml
# serviceaccount/admin-user created
k apply -f dashboard.admin-user-role.yaml
# clusterrolebinding.rbac.authorization.k8s.io/admin-user created
popd

kubectl -n kubernetes-dashboard describe secret admin-user-token | grep '^token'
kubectl proxy
# open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
# enter token
