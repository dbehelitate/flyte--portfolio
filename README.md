[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/dbehelitate/flyte--portfolio?quickstart=1)
>**4-core** recommended — the devbox runs a Kubernetes cluster in Docker
---
```bash
kubectl get pods -A                                  # peek under the hood
flyte run examples/hello.py main                     # run script  
--local (`flyte run --local examples/hello.py main`) # run Python process instead of cluster.
uv run example.py                                    # if dependencies inline is in script   
```
