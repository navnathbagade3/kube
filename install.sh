#!bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install azure-cli
sudo apt-get install fzf
sudo apt-get install tree
sudo apt-get install unzip
sudo touch /usr/local/bin/kubectl /usr/local/bin/kubectx /usr/local/bin/kubens /usr/local/bin/helm3 /usr/local/bin/helm2
sudo chmod 777 /usr/local/bin/*
sudo az aks install-cli
mkdir helm2 helm3
curl https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz -o helm3.tar.gz
tar xzfv helm3.tar.gz -C helm3
sudo mv helm3/linux-amd64/helm /usr/local/bin/helm3
curl https://get.helm.sh/helm-v2.16.12-linux-amd64.tar.gz -o helm2.tar.gz
tar xzfv helm2.tar.gz -C helm2
sudo mv helm2/linux-amd64/helm /usr/local/bin/helm2
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
mkdir -p ~/.local/bin/
. ~/.profile
ln -s ~/.tfenv/bin/* ~/.local/bin
curl https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip  -o terraform_0.12.24_linux_amd64.zip
unzip terraform_0.12.24_linux_amd64.zip
tfenv install 0.12.24
tfenv use 0.12.24
sudo apt-get update
sudo apt-get upgrade

ln -s /mnt/c/Users/nbagade/Downloads/install/install.sh .bkup/.install.sh
ln -s /mnt/c/Users/nbagade/Downloads/install/notes.sh .bkup/.notes.sh
ln -s /mnt/c/Users/nbagade/Downloads .downloads

cat <<- 'EOF' >> "~/.bash_profile"
if [ -n "$BASH_VERSION" ] && [ -f $HOME/.bashrc ];then
    source $HOME/.bashrc
fi
EOF

cat <<- 'EOF' >> "~/.bashrc"
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
source <(kubectl completion bash)
source .terminal_prompt.sh
EOF

curl -s https://raw.githubusercontent.com/navnathbagade3/kube/main/bash_aliases -o .bash_aliases
curl -s https://raw.githubusercontent.com/navnathbagade3/kube/main/kubectx -o kubectx
curl -s https://raw.githubusercontent.com/navnathbagade3/kube/main/kubens -o kubens
curl -s https://raw.githubusercontent.com/navnathbagade3/kube/main/terminal_prompt.sh -o .terminal_prompt.sh

mv ./kubectx /usr/local/bin
mv ./kubens /usr/local/bin

source ~/.bashrc