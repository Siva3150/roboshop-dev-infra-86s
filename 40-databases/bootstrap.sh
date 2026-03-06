###!/bin/bash 

# component = mongodb 
# dnf install ansible -y 
#ansible-pull -U https://github.com/Siva3150/ansible-roboshop-roles-tf-86s.git main.yaml
# git clone ansible-playbook
# cd ansible-playbook
# ansible-playbook -i inventory main.yaml

#!/bin/bash 
component=$1 
dnf install ansible -y 
ansible-pull -U https://github.com/Siva3150/ansible-roboshop-roles-tf-86s.git -e component=$component main.yaml