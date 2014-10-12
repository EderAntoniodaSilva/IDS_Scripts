#!/bin/bash
#
# 4. Desenvolva um script que leia entre 1 e 9 números e apresente a soma e média entre eles (atente-se ao fato de que o usuário pode informar qualquer quantidade de números)
#
clear
n=1
echo "Qual a quantidade de numeros que você deseja inserir (entre 1 e 9)?"
read numero
while [ $n -le $numero ]
do
	echo "Digite o $n º numero: "
	read numero2
	let soma=soma+numero2
	n=$(( n+1 ))
done
echo "Soma dos numeros: $soma"
media=$(echo "scale=2;($soma)/$numero" | bc)
echo "Media dos numeros: $media"
