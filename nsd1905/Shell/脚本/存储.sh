#/bin/bash
#提取根分区剩余空间 
disk=$(df / | awk '/\//{print $4}') 
#"\/" 取消/的特殊定义
#提取内存剩余空间 
men=$(free | awk '/Mem/{print $4}')
while :
do
#注意内存和磁盘提取的空间大小都是以 Kb 为单位 
if [ $disk -le 512000 -a $men -le 1024000 ];then
mail -s waring student <<EOF
dddddddddddd
EOF
fi
done
