# How to install microK8S in Windows WSL2 Ubuntu
TOC
- [How to install microK8S in Windows WSL2 Ubuntu](#how-to-install-microk8s-in-windows-wsl2-ubuntu)
  - [1 - Install WSL2 & microK8s install](#1---install-wsl2--microk8s-install)
    - [1.1 - In case you are behind company proxy](#11---in-case-you-are-behind-company-proxy)
    - [1.2 - Checking everything is right](#12---checking-everything-is-right)
    - [1.3 - Microk8s web dashboard proxy](#13---microk8s-web-dashboard-proxy)
    - [1.4 - Microk8s web dashboard using service NodePort](#14---microk8s-web-dashboard-using-service-nodeport)
    - [1.5 - Linux alias](#15---linux-alias)
  - [2 - Troubleshooting](#2---troubleshooting)
## 1 - Install WSL2 & microK8s install
Follow steps in the link [WSL2 install](https://microk8s.io/docs/install-wsl2)

### 1.1 - In case you are behind company proxy
```
wsl --update --web-download 
wsl -l -v
wsl --install -d Ubuntu-22.04
```

### 1.2 - Checking everything is right:

## 1 - Install WSL2 & microK8s install
Follow steps in the link [WSL2 install](https://microk8s.io/docs/install-wsl2)

### 1.1 - In case you are behind company proxy
```
wsl --update --web-download 
wsl -l -v
wsl --install -d Ubuntu-22.04
```

### 1.2 - Checking everything is right:
````
wsl 
sudo microk8s status --wait-ready
  microk8s is running

sudo microk8s kubectl version
  Client Version: v1.32.2
  Kustomize Version: v5.5.0
  Server Version: v1.32.2
 
````

### 1.3 - Microk8s web dashboard proxy:
````
kubectl describe secret -n kube-system microk8s-dashboard-token

sudo microk8s dashboard-proxy &
````
- This last command starts a proxy to the Kubernetes Dashboard UI and it will be available at https://127.0.0.1:10443
- Launch it as a background process with <span style="color: red;">&</span> in order to regain console foreground control
- Use the token got above to log into Dashboard
### 1.4 - Microk8s web dashboard using service NodePort:
Alternatively, if you do not want to use the proxy service above, you can convert dashboard service from clusterip service into nodeport service. For example:
````yaml
sudo microk8s kubectl edit  svc/kubernetes-dashboard -n kube-system
  type: NodePort
  nodePort: 30080

sudo microk8s kubectl describe svc/kubernetes-dashboard -n kube-system
  Name:                     kubernetes-dashboard
  Namespace:                kube-system
  Labels:                   k8s-app=kubernetes-dashboard
  Annotations:              <none>
  Selector:                 k8s-app=kubernetes-dashboard
  # check NodePort type
  Type:                     NodePort
  IP Family Policy:         SingleStack
  IP Families:              IPv4
  IP:                       10.152.183.21
  IPs:                      10.152.183.21
  Port:                     <unset>  443/TCP
  TargetPort:               8443/TCP
  # check NodePort port
  NodePort:                 <unset>  30080/TCP
  Endpoints:                10.1.101.69:8443
  Session Affinity:         None
  External Traffic Policy:  Cluster
  Internal Traffic Policy:  Cluster
  Events:                   <none>

# to get the server IP
sudo microk8s kubectl get nodes -o wide
  NAME              STATUS   ROLES    AGE   VERSION   INTERNAL-IP      EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION                       CONTAINER-RUNTIME
  desktop-41ahscb   Ready    <none>   14h   v1.32.2   172.23.103.249   <none>        Ubuntu 22.04.5 LTS   5.15.167.4-microsoft-standard-WSL2   containerd://1.6.36
````
Dashboard should be available in your **https://VM-ip:30080 port**, in our example https://172.23.103.249:30080

### 1.5 - Linux alias:
Optionally, you can add the following alias into .bashrc to ease command line interaction:
````
#aliases in Ubuntu 
alias smk="sudo microk8s kubectl"
````


## 2 -  Troubleshooting

error: timed out waiting for the condition on deployments/kubernetes-dashboard

https://microk8s.io/docs/troubleshooting

Solution: use proxy free connection/wifi during microk8s install
