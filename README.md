
# 1 - Objective
- **NOT READY for use yet**
- **WIP - WIP - WIP - WIP - WIP - WIP - WIP - WIP - WIP - WIP**
- **NOT READY for use yet**

AI agents (hands) getting data from local data sources and passing RAG results to local LLM (brain) with Ollama to get a human readable result.

Data is kept private and never goes outsite the company defined infraestructure.

All done with CNCF neutral vendor OSS technology.

![Architecture Diagram](4-AI-Ollama-Dapr-microk8s.drawio.png)

**How is this done?**
- Picking and integrating key [CNCF's certified neutral vendor projects](https://www.cncf.io/projects/) such as:
    - Microk8s, see [certified kubernetes status](https://www.cncf.io/training/certification/software-conformance/) 
    - Dapr AI agents:
        - see [Dapr graduated status](https://www.cncf.io/projects/dapr/)
        - see [Dapr AI Agents Blog](https://www.cncf.io/blog/2025/03/12/announcing-dapr-ai-agents/)
    - Open Telemetry, see [incubating status](https://www.cncf.io/projects/opentelemetry/)
    - ArgoCD, see [graduated status](https://www.cncf.io/projects/argo/)
    - ...
- More on [CNCF projects status](https://www.cncf.io/project-metrics/)

**Why is this project done? In orther to become a good hands on CTO/Architect/DevSecOps/SRE/Platform/AI engineer, you need to:**
- Play hard & work smart: undestanding by playing with some specially **selected & curated & documented** mini **POC (probe of concept)** projects.
- Explain what you have done to someone else for better understanding
- Try to return some value to OSS community. We receive a lot and contribute very little.

## 1.1 - Why Kubernetes?
Kubernetes is vendor-neutral because it:

- Is open-source and governed by the CNCF, with contributions from many companies.
- Can be deployed on any infrastructure (cloud, on-premises, hybrid).
- Supports multiple extensions and integrations, ensuring flexibility and compatibility.
- Prevents vendor lock-in by abstracting away cloud-specific details.

In short, Kubernetes is designed to be flexible, extensible, and cloud-agnostic, giving users the freedom to choose the best infrastructure for their needs without being tied to any one vendor.

## 1.2 - Why microk8s?
MicroK8s is a great option for those who want a lightweight, minimal Kubernetes setup with production-ready features at a smaller scale, and without the need for extra overhead. It is particularly useful for smaller deployments, edge computing, or environments where simplicity and cost are key factors.

You can start small and install microk8s under your PC WSL2/Ubuntu or AWS free tier machine and later on move those projects into [microk8s HA environment](https://www.cncf.io/online-programs/microk8s-ha-under-the-hood-kubernetes-with-dqlite/), EKS, AKS, GKS or OpenShift. 

This use case is specially valuable when corporate close minded IT/SOC/SecOps/platform teams does not provide confortable lab/dev environments and developers are left in **"very restricted"** or **"do everything by your own"** schenarios. DevOps culture is not the same in every place.


## 1.3 - Why DAPR AI Agents?
This is a summary from [CNCF's Dapr AI Agents Blog](https://www.cncf.io/blog/2025/03/12/announcing-dapr-ai-agents/)

- **Robust and well-integrated workflow capabilities right from the very beginning**: Dapr Agents is built on top of Dapr’s full featured workflow engine. Dapr is reliable for production use cases. Dapr Agents uses Dapr’s proven workflow system, which is designed to handle failures, retries, and scaling. This gives 

- **Databases and message broker abstraction**: Dapr Agents abstracts integrations with databases and message brokers using Dapr’s consistent programming model. You can  switch between databases like Postgres, MySQL, AWS DynamoDB and a dozen others without having to rewrite your agent code. Additionally, Dapr Agents integrates seamlessly with Kubernetes environments and runs just as well locally or on a VM.

- **Communication through message brokers**: as mentioned above, Dapr Agents communicate through message brokers. This allows for collaborative workflows where agents with different roles can share context leading to very reliable communications and no loss of context in a large multi-agent setup.

- **OpenTelemetry support**: Dapr Agents offers metrics and tracing out-of-the-box, supporting Prometheus and OpenTelemetry formats respectively.

- **Event-driven and non-deterministic execution**: next agent to respond can be dynamically determined by an LLM, enabling autonomous and evolving workflows.

## 1.4 - Why Ollama?

## 1.5 - Why Open Telemetry?

## 1.6 - Why Flask?

## 1.7 - Why ArgoCD?


# 2 - Here some of the selected POCs

```
├── 1-microk8s: we choose microK8S as the neutral vendor platform to run differents POCs
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
# 3 - Install
Go to each numbered POC subfolder for installation instructions and project more detailed explanations