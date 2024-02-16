#!/usr/bin/env bash

read -p "
!!! ABOUT TO TEAR THE WHOLE THING DOWN !!!
Proceed? [y/n] " -r

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

ssh root@10.5.0.100 "virsh destroy --domain r2d2"
ssh root@10.5.0.100 "virsh destroy --domain k8s-controller1"
ssh root@10.5.0.100 "virsh destroy --domain k8s-controller2"
ssh root@10.5.0.100 "virsh destroy --domain k8s-controller3"
ssh root@10.5.0.100 "virsh destroy --domain k8s-worker1"
ssh root@10.5.0.100 "virsh destroy --domain k8s-worker2"
ssh root@10.5.0.100 "virsh destroy --domain k8s-worker3"
ssh root@10.5.0.100 "virsh destroy --domain k8s-worker4"

ssh root@10.5.0.100 "virsh undefine --domain r2d2"
ssh root@10.5.0.100 "virsh undefine --domain k8s-controller1"
ssh root@10.5.0.100 "virsh undefine --domain k8s-controller2"
ssh root@10.5.0.100 "virsh undefine --domain k8s-controller3"
ssh root@10.5.0.100 "virsh undefine --domain k8s-worker1"
ssh root@10.5.0.100 "virsh undefine --domain k8s-worker2"
ssh root@10.5.0.100 "virsh undefine --domain k8s-worker3"
ssh root@10.5.0.100 "virsh undefine --domain k8s-worker4"

ssh root@10.5.0.100 "zfs destroy zroot/zk/r2d2-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-controller1-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-controller2-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-controller3-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-worker1-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-worker2-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-worker3-root"
ssh root@10.5.0.100 "zfs destroy zroot/zk/k8s-worker4-root"
