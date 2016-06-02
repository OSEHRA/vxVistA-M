ONCNPC6 ;HIRMFO/GWB - PCE Study of Non-Hodgkin's Lymphoma - Table VII;4/23/97
 ;;2.2;ONCOLOGY;**1**;Jul 31, 2013;Build 8
 K TABLE,HTABLE
 S TABLE("DATE OF LAST CONTACT OR DEATH")="DLC"
 S TABLE("VITAL STATUS")="VS"
 S TABLE("CANCER STATUS")="CS"
 S TABLE("COMPLETED BY")="CB"
 S TABLE("REVIEWED BY CANCER COMMITTEE")="RBCC"
 S HTABLE(1)="DATE OF LAST CONTACT OR DEATH"
 S HTABLE(2)="VITAL STATUS"
 S HTABLE(3)="CANCER STATUS"
 S HTABLE(4)="COMPLETED BY"
 S HTABLE(5)="REVIEWED BY CANCER COMMITTEE"
 S CHOICES=5
 W @IOF D HEAD^ONCNPC0
 W !?23,"TABLE VI - STATUS AT LAST CONTACT"
 W !?23,"---------------------------------"
DLC S DLC="" I $D(^ONCO(160,ONCOPA,"F","B")) S DLC=$O(^ONCO(160,ONCOPA,"F","B",""),-1)
 I DLC'="" S Y=DLC D DATEOT^ONCOPCE S DLC=Y
 W !,"DATE OF LAST CONTACT OR DEATH: ",DLC
VS S DIE="^ONCO(160,",DA=ONCONUM
 S DR="15VITAL STATUS................." D ^DIE G:$D(Y) JUMP
 I X=1 S $P(^ONCO(165.5,ONCONUM,7),U,14)=0
CS S CS="" I $D(^ONCO(165.5,ONCONUM,"TS","AA")) D
 .S CSDAT=$O(^ONCO(165.5,ONCONUM,"TS","AA",""))
 .S CSIEN=$O(^ONCO(165.5,ONCONUM,"TS","AA",CSDAT,""))
 .S CSPNT=$P(^ONCO(165.5,ONCONUM,"TS",CSIEN,0),U,2)
 .S CS=$P(^ONCO(164.42,CSPNT,0),U,1)
 W !,"CANCER STATUS................: ",CS
CB S DIE="^ONCO(165.5,",DA=ONCONUM
 S DR="81COMPLETED BY................." D ^DIE G:$D(Y) JUMP
RBCC S DIE="^ONCO(165.5,",DA=ONCONUM
 S DR="82REVIEWED BY CANCER COMMITTEE." D ^DIE G:$D(Y) JUMP
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
EXIT K CHOICES,HTABLE,TABLE
 K CS,CSDAT,CSIEN,CSPNT,DLC
 K DA,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,XX,Y
 Q
