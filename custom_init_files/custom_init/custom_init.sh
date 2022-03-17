#!/bin/bash

debug=0
if [ $1 == "" ] || [ $1 -eq 1 ] 
then
	echo "[custom_init] DEBUG = 1"
	debug=$1 
fi

if [ $debug -eq 1 ] 
then
	echo "[custom_init] Custom Init STARTED !!"
fi


##
## XAMPP/LAMPP commands loader
##

if [ $debug -eq 1 ] 
then
	echo "[custom_init(XAMPP)] Executing XAMPP Loader ..."
fi

source $(dirname "${BASH_SOURCE[0]}")/xampp/loader.sh ${debug}

if [ $debug -eq 1 ] 
then
	echo "[custom_init(XAMPP)] LOADER EXECUTED !!"
fi
