
# 1 - Objective

How to become a good hands CTO/Architect/DevOps/SRE/Platform engineer? 

- Play hard & work smart: undestanding by playing/doing with some specially **selected & curated & documented** mini **POC (probe of concept)** projects under  **microK8s** platform.

You can install microk8s under your PC WSL2/Ubuntu or AWS free tier machine and later on move those projects into EKS or AKS or GKS or OpenShift. This environment is specially useful when close minded  IT/SecOps/platform teams does not provide confortable lab/dev environments and developers are left in "do everything by your own" schenario.

MicroK8s is a great option for those who want a lightweight, minimal Kubernetes setup with production-ready features at a smaller scale, and without the need for extra overhead. It is particularly useful for smaller deployments, edge computing, or environments where simplicity and cost are key factors.


# 2 - Here some of the selected POCs

```
├── 1-microk8s: we choose microK8S as the platform to run differents POCs
│   ├── AWS: TF/OpenTofu scripts to run it in AWS free tier t4g Ubuntu
│   └── WSL2: how to install it locally in WSL2 - Ubuntu 22
├── 2-Docker
│   └── tasks-flask-api
│       └── api
│           ├── v1
│           ├── v1.0
│           └── v2
├── 3-K8s-task-flask-api: with our own Task application we CRUD tasks in MongoDB in K8S platform
├── 4-K8s-Best-practices
│   ├── 4.1-Swiss-Army-Knife-networking
│   ├── ArgoCD
│   ├── Istio
│   ├── Mem-CPU-limits
│   └── eBPF
├── 5-WASM
│   └── build
│       ├── web
│       └── web-cache
├── 6-Prometheus-OpenTelemetry
├── 7-Kubeflow
├── 8-BigData-AI
│   └── crewAI
│       └── 1stcrewaiproject
│           ├── knowledge
│           ├── src
│           │   └── 1stcrewaiproject
│           │       ├── config
│           │       └── tools
│           └── tests
└── 9-Gitlab-CI-CD
``` 