# desafio-curadoria-cidacs
Repositório para entrega dos artefatos relacionados ao desafio da vaga de curadoria no CIDACS.

***

# A1/
Artefatos que auxiliaram na análise da estrutura dos arquivos de disseminação (em DBC) relacionados com a APAC de medicamentos (AMAPAC) para definir layout do modelo de dados.


**layout/**

Mantem os arquivos que foram usadaos para definir o layouto do banco de dados relacioanl. A modelagem foi feita usando três entidades que são armazenadass em tabelas: *tb_paciente, tb_esstabelecimento e tb_medicamento*; além disso foi usada uma tabela para receber dados de um arquivo exertno (.CSV), funcionando como um warehouse, para armazenar os dados antes de realizar outras operações: *wh_amapac*.


**shell/**

Para baixar os dados da AMAPAC, em arquivos DBC, do ano de 2021, mês de janeiro (01), de todos os estados do Brasil, usei um script em bash. 

O script chama-se *script_wget_from_DATASUS.sh* e para acesssá-lo navegue até a página A1/shell e digite o comando abaixo, os arquivos serão salvos na pasta dbc, que será criada automáticamente caso ainda não exista.

*bash ./script_wget_from_DATASUS.sh*

obs: o script utiliza o wget para fazer download no link ftp do DATASUSU, verifique a instalação deste pacote antes de rodar.


**sql/**

Uma vez definido o modelo (ver layout) elaborei um script (*DLL_create_schema_n_tables.sql*) que cria as 4 entidades. 


***

# A2 
Artefatos que auxiliaram a importar os dados para o SGDB PostgreSQL


**r/**
Nesta pasta encontra-se o script em R (*script_create_csv_from_dbc.r*) capaz de ler todos os arquivos da pasta A1/dbc e converter os dados de .DBC para .CSV. Os dados são armazenados na pasta csv, que será criada automáticamente caso ainda não exista.
Os arquivos CSV possuem 4 campos que foram inseridos nesta etapa para auxiliar no processo de importação dos dados.
  
  exemplo:   
  amapac_df$wh_year <- 2021
  amapac_df$wh_month <- 01
  amapac_df$wh_uf <- uf
  amapac_df$wh_dbc_source_file <- gsub('_UF_', uf, 'AM_UF_2101.dbc')
  

**shell/**
Uma vez que os arquivos .CSV e as tabelas estão criadas no SGDB PostgreSQL, optei por importar todos dados para uma tabela, nomeada aqui de *wh_amapac* usando um script shell (*script_import_from_csv_to_db.sh*), para
acesssá-lo navegue até a página A2/shell e digite o comando abaixo, os arquivos serão importados usando o comando \copy do SGDB PostgreSQL.

*bash ./script_import_from_csv_to_db.sh*

** Antes de rodar o script deve ser configurado cinco variaveis que sejam adequadas ao ambiente. Em cada variável as aspas devem ser mantidas, se o user for adm, deve ficar user="admin" **

export user=" "
export PGPASSWORD=" "
export db=" " 
export host=" "
export port=" "


**sql/**

Uma vez importado os dados de definido *wh_amapac* é possível preencher as outras 3 tabelas do modelo (ver layout). Elaborei um script (*DML_selecet_from_warehouse_insert_at_tables.sql*) que preenche os dados para 3 entidades: *tb_paciente, tb_esstabelecimento e tb_medicamento*. 

obs: ao final do processamento uma 5ª tabela poderá ser criada (TB_MEDICAMENTO_AUTORIZACAO_DUPLICADA) para verificar se há registros errados.

Na sub pasta *modelagem* é posssivel localizar o diagrama completo gerado via schemaspy [https://schemaspy.readthedocs.io/en/latest/started.html]. BAsta acessar o arquivo index [A2/sql/modelagem/index.html] para visualizar detalhes.

