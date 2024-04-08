# Ansible Lab
Laboratório pra validar o conhecimento em Ansible.
O objetivo é criar dois containeres um com um servidor apache que será configurado o WordPress e outro com o banco de dados mysql.
Ambos os containeres estarão configurados com uma imagem ubuntu, com um usuário chamado *ansible* e com o pacote do SSH.

### Obejtivo para ser atingido
Praticar o uso da ferramenta Ansible na configuração de um ambiente básico de um servidor [WordPress](https://ubuntu.com/tutorials/install-and-configure-wordpress#1-overview) local.

### Ferramentas usadas no Control Node
- S.O. utilizado Ubuntu (https://ubuntu.com/tutorials/install-ubuntu-desktop#1-overview)
- Docker Compose version v2.19.1 (https://docs.docker.com/compose/install/)
- Docker Version: 24.0.5 (https://docs.docker.com/engine/install/)
- Ansible core 2.16.4 (https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html)
- OpenSSH Server 1.8 (https://ubuntu.com/server/docs/service-openssh) 

### Clonar repositório

    git clone git@github.com:pcalves1/ansible-lab.git

### Docker compose
A imagem foi criada para receber um argumento que é a senha do usuário pra se conectar via SSH pra utilizarmos o ansible. `Altere a senha do usuário ansible`.

    ANSIBLE_PASSWORD=senha_ansible docker compose up --build -d

##### Group vars
No o arquivo `groups_vars/mysql.yaml`, deveremos inserir o IP do container `wordpress` para permitir que o banco de dados receba informações somente desse container por questão de segurança. 
Abra o arquivo `groups_vars/wordpress.yaml`, cole o IP do container `mysql` para deixarmos claro o endereço do banco de dados que o WordPress irá usar. Não esqueça de salvar as alterações em ambos os arquivos.

Para facilitar esse processo e reduzir os erros na hora de modificar os arquivos, iremos utilizar o comando `sed` para automatizar o input do IP nesses arquivos. Para mais info de como funciona o [sed](https://www.gnu.org/software/sed/)

    sed -i "s/<<IP_DB>>/$(docker inspect mysql --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')/g" groups_vars/wordpress.yaml

    sed -i "s/<<IP_WORDPRESS>>/$(docker inspect wordpress --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')/g" groups_vars/mysql.yaml

##### Hosts
Nesse passo executaremos também o comando `sed` para substituir os IPs dos containeres WordPress e Mysql de forma automática. 

    sed -i "s/<<IP_WORDPRESS>>/$(docker inspect wordpress --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')/g" hosts

    sed -i "s/<<IP_DB>>/$(docker inspect mysql --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')/g" hosts


### Criar e copiar chaves SSH
Inicie uma conexão SSH com o container *wordpress* para criar uma chave pública de ambos os containeres com o seguinte comando. Entre com a senha definida no `ANSIBLE_PASSWORD=senha_ansible`. 

    ssh ansible@$(docker inspect wordpress --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')

Repita o mesmo passo para o  container *mysql*:

    ssh ansible@$(docker inspect mysql --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')


Em seguida execute o comando abaixo e digite **yes**. Em seguida digite a senha definida no `ANSIBLE_PASSWORD=senha_ansible`

    ssh-copy-id ansible@$(docker inspect wordpress --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')

Repita o mesmo passo para o  container *mysql*:

    ssh-copy-id ansible@$(docker inspect mysql --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')

### Rodar comando ansible
Execute o comando para aplicar as mudanças que estão definidas em cada role

    ansible-playbook provisioning.yaml -i hosts 


### Acessar o servidor criado
Apos o comando anterior concluir, abra o seu browser e no endereço entre com `localhost`. Se tudo estiver certo, aparecerá a página de Welcome do wordpress pedindo para criar usuário e senha.