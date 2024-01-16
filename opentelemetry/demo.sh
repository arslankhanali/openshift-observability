# https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-demo

namespace=opentelemetry-demo

# Add the OpenTelemetry Helm charts repository to Helm
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

# Create a new OpenShift project named 'opentelemetry-demo'
oc new-project $namespace

# Create a service account named 'opentelemetry-demo' in the project
oc create sa opentelemetry-demo

# Add the 'anyuid' security context constraint to the 'opentelemetry-demo' service account
oc adm policy add-scc-to-user anyuid -z opentelemetry-demo

# Install the OpenTelemetry Helm chart 'opentelemetry-demo' with specific configurations
helm install my-otel-demo open-telemetry/opentelemetry-demo \
    --namespace $namespace \
    --set serviceAccount.create=false \
    --set serviceAccount.name=opentelemetry-demo \
    --set prometheus.rbac.create=false \
    --set prometheus.serviceAccounts.server.create=false \
    --set prometheus.serviceAccounts.server.name=opentelemetry-demo \
    --set grafana.rbac.create=false \
    --set grafana.serviceAccount.create=false \
    --set grafana.serviceAccount.name=opentelemetry-demo \
    --values my-values-file.yaml


oc patch --namespace $namespace deployment my-otel-demo-grafana -p '{"spec":{"template":{"spec":{"securityContext":null}}}}'

# Restart the deployment to apply the changes
oc rollout restart deployment my-otel-demo-grafana

# Forward the local port 8080 to the 'my-otel-demo-frontendproxy' service in the 'opentelemetry-demo' namespace
# Can also expose a route
oc --namespace $namespace port-forward svc/my-otel-demo-frontendproxy 8080:8080

#   The following services are available at these paths once the proxy is exposed:
#   Webstore             http://localhost:8080/
#   Grafana              http://localhost:8080/grafana/
#   Feature Flags UI     http://localhost:8080/feature/
#   Load Generator UI    http://localhost:8080/loadgen/
#   Jaeger UI            http://localhost:8080/jaeger/ui/

# helm upgrade my-otel-demo open-telemetry/opentelemetry-demo --values my-values-file.yaml