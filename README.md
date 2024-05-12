# Haproxy
Helm Chart of Haproxy in K8S (for Postgres Patroni cluster)

# Usage
Use the following command to render the Helm Chart:
```bash
helm template . --name-template=patroni-haproxy --set-file haproxy.config="configs/haproxy.cfg"
```
OR put a config into the values file to haproxy.config key
```yml
haproxy:
  config: |-
    example
```
```bash
helm template . --name-template=patroni-haproxy
```
