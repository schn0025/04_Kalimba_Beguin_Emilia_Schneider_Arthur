/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  22/11/2022 16:25:21                      */
/*==============================================================*/


alter table Cours
   drop constraint FK_COURS_ANIMER_PROF;

alter table Cours
   drop constraint FK_COURS_APPARTENI_TYPE_COU;

alter table Cours
   drop constraint FK_COURS_DEDIER_A_TYPE_INS;

alter table Instrument
   drop constraint FK_INSTRUME_CORRESPON_TYPE_INS;

alter table Pratiquer
   drop constraint FK_PRATIQUE_PRATIQUER_PROF;

alter table Pratiquer
   drop constraint FK_PRATIQUE_PRATIQUER_TYPE_INS;

alter table Prof
   drop constraint FK_PROF_SPECIALIS_TYPE_INS;

alter table Tarifer
   drop constraint FK_TARIFER_TARIFER_TRANCHE;

alter table Tarifer
   drop constraint FK_TARIFER_TARIFER2_TYPE_COU;

alter table Type_Instrument
   drop constraint FK_TYPE_INS_REGROUPER_CATEGORI;

drop index ANIMER_FK;

drop index APPARTENIR_FK;

drop index DEDIER_A_FK;

drop table Cours cascade constraints;

drop index CORRESPONDRE_FK;

drop table Instrument cascade constraints;

drop index PRATIQUER2_FK;

drop index PRATIQUER_FK;

drop table Pratiquer cascade constraints;

drop index SPECIALISER_FK;

drop table Prof cascade constraints;

drop index TARIFER2_FK;

drop index TARIFER_FK;

drop table Tarifer cascade constraints;

drop table Tranche cascade constraints;

drop index REGROUPER_FK;

drop table Type_Instrument cascade constraints;

drop table Type_cours cascade constraints;

drop table categorie cascade constraints;

/*==============================================================*/
/* Table : Cours                                                */
/*==============================================================*/
create table Cours 
(
   Idcours              INTEGER              not null,
   idTpCours            INTEGER              not null,
   idTpInst             INTEGER,
   IdProf               INTEGER              not null,
   libCours             VARCHAR2(30),
   ageMini              INTEGER,
   ageMaxi              INTEGER,
   nbPlaces             INTEGER,
   constraint PK_COURS primary key (Idcours)
);

/*==============================================================*/
/* Index : DEDIER_A_FK                                          */
/*==============================================================*/
create index DEDIER_A_FK on Cours (
   idTpInst ASC
);

/*==============================================================*/
/* Index : APPARTENIR_FK                                        */
/*==============================================================*/
create index APPARTENIR_FK on Cours (
   idTpCours ASC
);

/*==============================================================*/
/* Index : ANIMER_FK                                            */
/*==============================================================*/
create index ANIMER_FK on Cours (
   IdProf ASC
);

/*==============================================================*/
/* Table : Instrument                                           */
/*==============================================================*/
create table Instrument 
(
   idInst               INTEGER              not null,
   idTpInst             INTEGER              not null,
   dateAchat            DATE,
   prixAchat            NUMBER(8,2),
   couleur              VARCHAR2(30),
   Marque               VARCHAR2(30),
   Modele               VARCHAR2(30),
   constraint PK_INSTRUMENT primary key (idInst)
);

/*==============================================================*/
/* Index : CORRESPONDRE_FK                                      */
/*==============================================================*/
create index CORRESPONDRE_FK on Instrument (
   idTpInst ASC
);

/*==============================================================*/
/* Table : Pratiquer                                            */
/*==============================================================*/
create table Pratiquer 
(
   IdProf               INTEGER              not null,
   idTpInst             INTEGER              not null,
   constraint PK_PRATIQUER primary key (IdProf, idTpInst)
);

/*==============================================================*/
/* Index : PRATIQUER_FK                                         */
/*==============================================================*/
create index PRATIQUER_FK on Pratiquer (
   IdProf ASC
);

/*==============================================================*/
/* Index : PRATIQUER2_FK                                        */
/*==============================================================*/
create index PRATIQUER2_FK on Pratiquer (
   idTpInst ASC
);

/*==============================================================*/
/* Table : Prof                                                 */
/*==============================================================*/
create table Prof 
(
   IdProf               INTEGER              not null,
   idTpInst             INTEGER,
   nomProf              VARCHAR2(30)         not null,
   pnomProf             VARCHAR2(30)         not null,
   dateNais             DATE                 not null,
   dateEmb              DATE,
   dateDpt              DATE,
   statut               INTEGER             
      constraint CKC_STATUT_PROF check (statut is null or (statut between 1 and 3 and statut in (2,3,1))),
   emailProf            VARCHAR2(30),
   telProf              CHAR(10),
   constraint PK_PROF primary key (IdProf)
);

/*==============================================================*/
/* Index : SPECIALISER_FK                                       */
/*==============================================================*/
create index SPECIALISER_FK on Prof (
   idTpInst ASC
);

/*==============================================================*/
/* Table : Tarifer                                              */
/*==============================================================*/
create table Tarifer 
(
   idTranche            VARCHAR2(1)          not null
      constraint CKC_IDTRANCHE_TARIFER check (idTranche in ('A','B','C','D','E','F','H')),
   idTpCours            INTEGER              not null,
   montant              FLOAT,
   constraint PK_TARIFER primary key (idTranche, idTpCours)
);

/*==============================================================*/
/* Index : TARIFER_FK                                           */
/*==============================================================*/
create index TARIFER_FK on Tarifer (
   idTranche ASC
);

/*==============================================================*/
/* Index : TARIFER2_FK                                          */
/*==============================================================*/
create index TARIFER2_FK on Tarifer (
   idTpCours ASC
);

/*==============================================================*/
/* Table : Tranche                                              */
/*==============================================================*/
create table Tranche 
(
   idTranche            VARCHAR2(1)          not null
      constraint CKC_IDTRANCHE_TRANCHE check (idTranche in ('A','B','C','D','E','F','H')),
   quotientMin          INTEGER,
   constraint PK_TRANCHE primary key (idTranche)
);

/*==============================================================*/
/* Table : Type_Instrument                                      */
/*==============================================================*/
create table Type_Instrument 
(
   idTpInst             INTEGER              not null,
   idCat                INTEGER              not null,
   libTpInst            VARCHAR2(30),
   constraint PK_TYPE_INSTRUMENT primary key (idTpInst)
);

/*==============================================================*/
/* Index : REGROUPER_FK                                         */
/*==============================================================*/
create index REGROUPER_FK on Type_Instrument (
   idCat ASC
);

/*==============================================================*/
/* Table : Type_cours                                           */
/*==============================================================*/
create table Type_cours 
(
   idTpCours            INTEGER              not null,
   libTpCours           VARCHAR2(30)        
      constraint CKC_LIBTPCOURS_TYPE_COU check (libTpCours is null or (libTpCours in ('individuel','colectif'))),
   constraint PK_TYPE_COURS primary key (idTpCours)
);

/*==============================================================*/
/* Table : categorie                                            */
/*==============================================================*/
create table categorie 
(
   idCat                INTEGER              not null,
   libCat               VARCHAR2(30),
   constraint PK_CATEGORIE primary key (idCat)
);

alter table Cours
   add constraint FK_COURS_ANIMER_PROF foreign key (IdProf)
      references Prof (IdProf);

alter table Cours
   add constraint FK_COURS_APPARTENI_TYPE_COU foreign key (idTpCours)
      references Type_cours (idTpCours);

alter table Cours
   add constraint FK_COURS_DEDIER_A_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table Instrument
   add constraint FK_INSTRUME_CORRESPON_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table Pratiquer
   add constraint FK_PRATIQUE_PRATIQUER_PROF foreign key (IdProf)
      references Prof (IdProf);

alter table Pratiquer
   add constraint FK_PRATIQUE_PRATIQUER_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table Prof
   add constraint FK_PROF_SPECIALIS_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table Tarifer
   add constraint FK_TARIFER_TARIFER_TRANCHE foreign key (idTranche)
      references Tranche (idTranche);

alter table Tarifer
   add constraint FK_TARIFER_TARIFER2_TYPE_COU foreign key (idTpCours)
      references Type_cours (idTpCours);

alter table Type_Instrument
   add constraint FK_TYPE_INS_REGROUPER_CATEGORI foreign key (idCat)
      references categorie (idCat);

