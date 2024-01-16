oc create -f namespace.yaml

oc create -f operator.yaml

oc create -f obc.yaml

./createsecret.sh

oc create -f tempoStack.yaml

oc create -f route.yaml
#oc create -f tempo-job.yaml