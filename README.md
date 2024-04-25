# Inicializando a infra:
```
terraform plan
terraform apply
```

2. descomentar o módulo argocd no main.tf

```
terraform apply -target=module.argocd
```
3. com isso teremos a infra de pé.

5. acesse o painel do argocd-server e gere a senha admin

- argoCD:
https://172.18.255.204/applications?proj=&sync=&health=&namespace=&cluster=&labels=4


```
 argocd admin initial-password -n argocd
```
6. sincronize os apps

* Criando e listando comentários por matéria

```
# matéria 1
curl -sv http://url_loadbalancer:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"first post!","content_id":1}'
curl -sv http://url_loadbalancer:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"ok, now I am gonna say something more useful","content_id":1}'
curl -sv http://url_loadbalancer:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"bob@example.com","comment":"I agree","content_id":1}'

# matéria 2
curl -sv http://url_loadbalancer:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"bob@example.com","comment":"I guess this is a good thing","content_id":2}'
curl -sv http://url_loadbalancer:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"charlie@example.com","comment":"Indeed, dear Bob, I believe so as well","content_id":2}'
curl -sv http://url_loadbalancer:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"eve@example.com","comment":"Nah, you both are wrong","content_id":2}'

# listagem matéria 1
curl -sv http://url_loadbalancer:8000/api/comment/list/1

# listagem matéria 2
curl -sv http://url_loadbalancer:8000/api/comment/list/2
```
# Monitoramento:

Após subir a infra será possível montar o painel do grafana com as métricas extraídas com o prometheus

- Grafana: 
http://172.18.255.202:3000/d/msqzbWjWk/kubernetes-monitoring-dashboard?orgId=1&refresh=10s

- Prometheus:
http://172.18.255.203:8080/
