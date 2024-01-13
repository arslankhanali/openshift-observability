oc create -f namespace.yaml

oc create -f operator.yaml

oc create -f obc.yaml

./tempo-createsecret.sh

oc create -f tempoStack.yaml

oc create -f tempo-job.yaml