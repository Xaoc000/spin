#!/bin/bash

set -e

GCP_PROJ=focal-freedom-236620
PREFIX=plugins/gcp
export KUBECONFIG=conf/kube.conf

# Deploy infrastructure
terraform init "$PREFIX"/terraform
terraform apply -var user="$USER" -var gcp_project="$GCP_PROJ" -auto-approve "$PREFIX"/terraform

# Wait for Kubernetes cluster
"$PREFIX"/script/wait-for-gke.bash $(terraform output name)

# Update conf/kube.conf
gcloud container clusters get-credentials $(terraform output name) --zone $(terraform output zone)

# Output files of this job
terraform output agents | tr -d ',' > conf/agents.conf 
cp "$PREFIX"/creds/id_ecdsa* conf/