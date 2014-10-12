#!/bin/bash
#
# 2. Desenvolva um script que leia o nome do usuário de forma interativa e imprima a seguinte mensagem:
# "Olá Fulano! Hoje é 22/08/2014" (APresente a data atual e o nome informado)
#
now=`date +%d/%m/%Y`
echo 'Digite o seu nome: '
read nome
echo "Olá $nome ! Hoje é $now "
