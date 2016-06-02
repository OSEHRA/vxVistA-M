PXBGCPT ;ISL/JVS - GATHER CPT ;8/10/04 1:21pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**73,149,124**;Aug 12, 1996;Build 3
 ;
CPT(VISIT) ;--Gather the entries in the V CPT file
 ;
 N IEN,QUANTITY,PROVIDER,NARR,CPT,GROUP,PXBC
 N DIC,DR,DA,DIQ
 N PXSFIL,PXSIEN,PXMOD
 ;
 K ^TMP("PXBU",$J),VAUGHN,CPT,PXBKY,PXBSAM,PXBSKY,PXBPRV
 I $D(^AUPNVCPT("AD",VISIT)) D
 .S IEN=0
 .F  S IEN=$O(^AUPNVCPT("AD",VISIT,IEN)) Q:IEN'>0  D
 ..S ^TMP("PXBU",$J,"CPT",IEN)=""
 ;
A ;--Set array with CPT codes and associated modifiers
 ;
 I $D(^TMP("PXBU",$J,"CPT")) D
 .S IEN=0
 .F  S IEN=$O(^TMP("PXBU",$J,"CPT",IEN)) Q:IEN'>0  D
 ..N VAUGHN,PX124,EDATA
 ..S PX124=".01;.16;1204;.04;1*;1202;.05;.09:.15"
 ..D GETS^DIQ(9000010.18,IEN,PX124,"E","VAUGHN")
 ..;DSS/RJS - BEGIN MODS ADDED 21600.01 
 .. I $G(^%ZOSF("ZVX"))["VX" S PX124="21600.01" D GETS^DIQ(9000010.18,IEN,PX124,"E","VAUGHN")
 ..;DSS/RJS - END MODS
 ..S CPT=$G(VAUGHN(9000010.18,IEN_",",".01","E"))
 ..S QUANTITY=$G(VAUGHN(9000010.18,IEN_",",".16","E"))
 ..S PROVIDER=$G(VAUGHN(9000010.18,IEN_",","1204","E"))
 ..S NARR=$E($G(VAUGHN(9000010.18,IEN_",",".04","E")),1,29)
 ..I NARR="" S NARR=$P($$CPT^ICPTCOD(CPT,$G(IDATE)),U,3)
 ..S EDATA=$E($G(VAUGHN(9000010.18,IEN_",",1202,"E")),1,29)
 ..D CASE^PXBUTL
 ..S GROUP=CPT_"^"_QUANTITY_"^"_PROVIDER_"^"_NARR
 ..F PX124=.05,.09,.1,.11,.12,.13,.14,.15 D
 ...S DA=$G(VAUGHN(9000010.18,IEN_",",PX124,"E")),DR=DA,GROUP=GROUP_U_DA
 ...;DSS/RJS - BEGIN MODS ADDED 21600.01 
 ... I $G(^%ZOSF("ZVX"))["VX" S PX124=21600.01,DA=$G(VAUGHN(9000010.18,IEN_",",PX124,"E")),DR=DA,GROUP=GROUP_U_DA
 ...;DSS/RJS - END MODS
 ...I DA S DR=$$XLATE^PXBGPOV(VISIT,DA),DA=$P(DR,U,2)
 ...I DR S PXBREQ(DA,"I")=$P(DR,U,4,20)
 ..K DR,DA
 ..S $P(GROUP,U,22)=EDATA,CPT(CPT,IEN)=GROUP
 ..S PXSFIL=9000010.181,PXSIEN=""
 ..F  S PXSIEN=$O(VAUGHN(PXSFIL,PXSIEN)) Q:PXSIEN=""  D
 ...S PXMOD=VAUGHN(PXSFIL,PXSIEN,.01,"E")
 ...S CPT(CPT,IEN,"MOD",+PXSIEN)=PXMOD
 ;
B ;--Add line numbers
 ;
 I $D(CPT) D
 .S PXBC=0,CPT=""
 .F  S CPT=$O(CPT(CPT)) Q:CPT=""  D
 ..S IEN=0
 ..F  S IEN=$O(CPT(CPT,IEN)) Q:IEN=""  S PXBC=PXBC+1 D
 ...S PXBKY(CPT,PXBC)=$G(CPT(CPT,IEN))
 ...S PXBSAM(PXBC)=$G(CPT(CPT,IEN))
 ...S PXBSKY(PXBC,IEN)=""
 ...S PXSIEN=0
 ...F  S PXSIEN=$O(CPT(CPT,IEN,"MOD",PXSIEN)) Q:PXSIEN=""  D
 ....S PXBKY(CPT,PXBC,"MOD",PXSIEN)=CPT(CPT,IEN,"MOD",PXSIEN)
 ....S PXBSAM(PXBC,"MOD",PXSIEN)=CPT(CPT,IEN,"MOD",PXSIEN)
 ...I $P($G(CPT(CPT,IEN)),"^",3)]"" D
 ....S PXBPRV($P($G(CPT(CPT,IEN)),"^",3),$P($G(CPT(CPT,IEN)),"^",1),IEN,PXBC)=QUANTITY
EXIT ;--KILL
 K ^TMP("PXBU",$J),VAUGHN
 S PXBCNT=+$G(PXBC)
 Q
 ;
