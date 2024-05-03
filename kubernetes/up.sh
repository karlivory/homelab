#!/usr/bin/env bash

set -e

KUBECTL_VERSION=v1.29.1
K0SCTL_VERSION=v0.17.5
HELM_VERSION=v3.14.0
TMP_DIR="$HOME/tmp"
KUBECTL_BIN_PATH="$TMP_DIR/kubectl-$KUBECTL_VERSION"
K0SCTL_BIN_PATH="$TMP_DIR/k0sctl-$K0SCTL_VERSION"
HELM_BIN_PATH="$TMP_DIR/helm-$HELM_VERSION/linux-amd64/helm"
KUBECONFIG_PATH="$TMP_DIR/kubeconfig"

function fail {
    echo "Failed. Cleaning up..."
    rm "$KUBECONFIG_PATH"
    exit 1
}

mkdir -p "$TMP_DIR"

if [ ! -f "$K0SCTL_BIN_PATH" ]; then
    echo "### Downloading k0sctl $K0SCTL_VERSION to $K0SCTL_BIN_PATH ###"
    curl -L "https://github.com/k0sproject/k0sctl/releases/download/$K0SCTL_VERSION/k0sctl-linux-x64" -o "$K0SCTL_BIN_PATH"
    chmod +x "$K0SCTL_BIN_PATH"
fi

if [ ! -f "$HELM_BIN_PATH" ]; then
    echo "### Downloading helm $HELM_VERSION to $HELM_BIN_PATH ###"
    curl -L "https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz" -o "$TMP_DIR/helm-$HELM_VERSION-linux-amd64.tar.gz"
    mkdir -p "$TMP_DIR/helm-$HELM_VERSION/"
    tar -xvf "$TMP_DIR/helm-$HELM_VERSION-linux-amd64.tar.gz" -C "$TMP_DIR/helm-$HELM_VERSION" linux-amd64/helm
    chmod +x "$HELM_BIN_PATH"
fi

if [ ! -f "$KUBECTL_BIN_PATH" ]; then
    echo "### Downloading kubectl $KUBECTL_VERSION to $KUBECTL_BIN_PATH ###"
    curl -L "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl" -o "$KUBECTL_BIN_PATH"
    chmod +x "$KUBECTL_BIN_PATH"
fi


# Use the specified k0sctl binary for the following commands
$K0SCTL_BIN_PATH apply --config k0sctl.yml
$K0SCTL_BIN_PATH kubeconfig --config k0sctl.yml > "$KUBECONFIG_PATH"
chmod 0600 "$KUBECONFIG_PATH"

# helm repo add argo-cd https://argoproj.github.io/argo-helm
# KUBECONFIG=$KUBECONFIG_PATH $HELM_BIN_PATH install argocd -n argocd --create-namespace argo/argo-cd --values apps/argocd/values.yaml
ARGOCD_VERSION=$(grep -A3 "name: argo-cd" apps/argocd/Chart.yaml | grep 'version:' | tr -d 'v' | awk -F " " '{print $NF}')
KUBECONFIG=$KUBECONFIG_PATH $HELM_BIN_PATH upgrade argocd argo-cd \
  --install \
  --version "$ARGOCD_VERSION" \
  --values apps/argocd/values.yaml \
  --repo https://argoproj.github.io/argo-helm \
  --create-namespace \
  --namespace argocd || echo "already installed, skipping..."

KUBECONFIG=$KUBECONFIG_PATH $KUBECTL_BIN_PATH apply -f ./appset.yaml

rm "$KUBECONFIG_PATH"
