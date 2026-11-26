[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/dbehelitate/flyte--portfolio?quickstart=1)
>**4-core** recommended — the devbox runs a Kubernetes cluster in Docker
---
```bash
flyte start devbox

kubectl get pods -A
                               
flyte run examples/hello.py main                    

uv run example.py                                 
```
