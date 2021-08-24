DROP TABLE IF EXISTS desafio_curadoria."TB_ESTABELECIMENTO_AUX";

CREATE TABLE desafio_curadoria."TB_ESTABELECIMENTO_AUX" AS
SELECT DISTINCT
    CAST (ap_coduni AS INTEGER) as ap_coduni,
    ap_mvm,
    ap_condic,
    CAST (ap_gestao AS INTEGER) as ap_gestao,
    CAST (ap_ufmun AS INTEGER) as ap_ufmun,	
    CAST (ap_tpups AS SMALLINT) as ap_tpups,	    
    ap_mn_ind,	
    CAST (ap_tippre AS SMALLINT) as ap_tippre,
    CAST (ap_cnpjcpf AS BIGINT) as ap_cnpjcpf,
    CAST (ap_cnpjmnt AS BIGINT) as ap_cnpjmnt,
    CAST (ap_natju AS SMALLINT) as ap_natju
FROM desafio_curadoria."WH_AMAPAC";

ALTER TABLE desafio_curadoria."TB_ESTABELECIMENTO_AUX" OWNER TO postgres;



DROP TABLE IF EXISTS desafio_curadoria."TB_ESTABELECIMENTO";

DROP SEQUENCE IF EXISTS desafio_curadoria."SEQ_TB_ESTABELECIMENTO_ID";

CREATE SEQUENCE desafio_curadoria."SEQ_TB_ESTABELECIMENTO_ID" START 1;

ALTER TABLE desafio_curadoria."SEQ_TB_ESTABELECIMENTO_ID" OWNER TO postgres;

CREATE TABLE desafio_curadoria."TB_ESTABELECIMENTO"(
    id          bigint DEFAULT nextval('desafio_curadoria."SEQ_TB_ESTABELECIMENTO_ID"'::regclass) NOT NULL,
    ap_coduni	integer, 
    ap_mvm	character(6),
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


INSERT INTO desafio_curadoria."TB_ESTABELECIMENTO"(
    ap_coduni,
    ap_mvm,
    ap_condic,
    ap_gestao,	
    ap_ufmun,	
    ap_tpups,	
    ap_tippre,    
    ap_mn_ind,	
    ap_cnpjcpf,	
    ap_cnpjmnt,
    ap_natju
) 
SELECT DISTINCT
    ap_coduni,
    ap_mvm,
    ap_condic,
    ap_gestao,	
    ap_ufmun,	
    ap_tpups,	
    ap_tippre,    
    ap_mn_ind,	
    ap_cnpjcpf,	
    ap_cnpjmnt,
    ap_natju
FROM desafio_curadoria."TB_ESTABELECIMENTO_AUX";


ALTER TABLE desafio_curadoria."TB_ESTABELECIMENTO" ADD CONSTRAINT TB_ESTABELECIMENTO_PK_ID PRIMARY KEY (id);

CREATE INDEX "IDX_TB_ESTABELECIMENTO_ID" ON desafio_curadoria."TB_ESTABELECIMENTO" USING btree (id);

CREATE INDEX "IDX_TB_ESTABELECIMENTO_AP_CODUNI" ON desafio_curadoria."TB_ESTABELECIMENTO" USING btree (ap_coduni);

DROP TABLE IF EXISTS desafio_curadoria."TB_ESTABELECIMENTO_AUX";

