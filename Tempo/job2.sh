# https://developers.redhat.com/articles/2023/08/01/how-deploy-new-grafana-tempo-operator-openshift#how_to_install_the_tempo_operator
oc delete jobs telemetrygen

kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: telemetrygen
  namespace: tracing-system
  labels:
    app: telmeetrygen
spec:
  ttlSecondsAfterFinished: 30
  template:
    spec:
      restartPolicy: OnFailure
      containers:
      - name: telemetrygen
        image: ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen:v0.74.0
        args: [traces, --otlp-endpoint=tempo-tempostack-distributor.tracing-system.svc.cluster.local:4317, --otlp-insecure, --duration=240s, --rate=4]
EOF

# docker run --rm -it ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen:v0.74.0 traces --otlp-endpoint=hub-tracing-system.apps.cluster-tfmtk.dynamic.redhatworkshops.io:4317 --otlp-insecure --duration 10s --rate 4