#!/bin/bash

NAMESPACE=couchbase

echo "******************************************************************************************"
echo `date`"   Creating namespace ${NAMESPACE}"
kubectl create namespace ${NAMESPACE}

echo "******************************************************************************************"
echo `date`"   Adding couchbase kubernetes operators to namespace ${NAMESPACE}"
unzip -qq couchbase-autonomous-operator-kubernetes_2.0.1-macos-x86_64.zip
cd couchbase-autonomous-operator-kubernetes_2.0.1-macos-x86_64
kubectl create -f crd.yaml
bin/cbopcfg --no-operator --namespace ${NAMESPACE} | kubectl create -n ${NAMESPACE} -f -
bin/cbopcfg --no-admission --namespace ${NAMESPACE} | kubectl create -n ${NAMESPACE} -f -
cd ..
rm -rf couchbase-autonomous-operator-kubernetes_2.0.1-macos-x86_64

echo "******************************************************************************************"
echo `date`"   Applying couchbase cluster helm chart to namespace ${NAMESPACE}"
#kubectl get deployments -n ${NAMESPACE}  
### https://docs.couchbase.com/operator/2.0/reference-couchbasecluster.html
#kubectl create -f couchbase-cluster.yaml -n ${NAMESPACE}
#helm install couchbase-cluster --dry-run --debug ./couchbase-cluster -n ${NAMESPACE}
helm install couchbase-cluster ./couchbase-cluster -n ${NAMESPACE}
#helm ls -n ${NAMESPACE}
#kubectl get pods -n ${NAMESPACE}
#kubectl port-forward cb-example-0000 8091 -n ${NAMESPACE}
#kubectl get svc -n ${NAMESPACE}

