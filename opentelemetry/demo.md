https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-demo

```sh
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

    # --values my-values-file.yaml

helm install my-otel-demo open-telemetry/opentelemetry-demo --values my-values-file.yaml


helm uninstall my-otel-demo open-telemetry/opentelemetry-demo


- All services are available via the Frontend proxy: http://localhost:8080
  by running these commands:
     oc --namespace opentelemetry-demo port-forward svc/my-otel-demo-frontendproxy 8080:8080

  The following services are available at these paths once the proxy is exposed:
  Webstore             http://localhost:8080/
  Grafana              http://localhost:8080/grafana/
  Feature Flags UI     http://localhost:8080/feature/
  Load Generator UI    http://localhost:8080/loadgen/
  Jaeger UI            http://localhost:8080/jaeger/ui/

```
# ERRORS
### Grafana error about 
There is an error for grafana deployment regarding security context
> Fix
Go to grafana deployment yaml and delete lines regarding 412 ID etc. there are 4/5 lines  
Then restart the deployment. Grafana dashboard should start appearing.

### Cluster role and Role binding already presenty
>Fix
Delete that role and rolebinding

### chart delpoys but no UI and services pod dont start
>Fix
You are probably running on OCP and need to run extra commands like giving anyuid scc to the service account.