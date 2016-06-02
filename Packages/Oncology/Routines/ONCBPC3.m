ONCBPC3 ;HIRMFO/GWB - PCE Study of Cancers of the Urinary Bladder Table III;6/19/96
 ;;2.2;ONCOLOGY;**1**;Jul 31, 2013;Build 8
 K TABLE,HTABLE
 S TABLE("STAGING PROCEDURES")="STA"
 S TABLE("PRESENCE OF HYDRONEPHROSIS")="POH"
 S TABLE("TUMOR SIZE (mm)")="TUM"
 S TABLE("PRESENCE OF MULTIPLE TUMORS")="POMT"
 S TABLE("REGIONAL NODES EXAMINED")="RNE"
 S TABLE("REGIONAL NODES POSITIVE")="RNP"
 S TABLE("SITES OF DISTANT METASTASIS")="SODM"
 S TABLE("AJCC CLINICAL STAGE (cTNM)")="ACS"
 S TABLE("AJCC PATHOLOGIC STAGE (pTNM)")="APS"
 S TABLE("STAGED BY")="SB"
 S HTABLE(1)="STAGING PROCEDURES"
 S HTABLE(2)="PRESENCE OF HYDRONEPHROSIS"
 S HTABLE(3)="TUMOR SIZE (mm)"
 S HTABLE(4)="PRESENCE OF MULTIPLE TUMORS"
 S HTABLE(5)="REGIONAL NODES EXAMINED"
 S HTABLE(6)="REGIONAL NODES POSITIVE"
 S HTABLE(7)="SITES OF DISTANT METASTASIS"
 S HTABLE(8)="AJCC CLINICAL STAGE (cTNM)"
 S HTABLE(9)="AJCC PATHOLOGIC STAGE (pTNM)"
 S HTABLE(10)="STAGED BY"
 S CHOICES=10
 W @IOF D HEAD^ONCBPC0
 W !?18,"TABLE III- EXTENT OF DISEASE AND AJCC STAGE",!
STA W !,"STAGING PROCEDURES:",!
 S DIE="^ONCO(165.5,",DA=ONCONUM
 S DR="335  ABDOMINAL ULTRASOUND........." D ^DIE G:$D(Y) JUMP
 S DR="336  BONE IMAGING................." D ^DIE G:$D(Y) JUMP
 S DR="337  CHEST X-RAY.................." D ^DIE G:$D(Y) JUMP
 S DR="338  CT CHEST/LUNG................" D ^DIE G:$D(Y) JUMP
 S DR="339  CT ABDOMEN/PELVIS............" D ^DIE G:$D(Y) JUMP
 S DR="340  CT OTHER....................." D ^DIE G:$D(Y) JUMP
 S DR="341  MRI PELVIS/ABDOMEN..........." D ^DIE G:$D(Y) JUMP
 S DR="342  MRI OTHER...................." D ^DIE G:$D(Y) JUMP
 S DR="343  OTHER........................" D ^DIE G:$D(Y) JUMP
 W !
POH S DR="344PRESENCE OF HYDRONEPHROSIS....." D ^DIE G:$D(Y) JUMP
TUM S DR="29TUMOR SIZE (mm)................" D ^DIE G:$D(Y) JUMP
POMT S DR="345PRESENCE OF MULTIPLE TUMORS...." D ^DIE G:$D(Y) JUMP
RNE S DR="33REGIONAL NODES EXAMINED........" D ^DIE G:$D(Y) JUMP
RNP S DR="32REGIONAL NODES POSITIVE........" D ^DIE G:$D(Y) JUMP
SODM W !!,"SITES OF DISTANT METASTASIS:",!
 S DR="34  SITE OF DISTANT METASTASIS #1" D ^DIE G:$D(Y) JUMP
 I X=0 D  G ACS
 .S $P(^ONCO(165.5,ONCONUM,2),U,15)=0
 .W !,"  SITE OF DISTANT METASTASIS #2: None"
 .S $P(^ONCO(165.5,ONCONUM,2),U,16)=0
 .W !,"  SITE OF DISTANT METASTASIS #3: None"
 S DR="34.1  SITE OF DISTANT METASTASIS #2" D ^DIE G:$D(Y) JUMP
 I X=0 D  G ACS
 .S $P(^ONCO(165.5,ONCONUM,2),U,16)=0
 .W !,"  SITE OF DISTANT METASTASIS #3: None"
 S DR="34.2  SITE OF DISTANT METASTASIS #3" D ^DIE G:$D(Y) JUMP
ACS W !!,"AJCC CLINICAL STAGE (cTNM):",!
 S DR="37.1  T-CODE......................." D ^DIE G:$D(Y) JUMP
 D CN1^ONCOTN,CN2^ONCOTN
 S DR="37.2  N-CODE......................." D ^DIE G:$D(Y) JUMP
 S DR="37.3  M-CODE......................." D ^DIE G:$D(Y) JUMP
 I '$D(SKAJCC) D CN1^ONCOTN
 S STGIND="C" D ES^ONCOTN
 ;W ! S DR="38AJCC STAGE....................." D ^DIE G:$D(Y) JUMP
APS W !,"AJCC PATHOLOGIC STAGE (pTNM):",!
 S DR="85  T-CODE......................." D ^DIE G:$D(Y) JUMP
 D CN3^ONCOTN,CN4^ONCOTN
 S DR="86  N-CODE......................." D ^DIE G:$D(Y) JUMP
 S DR="87  M-CODE......................." D ^DIE G:$D(Y) JUMP
 I '$D(SKAJCC) D CN3^ONCOTN
 S STGIND="P" D ES^ONCOTN
 ;W ! S DR="88AJCC STAGE....................." D ^DIE G:$D(Y) JUMP
SB W !,"STAGED BY:",!
 S DR="19  CLINICAL STAGE...................." D ^DIE G:$D(Y) JUMP
 S DR="89  PATHOLOGIC STAGE.................." D ^DIE G:$D(Y) JUMP
 W ! K DIR S DIR(0)="E" D ^DIR
 G EXIT
JUMP ;Jump to prompts
 S XX="" R !!,"GO TO: ",X:DTIME I (X="")!(X[U) S OUT="Y" G EXIT
 I X["?" D  G JUMP
 .W !,"CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 I '$D(TABLE(X)) S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !,"CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 S X=TABLE(X)
 G @X
EXIT K HTABLE,TABLE,CHOICES
 K DA,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,XX,Y
 Q
