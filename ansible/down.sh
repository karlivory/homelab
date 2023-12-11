#!/usr/bin/env bash

read -p "
!!! ABOUT TO TEAR THE WHOLE THING DOWN !!!
Proceed? [y/n] " -r

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

ssh root@10.5.0.100 "virsh destroy --domain r2d2"
ssh root@10.5.0.100 "virsh destroy --domain k8s-prod-controller1"
ssh root@10.5.0.100 "virsh destroy --domain k8s-prod-controller2"
ssh root@10.5.0.100 "virsh destroy --domain k8s-prod-controller3"
ssh root@10.5.0.100 "virsh destroy --domain k8s-prod-worker1"
ssh root@10.5.0.100 "virsh destroy --domain k8s-prod-worker2"
ssh root@10.5.0.100 "virsh destroy --domain k8s-prod-worker3"
ssh root@10.5.0.100 "virsh destroy --domain k8s-prod-worker4"
ssh root@10.5.0.100 "virsh destroy --domain k8s-dev-controller1"
ssh root@10.5.0.100 "virsh destroy --domain k8s-dev-controller2"
ssh root@10.5.0.100 "virsh destroy --domain k8s-dev-controller3"
ssh root@10.5.0.100 "virsh destroy --domain k8s-dev-worker1"
ssh root@10.5.0.100 "virsh destroy --domain k8s-dev-worker2"
ssh root@10.5.0.100 "virsh destroy --domain k8s-dev-worker3"
ssh root@10.5.0.100 "virsh destroy --domain k8s-dev-worker4"

ssh root@10.5.0.100 "virsh undefine --domain r2d2"
ssh root@10.5.0.100 "virsh undefine --domain k8s-prod-controller1"
ssh root@10.5.0.100 "virsh undefine --domain k8s-prod-controller2"
ssh root@10.5.0.100 "virsh undefine --domain k8s-prod-controller3"
ssh root@10.5.0.100 "virsh undefine --domain k8s-prod-worker1"
ssh root@10.5.0.100 "virsh undefine --domain k8s-prod-worker2"
ssh root@10.5.0.100 "virsh undefine --domain k8s-prod-worker3"
ssh root@10.5.0.100 "virsh undefine --domain k8s-prod-worker4"
ssh root@10.5.0.100 "virsh undefine --domain k8s-dev-controller1"
ssh root@10.5.0.100 "virsh undefine --domain k8s-dev-controller2"
ssh root@10.5.0.100 "virsh undefine --domain k8s-dev-controller3"
ssh root@10.5.0.100 "virsh undefine --domain k8s-dev-worker1"
ssh root@10.5.0.100 "virsh undefine --domain k8s-dev-worker2"
ssh root@10.5.0.100 "virsh undefine --domain k8s-dev-worker3"
ssh root@10.5.0.100 "virsh undefine --domain k8s-dev-worker4"

ssh root@10.5.0.100 "zfs destroy zroot/zk/r2d2-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-prod-controller1-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-prod-controller2-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-prod-controller3-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-prod-worker1-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-prod-worker2-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-prod-worker3-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-prod-worker4-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-dev-controller1-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-dev-controller2-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-dev-controller3-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-dev-worker1-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-dev-worker2-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-dev-worker3-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-dev-worker4-root"

