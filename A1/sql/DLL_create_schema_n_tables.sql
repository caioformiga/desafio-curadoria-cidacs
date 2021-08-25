--# verificar se existe uma instancia do postgresql funcionando
--# verificar se existe um usuário postgres
--# executar o script no Query Browser ou via pssql

DROP SCHEMA IF EXISTS desafio_curadoria CASCADE;

CREATE SCHEMA desafio_curadoria AUTHORIZATION postgres;



DROP TABLE IF EXISTS desafio_curadoria."WH_AMAPAC";

CREATE TABLE desafio_curadoria."WH_AMAPAC"
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
  OIDS = FALSE
);

ALTER TABLE desafio_curadoria."WH_AMAPAC" OWNER TO postgres;




DROP TABLE IF EXISTS desafio_curadoria."TB_PACIENTE";

DROP SEQUENCE IF EXISTS desafio_curadoria."SEQ_TB_PACIENTE_ID";

CREATE SEQUENCE desafio_curadoria."SEQ_TB_PACIENTE_ID" START 1;
    
ALTER TABLE desafio_curadoria."SEQ_TB_PACIENTE_ID" OWNER TO postgres;

CREATE TABLE desafio_curadoria."TB_PACIENTE"(
    id          bigint DEFAULT nextval('desafio_curadoria."SEQ_TB_PACIENTE_ID"'::regclass) NOT NULL,
    ap_cnspcn	  text, 
    ap_coidade	smallint,
    idade_max	smallint,  -- campo sera imputado, ver layout
    ap_sexo	    character(1),
    ap_racacor	smallint,
    ap_ufnacio	smallint,
    ap_etnia	  character(4),
    peso_medio numeric(5,2), -- campo sera imputado, ver layout
    altura_media numeric(5,2) -- campo sera imputado, ver layout
)
WITH (
  OIDS=FALSE
);

ALTER TABLE desafio_curadoria."TB_PACIENTE" OWNER TO postgres;




DROP TABLE IF EXISTS desafio_curadoria."TB_ESTABELECIMENTO";

DROP SEQUENCE IF EXISTS desafio_curadoria."SEQ_TB_ESTABELECIMENTO_ID";

CREATE SEQUENCE desafio_curadoria."SEQ_TB_ESTABELECIMENTO_ID" START 1;

ALTER TABLE desafio_curadoria."SEQ_TB_ESTABELECIMENTO_ID" OWNER TO postgres;

CREATE TABLE desafio_curadoria."TB_ESTABELECIMENTO"(
    id          bigint DEFAULT nextval('desafio_curadoria."SEQ_TB_ESTABELECIMENTO_ID"'::regclass) NOT NULL,
    ap_coduni	integer, 
    ap_mvm	    character(6),
    ap_condic 	character(2),
    ap_gestao	integer,	
    ap_ufmun	integer,	
    ap_tpups	smallint,	    
    ap_tippre	smallint,
    ap_mn_ind	character(1),    
    ap_cnpjcpf	bigint,	
    ap_cnpjmnt	bigint,
    ap_natju	smallint
)
WITH (
  OIDS=FALSE
);

ALTER TABLE desafio_curadoria."TB_ESTABELECIMENTO" OWNER TO postgres;



DROP TABLE IF EXISTS desafio_curadoria."TB_MEDICAMENTO";

CREATE TABLE desafio_curadoria."TB_MEDICAMENTO"(
    ap_autoriz	bigint,
    id_pcn      bigint,
    id_estab	integer,
    ap_cmp	    character(6),
    ap_pripal	bigint,
    ap_vl_ap	numeric(14,2),
    ap_nuidade	smallint,
    ap_ufdif	smallint,
    ap_mndif	smallint,
    ap_dtinic	character(8),
    ap_dtfim	character(8),
    ap_tpaten	smallint,
    ap_tpapac	smallint,
    ap_motsai	smallint,
    ap_obito	smallint,
    ap_encerr	smallint,
    ap_perman	smallint,
    ap_alta	    smallint,
    ap_transf	smallint,
    ap_dtocor	character(8),
    ap_codemi	character(10),
    ap_catend	character(2),
    ap_apacant	character(13),
    ap_unisol	integer,
    ap_dtsolic	character(8),
    ap_dtaut	character(8),
    ap_cidcas	character(4),
    ap_cidpri	character(4),
    ap_cidsec	character(4),
    am_peso	    numeric(5,2),
    am_altura	numeric(5,2),
    am_transpl	character(1),
    am_qtdtran	smallint,
    am_gestant	character(1)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE desafio_curadoria."TB_MEDICAMENTO" OWNER TO postgres;