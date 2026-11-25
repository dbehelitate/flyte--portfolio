# Portfolio

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/dbehelitate/flyte-portfolio?quickstart=1)




          
  > **Machine type:** the **4-core** recommended — the devbox runs a Kubernetes cluster in Docker



      



## Handy commands

```bash
kubectl get pods -A            # peek under the hood
  
flyte get runs                 # list past runs
flyte stop devbox              # shut the cluster down
flyte start devbox             # bring it back
flyte delete devbox --volume   # remove it entirely, including data
  
flyte run examples/hello.py main  
Add `--local` (e.g. `flyte run --local examples/hello.py main`) to run in your Python process instead of on the devbox cluster.
```
