# desafio-curadoria-cidacs
Repositório para entrega dos artefatos relacionados ao desafio da vaga de curadoria no CIDACS.

***

/A1
Artefatos que auxiliaram na análise da estrutura dos arquivos de disseminação (em DBC) relacionados com a APAC de medicamentos (AMAPAC) para definir layout do modelo de dados do warehouse e das tabelas usadas para manter os dados.

**script_wget_from_DATASUS.sh**
Para baixar os dados da AMAPAC, em arquivos DBC, do ano de 2021, mês de janeiro (01), de todos os estados do Brasil, use o script em bash, navegue até a página A1 e digite o comando abaixo, e os arquivos serão salvos na pasta dbc, que será criada automáticamente caso ainda não exista.

*bash ./script_wget_from_DATASUS.sh*

obs: o script utiliza o wget para fazer download no link ftp do DATASUSU, verifique a instalação deste pacote antes de rodar.



**layout/**
Mantem os arquivos que foram usadaos para definir o layouto do banco de dados relacioanl

***

/A2
Extrair arquivos .DBC e criar arquivos .CSV para dados, de pelo menos um mês, de todos os estados para AMAPAC.
Criar tabela(s) no SGDB PostgreSQL e importar os 
