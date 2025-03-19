#!/bin/bash
### wait  network to come up
URL="api.snapcraft.io"  # snap server api
# The HTTP status code to check for (200 OK)
SUCCESS_STATUS=200
# Start an infinite loop
while true; do
    # Send a GET request to the URL and capture the HTTP status code
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
    # Check if the status code is 200
    if [ "$HTTP_STATUS" -eq "$SUCCESS_STATUS" ]; then
        echo "Request successful! HTTP status code: $HTTP_STATUS"
        break  # Exit the loop if successful
    else
        echo "Request failed with status code: $HTTP_STATUS. Retrying..."
    fi
    # Optional: Add a delay before retrying
    sleep 5
done
# update ubuntu
sudo apt-get update -y
# # set FQDN  <- var.ec2_vm_name+var.ec2_fqdn
# ssh RSA public from selected users <-- ec2_user_public_rsa
echo "${var.ec2_user_public_rsa}" >> /home/ubuntu/.ssh/authorized_keys
sudo snap version
sudo snap list
sudo snap install microk8s --classic --channel=1.32/stable
sudo microk8s status --wait-ready
sudo microk8s enable dns dashboard
sudo snap alias microk8s.kubectl kubectl
#https://alabekir1975.medium.com/installing-microk8s-on-aws-on-ubuntu20-04-server-e362091fb5ee
bash
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube
exit
bash
sudo microk8s enable dashboard dns  
# sudo microk8s enable registry istio
# To Access to the MicroK8S dashboard from public IP that we have to edit config file.
# kubectl -n kube-system edit service kubernetes-dashboard
# changing ‘ClusterIP’ to ‘NodePort’,
kubectl get service <service-name> -n <namespace> -o yaml > service.yaml
sed -i 's/type: ClusterIP/type: NodePort/' service.yaml
sed  nodePort: 30080 
kubectl apply -f service.yaml
#Microk8s web dashboard:system microk8s-dashboard-token
exit

# Options bash shell script, ansible, argoCD
# We choose argoCD
#install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
#expose vi aport server
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
#login argoCD user admin
#kubectl -n argocd get secret argocd-initial-admin-secret -o=jsonpath='{.data.password}' | base64 -d
#connect from local ssh to port 8888
# ssh -L 8888:127.0.0.1:8080 ubuntu@<ec2-public-ip>
# get the my-app-argo.yaml with wget from github or S3
github https://github/my-app-argo.yaml
kubectl apply -f my-app-argo.yaml
# Deploy task flask api with the comand above
# Deploy CrewAI with automations