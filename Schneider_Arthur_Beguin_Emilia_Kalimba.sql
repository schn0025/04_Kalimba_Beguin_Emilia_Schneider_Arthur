/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  21/11/2022 17:11:38                      */
/*==============================================================*/


alter table Cours
   drop constraint FK_COURS_AVOIR_TYPE_COU;

alter table Cours
   drop constraint FK_COURS_ENSEIGNER_PROF;

alter table Cours
   drop constraint FK_COURS_NECESSITE_TYPE_INS;

alter table Couter
   drop constraint FK_COUTER_COUTER_TRANCHE;

alter table Couter
   drop constraint FK_COUTER_COUTER2_TYPE_COU;

alter table Pratiquer
   drop constraint FK_PRATIQUE_PRATIQUER_PROF;

alter table Pratiquer
   drop constraint FK_PRATIQUE_PRATIQUER_TYPE_INS;

alter table Prof
   drop constraint FK_PROF_SPECIALIS_TYPE_INS;

alter table Type_Instrument
   drop constraint FK_TYPE_INS_CLASSER_CATEGORI;

alter table appartenir
   drop constraint FK_APPARTEN_APPARTENI_TYPE_INS;

alter table appartenir
   drop constraint FK_APPARTEN_APPARTENI_INSTRUME;

drop index ENSEIGNER_FK;

drop index AVOIR_FK;

drop index NECESSITER_FK;

drop table Cours cascade constraints;

drop index COUTER2_FK;

drop index COUTER_FK;

drop table Couter cascade constraints;

drop table Instrument cascade constraints;

drop index PRATIQUER2_FK;

drop index PRATIQUER_FK;

drop table Pratiquer cascade constraints;

drop index SPECIALISER_FK;

drop table Prof cascade constraints;

drop table Tranche cascade constraints;

drop index CLASSER_FK;

drop table Type_Instrument cascade constraints;

drop table Type_cours cascade constraints;

drop index APPARTENIR2_FK;

drop index APPARTENIR_FK;

drop table appartenir cascade constraints;

drop table categorie cascade constraints;

/*==============================================================*/
/* Table : Cours                                                */
/*==============================================================*/
create table Cours 
(
   Idcours              INTEGER              not null,
   idTpCours            INTEGER              not null,
   idTpInst             INTEGER,
   Id_prof              INTEGER              not null,
   ageMax               INTEGER             
      constraint CKC_AGEMAX_COURS check (ageMax is null or (ageMax >= ageMin)),
   ageMin               INTEGER             
      constraint CKC_AGEMIN_COURS check (ageMin is null or (ageMin <= ageMax)),
   libCours             VARCHAR2(30),
   nbPlaces             INTEGER,
   constraint PK_COURS primary key (Idcours)
);

/*==============================================================*/
/* Index : NECESSITER_FK                                        */
/*==============================================================*/
create index NECESSITER_FK on Cours (
   idTpInst ASC
);

/*==============================================================*/
/* Index : AVOIR_FK                                             */
/*==============================================================*/
create index AVOIR_FK on Cours (
   idTpCours ASC
);

/*==============================================================*/
/* Index : ENSEIGNER_FK                                         */
/*==============================================================*/
create index ENSEIGNER_FK on Cours (
   Id_prof ASC
);

/*==============================================================*/
/* Table : Couter                                               */
/*==============================================================*/
create table Couter 
(
   idTranche            VARCHAR2(1)          not null
      constraint CKC_IDTRANCHE_COUTER check (idTranche in ('A','B','C','D','E','F','H')),
   idTpCours            INTEGER              not null,
   montant              FLOAT,
   constraint PK_COUTER primary key (idTranche, idTpCours)
);

/*==============================================================*/
/* Index : COUTER_FK                                            */
/*==============================================================*/
create index COUTER_FK on Couter (
   idTranche ASC
);

/*==============================================================*/
/* Index : COUTER2_FK                                           */
/*==============================================================*/
create index COUTER2_FK on Couter (
   idTpCours ASC
);

/*==============================================================*/
/* Table : Instrument                                           */
/*==============================================================*/
create table Instrument 
(
   idInst               INTEGER              not null,
   couleur              VARCHAR2(30),
   dateAchat            DATE,
   prixAchat            FLOAT,
   Marque               VARCHAR2(30),
   Modele               VARCHAR2(30),
   constraint PK_INSTRUMENT primary key (idInst)
);

/*==============================================================*/
/* Table : Pratiquer                                            */
/*==============================================================*/
create table Pratiquer 
(
   Id_prof              INTEGER              not null,
   idTpInst             INTEGER              not null,
   constraint PK_PRATIQUER primary key (Id_prof, idTpInst)
);

/*==============================================================*/
/* Index : PRATIQUER_FK                                         */
/*==============================================================*/
create index PRATIQUER_FK on Pratiquer (
   Id_prof ASC
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
   Id_prof              INTEGER              not null,
   idTpInst             INTEGER,
   nomprof              VARCHAR2(30),
   pnomprof             VARCHAR2(30),
   datenaisprof         DATE,
   telProf              VARCHAR2(10)         not null,
   mailprof             VARCHAR2(30),
   dateEmbauche         DATE,
   dateDep              DATE,
   statut               INTEGER              not null
      constraint CKC_STATUT_PROF check (statut between 1 and 3 and statut in (2,3,1)),
   constraint PK_PROF primary key (Id_prof)
);

/*==============================================================*/
/* Index : SPECIALISER_FK                                       */
/*==============================================================*/
create index SPECIALISER_FK on Prof (
   idTpInst ASC
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
   idCatg               INTEGER              not null,
   libTpInst            VARCHAR2(30),
   constraint PK_TYPE_INSTRUMENT primary key (idTpInst)
);

/*==============================================================*/
/* Index : CLASSER_FK                                           */
/*==============================================================*/
create index CLASSER_FK on Type_Instrument (
   idCatg ASC
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
/* Table : appartenir                                           */
/*==============================================================*/
create table appartenir 
(
   idTpInst             INTEGER              not null,
   idInst               INTEGER              not null,
   constraint PK_APPARTENIR primary key (idTpInst, idInst)
);

comment on table appartenir is
'
';

/*==============================================================*/
/* Index : APPARTENIR_FK                                        */
/*==============================================================*/
create index APPARTENIR_FK on appartenir (
   idTpInst ASC
);

/*==============================================================*/
/* Index : APPARTENIR2_FK                                       */
/*==============================================================*/
create index APPARTENIR2_FK on appartenir (
   idInst ASC
);

/*==============================================================*/
/* Table : categorie                                            */
/*==============================================================*/
create table categorie 
(
   idCatg               INTEGER              not null,
   libCatg              VARCHAR2(30),
   constraint PK_CATEGORIE primary key (idCatg)
);

alter table Cours
   add constraint FK_COURS_AVOIR_TYPE_COU foreign key (idTpCours)
      references Type_cours (idTpCours);

alter table Cours
   add constraint FK_COURS_ENSEIGNER_PROF foreign key (Id_prof)
      references Prof (Id_prof);

alter table Cours
   add constraint FK_COURS_NECESSITE_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table Couter
   add constraint FK_COUTER_COUTER_TRANCHE foreign key (idTranche)
      references Tranche (idTranche);

alter table Couter
   add constraint FK_COUTER_COUTER2_TYPE_COU foreign key (idTpCours)
      references Type_cours (idTpCours);

alter table Pratiquer
   add constraint FK_PRATIQUE_PRATIQUER_PROF foreign key (Id_prof)
      references Prof (Id_prof);

alter table Pratiquer
   add constraint FK_PRATIQUE_PRATIQUER_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table Prof
   add constraint FK_PROF_SPECIALIS_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table Type_Instrument
   add constraint FK_TYPE_INS_CLASSER_CATEGORI foreign key (idCatg)
      references categorie (idCatg);

alter table appartenir
   add constraint FK_APPARTEN_APPARTENI_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table appartenir
   add constraint FK_APPARTEN_APPARTENI_INSTRUME foreign key (idInst)
      references Instrument (idInst);

