# Comentários e Aprimoramentos

## Objetivo:
- Desenvolver e administrar um ambiente Kubernetes altamente eficaz na AWS, seguindo as melhores práticas de DevOps.

Eu havia desenvolvido usando serviços da aws https://github.com/iriscafe/devops-test nesse projeto, mas ao perceber que na entrega devido aos custos eu não entregaria as aplicações funcionando, então subi um kind e refiz o projeto.

Fluxograma que idealizei:
!['](https://github.com/iriscafe/devops-test/blob/master/imgs/cicd-workflow.gif?raw=true)

Kind feito:
!['](https://github.com/iriscafe/desafio-devops/blob/master/imgs/cicd-kind.png?raw=true)

## Tecnologias Escolhidas e Justificativas:
- Iniciei criando um bind para expor o gunicorn no dockerfile e enviando o build para o dockerhub.
- Utilizei o Terraform para criar toda a infraestrutura inicial, incluindo Kind, metallb, ingress e ArgoCD.

- O CI é realizado pelo GitFlow, o versionamento de imagem é feito pelo dockerHUB a cada atualização. 
- A partir da imagem enviada ao dockeHub, o campo de tag no values do Helm Chart da aplicação é atualizada com o hash da imagem em questão e assim o argoCD segue para o deploy da aplicação. 
- Além disso, o argoCD também é o responsável pela implementação do ambiente de monitoramento usando Grafana e Prometheus, escolhidos por sua facilidade de gerenciamento através dos Helm Charts.

## Melhorias:
- Usar menos hardcode em alguns módulos como ArgoCD e também nos helm charts.
- Implementar o ingress NGINX corretamente. Acabei optando por usar LoadBalancar, mas acho que seria muito mais prático ter usado o NGINX.
- usar o kustomize pra diferenciar os ambientes e também facilitar o versionamento.
- Uso do cert manager para garantir mais seguranças entre as comunicações.
- Implementar o cluster Autoscaler para escalabilidade automática do número de nós no cluster, garantindo resposta dinâmica à demanda e economia de recursos, mas devido ao tempo não consegui.
- Implementar toda a infra dividindo entre backend e deployment, onde em backend seria feito a instalação dos recursos e no deployment a execução de toda aplicação sem a necessidade de ajuste manual. Ex.: Não consigo subir o argocd juntamente no cluster, então preciso esperar pra então poder subir. O que num sistema com outro fluxo de automação talvez fosse mais eficiente.

# Histórico de Versões

## [Apr 24, 2024]
- Documentação.
- implementação do kind.
- Mudança de cluster por conta de custos.
- Repositório de origem atualizado no ArgoCD.
- Atualização no CodeBuild e sistema de versionamento.

## [Apr 23, 2024]
- Correção no Dockerfile: inserção de configuração de bind para o Gunicorn.
- Alteração na porta exposta.
- Adição do Helm da aplicação ao ArgoCD.
- Ajuste na configuração do ingress.

## [Apr 22, 2024]
- Correção no Dockerfile.

## [Apr 19, 2024]
- Adição dos arquivos do Helm Charts à aplicação.
- Ajustes no ArgoCD.
- Renomeação do arquivo Codestar e ajuste nas variáveis do CodeBuild.
- Adição do controlador de ingress.
- Adição do Fluxograma.

## [Apr 18, 2024]
- Ajustes nos caminhos do kubectl_manifest para futuros Helm Charts.
- Adição do ArgoCD à implantação.
- Correção do nome do ECR no CodeBuild.
- Atualização da imagem do CodeBuild e do computador.
- Atualização do pip no Dockerfile.
- Atualização do pip na compilação.
- Ajuste no caminho do CodeBuild.
- Adição do CodeBuild à implementação e ao buildspec.
- Ajustes nas permissões do Codestar no CodePipeline.
- Adição do módulo CodePipeline.
- Adição do módulo EKS.
- Adição da VPC.
- Dockerização da aplicação.
- Commit inicial.
