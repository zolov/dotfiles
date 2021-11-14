#!/usr/bin/env bash

GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
GREY=`tput setaf 8`
LBLUE=`tput setaf 6`
PURPLE=`tput setaf 5`
NC=`tput sgr0`

now=`date +"%m:%d:%H:%M"`

kubelogin --insecure-skip-tls-verify >/dev/null 2>&1

def_namespace=lk3-test1
echo
read -p "Enter namespace [${GREEN}${def_namespace}${NC}]: " namespace
namespace=${namespace:-${def_namespace}}
echo
def_ms=personal-area-user
read -p "Enter ms name [${GREEN}${def_ms}${NC}]: " ms_name
ms_name=${ms_name:-${def_ms}}

GREP=(`kubectl get pods --namespace=${namespace} | grep ${ms_name}`)
pod_name=${GREP[0]}
echo
echo Pod name is ${BLUE}${pod_name}${NC}

FILE_PATH="~/Documents/LOGS/${ms_name}-${now}.log"
kubectl logs ${pod_name} > ~/Documents/LOGS/${ms_name}-${now}.log
echo
echo Log file saved to ${BLUE}${FILE_PATH}${NC}
echo

echo ${LBLUE}Opening in VS code...
code $HOME/Documents/LOGS/${ms_name}-${now}.log

