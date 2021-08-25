--verificar se existe uma instancia do postgresql funcionando
--verificar se existe um usuário postgres
--executar o script no Query Browser ou via pssql

DROP TABLE IF EXISTS desafio_curadoria."TB_PACIENTE_AUX";

CREATE TABLE desafio_curadoria."TB_PACIENTE_AUX" AS
SELECT DISTINCT
    ap_cnspcn as ap_cnspcn,
    CAST (ap_coidade AS SMALLINT) as ap_coidade,
    ap_sexo,
    CAST (ap_racacor AS SMALLINT) as ap_racacor,    
    CAST (ap_ufnacio AS SMALLINT) as ap_ufnacio,
    ap_etnia as ap_etnia
FROM desafio_curadoria."WH_AMAPAC";

ALTER TABLE desafio_curadoria."TB_PACIENTE_AUX" OWNER TO postgres;



INSERT INTO desafio_curadoria."TB_PACIENTE"(
    ap_cnspcn,
    ap_coidade,
    ap_sexo,
    ap_racacor,
    ap_ufnacio,
    ap_etnia
) 
SELECT DISTINCT
    ap_cnspcn,
    ap_coidade,
    ap_sexo,
    ap_racacor,
    ap_ufnacio,
    ap_etnia
FROM desafio_curadoria."TB_PACIENTE_AUX";

ALTER TABLE desafio_curadoria."TB_PACIENTE" ADD CONSTRAINT TB_PACIENTE_PK_ID PRIMARY KEY (id);

CREATE INDEX "IDX_TB_PACIENTE_ID" ON desafio_curadoria."TB_PACIENTE" USING btree (id);

CREATE INDEX "IDX_TB_PACIENTE_AP_CNSPCN" ON desafio_curadoria."TB_PACIENTE" USING btree (ap_cnspcn);

DROP TABLE IF EXISTS desafio_curadoria."TB_PACIENTE_AUX";



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


DROP TABLE IF EXISTS desafio_curadoria."TB_MEDICAMENTO_AUX";

CREATE TABLE desafio_curadoria."TB_MEDICAMENTO_AUX" AS
SELECT 
    CAST (wh.ap_autoriz AS BIGINT) as ap_autoriz, -- funciona como um id
    ap_cnspcn as ap_cnspcn,
    CAST (ap_coduni AS INTEGER) as ap_coduni,	
    ap_cmp,
    CAST (wh.ap_pripal AS BIGINT) as ap_pripal,
    CAST (wh.ap_vl_ap AS NUMERIC(14,2)) as ap_vl_ap,
    CAST (ap_nuidade AS SMALLINT) as ap_nuidade,
    CAST (ap_ufdif AS SMALLINT) as ap_ufdif,
    CAST (ap_mndif AS SMALLINT) as ap_mndif,
    ap_dtinic,
    ap_dtfim,
    CAST (ap_tpaten AS SMALLINT) as ap_tpaten,
    CAST (ap_tpapac AS SMALLINT) as ap_tpapac,
    CAST (ap_motsai AS SMALLINT) as ap_motsai,
    CAST (ap_obito AS SMALLINT) as ap_obito,
    CAST (ap_encerr AS SMALLINT) as ap_encerr,
    CAST (ap_perman AS SMALLINT) as ap_perman,
    CAST (ap_alta AS SMALLINT) as ap_alta,
    CAST (ap_transf AS SMALLINT) as ap_transf,
    ap_dtocor,
    ap_codemi,
    ap_catend,
    ap_apacant,
    CAST (ap_unisol AS INTEGER) as ap_unisol,
    ap_dtsolic,
    ap_dtaut,
    ap_cidcas,
    ap_cidpri,
    ap_cidsec,
    CAST (wh.am_peso AS NUMERIC(5,2)) as am_peso,
    CAST (wh.am_altura AS NUMERIC(5,2)) as am_altura,
    am_transpl,
    CAST (am_qtdtran AS INTEGER) as am_qtdtran,
    am_gestant	
FROM desafio_curadoria."WH_AMAPAC" as wh;

ALTER TABLE desafio_curadoria."TB_MEDICAMENTO_AUX" OWNER TO postgres;

CREATE INDEX "IDX_TB_MEDICAMENTO_AUX_AP_CODUNI" ON desafio_curadoria."TB_MEDICAMENTO_AUX" USING btree (ap_coduni);

CREATE INDEX "IDX_TB_MEDICAMENTO_AUX_AP_CNSPCN" ON desafio_curadoria."TB_MEDICAMENTO_AUX" USING btree (ap_cnspcn);


DROP TABLE IF EXISTS desafio_curadoria."TB_MEDICAMENTO_AUTORIZACAO_DUPLICADA";

CREATE TABLE desafio_curadoria."TB_MEDICAMENTO_AUTORIZACAO_DUPLICADA" AS
SELECT aux.ap_autoriz, count(distinct aux.ap_cnspcn) as qtd_pacientes
FROM desafio_curadoria."TB_MEDICAMENTO_AUX" as aux
GROUP BY aux.ap_autoriz
HAVING count(DISTINCT aux.ap_cnspcn) > 1
ORDER BY 2 DESC;

ALTER TABLE desafio_curadoria."TB_MEDICAMENTO_AUTORIZACAO_DUPLICADA" OWNER TO postgres;


DELETE FROM desafio_curadoria."TB_MEDICAMENTO_AUX" as aux
WHERE aux.ap_autoriz IN (
	  SELECT dupl.ap_autoriz
	  FROM desafio_curadoria."TB_MEDICAMENTO_AUTORIZACAO_DUPLICADA" as dupl
);


INSERT INTO desafio_curadoria."TB_MEDICAMENTO"(
    ap_autoriz,
    id_pcn,
    id_estab,
    ap_cmp,
    ap_pripal,
    ap_vl_ap,
    ap_nuidade,
    ap_ufdif,
    ap_mndif,
    ap_dtinic,
    ap_dtfim,
    ap_tpaten,
    ap_tpapac,
    ap_motsai,
    ap_obito,
    ap_encerr,
    ap_perman,
    ap_alta,
    ap_transf,
    ap_dtocor,
    ap_codemi,
    ap_catend,
    ap_apacant,
    ap_unisol,
    ap_dtsolic,
    ap_dtaut,
    ap_cidcas,
    ap_cidpri,
    ap_cidsec,
    am_peso,
    am_altura,
    am_transpl,
    am_qtdtran,
    am_gestant
) 
SELECT DISTINCT
    aux.ap_autoriz,
    pcn.id as id_pcn,
    estab.id as id_estab,
    aux.ap_cmp,
    aux.ap_pripal,
    aux.ap_vl_ap,
    aux.ap_nuidade,
    aux.ap_ufdif,
    aux.ap_mndif,
    aux.ap_dtinic,
    aux.ap_dtfim,
    aux.ap_tpaten,
    aux.ap_tpapac,
    aux.ap_motsai,
    aux.ap_obito,
    aux.ap_encerr,
    aux.ap_perman,
    aux.ap_alta,
    aux.ap_transf,
    aux.ap_dtocor,
    aux.ap_codemi,
    aux.ap_catend,
    aux.ap_apacant,
    aux.ap_unisol,
    aux.ap_dtsolic,
    aux.ap_dtaut,
    aux.ap_cidcas,
    aux.ap_cidpri,
    aux.ap_cidsec,
    aux.am_peso,
    aux.am_altura,
    aux.am_transpl,
    aux.am_qtdtran,
    aux.am_gestant
FROM desafio_curadoria."TB_MEDICAMENTO_AUX" as aux
LEFT JOIN desafio_curadoria."TB_PACIENTE" as pcn
ON (aux.ap_cnspcn = pcn.ap_cnspcn)
LEFT JOIN desafio_curadoria."TB_ESTABELECIMENTO" as estab
ON (aux.ap_coduni = estab.ap_coduni)
