# openshift-observability

## Env
Tested on OpenShift 4.14

## Demo for service mesh
#### Distributed Tracing
1. All required manifests are in servicemesh folder
2. Jaeger and Kali are deployed as part of Service Mesh
3. Control Plane(Istio, Kiali, Jaeger) is in bookinfo-mesh namespace 
4. Application is in bookinfo namespace
5. Once deployed refresh producpage
   1. Get routes (App/Kiali/Jaeger) from `bookinfo-mesh` namespace
      1. Navigate to `topology` in `Developer View`
   2. For App
      1. Route is istio-ingressgateway
      2. Use http instead of https
      3. append /productpage at the end
      4. e.g. `http://bookinfo-bookinfo-gateway-684888c0ebb17f37-bookinfo-mesh.apps.cluster-vdfs9.dynamic.redhatworkshops.io/productpage`
      5. Refresh to create traces
   3. Observer traces in Kiali and Jaeger dashboards
#### Observavility 
1. In administrator view
   1. Observe -> Dashboards
   2. Select
      1. Dashboard: Kubernetes/Conpute Resource/Namespace (Workloads)
      2. NameSpace: Bookinfo
      3. Type: Deployment

## Demo for opentelemetry 
1.  Run demo.sh in opentelemetry folder

## Demo for  Tempo
1. Make sure ODF is operator is installed properly. We need to use s3 storage
2. All files are in Tempo folder
3. Deploy tempo operator yaml
4. Deploy ObjectBucketClaim yaml
5. Run tempo-createsecret bash script
6. Deploy tempoStack yaml
7. Deploy tempo Job yaml to create traces
   1. View Traces in Jaeger dashboard provided by Tempo

## Demo for ODF

# Future work
### GitOps
1. Manifests to install GitOps operator

### Known Issues
1. istio-ServiceMeshMember.yaml manifest gives errors when deployed using gitops.
   1. Permissions need to be fixed.