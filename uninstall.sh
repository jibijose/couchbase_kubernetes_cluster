#!/bin/bash

NAMESPACE=couchbase

kubectl delete -f couchbase-cluster.yaml -n ${NAMESPACE}

unzip -qq couchbase-autonomous-operator-kubernetes_2.0.1-macos-x86_64.zip
cd couchbase-autonomous-operator-kubernetes_2.0.1-macos-x86_64
bin/cbopcfg --no-operator --namespace ${NAMESPACE} | kubectl delete -n ${NAMESPACE} -f -
bin/cbopcfg --no-admission --namespace ${NAMESPACE} | kubectl delete -n ${NAMESPACE} -f -
kubectl delete -f crd.yaml
cd ..
rm -rf couchbase-autonomous-operator-kubernetes_2.0.1-macos-x86_64

kubectl delete namespace ${NAMESPACE}