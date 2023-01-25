#!/bin/sh

kubeconfig=$1
namespace=$2
service=$3
host_port=$4
target_port=$5

if [ $# != 5 ]; then
    echo "Usage: ./port-forward.sh $namespace $service $host_port $target_port"
    exit 1
fi

kubectl port-forward --kubeconfig "$kubeconfig" -n "$namespace" "$service" "$host_port":"$target_port" &
PID=$(ps -ef | grep -v grep | grep 'kubectl port-forward' | cut -f4 -d" ")

while [ $(ps -ef | grep -v grep | grep 'terraform apply' | wc -l) -ge 1 ];do
    sleep 15
done

kill "$PID"
