# requisitos
# install.packages("read.dbc")        # https://github.com/danicat/read.dbc
# definir variavel de ambiente CIDACS_HOME como pasta path do projeto após clonar do repositório
# se clonado em $HOME/Downloads, CIDACS_HOME=$HOME/Downloads/desafio-curadoria-cidacs 

CIDACS_HOME = Sys.getenv(c("CIDACS_HOME"))

A2_PATH <-paste(CIDACS_HOME, "A2", sep ="/")
setwd(A2_PATH)
dir.create("./csv")
CSV_PATH = paste(A2_PATH, "csv", sep ="/")

RSCRIPT_PATH <- paste(A2_PATH, "r", sep ="/")

A1_PATH <-paste(CIDACS_HOME, "A1", sep ="/")
DBC_PATH = paste(A1_PATH, "dbc", sep ="/")
dbc_file_path <- paste(DBC_PATH, "AM_UF_2101.dbc", sep ="/")

library(read.dbc)

LISTA_UF_ESTADOS <- c("AC" , "AL" , "AM" , "AP" , "BA" , "CE" , "DF" , "ES" , "GO" , "MA" , "MG" , "MS" , "MT" , "PA" , "PB" , "PE" , "PI" , "PR" , "RJ" , "RN" , "RO" , "RR" , "RS" , "SC" , "SE" , "SP" , "TO")

# os arquivos serão convertidos apenas do ano de 2021 e mês de janeiro
FLAG="_UF_"

for (uf in LISTA_UF_ESTADOS) {
  url=gsub("_UF_", uf, dbc_file_path)
  amapac_df <- read.dbc::read.dbc(url)
  
  # adicionar coluna usando os dados da coluna AP_CNSPCN e convertidos de latin1 para utf-8
  amapac_df$AP_CNSPCN <- iconv(amapac_df$AP_CNSPCN, from = "LATIN1", to = "UTF8")
  
  # concatenar a string da uf para gerar o nome do arquivo, exemplo: BA.csv
  csv_file <- paste(uf, ".csv", sep ="")
  
  # concatenar o nome do arquivo para gerar o path completo
  csv_file_path <- paste(CSV_PATH, csv_file, sep ="/")
  
  colnames(amapac_df) <- c("ap_mvm","ap_condic","ap_gestao", "ap_coduni", "ap_autoriz", "ap_cmp", "ap_pripal", "ap_vl_ap", "ap_ufmun", "ap_tpups", "ap_tippre", "ap_mn_ind", "ap_cnpjcpf", "ap_cnpjmnt", "ap_cnspcn", "ap_coidade", "ap_nuidade", "ap_sexo", "ap_racacor", "ap_munpcn", "ap_ufnacio", "ap_ceppcn", "ap_ufdif", "ap_mndif", "ap_dtinic", "ap_dtfim", "ap_tpaten", "ap_tpapac", "ap_motsai", "ap_obito", "ap_encerr", "ap_perman", "ap_alta", "ap_transf", "ap_dtocor", "ap_codemi", "ap_catend", "ap_apacant", "ap_unisol", "ap_dtsolic", "ap_dtaut", "ap_cidcas", "ap_cidpri", "ap_cidsec", "ap_etnia", "am_peso", "am_altura", "am_transpl", "am_qtdtran", "am_gestant", "ap_natjur")
  
  amapac_dF_ORDENADO <- amapac_df[c("ap_mvm","ap_condic","ap_gestao", "ap_coduni", "ap_autoriz", "ap_cmp", "ap_pripal", "ap_vl_ap", "ap_ufmun", "ap_tpups", "ap_tippre", "ap_mn_ind", "ap_cnpjcpf", "ap_cnpjmnt", "ap_cnspcn", "ap_coidade", "ap_nuidade", "ap_sexo", "ap_racacor", "ap_munpcn", "ap_ufnacio", "ap_ceppcn", "ap_ufdif", "ap_mndif", "ap_dtinic", "ap_dtfim", "ap_tpaten", "ap_tpapac", "ap_motsai", "ap_obito", "ap_encerr", "ap_perman", "ap_alta", "ap_transf", "ap_dtocor", "ap_codemi", "ap_catend", "ap_apacant", "ap_unisol", "ap_dtsolic", "ap_dtaut", "ap_cidcas", "ap_cidpri", "ap_cidsec", "ap_etnia", "am_peso", "am_altura", "am_transpl", "am_qtdtran", "am_gestant", "ap_natjur")]
  amapac_df <- amapac_dF_ORDENADO
  
  # adiciona QUATRO colunas
  amapac_df$wh_year <- 2021
  amapac_df$wh_month <- 01
  amapac_df$wh_uf <- uf
  amapac_df$wh_dbc_source_file <- gsub('_UF_', uf, 'AM_UF_2101.dbc')
  
  write.csv(amapac_df, csv_file_path, row.names = FALSE, fileEncoding="UTF8");
}
