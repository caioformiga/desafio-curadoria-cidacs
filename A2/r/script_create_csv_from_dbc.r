# requisitos
# install.packages("read.dbc")        # https://github.com/danicat/read.dbc
# definir variavel de ambiente CIDACS_HOME

CIDACS_HOME = Sys.getenv(c("CIDACS_HOME"))

A2_PATH <-paste(CIDACS_HOME, "A2", sep ="/")
setwd(A2_PATH)
dir.create("./csv")
CSV_PATH = paste(A2_PATH, "csv", sep ="/")

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

  amapac_dF_ORDENADO <- amapac_df[c("AP_MVM","AP_CONDIC","AP_GESTAO", "AP_CODUNI", "AP_AUTORIZ", "AP_CMP", "AP_PRIPAL", "AP_VL_AP", "AP_UFMUN", "AP_TPUPS", "AP_TIPPRE", "AP_MN_IND", "AP_CNPJCPF", "AP_CNPJMNT", "AP_CNSPCN", "AP_COIDADE", "AP_NUIDADE", "AP_SEXO", "AP_RACACOR", "AP_MUNPCN", "AP_UFNACIO", "AP_CEPPCN", "AP_UFDIF", "AP_MNDIF", "AP_DTINIC", "AP_DTFIM", "AP_TPATEN", "AP_TPAPAC", "AP_MOTSAI", "AP_OBITO", "AP_ENCERR", "AP_PERMAN", "AP_ALTA", "AP_TRANSF", "AP_DTOCOR", "AP_CODEMI", "AP_CATEND", "AP_APACANT", "AP_UNISOL", "AP_DTSOLIC", "AP_DTAUT", "AP_CIDCAS", "AP_CIDPRI", "AP_CIDSEC", "AP_ETNIA", "AM_PESO", "AM_ALTURA", "AM_TRANSPL", "AM_QTDTRAN", "AM_GESTANT", "AP_NATJUR")]
  amapac_df <- amapac_dF_ORDENADO
  
  # adiciona QUATRO colunas
  amapac_df$WH_YEAR <- 2021
  amapac_df$WH_MONTH <- 01
  amapac_df$WH_UF <- uf
  amapac_df$WH_DBC_SOURCE_FILE <- gsub('_UF_', uf, 'AM_UF_2101.dbc')
  
  write.csv(amapac_df, csv_file_path, row.names = FALSE, fileEncoding="UTF8");
}
