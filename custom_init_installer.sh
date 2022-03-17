#!/bin/bash

echo "[custom_init] Executing the installer"

if [ "$1" == "" ] 
then
	echo "[custom_init] ERROR: You must provide an argument specifying the user for which install custom_init!"
	echo "[custom_init] Installation ABORTED. Exiting ..."
	return
fi

normal_user=$1
curr_user_id=$(id -u)

if [ "$curr_user_id" != "0" ] 
then
	echo "[custom_init] ERROR: You must run this installer script as ROOT. Try using sudo before actual executing command"
	return
fi

user_home="/home/${normal_user}"
bashrc_path="${user_home}/.bashrc"

start_message="echo \"[.bashrc] Running r4g3's custom_init.sh ...\""
end_message="echo \"[.bashrc] r4g3's custom_init.sh: DONE!\""

echo "$start_message" >> $bashrc_path
echo "debug_opt=0" >> $bashrc_path
echo "source ${user_home}/custom_init/custom_init.sh \$debug_opt"
echo "$end_message" >> $bashrc_path

cp -r ./custom_init_files/custom_init ${user_home}/

ci_path="${user_home}/custom_init"

chmod 755 ${ci_path}/custom_init.sh
chown ${normal_user}:${normal_user} ${ci_path}/custom_init.sh

##
## TODO: Modify this part of the installer to be dynamic referring to a list of files
##

chmod 755 ${ci_path}/xampp/loader.sh
chown ${normal_user}:${normal_user} ${ci_path}/xampp/loader.sh

chmod 755 ${ci_path}/xampp/aliases.sh
chown ${normal_user}:${normal_user} ${ci_path}/xampp/aliases.sh

touch ${user_home}/ci_uninstall.sh
cat ./custom_init_files/uninstaller.sh >> ${user_home}/ci_uninstall.sh
chmod 700 ${user_home}/ci_uninstall.sh
chown ${normal_user}:${normal_user} ${user_home}/ci_uninstall.sh

echo "[custom_init] SCRIPT INSTALLED! Uninstaller created at: ${user_home}/ci_uninstall.sh"

source ${user_home}/.bashrc
