CREATE TABLE AFP 
    ( 
     id_afp NUMBER (6)  NOT NULL , 
     nombre VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE AFP 
    ADD CONSTRAINT PK_AFP PRIMARY KEY ( id_afp ) ;

ALTER TABLE AFP 
    ADD CONSTRAINT UK_AFP_nombre UNIQUE ( nombre ) ;

CREATE TABLE ATENCION_MEDICA 
    ( 
     id_atencion                 NUMBER  NOT NULL , 
     fecha_atencion              DATE  NOT NULL , 
     tipo_atencion               VARCHAR2 (25)  NOT NULL , 
     PACIENTE_id_paciente        NUMBER (12)  NOT NULL , 
     id_medico                   NUMBER  NOT NULL , 
     id_derivacion               NUMBER , 
     ATENCION_MEDICA_id_atencion NUMBER , 
     MEDICO_id_medico            NUMBER (6)  NOT NULL 
    ) 
;

ALTER TABLE ATENCION_MEDICA 
    ADD 
    CHECK (tipo_atencion IN ('"general"', '"preventiva"', '"urgencia"')) 
;

ALTER TABLE ATENCION_MEDICA 
    ADD CONSTRAINT PK_ATENCION_MEDICA PRIMARY KEY ( id_atencion ) ;

CREATE TABLE COMUNA 
    ( 
     id_comuna        NUMBER (6)  NOT NULL , 
     nombre           VARCHAR2 (75)  NOT NULL , 
     id_region        NUMBER , 
     REGION_id_region NUMBER (6)  NOT NULL 
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT PK_COMUNA PRIMARY KEY ( id_comuna ) ;

CREATE TABLE ESPECIALIDAD 
    ( 
     id_especialidad NUMBER (6)  NOT NULL , 
     nombre          VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE ESPECIALIDAD 
    ADD CONSTRAINT PK_ESPECIALIDAD PRIMARY KEY ( id_especialidad ) ;

ALTER TABLE ESPECIALIDAD 
    ADD CONSTRAINT UK_ESPECIALIDAD_nombre UNIQUE ( nombre ) ;

CREATE TABLE EXAMEN 
    ( 
     codigo                      NUMBER (9)  NOT NULL , 
     nombre                      VARCHAR2 (75)  NOT NULL , 
     tipo_muestra                VARCHAR2 (25)  NOT NULL , 
     condicion_preparacion       VARCHAR2 (25) , 
     resultado                   CLOB , 
     ATENCION_MEDICA_id_atencion NUMBER  NOT NULL 
    ) 
;

ALTER TABLE EXAMEN 
    ADD CONSTRAINT PK_EXAMEN PRIMARY KEY ( codigo ) ;

CREATE TABLE MEDICO 
    ( 
     rut                          VARCHAR2 (12)  NOT NULL , 
     id_medico                    NUMBER (6)  NOT NULL , 
     f_ingreso                    DATE  NOT NULL , 
     id_especialidad              NUMBER  NOT NULL , 
     id_afp                       NUMBER  NOT NULL , 
     SALUD_id_salud               NUMBER (6)  NOT NULL , 
     MEDICO_id_medico             NUMBER (6)  NOT NULL , 
     AFP_id_afp                   NUMBER (6)  NOT NULL , 
     ESPECIALIDAD_id_especialidad NUMBER (6)  NOT NULL , 
     UNIDAD_id_unidad             NUMBER (6)  NOT NULL 
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT PK_MEDICO PRIMARY KEY ( id_medico ) ;

CREATE TABLE PACIENTE 
    ( 
     rut                     VARCHAR2 (12)  NOT NULL , 
     id_paciente             NUMBER (12)  NOT NULL , 
     f_nacimiento            DATE  NOT NULL , 
     direccion               VARCHAR2 (100)  NOT NULL , 
     id_comuna               NUMBER  NOT NULL , 
     sexo                    CHAR (1)  NOT NULL , 
     telefono                NUMBER (12) , 
     correo                  VARCHAR2 (100) , 
     id_usuario              NUMBER  NOT NULL , 
     TIPO_USUARIO_id_usuario NUMBER (6)  NOT NULL , 
     COMUNA_id_comuna        NUMBER (6)  NOT NULL 
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT PK_PACIENTE PRIMARY KEY ( id_paciente ) ;

CREATE TABLE PAGO_ATENCION 
    ( 
     id_pago                     NUMBER (6)  NOT NULL , 
     tipo_pago                   VARCHAR2 (12)  NOT NULL , 
     monto                       NUMBER (12)  NOT NULL , 
     f_pago                      DATE  NOT NULL , 
     id_atencion                 NUMBER  NOT NULL , 
     ATENCION_MEDICA_id_atencion NUMBER  NOT NULL 
    ) 
;

ALTER TABLE PAGO_ATENCION 
    ADD CONSTRAINT CK_PAGO_TIPO 
    CHECK (tipo_pago IN ('"convenio"', '"efectivo"', '"tarjerta"')) 
;

ALTER TABLE PAGO_ATENCION 
    ADD CONSTRAINT PK_PAGO_ATENCION PRIMARY KEY ( id_pago ) ;

CREATE TABLE PERSONA 
    ( 
     rut        VARCHAR2 (12)  NOT NULL , 
     nombre     VARCHAR2 (75)  NOT NULL , 
     ap_paterno VARCHAR2 (50)  NOT NULL , 
     ap_materno VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE PERSONA 
    ADD CONSTRAINT PK_PERSONA PRIMARY KEY ( rut ) ;

CREATE TABLE REGION 
    ( 
     id_region NUMBER (6)  NOT NULL , 
     nombre    VARCHAR2 (75)  NOT NULL 
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT PK_REGION PRIMARY KEY ( id_region ) ;

ALTER TABLE REGION 
    ADD CONSTRAINT UK_REGION_nombre UNIQUE ( nombre ) ;

CREATE TABLE SALUD 
    ( 
     id_salud NUMBER (6)  NOT NULL , 
     nombre   VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE SALUD 
    ADD CONSTRAINT PK_SALUD PRIMARY KEY ( id_salud ) ;

ALTER TABLE SALUD 
    ADD CONSTRAINT UK_SALUD_nombre UNIQUE ( nombre ) ;

CREATE TABLE TIPO_USUARIO 
    ( 
     id_usuario NUMBER (6)  NOT NULL , 
     nombre     VARCHAR2 (15)  NOT NULL 
    ) 
;

ALTER TABLE TIPO_USUARIO 
    ADD CONSTRAINT CK_USUARIO_NOMBRE 
    CHECK (nombre IN ('"estudiante"', '"externo"', '"funcionario"')) 
;

ALTER TABLE TIPO_USUARIO 
    ADD CONSTRAINT PK_TIPO_USUARIO PRIMARY KEY ( id_usuario ) ;

ALTER TABLE TIPO_USUARIO 
    ADD CONSTRAINT UK_TIPO_USUARIO_nombre UNIQUE ( nombre ) ;

CREATE TABLE UNIDAD 
    ( 
     id_unidad NUMBER (6)  NOT NULL , 
     nombre    VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE UNIDAD 
    ADD CONSTRAINT CK_UNIDAD_NOMBRE 
    CHECK (nombre IN ('"laboratorio clinico"', '"medicina general"', '"salud mental"')) 
;

ALTER TABLE UNIDAD 
    ADD CONSTRAINT PK_UNIDAD PRIMARY KEY ( id_unidad ) ;

ALTER TABLE UNIDAD 
    ADD CONSTRAINT UK_UNIDAD_NOMBRE UNIQUE ( nombre ) ;

ALTER TABLE ATENCION_MEDICA 
    ADD CONSTRAINT FK_ATENCION_MEDICA_DERIVACION FOREIGN KEY 
    ( 
     ATENCION_MEDICA_id_atencion
    ) 
    REFERENCES ATENCION_MEDICA 
    ( 
     id_atencion
    ) 
;

ALTER TABLE ATENCION_MEDICA 
    ADD CONSTRAINT FK_ATENCION_MEDICA_MEDICO FOREIGN KEY 
    ( 
     MEDICO_id_medico
    ) 
    REFERENCES MEDICO 
    ( 
     id_medico
    ) 
;

ALTER TABLE ATENCION_MEDICA 
    ADD CONSTRAINT FK_ATENCION_MEDICA_PACIENTE FOREIGN KEY 
    ( 
     PACIENTE_id_paciente
    ) 
    REFERENCES PACIENTE 
    ( 
     id_paciente
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT FK_COMUNA_REGION FOREIGN KEY 
    ( 
     REGION_id_region
    ) 
    REFERENCES REGION 
    ( 
     id_region
    ) 
;

ALTER TABLE EXAMEN 
    ADD CONSTRAINT FK_EXAMEN_ATENCION_MEDICA FOREIGN KEY 
    ( 
     ATENCION_MEDICA_id_atencion
    ) 
    REFERENCES ATENCION_MEDICA 
    ( 
     id_atencion
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_AFP FOREIGN KEY 
    ( 
     AFP_id_afp
    ) 
    REFERENCES AFP 
    ( 
     id_afp
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_ESPECIALIDAD FOREIGN KEY 
    ( 
     ESPECIALIDAD_id_especialidad
    ) 
    REFERENCES ESPECIALIDAD 
    ( 
     id_especialidad
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_PERSONA FOREIGN KEY 
    ( 
     rut
    ) 
    REFERENCES PERSONA 
    ( 
     rut
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_SALUD FOREIGN KEY 
    ( 
     SALUD_id_salud
    ) 
    REFERENCES SALUD 
    ( 
     id_salud
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT FK_MEDICO_UNIDAD FOREIGN KEY 
    ( 
     UNIDAD_id_unidad
    ) 
    REFERENCES UNIDAD 
    ( 
     id_unidad
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT FK_PACIENTE_COMUNA FOREIGN KEY 
    ( 
     COMUNA_id_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT FK_PACIENTE_PERSONA FOREIGN KEY 
    ( 
     rut
    ) 
    REFERENCES PERSONA 
    ( 
     rut
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT FK_PACIENTE_TIPO_USUARIO FOREIGN KEY 
    ( 
     TIPO_USUARIO_id_usuario
    ) 
    REFERENCES TIPO_USUARIO 
    ( 
     id_usuario
    ) 
;

ALTER TABLE PAGO_ATENCION 
    ADD CONSTRAINT FK_PAGO_ATENCION_MEDICA FOREIGN KEY 
    ( 
     ATENCION_MEDICA_id_atencion
    ) 
    REFERENCES ATENCION_MEDICA 
    ( 
     id_atencion
    ) 
;