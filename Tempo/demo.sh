oc create -f namespace.yaml

oc create -f operator.yaml
sleep 1m

oc create -f obc.yaml

./createsecret.sh

oc create -f tempoStack.yaml

#oc create -f tempo-job.yaml