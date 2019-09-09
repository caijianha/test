#!/bin/bash
. /etc/init.d/functions
CONF_DIR=/etc/libvirt/qemu
IMG_DIR=/var/lib/libvirt/images
BASEVM=node_tedu
createvm(){
 qemu-img create -f qcow2 -b ${IMG_DIR}/.${BASEVM}.qcow2 $IMG_DIR/${1}.img 30G &> /dev/null
 sed  "s/${BASEVM}/${1}/" ${IMG_DIR}/.${BASEVM}.xml > ${CONF_DIR}/${1}.xml
 sudo virsh define ${CONF_DIR}/${1}.xml &> /dev/null
 echo_success 
 echo "VM ${1} Create"
}

read -p "Enter VM number: "   VMNUM

if [ -z $VMNUM  ];then
echo    Please enter parameters
exit
fi

if [ -z "${VMNUM}" ]; then
    echo "You must input a number."
    exit 65
elif [ $(echo ${VMNUM}*1 | bc) = 0 ]; then
    echo "You must input a number."
    exit 66
elif [ ${VMNUM} -lt 1 -o ${VMNUM} -gt 99 ]; then
    echo "Input out of range"
    exit 67
fi

if  [ ${VMNUM} -le 9 ];then
   VMNUM=0${VMNUM}
fi

 if [ $USER == student ];then
   NEWVM=tedu_node
 elif [ $USER == weekend ];then
   NEWVM=tmooc_node
 else
   NEWVM=tedu_node
 fi
vm_name=${NEWVM}${VMNUM}
 if [ -e $IMG_DIR/${vm_name}.img ]; then
   echo_warning
   echo "vm ${vm_name} is exists"
   exit 38
 else
   createvm ${vm_name}
 fi
