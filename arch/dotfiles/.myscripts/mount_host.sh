#!/bin/bash

echo "Mounting host shared folders...."
MY_UID=$(id -u)
MY_GID=$(id -g)

SHARES=( "projects" "3dprint" "experiments" )

for i in "${!SHARES[@]}" ; do
    pushd $HOME > /dev/null
    mkdir -p ${SHARES[$i]}
    mount | grep $HOME/${SHARES[$i]} > /dev/null
    if [ $? -ne 0 ] ; then
        echo "Mounting ${SHARES[$i]}.."
        sudo mount -t vboxsf ${SHARES[$i]} $HOME/${SHARES[$i]}  -o "nosuid,uid=$MY_UID,gid=$MY_GID" 
    else
        echo "${SHARES[$i]} is mounted... skipping!"
    fi
    popd > /dev/null
done

echo "done!"