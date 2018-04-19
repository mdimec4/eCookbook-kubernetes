#!/bin/sh


trap 'killgroup' INT TERM HUP QUIT

killgroup() {
	echo "**** Shutting down... ****"
	trap '' INT TERM HUP QUIT # ignore signals while shutting down
	kill -TERM 0
}

# this is just an example
# you need to edit this file to use correct node IP and service node ports
#
# https://github.com/kubernetes/minikube/issues/38
# suggests a tmp solution which would not require manual edition solution in the style of:
# socat tcp-listen:8080,reuseaddr,fork tcp:172.17.4.99:$(kubectl get service outyet -o template --template="{{range.spec.ports}}{{.nodePort}}{{end}}")
# this solution without some modifications is not sufficient for services that expose more then one port

socat -d -d TCP-LISTEN:8081,fork TCP:192.168.99.102:31780 &
socat -d -d TCP-LISTEN:11113,fork TCP:192.168.99.102:31266 &
socat -d -d TCP-LISTEN:4007,fork TCP:192.168.99.102:30114 &
socat -d -d TCP-LISTEN:4006,fork TCP:192.168.99.102:30457 &

wait
exit $?
