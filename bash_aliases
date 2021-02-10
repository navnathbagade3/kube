alias ll='ls -l'
alias la='ls -la'
alias k='kubectl'
alias kx='kubectx'
alias kns='kubens'
alias ke='kubectl edit'
alias kg='kubectl get'
alias kl='kubectl logs'
alias ka='kubectl apply'
alias kds='kubectl describe'
alias knsks='kubens kube-system'
alias copy='clip.exe'
alias en='base64 -w 0'
alias dc='base64 -d'

#getting resources from same namespace

alias kga='kubectl get all'
alias kgp='kubectl get pods'
alias kgi='kubectl get ingress'
alias kgs='kubectl get secrets'
alias kgsvc='kubectl get svc'
alias kgc='kubectl get configmaps'
alias kgd='kubectl get deployment'
alias kgns='kubectl get ns'
alias kgr='kubectl get role'
alias kgrb='kubectl get rolebinding'
alias kgrs='kubectl get replicaset'
alias kgnd='kubectl get nodes'
alias kgndw='kubectl get nodes -o wide'

#deleteting resources from the namespace / cluster

alias kdelp='kubectl delete pods'
alias kdeli='kubectl delete ingress'
alias kdels='kubectl delete secrets'
alias kdelsvc='kubectl delete svc'
alias kdelc='kubectl delete configmaps'
alias kdeld='kubectl delete deployment'
alias kdelns='kubectl delete ns'
alias kdelr='kubectl delete role'
alias kdelrb='kubectl delete rolebinding'
alias kdelrs='kubectl delete replicaset'

#getting resources from across cluster

alias kgpa='kubectl get pods -A'
alias kgia='kubectl get ingress -A'
alias kgsa='kubectl get secrets -A'
alias kgsvca='kubectl get svc -A'
alias kgca='kubectl get configmaps -A'
alias kgda='kubectl get deployment -A'
alias kgnsa='kubectl get ns -A'
alias kgra='kubectl get role -A'
alias kgrba='kubectl get rolebinding -A'
alias kgrsa='kubectl get replicaset -A'

#describing resources in namespace

alias kdsp='kubectl describe pods'
alias kdsi='kubectl describe ingress'
alias kdss='kubectl describe secrets'
alias kdssvc='kubectl describe svc'
alias kdsc='kubectl describe configmaps'
alias kdsd='kubectl describe deployment'
alias kdsns='kubectl describe ns'
alias kdsr='kubectl describe role'
alias kdsrb='kubectl describe rolebinding'

#watching resources
alias wkgp='watch kubectl get pods'
alias wkgpa='watch kubectl get pods -A'
alias wkgnd='watch kubectl get nodes'
alias wkgndw='watch kubectl get nodes -o wide'

#opening application need to change mount path if sublime is at different location.

alias sl='/mnt/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe'

#functions for getting resources yaml file

function kex { kubectl exec -it "$1" -c "$2" -- sh; }

function ecs { echo "$1" | base64; }	
function dcs { echo "$1" | base64 -d; }

function kgpy { kubectl get pods "$1" -o yaml; }
function kgiy { kubectl get ingress "$1" -o yaml; }
function kgsy { kubectl get secrets "$1" -o yaml; }
function kgsvcy { kubectl get svc "$1" -o yaml; }
function kgcy { kubectl get configmaps "$1" -o yaml; }
function kgdy { kubectl get deployment "$1" -o yaml; }
function kgnsy { kubectl get ns "$1" -o yaml; }
function kgry { kubectl get role "$1" -o yaml; }
function kgrby { kubectl get rolebinding "$1" -o yaml; }
