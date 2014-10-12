#!/bin/bash
#
# 1. Desenvolva um script que,, ao aceitar por parâmetro um determinado nome, identificar se o mesmo é um arquivo ou diretório
#
clear 
if test -d $1
then
	echo "$1 é um diretório!"
elif test -f $1
then
	echo "$1 é um arquivo!"
fi
