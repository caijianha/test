#/bin/bash
name=$1

cd /var/lib/libvirt/images/
if [ -e ${name}.img ];then
	echo xxxxoooo
	exit 1
else
	qemu-img create -b .node_base.qcow2 -f qcow2 ${name}.img 20G
fi

cd /etc/libvirt/qemu/

if [ -e ${name}.xml ];then
	echo xxxxxooooo
	exit 1
else
	sed "s,node,${name},g" /etc/libvirt/qemu/node.xml > /etc/libvirt/qemu/${name}.xml
fi

virsh define /etc/libvirt/qemu/${name}.xml
