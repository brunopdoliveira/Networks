#!/bin/bash

if [ "$1" == "-h" ] || [ "$1" == '' ]; then
  echo "Usage: `basename $0` [vm_name]"
  echo 
  exit 0
fi
echo "A tecla de escape para sair do monitor da VM ${1} eh Ctrl + q"
socat unix:/vms-kvm/monitor/${1}.sock stdio,raw,echo=0,escape=0x11
