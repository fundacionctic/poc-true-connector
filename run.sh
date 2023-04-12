#!/usr/bin/env bash

set -e
set -x

# Run before to configure kubectl to access the GKE cluster:
# gcloud container clusters get-credentials gke-cluster --region europe-west1-b --project moderate-prod

: ${BASE_DOMAIN:="moderate.cloud"}
: ${NGINX_CONTROLLER_SERVICE:="ingress-nginx-controller"}
: ${PROJECT_ID:="moderate-common"}
: ${MANAGED_ZONE:="moderate-cloud"}
: ${TTL:="300"}
