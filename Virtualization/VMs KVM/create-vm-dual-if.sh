#!/bin/bash

if [ -z $1 ]; then
        echo "Você deve informar o nome da VM a ser criada e um id unico 01 até ff"
        echo "Exemplo: \$ $0 NomeDaVM 01"
        exit 2
fi

if [ -z $2 ]; then
        echo "Você deve informar o nome da VM a ser criada e um id unico 01 até ff"
        echo "Exemplo: \$ $0 NomeDaVM 01"
        exit 2
fi

export VM_NAME="$1"

ENABLED_KVM=""
ls /dev/kvm &> /dev/null && ENABLED_KVM="-enable-kvm"

ls /vms-kvm/discos/${VM_NAME}.qcow2 || qemu-img create -f qcow2 -F qcow2 -b /vms-kvm/fc24.qcow2 /vms-kvm/discos/${VM_NAME}.qcow2 

ip tuntap add mode tap tap1_$VM_NAME
ip link set tap1_$VM_NAME up

ip tuntap add mode tap tap2_$VM_NAME
ip link set tap2_$VM_NAME up

echo "Criando a vm ${VM_NAME} com as interface: "
echo "tap1_${VM_NAME} : bb:00:00:11:76:${2}"
echo "tap2_${VM_NAME} : cc:00:00:11:76:${2}"

qemu-system-x86_64 -m 128 $ENABLED_KVM \
	-cpu host \
	-drive file=/vms-kvm/discos/${VM_NAME}.qcow2 \
	-netdev type=tap,ifname=tap1_$VM_NAME,id=net0,script=no \
	-device virtio-net-pci,netdev=net0,mac=bb:00:00:11:76:${2} \
    -netdev type=tap,ifname=tap2_$VM_NAME,id=net1,script=no \
	-device virtio-net-pci,netdev=net1,mac=cc:00:00:22:76:${2} \
    -display none \
    -chardev socket,id=monitor,path=/vms-kvm/monitor/$VM_NAME.sock,server=on,wait=off \
	-monitor chardev:monitor \
	-chardev socket,id=serial0,path=/vms-kvm/console/$VM_NAME.sock,server=on,wait=off \
	-serial chardev:serial0 \
	-daemonize -name ${VM_NAME}

