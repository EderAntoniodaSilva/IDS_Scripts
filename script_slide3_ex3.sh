#!/bin/bash
#
# 3. Desenvolva um script que calcule a média entre 4 números e apresente a resposta na tela. Os números devem ser informados de forma interativa.
#
clear
echo "Digite o primeiro numero: "
read numero1
echo "Digite o segundo numero: "
read numero2
echo "Digite o terceiro numero: "
read numero3
echo "Digite o quarto numero: "
read numero4
media=$(echo "scale=2;($numero1+$numero2+$numero3+$numero4)/4" | bc)
echo "calculando..."
sleep 2s
echo "Media final: $media"
