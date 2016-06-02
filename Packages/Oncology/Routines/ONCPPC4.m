ONCPPC4 ;HIRMFO/GWB - PCE Studies of Prostate Cancer - Table IV;7/22/96
 ;;2.2;ONCOLOGY;**1**;Jul 31, 2013;Build 8
 K TABLE,HTABLE
 S TABLE("SURGERY")="SUR"
 S TABLE("RADIATION THERAPY")="RAD"
 S TABLE("HORMONE THERAPY")="HOR"
 S HTABLE(1)="SURGERY"
 S HTABLE(2)="RADIATON THERAPY"
 S HTABLE(3)="HORMONE THERAPY"
 S CHOICES=3
 W @IOF D HEAD^ONCPPC0 W !?22,"TABLE IV - FIRST COURSE OF TREATMENT",!
 K ONC S DIC="^ONCO(165.5,",DR="50;51;54;58.1;58.2;58.3;58;74"
 S DA=ONCONUM,DIQ="ONC" D EN^DIQ1
 S DIE="^ONCO(165.5,",DA=ONCONUM
SUR W !,"SURGERY:",!
 S NCDS=$E(ONC(165.5,ONCONUM,58.1),1,2),NCDSOT=ONC(165.5,ONCONUM,58.1)
 S CDS=$E(ONC(165.5,ONCONUM,58.2),1,2),CDSOT=ONC(165.5,ONCONUM,58.2)
 I (CDS="")!(CDS="00") D
 .S SURG=NCDSOT,SURGDT=ONC(165.5,ONCONUM,58.3)
 I ((CDS'="")&(CDS'="00"))!(NCDS="") D
 .S SURG=CDSOT,SURGDT=ONC(165.5,ONCONUM,50)
 S (SURG1,SURG2)=""
 S LOS=$L(SURG) I LOS<56 S SURG1=SURG G TOS
 S NOP=$L($E(SURG,1,42)," ")
 S SURG1=$P(SURG," ",1,NOP-1),SURG2=$P(SURG," ",NOP,999)
TOS W !,"  TYPE OF SURGERY................: ",SURG1
 W:SURG2'="" !,?38,SURG2
 I (SURG1="")!($E(SURG1,1,2)="00") S SURGDT="88/88"
 W !,"  DATE OF SURGERY................: ",SURGDT
 W !,"  REASON FOR NO SURGERY..........: ",ONC(165.5,ONCONUM,58)
 W !,"  SURGICAL APPROACH..............: ",ONC(165.5,ONCONUM,74)
 S DR="624  RESEARCH PROTOCOL.............." D ^DIE G:$D(Y) JUMP
RAD W !!,"RADIATION THERAPY:",!
 S DR="625  RADIATION THERAPY.............." D ^DIE G:$D(Y) JUMP
 I (X=2)!(X=3)!(X=4) D  G HOR
 .F PIECE=27:1:42 S $P(^ONCO(166.2,ONCONUM,0),U,PIECE)=""
 W !,"  DATE RADIATION THERAPY BEGAN...: ",ONC(165.5,ONCONUM,51)
 S DR="626  INTERSTITIAL RADIATION........." D ^DIE G:$D(Y) JUMP
 I (X=2)!(X=3)!(X=4) D  G EXTRAD
 .F PIECE=28:1:32 S $P(^ONCO(166.2,ONCONUM,0),U,PIECE)=""
 W !!,"  INTERSTITIAL RADIATION ADMINISTERED:",!
 S DR="627    IODINE 125..................." D ^DIE G:$D(Y) JUMP
 S DR="628    GOLD 198....................." D ^DIE G:$D(Y) JUMP
 S DR="629    PALLADIUM 103................" D ^DIE G:$D(Y) JUMP
 S DR="630    IRIDIUM 192.................." D ^DIE G:$D(Y) JUMP
 S DR="631    OTHER INTERSTITIAL, NOS......" D ^DIE G:$D(Y) JUMP
EXTRAD W ! S DR="632  EXTERNAL RADIATION............." D ^DIE G:$D(Y) JUMP
 I (X=2)!(X=3)!(X=4) D  G HOR
 .F PIECE=34:1:42 S $P(^ONCO(166.2,ONCONUM,0),U,PIECE)=""
 W !!,"  EXTERNAL RADIATION ADMINISTERED:",!
 S DR="633    PROSTATE REGION ONLY........." D ^DIE G:$D(Y) JUMP
 S DR="634    PROSTATE/PELVIC NODES........" D ^DIE G:$D(Y) JUMP
 S DR="635    PARA-AORTIC NODES............" D ^DIE G:$D(Y) JUMP
 S DR="636    DISTANT METASTATIC SITES....." D ^DIE G:$D(Y) JUMP
 S DR="637    OTHER EXTERNAL SITES, NOS...." D ^DIE G:$D(Y) JUMP
 W !!,"  TOTAL RAD DOSE:",!
 S DR="638    PROSTATE....................." D ^DIE G:$D(Y) JUMP
 S DR="639    PELVIC NODES................." D ^DIE G:$D(Y) JUMP
 S DR="640    PARA-AORTIC NODES............" D ^DIE G:$D(Y) JUMP
 W !
 S DR="641  RESEARCH PROTOCOL.............." D ^DIE G:$D(Y) JUMP
HOR W !!,"HORMONE THERAPY:",!
 S DR="642  HORMONE THERAPY................" D ^DIE G:$D(Y) JUMP
 I (X=2)!(X=3)!(X=4) D  G EXIT
 .F PIECE=44:1:49 S $P(^ONCO(166.2,ONCONUM,0),U,PIECE)=""
 W !,"  DATE HORMONE THERAPY BEGAN.....: ",ONC(165.5,ONCONUM,54)
 W !!,"  HORMONES ADMINISTERED:",!
 S DR="643    ESTROGENS...................." D ^DIE G:$D(Y) JUMP
 S DR="644    ANTIANDROGENS................" D ^DIE G:$D(Y) JUMP
 S DR="645    PROGESTATIONAL AGENTS........" D ^DIE G:$D(Y) JUMP
 S DR="646    LUTEINIZING HORMONE-RELEASING" D ^DIE G:$D(Y) JUMP
 S DR="647    ORCHIECTOMY.................." D ^DIE G:$D(Y) JUMP
 S DR="648    OTHER........................" D ^DIE G:$D(Y) JUMP
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
EXIT K CHOICES,PIECE,HTABLE,TABLE
 K CDS,CDSOT,LOS,NCDS,NCDSOT,NOP,SURG,SURG1,SURG2,SURGDT
 K DA,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,XX,Y
 Q
