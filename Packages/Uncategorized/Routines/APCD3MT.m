APCD3MT ;IHS/CIM/EDE - PCC TO 3M CODER TEST [ 01/16/01  1:43 PM ]
 ;;2.0;IHS RPMS/PCC Data Entry;**4**;MAR 09, 1999
 ;;2.0
 ;
 ; This routine asks the user for a visit and tests the PCC
 ; to 3M Interface using the specified visit for patient data.
 ;
 ;
START ;
 D PROCESS
 D EOJ
 Q
 ;
PROCESS ;
 D INIT
 Q:APCD3Q
 D CALL3M
 Q
 ;
INIT ; INITIALIZATION
 S APCD3Q=1
 D GETPAT ;                               get patient
 Q:'APCDPAT
 D GETVISIT ;                             get visit
 Q:'APCDVSIT
 S APCD3Q=0
 Q
 ;
GETPAT ; GET PATIENT FOR TEST DATA
 S APCDPAT=0
 S DIC="^AUPNPAT(",DIC(0)="AEMQ"
 D ^DIC
 Q:Y<0
 S APCDPAT=+Y
 Q
 ;
GETVISIT ; GET VISIT FOR TEST DATA
 NEW APCD3V,X,Y
 S APCDVSIT=0
 S APCD3V=""
 F  Q:$D(DIRUT)  S APCD3V=$O(^AUPNVSIT("AC",APCDPAT,APCD3V),-1) Q:'APCD3V  D  Q:APCDVSIT
 .  S X=$G(^AUPNVSIT(APCD3V,0))
 .  Q:X=""
 .  W !!,APCD3V,"  ",$P(X,U)_"  "_$P(X,U,9)
 .  D ASK
 .  Q:Y'=1
 .  S APCDVSIT=APCD3V
 .  Q
 Q:'APCDVSIT
 S APCDDATE=+^AUPNVSIT(APCDVSIT,0),APCDTYPE=$P(^AUPNVSIT(APCDVSIT,0),U,3),APCDCAT=$P(^(0),U,7),APCDLOC=$P(^(0),U,6),APCDCLN=$P(^(0),U,8)
 Q
 ;
ASK ; ASK USER YES OR NO
 NEW X
 S DIR(0)="YO",DIR("A")="Do you want this visit (Y/N)",DIR("B")="NO" KILL DA D ^DIR KILL DIR
 Q
 ;
CALL3M ; CALL 3M INTERFACE WITH VISIT DATA
 D EN^APCD3ME
 S X=$G(APCD3MIP)
 D EN^XBVK("APCD")
 S APCD3MIP=$G(X)
 Q
 ;
EOJ ;
 K APCD3Q
 D ^XBFMK
 D EN^XBVK("%")
 D EN^XBVK("APCD")
 Q
 ;
RESET ; RESET FILE 4001 AND KILL ^INLHDEST
 NEW EDEY
 F EDEY=0:0 S EDEY=$O(^INTHU(EDEY)) Q:'EDEY  D
 .  S DIK="^INTHU(",DA=EDEY
 .  D ^DIK
 .  Q
 K ^INTHU("MESSID")
 K ^INLHDEST
 Q
 ;
SERVER ; CALLED BY 101 APCD3MT225 SERVER
 S ^EDE("SERVER",$H)=""
 Q
 ;
CLIENT ; CALLED BY 101 APCD3MT225 CLIENT
 S ^EDE("CLIENT",$H)=""
 Q