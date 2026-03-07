###!/bin/bash 

# component = mongodb 
# dnf install ansible -y 
#ansible-pull -U https://github.com/Siva3150/ansible-roboshop-roles-tf-86s.git main.yaml
# git clone ansible-playbook
# cd ansible-playbook
# ansible-playbook -i inventory main.yaml

#!/bin/bash 
component=$1
environment=$2


# dnf install ansible -y 
# ansible-pull -U https://github.com/Siva3150/ansible-roboshop-roles-tf-86s.git -e component=$component main.yaml

REPO_URL=https://github.com/Siva3150/ansible-roboshop-roles-tf-86s.git
REPO_DIR=/opt/roboshop/ansible 
ANSIBLE_DIR=ansible-roboshop-roles-tf-86s 

mkdir -p $REPO_DIR
mkdir -p /var/log/roboshop 
touch ansible.log 

cd $REPO_DIR 

if [ -d $ANSIBLE_DIR ]; then 

 cd $ANSIBLE_DIR
 git pull 

else 

 git clone $REPO_DIR
 cd $ANSIBLE_DIR
fi 

ansible-playbook -e component=$component -e env=$environment main.yaml 