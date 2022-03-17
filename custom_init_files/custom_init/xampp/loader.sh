#!/bin/bash

debug=$1

if [ $debug -eq 1 ] 
then
	echo "[loader(XAMPP)] XAMPP Loader STARTED !!"
	echo "[XAMPP] Defining command aliases ..."
fi

source $(dirname "${BASH_SOURCE[0]}")/aliases.sh $debug

if [ $debug -eq 1 ] 
then
	echo "[XAMPP] DONE !"
	echo "[loader(XAMPP)] DONE!"
fi
