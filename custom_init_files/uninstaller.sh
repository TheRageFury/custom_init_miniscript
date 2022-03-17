#!/bin/bash

echo "[custom_init] Executing the uninstaller"

if [ "$1" == "" ]
then
        echo "[custom_init] ERROR: You must provide an argument specifying the user for which remove custom_init!"
        echo "[custom_init] Deletion ABORTED. Exiting ..."
        exit 1
fi

normal_user=$1
curr_user_id=$(id -u)

if [ "$curr_user_id" != "0" ]
then
        echo "[custom_init] ERROR: You must run this uninstaller script as ROOT. Try using sudo before actual executing command"
        exit 2
fi

user_home="/home/${normal_user}"
ci_path="${user_home}/custom_init"
bashrc_path="${user_home}/.bashrc"

rm -rf ${ci_path}
sed -i '/custom_init/d' ${user_home}/.bashrc
sed -i '/debug_opt=/d' ${user_home}/.bashrc

echo "[custom_init] custom_init SCRIPT UNINSTALLED! To complete the procedure remove this .sh script manually"
