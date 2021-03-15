#!/bin/sh

oc create namespace openshift-local-storage
oc create namespace openshift-container-storage
oc label namespace openshift-local-storage "openshift.io/cluster-monitoring=true"

# Go to UI and install Local Storage Operator

# Verify nodes are labeled correctly
# Should display workers only
oc get nodes -l cluster.ocs.openshift.io/openshift-storage

# Deploy disk-id DaemonSet
oc apply -f https://gist.githubusercontent.com/jproque-dell/f030ca96e01ff54dc88b4b33cbda3653/raw/61feb52d0230a95e0d284c650155c9f3ae159e5f/disk-id-ds.yaml
oc get pods -l name=disk-gatherer -n default
kubectl logs -n default -l name=disk-gatherer
# Gather the disk IDs and fill in the 2-local-block-storage.yaml with these values
