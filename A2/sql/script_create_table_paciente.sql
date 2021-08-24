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