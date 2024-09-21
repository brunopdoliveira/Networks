#!/bin/bash

which lsb_release && apt update ; apt -y install qemu-kvm qemu-system-x86 qemu-utils bridge-utils socat wget 
ls /etc/redhat-release && dnf -y install qemu-kvm qemu-system-x86 qemu-img bridge-utils socat wget

mkdir /vms-kvm
mkdir /vms-kvm/discos
mkdir /vms-kvm/console
mkdir /vms-kvm/monitor
mkdir /vms-kvm/bin

cp console.sh create-single-vm.sh create-vm-dual-if.sh kill-vms.sh list-vms.sh make-env.sh monitor.sh /vms-kvm/bin/
chmod -R 755 /vms-kvm/bin/

wget https://www.ic.unicamp.br/william/vms/fc24.qcow2 -O /vms-kvm/fc24.qcow2

export PATH=$PATH:/vms-kvm/bin

echo 'export PATH=$PATH:/vms-kvm/bin' >> /root/.bashrc 
echo 'export PATH=$PATH:/vms-kvm/bin' >> /root/.bash_profile 

ls -l /dev/kvm && echo "Você possui suporte a KVM ;)" || echo "Você NAO tem suporte a KVM, pode utilizar emulação ou tentar habilitar na BIOS"
