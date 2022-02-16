# -*- mode: Python -*-
docker_build(
    'db-image',
    '.',
    dockerfile='db/deployments/Dockerfile'
)

docker_build('rest-api-image', '.', dockerfile='services/rest-api/deployments/Dockerfile')

k8s_yaml([
 './db/deployments/kubernetes.yaml',
 './services/rest-api/deployments/kubernetes.yaml',
])

k8s_resource(workload='db', port_forwards=5432)
k8s_resource(workload='rest-api', resource_deps=['db'], port_forwards=8080)