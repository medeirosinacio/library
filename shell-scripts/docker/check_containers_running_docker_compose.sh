#!/usr/bin/env bash
# check if all containers running docker-compose file
# $1 | one argument to set docker-compose file or empty to docker-compose file default
# example: ./check_containers_running_docker_compose.sh docker-compose-dev.yml

# check if set docker-compose filename
if [[ "$#" -eq  "0" ]]
then
   dockercomposefile="docker-compose.yml"
else
    dockercomposefile="$1"
fi

# Get containers ID's and set to array
declare -a containersId=()
while IFS= read -r line; do
    containersId+=( "$line" )
done < <( docker-compose -f ${dockercomposefile} ps -q )

declare -i timeout=30
declare -i len=${#containersId[@]}

for i in $(seq 1 ${timeout}); do

    declare -i containerUps=0

    for containerId in "${containersId[@]}"
    do
        if [[ $(docker ps -a -q --filter status=running --filter id=${containerId} | awk '{print $1}') ]]; then
           containerUps+=1
        fi
    done

    if [[ ${len} -eq ${containerUps} ]]
    then
        echo "all started containers"
        exit 0
    else
        echo "waiting for initialization of all containers"
        sleep 1s
    fi

done

echo "error in the initialization of the containers"
exit 1
