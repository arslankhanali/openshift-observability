oc create -f operator.yaml
oc create -f storagesystem.yaml
oc create -f obc.yaml

oc patch console.operator cluster -n openshift-storage --type json -p '[{"op": "add", "path": "/spec/plugins", "value": ["odf-console"]}]'