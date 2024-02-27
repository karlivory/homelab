#!/usr/bin/env bash

set -eu
PROJ_DIR=$1
PROJ=$(echo "$PROJ_DIR" | sed 's:/*$::' | awk -F/ '{print $NF}')

#helm -n "$PROJ" uninstall "$PROJ"
rm -rf "$PROJ_DIR/charts" "$PROJ_DIR/Chart.lock"
helm dependency build "$PROJ_DIR"

helm upgrade "$PROJ" "$PROJ_DIR" \
  --install \
  --create-namespace \
  --namespace "$PROJ"
