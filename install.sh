#!bin/bash

#installing packages

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install fzf -y
sudo apt-get install tree -y
sudo apt-get install unzip -y
sudo apt-get install azure-cli -y

#creating local symbolic links

ln -s /mnt/c/Users/nbagade/Downloads/kube/install.sh ~/.install.sh
ln -s /mnt/c/Users/nbagade/Downloads/notes.sh ~/.notes.sh
ln -s /mnt/c/Users/nbagade/Downloads .downloads
ln -s /mnt/c/Users/nbagade/Downloads/kube .repo

cp .downloads/setup/helm* .
cp .downloads/setup/terraform.zip .
cp .downloads/setup/kubectl .

sudo touch /usr/local/bin/kubectl /usr/local/bin/kubectx /usr/local/bin/kubens /usr/local/bin/helm3 /usr/local/bin/helm2 /usr/local/bin/tf /usr/local/bin/kubectl
sudo chmod 777 /usr/local/bin/*
mkdir helm2 helm3

#installing kubectl

if [ -f /usr/local/bin/kubectl ]; then
    echo "\n"
    echo "****************************************************************************************"
    echo "kubectl exists."
    echo "****************************************************************************************"
    echo "\n"
    sudo mv kubectl /usr/local/bin/kubectl
else 
    echo "\n"
    echo "****************************************************************************************"
    echo "kubectl does not exist."
    echo "****************************************************************************************"
    echo "\n"
    sudo az aks install-cli
fi

#installing helm2

if [ -f helm2.tar.gz ]; then
    echo "\n"
    echo "****************************************************************************************"
    echo "helm2.tar.gz exists."
    echo "****************************************************************************************"
    echo "\n"
    tar xzfv helm2.tar.gz -C helm2
    sudo mv helm2/linux-amd64/helm /usr/local/bin/helm2
else 
    echo "\n"
    echo "****************************************************************************************"
    echo "helm2.tar.gz does not exist."
    echo "****************************************************************************************"
    echo "\n"       
    curl https://get.helm.sh/helm-v2.16.12-linux-amd64.tar.gz -o helm2.tar.gz
    tar xzfv helm2.tar.gz -C helm2
    sudo mv helm2/linux-amd64/helm /usr/local/bin/helm2
fi

#installing helm3 

if [ -f helm3.tar.gz ]; then
    echo "\n"
    echo "****************************************************************************************"
    echo "helm3.tar.gz exists."
    echo "****************************************************************************************"
    echo "\n"
    tar xzfv helm3.tar.gz -C helm3
    sudo mv helm3/linux-amd64/helm /usr/local/bin/helm3
else 
    echo "\n"
    echo "****************************************************************************************"
    echo "helm3.tar.gz does not exist."
    echo "****************************************************************************************"
    echo "\n"
    curl https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz -o helm3.tar.gz
    tar xzfv helm3.tar.gz -C helm3
    sudo mv helm3/linux-amd64/helm /usr/local/bin/helm3
fi

#installing terraform

git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
mkdir -p ~/.local/bin/
. ~/.profile
ln -s ~/.tfenv/bin/* ~/.local/bin

if [ -f terraform.zip ]; then
    echo "\n"
    echo "****************************************************************************************"
    echo "terraform.zip exists."
    echo "****************************************************************************************"
    echo "\n"
    unzip terraform.zip
    tfenv install 0.12.24
    tfenv use 0.12.24
    sudo mv terraform /usr/local/bin/tf
else 
    echo "\n"
    echo "****************************************************************************************"
    echo "terraform.zip does not exist."
    echo "****************************************************************************************"
    echo "\n"
    curl https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip  -o terraform.zip
    unzip terraform.zip
    tfenv install 0.12.24
    tfenv use 0.12.24
    sudo mv terraform /usr/local/bin/tf
fi

#updating packages

sudo apt-get update -y
sudo apt-get upgrade -y

#appending .bash_profile

cat <<- 'EOF' >> ~/.bash_profile
if [ -n "$BASH_VERSION" ] && [ -f $HOME/.bashrc ];then
    source $HOME/.bashrc
fi
EOF

cat <<- 'EOF' >> ~/.bashrc
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
source <(kubectl completion bash)
source .terminal_prompt.sh
EOF

curl -s https://raw.githubusercontent.com/navnathbagade3/kube/main/bash_aliases -o .bash_aliases
curl -s https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -o kubectx
curl -s https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -o kubens
curl -s https://raw.githubusercontent.com/navnathbagade3/kube/main/terminal_prompt.sh -o .terminal_prompt.sh

sudo mv ./kubectx /usr/local/bin/kubectx
sudo mv ./kubens /usr/local/bin/kubens

rm -rf helm2 helm3 helm3.tar.gz helm2.tar.gz terraform.zip

source .bashrc
