
# 1 - Objective

How to become a good hands on architect? Implementing best practices with POCs (probe of concepts) on certain specialy selected mini projects.

Here are some examples

# 2 - Structure

```

├── 1-microk8s: we choose microK8S as the platform to run differents POCs
│   └── WSL2
│   │   └── README.md - How to install it in WSL2 - Ubuntu 22
│   ├── Ubuntu: How t instal it in Ubuntu
│   ├── AWS: TF/OpenTofu scripts to run it in AWS
│
├── 2-Docker: we need to build our own docker images with the demo aplications we build
│   └── tasks-flask-api: a Flask API to handle tasks documented with Flasgger
│       ├── Dockerfile
│       ├── api: YAML files to define Flasgger API /apidocs help
│       │   ├── v1
│       │   └── v2
│       ├── app.py
│       └── requirements.txt
├── 3-K8s-task-flask-api: with our own Task application we CRUD tasks in MongoDB in K8S platform
│   ├── README.md
│   ├── flask-api-secret.yml
│   ├── mongo-pv.yml
│   ├── mongo-pvc.yml
│   ├── mongo-svc.yml
│   ├── mongo.yml
│   ├── taskmaster-ikz-secret.yml
│   ├── taskmaster-ikz.yml
│   └── taskmaster-svc-ikz.yml
├── 4-K8s-Best-practices
│   ├── ArgoCD
│   ├── Istio
│   ├── Mem-CPU-limits
│   ├── Swiss-Army-Knife-networking
│   │   ├── README.md
│   │   └── swiss-army-knife.yaml
│   └── eBPF
├── 5-WASM
├── 6-Prometheus-OpenTelemetry
├── 7-Kubeflow
├── 8-BigData-AI
├── 9-Gitlab-CI-CD
│   └── README.md
├── LICENSE
└── README.md
``` 

More to come