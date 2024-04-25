# Inicializando a infra:
```
terraform plan
terraform apply
```

2. descomentar o módulo argocd no main.tf

```
terraform apply -target=module.argocd
```
3. acesse o painel do argocd-server e gere a senha admin

- argoCD: http://172.18.255.200/

```
 argocd admin initial-password -n argocd
```
4. sincronize os apps para o deploy dos charts
aplicação: http://172.18.255.202:8000/

Grafana: http://172.18.255.201:3000/

Prometheus: http://http://172.18.255.203:8080/

* Criando e listando comentários por matéria

```
# matéria 1
curl -sv http://172.18.255.202:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"first post!","content_id":1}'
curl -sv http://172.18.255.202:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"ok, now I am gonna say something more useful","content_id":1}'
curl -sv http://172.18.255.202:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"bob@example.com","comment":"I agree","content_id":1}'

# matéria 2
curl -sv http://172.18.255.202:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"bob@example.com","comment":"I guess this is a good thing","content_id":2}'
curl -sv http://172.18.255.202:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"charlie@example.com","comment":"Indeed, dear Bob, I believe so as well","content_id":2}'
curl -sv http://172.18.255.202:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"eve@example.com","comment":"Nah, you both are wrong","content_id":2}'

# listagem matéria 1
curl -sv http://172.18.255.202:8000/api/comment/list/1

# listagem matéria 2
curl -sv http://172.18.255.202:8000/api/comment/list/2
```
