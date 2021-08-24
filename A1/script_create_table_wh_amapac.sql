# verificar se existe uma instancia do postgresql funcionando
# verificar se existe um usuário postgres
# executar o script no Query Browser

CREATE SCHEMA desafio_curadoria
  AUTHORIZATION postgres;

﻿CREATE TABLE desafio_curadoria."WH_AMPAC"
(
    ap_mvm	    character(6),
    ap_condic	character(2),
    ap_gestao	character(6),
    ap_coduni	character(7),
    ap_autoriz	character(13),
    ap_cmp	    character(6),
    ap_pripal	character(10),
    ap_vl_ap	character(14),
    ap_ufmun	character(6),
    ap_tpups	character(2),
    ap_tippre	character(2),
    ap_mn_ind	character(1),
    ap_cnpjcpf	character(14),
    ap_cnpjmnt	character(14),
    ap_cnspcn	text, 
    ap_coidade	character(1),
    ap_nuidade	character(2),
    ap_sexo	    character(1),
    ap_racacor	character(2),
    ap_munpcn	character(6),
    ap_ufnacio	character(3),
    ap_ceppcn	character(8),
    ap_ufdif	character(2),
    ap_mndif	character(2),
    ap_dtinic	character(8),
    ap_dtfim	character(8),
    ap_tpaten	character(2),
    ap_tpapac	character(1),
    ap_motsai	character(2),
    ap_obito	character(1),
    ap_encerr	character(1),
    ap_perman	character(1),
    ap_alta	    character(1),
    ap_transf	character(1),
    ap_dtocor	character(8),
    ap_codemi	character(10),
    ap_catend	character(2),
    ap_apacant	character(13),
    ap_unisol	character(7),
    ap_dtsolic	character(8),
    ap_dtaut	character(8),
    ap_cidcas	character(4),
    ap_cidpri	character(4),
    ap_cidsec	character(4),
    ap_etnia	character(4),
    am_peso	    character(3),
    am_altura	character(3),
    am_transpl	character(1),
    am_qtdtran	character(2),
    am_gestant	character(1),
    ap_natju	character(4),
    wh_year  	smallint,
    wh_month	smallint,
    wh_uf	    character(2),
    wh_dbc_file	character(12)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE desafio_curadoria."WH_AMPAC"
  OWNER TO postgres;
