#/bin/bash
case $1 in
estab)
ss -antp | awk 'BEGIN{x=0}/^ESTAB/{x++} END{print x}';;
close_wait)
ss -antp | awk 'BEGIN{x=0}/^CLOSE-WAIT/{x++} END{print x}';;
time_wait)
ss -antp | awk 'BEGIN{x=0}/^TIME-WAIT/{x++} END{print x}';;
esac

