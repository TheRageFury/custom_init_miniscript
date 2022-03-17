#!/bin/bash

## Generic XAMPP aliases

alias xampp='/opt/lampp/xampp'
alias xampp-panel='sudo /opt/lampp/manager-linux-x64.run'

## MySQL aliases

mysqlc(){

	alias_name="mysqlc"

	cons_mode=$1
	comm="/opt/lampp/bin/mysql"
	comm_args="-u root"

	if [ "$cons_mode" = "-c" ]; 
	then
		if 	[ $# -ne 4 ] || 
			[ -z "$2" ] ||
			[ -z "$3" ] ||
			[ -z "$4" ] 
		then
				echo "Usage: ${alias_name} <db_name> <username> <password>"
				return
		fi
	

		dbname=$2
		user=$3
		passwd=$4

		comm_args="-u${user} -p${passwd} ${dbname}"
	elif [ "$cons_mode" = "--args" ] || [ "$cons_mode" = "-a" ];
	then
		all_args=$@
		comm_args="${all_args:2}"
	fi

	sudo ${comm} ${comm_args}
}

