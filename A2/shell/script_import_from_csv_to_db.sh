#!/bin/bash

# antes de rodar o script deve ser configurado cinco variaveis substituido a string "<****>" por outra que seja adequada ao ambiente. Em cada variável as aspas devem ser mantidas, se o user for adm, deve ficar user="admin"
export user=" "
export PGPASSWORD=" "
export db=" " 
export host=" "
export port=" "

sch="desafio_curadoria"
tb='"WH_AMAPAC"'

csv_pah=${CIDACS_HOME}/A2/csv

for f in "$csv_pah"/*.csv
do
    psql -d $db -U $user -h $host -p $port -c "\copy $sch.$tb from '$f' DELIMITER ',' CSV HEADER"
done
 
echo "Finalizou!"
