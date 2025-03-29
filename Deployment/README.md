# Blogging App Kubernetes Deployment

## Overview
This repository contains Kubernetes deployment configurations for the `blogging-app`. The setup includes:

- **Deployment**: Manages the replica set and rolling updates.
- **Service**: Exposes the application within the cluster.
- **Ingress**: Manages external access via an Nginx ingress controller.

## Deployment Configuration
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blogging-app
  namespace: blogging-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: blogging-app
  template:
    metadata:
      labels:
        app: blogging-app
    spec:
      containers:
      - name: blogging-app
        image: # Images
        ports:
        - containerPort: 8080
      imagePullSecrets:
      - name: ecr-registry-secret
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
```

## Service Configuration
```yaml
apiVersion: v1
kind: Service
metadata:
  name: blogging-app
  namespace: blogging-app
spec:
  selector:
    app: blogging-app
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
  type: ClusterIP
```

## Ingress Configuration
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: blogging-app-ingress
  namespace: blogging-app
spec:
  ingressClassName: nginx
  rules:
  - host: # DNS Load Balancer
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: blogging-app
            port:
              number: 8080
```


## Notes
- The `image` field in the Deployment configuration should be updated with the actual container image.
- The `host` field in the Ingress configuration should be updated with a valid DNS name.
- Ensure that the `ecr-registry-secret` exists in the namespace for pulling private images.

