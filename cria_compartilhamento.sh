#!/bin/bash

#############################################################################################################
# Desenvolva um script que crie um determinado compartilhamento,
# tendo como base o nome do  compartilhamento e até 5 usuários
# passados por parâmetro;
# Exemplo: ./cria_compartilhamento.sh almoxarifado msilva ecristina orodriguez wamerico pcabral
# Pontos importantes:
# - Criação e adequação das permissões do diretório (utilizar como pasta base o diretório /compartilhamentos);
# - Criação do grupo padrão (utilizar o mesmo nome do compartilhamento informado por parâmetro);
# - Entrada no arquivo smbd.conf
# - Criação dos usuários, tendo como senha padrão "123456";
#############################################################################################################

qtd_usuarios=$#
flag=1

if [ qtd_usuarios -eq 0 ]; then
	echo "Nenhum parâmetro foi informado."
	echo "Por favor, informe os usuários por parâmetro."
	echo "Script abortado."
	exit 1
else
	for i in $*
	do
		if [ $flag -eq 1 ] ; then
			mkdir /compartilhamentos/$i
                	if [ $? -eq 0 ]; then
                        	echo "Pasta $i criada com sucesso!"
                	else
                        	echo "Problema ao criar a pasta $i"
                	fi

			addgroup $i
			if [ $? -eq 0 ]; then
				echo "Grupo $i criado com sucesso!"
			else
				echo "Problema ao criar o grupo $i!"
			fi

                	chgrp $i /compartilhamentos/$i
                	if [ $? -eq 0 ]; then
                        	echo "Alterado o grupo padrão da pasta $i para o grupo $i"
                	else
                        	echo "Problema ao alterar o grupo padrão da pasta $i"
                	fi

                	chmod -R 2770 /compartilhamentos/$i
                	if [ $? -eq 0 ]; then
                        	echo "Alterando as permissões da pasta $i"
                	else
                        	echo "Problema ao alterar as permissões da pasta $i"
                	fi

                	echo -e "\n\n[$i]\n\tpath = /compartilhamentos/$i\n\tcomment = Compartilhamento da $i\n\tvalid users = +$i\n\twritable = yes" >> /etc/samba/smb.conf
                	if [ $? -eq 0 ]; then
                        	echo "Arquivo smb.conf alterado com as novas entradas!"
                	else
                        	echo "Falha ao alterar o arquivo smb.conf!"
                	fi
			let flag++
		else
			useradd $i
			if [ $? -eq 0 ]; then
				echo "Usuário $i adicionado com sucesso!"
			else
				echo "Problema ao inserir o usuário $i!"
			fi

			adduser $i $1
			if [ $? -eq 0]; then
				echo "Usuário $i adicionado ao grupo $1!"
			else
				echo "Problema ao adicionar o usuario $i ao grupo $1!"
			fi

			echo -e "123456\n123456" | passwd $i 2> /dev/null
			if [ $? -eq 0 ]; then
				echo "Senha do usuário $i definida com sucesso!"
			else
				echo "Problema ao definir a senha do usuário $i!"
			fi

			echo -e "123456\n123456" | smbpasswd -s -a $i 2> /dev/null
			if [ $? -eq 0 ]; then
				echo "Senha SMB do usuário $i definida com sucesso!"
			else
				echo "Problema ao definir a senha SMB do usuário $i!"
			fi
		fi
	done
fi
