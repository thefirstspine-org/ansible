# TFS ansible control node

## Build container

```
docker build -t ansible .
```

## Test container

```
docker run --rm -v {path}/conf/hosts/:/etc/ansible/hosts -v {path}/playbooks:/playbooks ansible ansible-playbook --version
```

Comments:
- `-v {path}/conf/hosts/:/etc/ansible/hosts` - inventory
- `-v {path}/playbooks:/playbooks` - playbooks
- `ansible-playbook --version` - get the current version

## Provision nodes

```
docker run --rm -v {path}/conf/hosts/:/etc/ansible/hosts -v {path}/playbooks:/playbooks ansible ansible-playbook /playbooks/provision-nodes.yaml
```

Comments:
- `-v ~/.ssh:/root/.ssh` - transfer SSH keys to the container
- `-v {path}/conf/hosts/:/etc/ansible/hosts` - inventory
- `-v {path}/playbooks:/playbooks` - playbooks
- `ansible ansible-playbook /playbooks/provision-nodes.yaml` - launch the playbook located at `/playbooks/provision-nodes.yaml`

## Troubleshooting

### Host key verification failed.

In order to disable host key checking in Ansible is by setting the `ANSIBLE_HOST_KEY_CHECKING` environment variable to `False`. To do so, add `-e ANSIBLE_HOST_KEY_CHECKING=False` to the command.

## Used roles

- Role `certbot`: https://github.com/geerlingguy/ansible-role-certbot
- Role `docker`: https://github.com/geerlingguy/ansible-role-docker
