/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  15/11/2022 10:14:58                      */
/*==============================================================*/


alter table COURS
   drop constraint FK_COURS_ANIMER_PROFESSE;

alter table COURS
   drop constraint FK_COURS_APPARTENI_TYPECOUR;

alter table COURS
   drop constraint FK_COURS_DEDIER_A_TYPEINST;

alter table INSTRUMENT
   drop constraint FK_INSTRUME_CORRESPON_TYPEINST;

alter table PRATIQUER
   drop constraint FK_PRATIQUE_PRATIQUER_TYPEINST;

alter table PRATIQUER
   drop constraint FK_PRATIQUE_PRATIQUER_PROFESSE;

alter table PROFESSEUR
   drop constraint FK_PROFESSE_SPECIALIS_TYPEINST;

alter table TARIFER
   drop constraint FK_TARIFER_TARIFER_TRANCHE;

alter table TARIFER
   drop constraint FK_TARIFER_TARIFER2_TYPECOUR;

alter table TYPEINSTRUMENT
   drop constraint FK_TYPEINST_REGROUPER_CATEGORI;

drop table CATEGORIE cascade constraints;

drop index DEDIER_A_FK;

drop index ANIMER_FK;

drop index APPARTENIR_FK;

drop table COURS cascade constraints;

drop index CORRESPONDRE_FK;

drop table INSTRUMENT cascade constraints;

drop index PRATIQUER2_FK;

drop index PRATIQUER_FK;

drop table PRATIQUER cascade constraints;

drop index SPECIALISER_FK;

drop table PROFESSEUR cascade constraints;

drop index TARIFER2_FK;

drop index TARIFER_FK;

drop table TARIFER cascade constraints;

drop table TRANCHE cascade constraints;

drop table TYPECOURS cascade constraints;

drop index REGROUPER_FK;

drop table TYPEINSTRUMENT cascade constraints;

/*==============================================================*/
/* Table : CATEGORIE                                            */
/*==============================================================*/
create table CATEGORIE 
(
   IDCAT                INTEGER              not null,
   LIBCAT               VARCHAR2(30),
   constraint PK_CATEGORIE primary key (IDCAT)
);

/*==============================================================*/
/* Table : COURS                                                */
/*==============================================================*/
create table COURS 
(
   IDCOURS              INTEGER              not null,
   IDTPINST             INTEGER,
   IDPROF               INTEGER              not null,
   IDTPCOURS            INTEGER              not null,
   LIBCOURS             VARCHAR2(30),
   AGEMINI              INTEGER,
   AGEMAXI              INTEGER,
   NBPLACES             INTEGER,
   constraint PK_COURS primary key (IDCOURS)
);

/*==============================================================*/
/* Index : APPARTENIR_FK                                        */
/*==============================================================*/
create index APPARTENIR_FK on COURS (
   IDTPCOURS ASC
);

/*==============================================================*/
/* Index : ANIMER_FK                                            */
/*==============================================================*/
create index ANIMER_FK on COURS (
   IDPROF ASC
);

/*==============================================================*/
/* Index : DEDIER_A_FK                                          */
/*==============================================================*/
create index DEDIER_A_FK on COURS (
   IDTPINST ASC
);

/*==============================================================*/
/* Table : INSTRUMENT                                           */
/*==============================================================*/
create table INSTRUMENT 
(
   IDINST               INTEGER              not null,
   IDTPINST             INTEGER              not null,
   DATEACHAT            DATE,
   PRIXACHAT            NUMBER(8,2),
   COULEUR              VARCHAR2(30),
   MARQUE               VARCHAR2(30),
   MODELE               VARCHAR2(30),
   constraint PK_INSTRUMENT primary key (IDINST)
);

/*==============================================================*/
/* Index : CORRESPONDRE_FK                                      */
/*==============================================================*/
create index CORRESPONDRE_FK on INSTRUMENT (
   IDTPINST ASC
);

/*==============================================================*/
/* Table : PRATIQUER                                            */
/*==============================================================*/
create table PRATIQUER 
(
   IDTPINST             INTEGER              not null,
   IDPROF               INTEGER              not null,
   constraint PK_PRATIQUER primary key (IDTPINST, IDPROF)
);

/*==============================================================*/
/* Index : PRATIQUER_FK                                         */
/*==============================================================*/
create index PRATIQUER_FK on PRATIQUER (
   IDTPINST ASC
);

/*==============================================================*/
/* Index : PRATIQUER2_FK                                        */
/*==============================================================*/
create index PRATIQUER2_FK on PRATIQUER (
   IDPROF ASC
);

/*==============================================================*/
/* Table : PROFESSEUR                                           */
/*==============================================================*/
create table PROFESSEUR 
(
   IDPROF               INTEGER              not null,
   IDTPINST             INTEGER,
   NOMPROF              VARCHAR2(30)         not null,
   PNOMPROF             VARCHAR2(30)         not null,
   DATENAIS             DATE                 not null,
   DATEEMB              DATE,
   DATEDPT              DATE,
   STATUT               INTEGER,
   EMAILPROF            VARCHAR2(30),
   TELPROF              CHAR(10),
   constraint PK_PROFESSEUR primary key (IDPROF)
);

/*==============================================================*/
/* Index : SPECIALISER_FK                                       */
/*==============================================================*/
create index SPECIALISER_FK on PROFESSEUR (
   IDTPINST ASC
);

/*==============================================================*/
/* Table : TARIFER                                              */
/*==============================================================*/
create table TARIFER 
(
   IDTRANCHE            CHAR(1)              not null,
   IDTPCOURS            INTEGER              not null,
   MONTANT              NUMBER,
   constraint PK_TARIFER primary key (IDTRANCHE, IDTPCOURS)
);

/*==============================================================*/
/* Index : TARIFER_FK                                           */
/*==============================================================*/
create index TARIFER_FK on TARIFER (
   IDTRANCHE ASC
);

/*==============================================================*/
/* Index : TARIFER2_FK                                          */
/*==============================================================*/
create index TARIFER2_FK on TARIFER (
   IDTPCOURS ASC
);

/*==============================================================*/
/* Table : TRANCHE                                              */
/*==============================================================*/
create table TRANCHE 
(
   IDTRANCHE            CHAR(1)              not null,
   QUOTIENTMIN          INTEGER,
   constraint PK_TRANCHE primary key (IDTRANCHE)
);

/*==============================================================*/
/* Table : TYPECOURS                                            */
/*==============================================================*/
create table TYPECOURS 
(
   IDTPCOURS            INTEGER              not null,
   LIBTPCOURS           VARCHAR2(30),
   constraint PK_TYPECOURS primary key (IDTPCOURS)
);

/*==============================================================*/
/* Table : TYPEINSTRUMENT                                       */
/*==============================================================*/
create table TYPEINSTRUMENT 
(
   IDTPINST             INTEGER              not null,
   IDCAT                INTEGER              not null,
   LIBTPINST            VARCHAR2(30),
   constraint PK_TYPEINSTRUMENT primary key (IDTPINST)
);

/*==============================================================*/
/* Index : REGROUPER_FK                                         */
/*==============================================================*/
create index REGROUPER_FK on TYPEINSTRUMENT (
   IDCAT ASC
);

alter table COURS
   add constraint FK_COURS_ANIMER_PROFESSE foreign key (IDPROF)
      references PROFESSEUR (IDPROF);

alter table COURS
   add constraint FK_COURS_APPARTENI_TYPECOUR foreign key (IDTPCOURS)
      references TYPECOURS (IDTPCOURS);

alter table COURS
   add constraint FK_COURS_DEDIER_A_TYPEINST foreign key (IDTPINST)
      references TYPEINSTRUMENT (IDTPINST);

alter table INSTRUMENT
   add constraint FK_INSTRUME_CORRESPON_TYPEINST foreign key (IDTPINST)
      references TYPEINSTRUMENT (IDTPINST);

alter table PRATIQUER
   add constraint FK_PRATIQUE_PRATIQUER_TYPEINST foreign key (IDTPINST)
      references TYPEINSTRUMENT (IDTPINST);

alter table PRATIQUER
   add constraint FK_PRATIQUE_PRATIQUER_PROFESSE foreign key (IDPROF)
      references PROFESSEUR (IDPROF);

alter table PROFESSEUR
   add constraint FK_PROFESSE_SPECIALIS_TYPEINST foreign key (IDTPINST)
      references TYPEINSTRUMENT (IDTPINST);

alter table TARIFER
   add constraint FK_TARIFER_TARIFER_TRANCHE foreign key (IDTRANCHE)
      references TRANCHE (IDTRANCHE);

alter table TARIFER
   add constraint FK_TARIFER_TARIFER2_TYPECOUR foreign key (IDTPCOURS)
      references TYPECOURS (IDTPCOURS);

alter table TYPEINSTRUMENT
   add constraint FK_TYPEINST_REGROUPER_CATEGORI foreign key (IDCAT)
      references CATEGORIE (IDCAT);

