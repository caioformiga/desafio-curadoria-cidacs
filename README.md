# desafio-curadoria-cidacs
Repositório para entrega dos artefatos relacionados ao desafio da vaga de curadoria no CIDACS.

***

# A1/
Artefatos que auxiliaram na análise da estrutura dos arquivos de disseminação (em DBC) relacionados com a APAC de medicamentos (AMAPAC) para definir layout do modelo de dados do warehouse e das tabelas usadas para manter os dados.


**layout/**

Mantem os arquivos que foram usadaos para definir o layouto do banco de dados relacioanl. A modelagem foi feita usando três entidades que são armazenadass em tabelas: *tb_paciente, tb_esstabelecimento e tb_medicamento*; além disso foi usada uma tabela para receber dados de um arquivo exertno (.CSV), funcionando como um warehouse, para armazenar os dados antes de realizar outras operações: *wh_amapac*.


**shell**

Para baixar os dados da AMAPAC, em arquivos DBC, do ano de 2021, mês de janeiro (01), de todos os estados do Brasil, usei um script em bash. 

O script chama-se *script_wget_from_DATASUS.sh* e para acesssá-lo navegue até a página A1/shell e digite o comando abaixo, os arquivos serão salvos na pasta dbc, que será criada automáticamente caso ainda não exista.

*bash ./script_wget_from_DATASUS.sh*

obs: o script utiliza o wget para fazer download no link ftp do DATASUSU, verifique a instalação deste pacote antes de rodar.


**sql**

Uma vez definido o modelo (ver layout) elaborei um script que cria as 4 entidades: DLL_create_schema_n_tables.sql


***

/A2
Extrair arquivos .DBC e criar arquivos .CSV para dados, de pelo menos um mês, de todos os estados para AMAPAC.
Criar tabela(s) no SGDB PostgreSQL e importar os 
