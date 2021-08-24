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
)



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


