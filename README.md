# TFS ansible control node

## Installation

The control node should be setuped with the `setup.sh` script present in the TFS Ansible repository. This will install Docker that is required to launch the control node under a container.

### Build image

This ansible node comes with a ready-to-use docker service.

```
docker build -t ansible .
```

### Test container

Then, you should test your container.

```
docker run --rm -v {path}/volume:/volume ansible ansible-playbook --version
```

Comments:
- `ansible-playbook --version` - get the current version

### Create inventory

Copy the file `volume/conf/inventory.example.yaml` under `volume/conf/inventory.yaml`. Fill this inventory with your own servers list.

Please, remember that passwords **MUST** be encrypted using Vault (see Encrypt string with Vault)

### Create SSH keypair

You can run `ssh-keygen -t ed25519 -C "your_email@example.com"` on your local machine to generate a key pair. The key pair has to be under the path `volume/keys/id` / `volume/keys/id.pub`.

Follow the Github instructions to add the public key to Github: https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

### You're ready!

You are now ready to provision nodes and deploy apps!

## Encrypt string with Vault

You should encrypt your secrets. Do do it run the following command. A password will be prompt.

```
docker run --rm -i -v {path}/volume:/volume ansible ansible-vault encrypt_string '{string to encrypt}'
```

Comments:
- `-v {path}/volume:/volume` - volume

## Provision nodes

To provision the nodes you should launch the `ansible-playbook` command.

```
docker run --rm -i -v {path}/volume:/volume ansible ansible-playbook -i /volume/conf/inventory.yaml --ask-vault-pass /volume/playbooks/provision-nodes.yaml
```

Comments:
- `--ask-vault-pass` - ask for password
- `-v {path}/volume:/volume` - volume
- `-i /volume/conf/inventory.yaml` - the inventory
- `ansible ansible-playbook /volume/playbooks/provision-nodes.yaml` - launch the playbook located at `/playbooks/provision-nodes.yaml`

## Deploy an app

To provision the nodes you should launch the `ansible-playbook` command.

```
docker run --rm -i -v {path}/volume:/volume ansible ansible-playbook -i /volume/conf/inventory.yaml --ask-vault-pass /volume/playbooks/deploy-{app}.yaml
```

`{app}` is one of the below app:
- arena_refuge
- arena_sanctuaire
- arena_sanctuary
- arena_shelter
- auth
- bots
- calendar
- drifters_tales_worlds
- messaging
- rest
- rooms
- shop
- solid_pancake
- website

Comments:
- `--ask-vault-pass` - ask for password
- `-v {path}/volume:/volume` - volume
- `-i /volume/conf/inventory.yaml` - the inventory
- `ansible ansible-playbook /volume/playbooks/provision-nodes.yaml` - launch the playbook located at `/playbooks/provision-nodes.yaml`

## Troubleshooting

### Host key verification failed.

In order to disable host key checking in Ansible you should set the `ANSIBLE_HOST_KEY_CHECKING` environment variable to `False`. To do so, add `-e ANSIBLE_HOST_KEY_CHECKING=False` to the command.

## Used roles

- Role `certbot`: https://github.com/geerlingguy/ansible-role-certbot
- Role `docker`: https://github.com/geerlingguy/ansible-role-docker
