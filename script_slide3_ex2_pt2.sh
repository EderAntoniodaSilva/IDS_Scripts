#!/bin/bash
#
# 2. Modifique o script anterior. Agora, caso o usuário não informe nenhum parâmetro, o script deverá perguntar o dado solicitado através do modo interativo (leitura de variáveis).
#
clear
if test $# -eq 0
then
	echo "Digite o nome de um arquivo ou diretório: "
	read nome
	if test -d $nome
	then
		echo "$nome é um diretório!"
	elif test -f $nome
	then
		echo "$nome é um arquivo!"
	fi
else
	if test -d $1
	then
		echo "$1 é um diretório!"
	elif test -f $1
	then
		echo "$1 é um arquivo!"
	fi
fi
