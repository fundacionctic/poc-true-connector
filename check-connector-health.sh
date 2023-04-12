#!/usr/bin/env bash

set -e
set -x

: ${HOST:="localhost"}

curl -k https://${HOST}:8090/about/version
curl -k https://${HOST}:8091/about/version

echo -e "✅ Both the Provider and the Consumer connectors seem to be healthy"