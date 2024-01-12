oc project tracing-system

AWS_ACCESS_KEY_ID=$(oc get secret tempo-bucket -n tracing-system -o json | jq -r '.data.AWS_ACCESS_KEY_ID' | base64 -d)
AWS_SECRET_ACCESS_KEY=$(oc get secret tempo-bucket -n tracing-system -o json | jq -r '.data.AWS_SECRET_ACCESS_KEY' | base64 -d)
ENDPOINT="http://$(oc get route -n openshift-storage s3 -ojsonpath={.spec.host})"
BUCKETNAME=$(oc get cm tempo-bucket -n tracing-system -ojsonpath={.data.BUCKET_NAME})

oc -n tracing-system create secret generic s3-secret --from-literal=access_key_id=$AWS_ACCESS_KEY_ID --from-literal=access_key_secret=$AWS_SECRET_ACCESS_KEY --from-literal=endpoint=$ENDPOINT --from-literal=bucket=$BUCKETNAME