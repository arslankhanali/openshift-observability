# https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-demo

helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

oc new-project opentelemetry-demo
oc create sa opentelemetry-demo
oc adm policy add-scc-to-user anyuid -z opentelemetry-demo

helm install my-otel-demo open-telemetry/opentelemetry-demo \
    --namespace opentelemetry-demo \
    --set serviceAccount.create=false \
    --set serviceAccount.name=opentelemetry-demo \
    --set prometheus.rbac.create=false \
    --set prometheus.serviceAccounts.server.create=false \
    --set prometheus.serviceAccounts.server.name=opentelemetry-demo \
    --set grafana.rbac.create=false \
    --set grafana.serviceAccount.create=false \
    --set grafana.serviceAccount.name=opentelemetry-demo 

