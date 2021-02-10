#!bin/bash

#installing packages
echo "*********************************** installing update *****************************************************"
sudo apt-get update -y
echo "*********************************** installing upgrade ****************************************************"
sudo apt-get upgrade -y
echo "*********************************** installing fzf ********************************************************"
sudo apt-get install fzf -y
echo "*********************************** installing tree *******************************************************"
sudo apt-get install tree -y
echo "*********************************** installing unzip ******************************************************"
sudo apt-get install unzip -y
echo "*********************************** installing azure-cli **************************************************"
sudo apt-get install azure-cli -y
echo "*********************************** installing jq **************************************************"
sudo apt install jq -y

#creating local symbolic links

cd ~
touch .profile
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
    sudo mv terraform /usr/local/bin/tf
else 
    echo "\n"
    echo "****************************************************************************************"
    echo "terraform.zip does not exist."
    echo "****************************************************************************************"
    echo "\n"
    curl https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip  -o terraform.zip
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

helm3 plugin install https://github.com/helm/helm-2to3

rm -rf helm2 helm3 helm3.tar.gz helm2.tar.gz terraform.zip

sudo chmod 777 /usr/local/bin/*

echo "\n"

echo "**************************************************************************************************"
echo "**************************************************************************************************"

source .bashrc

echo "source .bashrc"

echo "**************************************************************************************************"
echo "**************************************************************************************************


az login

az aks get-credentials --resource-group rg-aks-freemanht-centralus-t1-nonprod --name AKS-FreemanHT-T1-NonProd
az aks get-credentials --resource-group rg-aks-freemanht-centralus-t1-prod --name AKS-FreemanHT-T1-Prod
az aks get-credentials --resource-group rg-aks-freemanht-centralus-t2-nonprod --name AKS-FreemanHT-T2-NonProd
az aks get-credentials --resource-group rg-aks-freemanht-centralus-t2-prod --name AKS-FreemanHT-T2-Prod

az login

az aks get-credentials --resource-group RG-AKS-FreemanCorp-CentralUS-NonProd1 --name AKS-FreemanCorp-NonProd1
az aks get-credentials --resource-group RG-AKS-FreemanCorp-CentralUS-NonProd2 --name AKS-FreemanCorp-NonProd2
az aks get-credentials --resource-group RG-AKS-FreemanCorp-CentralUS-Prod1 --name AKS-FreemanCorp-Prod1
az aks get-credentials --resource-group RG-AKS-FreemanCorp-CentralUS-Prod2 --name AKS-FreemanCorp-Prod2


kx AKS-FreemanCorp-NonProd1 ; kns default ; kx AKS-FreemanCorp-NonProd2 ; kns default ; kx AKS-FreemanCorp-Prod1 ; kns default ; kx AKS-FreemanCorp-Prod2 ; kns default ; kx AKS-FreemanHT-T1-NonProd ; kns default ; kx AKS-FreemanHT-T1-Prod ; kns default ; kx AKS-FreemanHT-T2-NonProd ; kns default ; kx AKS-FreemanHT-T2-Prod ; kns default


rm -rf /mnt/c/Users/nbagade/Downloads/bash_bkup/* ; rm -rf /mnt/c/Users/nbagade/Downloads/bash_bkup/.* ; cp -r . /mnt/c/Users/nbagade/Downloads/bash_bkup/"
