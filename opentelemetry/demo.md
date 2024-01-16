https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-demo

./demo.sh
helm upgrade my-otel-demo open-telemetry/opentelemetry-demo --values my-values-file.yaml


# ERRORS
### Grafana error about 
There is an error for grafana deployment regarding security context
<!-- # Patch the deployment to remove the securityContext section, otherwise you will get an error because of following lines
    #   securityContext:
    #     runAsUser: 472
    #     runAsGroup: 472
    #     runAsNonRoot: true
    #     fsGroup: 472 -->
> Fix
Go to grafana deployment yaml and delete lines regarding 412 ID etc. there are 4/5 lines  
Then restart the deployment. Grafana dashboard should start appearing.

oc patch --namespace $namespace deployment my-otel-demo-grafana -p '{"spec":{"template":{"spec":{"securityContext":null}}}}'
oc rollout restart deployment my-otel-demo-grafana

### Cluster role and Role binding already presenty
# Error: INSTALLATION FAILED: Unable to continue with install: ClusterRole "my-otel-demo-otelcol" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-namespace" must equal "opentelemetry-demo-tempo": current value is "opentelemetry-demo"

>Fix
oc delete ClusterRole my-otel-demo-otelcol
oc delete ClusterRoleBindings my-otel-demo-otelcol

### chart delpoys but no UI and services pod dont start
>Fix
You are probably running on OCP and need to run extra commands like giving anyuid scc to the service account.

### adsense error
<!-- Picked up JAVA_TOOL_OPTIONS: -javaagent:/usr/src/app/opentelemetry-javaagent.jar
Error occurred during initialization of VM
agent library failed Agent_OnLoad: instrument
Error opening zip file or JAR manifest missing : /usr/src/app/opentelemetry-javaagent.jar -->

