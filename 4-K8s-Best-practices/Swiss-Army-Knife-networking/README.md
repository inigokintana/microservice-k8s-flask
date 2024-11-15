# 1 - Objective

We want to have a reference networking pod to check our existing K8S platform:

- See [github link](hhttps://github.com/leodotcloud/swiss-army-knife)
- See all the [network tools installed](https://github.com/leodotcloud/swiss-army-knife/blob/main/package/Dockerfile)
- See [quick start](https://github.com/leodotcloud/swiss-army-knife/blob/main/package/Dockerfile)

# 2 - Tests done

- 2.1) Check mongoDB port is open in pod
```
Get Pod IP : smk get pods -A -o wide
Connect to swiss-army-knife: kubectl exec -n mongo swiss-army-knife  -it -- /bin/bash

    netcat -v -z -w 4 10.1.26.181 27017
    Connection to 10.1.26.181 27017 port [tcp/*] succeeded!
```
- 2.2) 