#!/usr/bin/env bash

sops -d secrets.yml | kubectl apply -f -
