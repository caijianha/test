#/bin/bash
#/bin/bash
case $1 in
"Active")
        curl -s http://192.168.2.100/status | awk 'NR==1{print $3}';;
"accepts")
        curl -s http://192.168.2.100/status | awk 'NR==3{print $2}';;
"Waiting")
        curl -s http://192.168.2.100/status | awk 'NR==4{print $6}';;
esac

