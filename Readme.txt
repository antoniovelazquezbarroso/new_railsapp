#  README

# To provision with vagrant just run vagrant up

# To provision with metal inventory you should run 
#    $ ansible-playbook playbooks/main.yml -i inventories/metal/inventory --ask-become-pass
#     or 
#    $ ansible-playbook playbooks/main.yml -i inventories/metal/inventory -v -b -c paramiko --ask-become-pass


# To redirect external traffic from the external router to the web server of railsapp
# you need nginx installed at the server where you receive redirected port 80 traffic of your router
# (it is 192.168.1.32 at home; the same host used to monitor railsapp)
# and to redirect with a proxy this traffic to the web server of railsapp
# (it is 192.168.1.30 in my metal inventory)
# see sample config for the redirect proxy at /playbooks/nginx/files/proxypass.conf.sample 


# To install the required roles defined at requirements.yml
    $ ansible-galaxy install -r requirements.yml
# The installation folder is /roles because of the configuration in ansible.cfg

# To run a specific playbook (i.e. railsapp/deploy.yml)
    $ ansible-playbook playbooks/railsapp/deploy.yml -i inventories/vagrant/inventory -e "ansible_ssh_user='vagrant' ansible_ssh_private_key_file='~/.vagrant.d/insecure_private_key'"
    

# =========================================================================================================
# IF YOU REINSTALL THE ROLES (from ansible-galaxy), CHECK FOR REQUIRED AMMENDMENTS at:

#   role rvm.ruby/tasks/rubies.yml, incluir "changed_when: False" como ultima linea en los tasks
#         Symlink ruby related binaries on the system path, y
#         Symlink bundler binaries on the system path
#         es solo por estetica, para que no salga recurrentemente como "changed" al correr el playbook

# ==========================================================================================================

## Building the VMs

  1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
  2. Download and install [Vagrant](http://www.vagrantup.com/downloads.html).
  3. [Mac/Linux only] Install [Ansible](http://docs.ansible.com/intro_installation.html).
  4. Run `ansible-galaxy install -r requirements.yml` in this directory to get the required Ansible roles.
  5. Run `vagrant up` to build the VMs and configure the infrastructure.
