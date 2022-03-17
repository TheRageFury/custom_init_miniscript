#!/bin/bash

echo "[custom_init] Executing the installer"

if [ "$1" == "" ] 
then
	echo "[custom_init] ERROR: You must provide an argument specifying the user for which install custom_init!"
	echo "[custom_init] Installation ABORTED. Exiting ..."
	exit 1
fi

normal_user=$1
curr_user_id=$(id -u)

if [ "$curr_user_id" != "0" ] 
then
	echo "[custom_init] ERROR: You must run this installer script as ROOT. Try using sudo before actual executing command"
	exit 2
fi

echo "[custom_init] Setting start/end message and hooker loading in .bashrc file ..."

user_home="/home/${normal_user}"
bashrc_path="${user_home}/.bashrc"

start_message="echo \"[.bashrc] Running r4g3's custom_init.sh ...\""
end_message="echo \"[.bashrc] r4g3's custom_init.sh: DONE! \""

echo "$start_message" >> $bashrc_path
echo "debug_opt=0" >> $bashrc_path
echo "source ${user_home}/custom_init/custom_init.sh \$debug_opt" >> $bashrc_path
echo "$end_message" >> $bashrc_path

echo "[custom_init] .bashrc HOOKER CODE SET!"
echo "[custom_init] Copying the script folder with the main loader and some scripts ..."

ci_path="${user_home}/custom_init"
installer_path=$(dirname "${BASH_SOURCE[0]}")

cp -r ${installer_path}/custom_init_files/custom_init ${user_home}/

chmod 755 ${ci_path}/custom_init.sh
chown ${normal_user}:${normal_user} ${ci_path}/custom_init.sh

chmod -R 755 ${ci_path}
chown -R ${normal_user}:${normal_user} ${ci_path}

echo "[custom_init] FILES AND LOADER (custom_init.sh) COPIED!"
echo "[custom_init] Creating uninstaller ..."

touch ${user_home}/ci_uninstall.sh
cat ${installer_path}/custom_init_files/uninstaller.sh >> ${user_home}/ci_uninstall.sh
chmod 700 ${user_home}/ci_uninstall.sh
chown ${normal_user}:${normal_user} ${user_home}/ci_uninstall.sh

echo "[custom_init] UNINSTALLER CREATED!"
echo "[custom_init] SCRIPT INSTALLED! Uninstaller created at: ${user_home}/ci_uninstall.sh"

source ${user_home}/.bashrc
