# Ansible lab
An open source automation tool that can describe your IT infrastructure with YAML. This suite includes software provisioning, configuration management, and application deployment functionality.

## Goals
We're going to practice the configuration management functionality. We'll install and configure [*wordpress basics*](https://ubuntu.com/tutorials/install-and-configure-wordpress#1-overview) on *docker* stand alone and ansible to manage configurations containers. Let's set this computer on fire

### Pre requisites
[Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installation-guide) and [SSH]((https://ubuntu.com/server/docs/service-openssh)) on control node (The machine from which you run the Ansible CLI tools)

##### Control node
It's the main machine which Ansible is installed... It will control all containers involved this lab. 

#### Managed nodes must have Pyton and SSH
To allow our playground, this step are required for every single system that will be managed by control node

#### Dockerfile
First hand we need a container start this lab. Ubuntu will be used to this lab, this distro was chosen randomly we're not concerned abou performance. 
The following configurations was built in this image: Python, SSH, user ansible with sudo permission (this permission will be assigned but it isn't recommended) and the last one detail is the command that allows the container keeps running and listening 22 port on SSH.

#### Inventory
List of managed nodes. It can be sorted by groups for a better management, we can use for specify information to each node.  

#### SSH keys
In this part, we need to create the public key from managed node to control node and copy it.

#### Vars
The vars were used to maitain our lab organized and reusable through files or roles... 

#### Roles
Roles allows segment our code according each needs, ensuring the modularity, reusability. We can create roles to configure apache and its dependencies and use them whenever it required

#### Tasks
The definition of an ‘action’ to be applied to the managed node

#### Handlers
Actions that can be used when a task calls it, such as reload a service reconfigure a file etc.

#### Templates
Allows to inject variable to aim files configs dynamically

#### Meta
Allows to control flow of execution os ansible tasks

