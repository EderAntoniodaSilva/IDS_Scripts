#!/bin/bash
#
# 3. Com basena aula anterior, desenvolva um script que configure a rede de um determinado computador. O script deverá ser capaz de ler os parâmetros informados na seguinte ordem: 
# conf_rede IP MASCARA GATEWAY DNS1 DNS2
# Caso um dos parâmetros não seja informado, o script deverá abortar a tarefa e avisar o usuário. Para cada tarefa concluída com sucesso, o script deverá emitir um aviso na tela.
#
clear
if [ $# -lt 6 ]
then
	echo "Configuração de rede abortada. Você não informou a quantidade correta de parâmetros"
	echo "Parâmetros: conf_rede IP MASCARA GATEWAY DNS1 DNS2"
else
	sudo ifconfig $1 $2
	if [ $? -eq 0 ]
	then
		echo "Configurando o ip $2 na placa $1..."
		sleep 1s
		echo "Configuração de IP realizada com sucesso!"
	else
		echo "Configuração de ip falhou!"
	fi
	sudo ifconfig $1 $2 netmask $3 up
	if [ $? -eq 0 ]
	then
		echo "Configurando a mascara $3 na placa $1..."
		sleep 1s
		echo "Configuração de mascara realizada com sucesso!"
	else
		echo "Configuração de mascara falhou!"
	fi
	sudo route del default gw $4
	sudo route add default gw $4
	if [ $? -eq 0 ]
	then
		echo "Configurando a rota default $4..."
		sleep 1s
		echo "Configuração de rota realizada com sucesso!"
	else
		echo "Configuração de rota falhou!"
	fi
	#rm /etc/resolv.conf
	#touch /etc/resolv.conf
	sudo echo nameserver $5 > /etc/resolv.conf
	sudo echo nameserver $6 >> /etc/resolv.conf
	if [ $? -eq 0 ]
	then
		echo "Configurando o DNS 1 $5..."
		echo "COnfigurando o DNS 2 $6..."
		sleep 1s
		echo "Configuraão de DNS realizada com sucesso!"
	else
		"Configuração de DNS falhou!"
	fi
fi
