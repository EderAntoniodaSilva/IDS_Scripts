#!/bin/bash
###############################
#
# Backup to FAT32  mount script
#
###############################

#Pasta a qual eu quero fazer backup
backup_files="/Compartilhamentos"

#Criando variáveis de tempo
day=$(date +%Y%m%d)
data_hora=$(date +%d/%m/%Y_%H:%M)

#Verificando se o arquivo de log existe. Se não existir, cria.
cd /root
if [ ! -f backup.log ]; then
	echo "Arquivo de log inexistente" >> /root/backup.log
	echo "Criando arquivo de log..." >> /root/backup.log
	touch backup.log >> /root/backup.log
	sleep 1s
	if [ $? -eq 0 ]; then
		echo "Arquivo de log criado com sucesso!" >> /root/backup.log
	else
		echo "Problema ao criar o arquivo de log" >> /root/backup.log
		exit 1
	fi
fi

#Verificando se o diretório de backup existe. Se não existir, cria.
cd /media
if [ ! -d Backup ]; then
	echo "Diretório Backup inexistente" >> /root/backup.log
	echo "Criando diretório Backup..." >> /root/backup.log
	mkdir Backup >> /root/backup.log
	sleep 1s
	if [ $? -eq 0 ]; then
		echo "Diretório Backup criado com sucesso!" >> /root/backup.log
	else
		echo "Problema ao criar o diretório Backup!" >> /root/backup.log
		exit 1
	fi
fi

#Montando a unidade externa
media=`fdisk -l | grep FAT32 | cut -d 2 -f 1` >> /root/backup.log
mount -t vfat $media Backup >> /root/backup.log
if [ ! $? -eq 0 ]; then
	echo "ERRO - $data_hora - Dispositivo externo não encontrado. Backup não realizado" >> /root/backup.log
	umount -l $media >> /root/backup.log
fi

#Realizando backup
cd /media/Backup
tar -zcvf "BACKUP_$day.tar.bz2" $backup_files >> /root/backup.log
if [ $? -eq 0 ]; then
	echo "SUCESSO - $data_hora - Backup realizado com sucesso!" >> /root/backup.log
else
	echo "ERRO - $data_hora - Não foi possível realizar o backup!" >> /root/backup.log
	exit 1
fi

#Excluindo arquivos de backup com mais de 15 dias
find /media/Backup -mtime +15 -exec rm -rif {} \; >> /root/backup.log
if [ $? -eq 0 ]; then
	echo "SUCESSO - $data_hora - Arquivos de backups antigos (15 dias) foram excluídos!" >> /root/backup.log
else
	echo "ERRO - $data_hora - Não foi possível remover os arquivos de backups antigos!" >> /root/backup.log
fi

#Desmontando a unidade externa
umount -l $media >> /root/backup.log
if [ $? -eq 0 ]; then
	echo "SUCESSO - $data_hora - Unidade externa removida com sucesso!" >> /root/backup.log
else
	echo "ERRO - $data_hora - Não foi possível remover a unidade externa!" >> /root/backup.log
fi
