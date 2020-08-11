#!/bin/bash

NAMESPACE=couchbase

echo "******************************************************************************************"
echo `date`"   Uninstalling couchbase cluster helm chart to namespace ${NAMESPACE}"
#kubectl delete -f couchbase-cluster.yaml -n ${NAMESPACE}
helm uninstall couchbase-cluster -n ${NAMESPACE}

echo "******************************************************************************************"
echo `date`"   Removing couchbase kubernetes operators to namespace ${NAMESPACE}"
unzip -qq couchbase-autonomous-operator-kubernetes_2.0.1-macos-x86_64.zip
cd couchbase-autonomous-operator-kubernetes_2.0.1-macos-x86_64
bin/cbopcfg --no-operator --namespace ${NAMESPACE} | kubectl delete -n ${NAMESPACE} -f -
bin/cbopcfg --no-admission --namespace ${NAMESPACE} | kubectl delete -n ${NAMESPACE} -f -
kubectl delete -f crd.yaml
cd ..
rm -rf couchbase-autonomous-operator-kubernetes_2.0.1-macos-x86_64

echo "******************************************************************************************"
echo `date`"   Deleting namespace ${NAMESPACE}"
kubectl delete namespace ${NAMESPACE}