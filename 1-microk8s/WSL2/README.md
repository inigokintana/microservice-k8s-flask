# How to install microK8S in Windows - Follow the steps

## 1 -  WXP-10 -  WSL2 Ubuntu 22
#To avoid proxy
wsl --update --web-download 
wsl -l -v
wsl --install -d Ubuntu-22.04

## 2 - microK8s
https://microk8s.io/docs/install-wsl2

```
wsl 
sudo microk8s status --wait-ready

microk8s is running
high-availability: no
  datastore master nodes: 127.0.0.1:19001
  datastore standby nodes: none
addons:
  enabled:
    dns                  # (core) CoreDNS
    ha-cluster           # (core) Configure high availability on the current node
    helm                 # (core) Helm - the package manager for Kubernetes
    helm3                # (core) Helm 3 - the package manager for Kubernetes
  disabled:
    cert-manager         # (core) Cloud native certificate management
    cis-hardening        # (core) Apply CIS K8s hardening
    community            # (core) The community addons repository
    dashboard            # (core) The Kubernetes dashboard
    gpu                  # (core) Alias to nvidia add-on
    host-access          # (core) Allow Pods connecting to Host services smoothly
    hostpath-storage     # (core) Storage class; allocates storage from host directory
    ingress              # (core) Ingress controller for external access
    kube-ovn             # (core) An advanced network fabric for Kubernetes
    mayastor             # (core) OpenEBS MayaStor
    metallb              # (core) Loadbalancer for your Kubernetes cluster
    metrics-server       # (core) K8s Metrics Server for API access to service metrics
    minio                # (core) MinIO object storage
    nvidia               # (core) NVIDIA hardware (GPU and network) support
    observability        # (core) A lightweight observability stack for logs, traces and metrics
    prometheus           # (core) Prometheus operator for monitoring and logging
    rbac                 # (core) Role-Based Access Control for authorisation
    registry             # (core) Private image registry exposed on localhost:32000
    rook-ceph            # (core) Distributed Ceph storage using Rook
    storage              # (core) Alias to hostpath-storage add-on, deprecated

iquintza@B1083852:/mnt/c/WINDOWS/system32$
sudo microk8s kubectl version
Client Version: v1.31.1
Kustomize Version: v5.4.2
Server Version: v1.31.1
 

kubectl describe secret -n kube-system microk8s-dashboard-token

sudo microk8s dashboard-proxy

# aliases
alias smk="sudo microk8s kubectl"
```

## 3 -  Troubleshooting

error: timed out waiting for the condition on deployments/kubernetes-dashboard

https://microk8s.io/docs/troubleshooting

Use free proxy wifi


## 4 - Container K8S Flask API demo

https://www.linkedin.com/pulse/distroless-images-python-flask-perfect-combination-fast-chatterjee-qgbjc/


Distroless no so good - log - shell for errors -lack dev control - alpine