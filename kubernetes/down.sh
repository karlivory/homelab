#!/usr/bin/env bash

read -p "Delete cluster? [y/n] " -r

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

ssh root@10.5.0.100 "sudo virsh destroy --domain k8s-prod-controller1"
ssh root@10.5.0.100 "sudo virsh destroy --domain k8s-prod-controller2"
ssh root@10.5.0.100 "sudo virsh destroy --domain k8s-prod-controller3"
ssh root@10.5.0.100 "sudo virsh destroy --domain k8s-prod-worker1"
ssh root@10.5.0.100 "sudo virsh destroy --domain k8s-prod-worker2"
ssh root@10.5.0.100 "sudo virsh destroy --domain k8s-prod-worker3"
ssh root@10.5.0.100 "sudo virsh destroy --domain k8s-prod-worker4"

ssh root@10.5.0.100 "sudo virsh undefine --domain k8s-prod-controller1"
ssh root@10.5.0.100 "sudo virsh undefine --domain k8s-prod-controller2"
ssh root@10.5.0.100 "sudo virsh undefine --domain k8s-prod-controller3"
ssh root@10.5.0.100 "sudo virsh undefine --domain k8s-prod-worker1"
ssh root@10.5.0.100 "sudo virsh undefine --domain k8s-prod-worker2"
ssh root@10.5.0.100 "sudo virsh undefine --domain k8s-prod-worker3"
ssh root@10.5.0.100 "sudo virsh undefine --domain k8s-prod-worker4"

ssh root@10.5.0.100 "sudo zfs destroy zroot/zk/k8s-prod-controller1-root"
ssh root@10.5.0.100 "sudo zfs destroy zroot/zk/k8s-prod-controller2-root"
ssh root@10.5.0.100 "sudo zfs destroy zroot/zk/k8s-prod-controller3-root"
ssh root@10.5.0.100 "sudo zfs destroy zroot/zk/k8s-prod-worker1-root"
ssh root@10.5.0.100 "sudo zfs destroy zroot/zk/k8s-prod-worker2-root"
ssh root@10.5.0.100 "sudo zfs destroy zroot/zk/k8s-prod-worker3-root"
ssh root@10.5.0.100 "sudo zfs destroy zroot/zk/k8s-prod-worker4-root"
