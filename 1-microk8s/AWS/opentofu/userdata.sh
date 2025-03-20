#!/bin/bash 
# set -e
# set -x
############################
### wait  network to come up
#URL="api.snapcraft.io"  # snap server api
# The HTTP status code to check for (200 OK)
#SUCCESS_STATUS=200
# Start an infinite loop
# while true; do
#     # Send a GET request to the URL and capture the HTTP status code
#     HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
#     # Check if the status code is 200
#     if [ "$HTTP_STATUS" -eq "$SUCCESS_STATUS" ]; then
#         echo "Request successful! HTTP status code: $HTTP_STATUS"
#         break  # Exit the loop if successful
#     else
#         echo "Request failed with status code: $HTTP_STATUS. Retrying..."
#     fi
#     # Optional: Add a delay before retrying
#     sleep 5
# done
############################
# update ubuntu
sudo apt-get update -y
sudo apt-get upgrade -y
# # set FQDN  <- var.ec2_vm_name+var.ec2_fqdn
# ssh RSA public from selected users <-- ec2_user_public_rsa
echo "${var.ec2_user_public_rsa}" >> /home/ubuntu/.ssh/authorized_keys
sudo snap version
sudo snap list
sudo snap install microk8s --classic --channel=1.32/stable
sudo microk8s status --wait-ready
# microk8s add-on offer easy way to enable dns dashboard storage registry->(LLM images can be heavy)
sudo microk8s enable dns dashboard storage registry
# This command starts a proxy to the Kubernetes Dashboard UI in the background
# it will be available at https://127.0.0.1:10443
sudo microk8s dashboard-proxy &
# kubectl alias
#aliases in Ubuntu WSL2
echo "# microk8s alias" >> /home/ubuntu/.bashrc
echo "alias k="sudo microk8s kubectl"" >> /home/ubuntu/.bashrc
# execute the bashrc to get the alias working
source /home/ubuntu/.bashrc
k get nodes -o wide

# To Access to the MicroK8S dashboard from public IP that we have to edit config file.
# kubectl -n kube-system edit service kubernetes-dashboard
# changing ‘ClusterIP’ to ‘NodePort’,
# kubectl get service <service-name> -n <namespace> -o yaml > service.yaml
# sed -i 's/type: ClusterIP/type: NodePort/' service.yaml
# sed  nodePort: 30080 
# kubectl apply -f service.yaml
# Microk8s web dashboard:system microk8s-dashboard-token
# exit

## Install Dapr arm architecture
wget https://github.com/dapr/cli/releases/download/v1.15.0/dapr_linux_arm64.tar.gz
tar -xvzf dapr_linux_arm64.tar.gz
sudo mv dapr /usr/local/bin/dapr
cd 
mkdir .kube
sudo cp -p /var/snap/microk8s/current/credentials/client.config .kube/config
sudo chown ubuntu:microk8s .kube/config
dapr init --kubernetes
k get pods -n dapr-system
## Install Ollama arm architecture


# Install ArgoCD arm architecture
# kubectl create namespace argocd
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
#expose via port server
# kubectl port-forward svc/argocd-server -n argocd 8080:443 &
#login argoCD user admin
# kubectl -n argocd get secret argocd-initial-admin-secret -o=jsonpath='{.data.password}' | base64 -d
#connect from local ssh to port 8888
# ssh -L 8888:127.0.0.1:8080 ubuntu@<ec2-public-ip>
# get the my-app-argo.yaml with wget from github or S3
# github https://github/my-app-argo.yaml
# kubectl apply -f my-app-argo.yaml
# Deploy task flask api with the comand above

# Deploy Dapr with Agent automations

# Deploy Ollama predefined LLM model