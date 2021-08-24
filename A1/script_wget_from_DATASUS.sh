#!/bin/bash

# para rodar navegue até a pasta do projeto/entrega A1 e digite 
# bash ./script_wget_from_DATASUS.sh

mkdir -p dbc

cd dbc

LISTA_UF_ESTADOS=("AC" "AL" "AM" "AP" "BA" "CE" "DF" "ES" "GO" "MA" "MG" "MS" "MT" "PA" "PB" "PE" "PI" "PR" "RJ" "RN" "RO" "RR" "RS" "SC" "SE" "SP" "TO")

# os arquivos serão salvos são apenas do ano de 2021 e mês de janeiro
DEFAULT_URL="ftp://ftp.datasus.gov.br/dissemin/publicos/SIASUS/200801_/Dados/AM_UF_2101.dbc"

FLAG="_UF_"

for uf in "${LISTA_UF_ESTADOS[@]}"
do
    wget ${DEFAULT_URL/$FLAG/$uf}
done
