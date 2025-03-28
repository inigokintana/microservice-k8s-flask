#https://sarinsuriyakoon.medium.com/deploy-ollama-on-local-kubernetes-microk8s-6ca22bfb7fa3

k apply -f namespace.yaml
k apply -f deployment.yaml 
k apply -f service.yaml

k -n ollama port-forward service/ollama 11434:80 &

 -n ollama exec -it pod/ollama-59476b6f4c-6sxct -- sh
# 
# 
# 
# which ollama
/usr/bin/ollama
# ollama run llama3.2:1b
pulling manifest 
pulling 74701a8c35f6... 100% ▕████████████████████████████████████████████████████████████████████████████████████████████████▏ 1.3 GB                         
pulling 966de95ca8a6... 100% ▕████████████████████████████████████████████████████████████████████████████████████████████████▏ 1.4 KB                         
pulling fcc5a6bec9da... 100% ▕████████████████████████████████████████████████████████████████████████████████████████████████▏ 7.7 KB                         
pulling a70ff7e570d9... 100% ▕████████████████████████████████████████████████████████████████████████████████████████████████▏ 6.0 KB                         
pulling 4f659a1e86d7... 100% ▕████████████████████████████████████████████████████████████████████████████████████████████████▏  485 B                         
verifying sha256 digest 
writing manifest 
success 
>>> 
Use Ctrl + d or /bye to exit.
>>> bye