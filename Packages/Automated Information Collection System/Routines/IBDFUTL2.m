IBDFUTL2 ;ALB/MAF - MAINTENANCE UTILITY CONT. ;4/24/95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**9,63**;APR 24, 1997;Build 80
 ;
 ;
 ;
ENDV ;  -- Entire divisions were chosen, find all clinics (with encounter forms defined)
 N IBCLN,IBDIV,NODE,DIVISION,ALL
 ;  -- Make a list of the divisions chosen
 S IBDFGNM=0 F IBDFGN=0:0 S IBDFGNM=$O(^TMP("IBDF",$J,"D",IBDFGNM)) Q:IBDFGNM']""  S IBDIV=0 F  S IBDIV=$O(^TMP("IBDF",$J,"D",IBDFGNM,IBDIV)) Q:'IBDIV  S DIVISION(IBDIV,IBDFGNM)=""
 ;
 ;  -- Loop through all the clinics finding ones in selected divisions
  S IBCLN="" F  S IBCLN=$O(^SC(IBCLN)) Q:IBCLN=""  D
 .S NODE=$G(^SC(IBCLN,0))
 .S IBDIV=$P(NODE,"^",15)
 .I IBDIV Q:'$D(DIVISION(IBDIV))
 .;  -- Check that location is a clinic
 .Q:$P(NODE,"^",3)'="C"
 .;  -- It passed all the tests, put it on the list
 .S IBDNAM=0 F IBDFDIV=0:0 S IBDFDIV=$O(DIVISION(IBDFDIV)) Q:'IBDFDIV  I IBDFDIV=IBDIV F IBDNAME=0:0 S IBDNAM=$O(DIVISION(IBDFDIV,IBDNAM)) Q:IBDNAM']""  S ^TMP("IBDF",$J,"C",IBDNAM,$P(^SC(IBCLN,0),"^",1))=IBCLN
 ;
 ;  -- Don't need list of divisions anymore
 K ^TMP("IBDF",$J,"D")
 Q
 ;
 ;
CLINICS ;  -- Clinics that use the form
 N IBDFFLG
 S IBDFFLG=0 F IDX="C","D","E","F","G","H","I","J" D
 .S SETUP="" F  S SETUP=$O(^SD(409.95,IDX,IBDFORM1,SETUP)) Q:'SETUP  D
 ..S CLINIC=$P($G(^SD(409.95,SETUP,0)),"^",1)
 ..Q:'CLINIC
 ..S NAME=$P($G(^SC(CLINIC,0)),"^",1)
 ..Q:NAME=""
 ..I IBDFFLG S IBDCNT=IBDCNT+1,VALMCNT=VALMCNT+1
 ..D:'IBDFFLG TMP1 S:IBDFFLG X="" S X=$$SETSTR^VALM1($E(NAME,1,20),X,66,14) D TMP^IBDFUTL1,CNTRL^VALM10(VALMCNT,37,29,IOINHI,IOINORM,0) S IBDFFLG=1
 Q
 ;
 ;
TMP1 ;  -- Text display set up of TMP array
 S X="",IBDCNT=IBDCNT+1,VALMCNT=VALMCNT+1
 S X=$$SETSTR^VALM1(" ",X,1,80) D TMP^IBDFUTL1
 S X="",X=$$SETSTR^VALM1("CLINICS USING THIS FORM ARE:           ",X,37,29)
 Q
 ;
 ;
HEADER ;  -- Set up header line for the display
 I VALMCNT>0 N IBXFL S IBXFL=$S(VALMCNT+1/14?1.6N:1,VALMCNT+2/14?1.6N:2,VALMCNT+3/14?1.6N:3,VALMCNT+4/14?1.6N:4,1:0) I IBXFL D
 .N IBXFL1
 .F IBXFL1=1:1:IBXFL D
 ..S X="",IBDCNT=IBDCNT+1,VALMCNT=VALMCNT+1 S X=$$SETSTR^VALM1(" ",X,1,3) D TMP^IBDFUTL1
 S IBDCNT1=IBDCNT1+1
 S IBDCNT=IBDCNT+1,VALMCNT=VALMCNT+1
 S X=""
 S IBDF(IBDFNAME)=IBDCNT_"^"_IBDFORM1
 S X=$$SETSTR^VALM1(" ",X,1,3) D TMP^IBDFUTL1
 S X="",IBDCNT=IBDCNT+1,VALMCNT=VALMCNT+1
 S IBDVAL=IBDFNAME
 S IBDVAL1=$L(IBDVAL) S IBDVAL1=(80-IBDVAL1)/2 S IBDVAL1=IBDVAL1\1 S X=$$SETSTR^VALM1(" ",X,1,IBDVAL1)
 S X=$$SETSTR^VALM1(IBDVAL,X,IBDVAL1,25) D TMP^IBDFUTL1,CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM,0)
 S X="",IBDCNT=IBDCNT+1,VALMCNT=VALMCNT+1
 S X=$$SETSTR^VALM1(" ",X,1,3) D TMP^IBDFUTL1
 S IBDCNT1=IBDCNT1-1
 Q
 ;
 ;
JUMP ; -- Jump action to display a specific clinic group on the screen.
 D FULL^VALM1
 I $D(XQORNOD(0)),$P(XQORNOD(0),"^",4)]"" S X=$P(XQORNOD(0),"^",4) S X=$P(X,"=",2) I X]"" D:X?1.6N JSEL S DIC=$S($D(VAUTF):"^IBE(357,",$D(VAUTG):"^IBD(357.99,",1:"^SC("),DIC(0)="QEZ" D ^DIC K DIC G:Y<0 JMP S Y=+Y D JUMP1 Q
JMP S DIC=$S($D(VAUTF):"^IBE(357,",$D(VAUTG):"^IBD(357.99,",1:"^SC("),DIC(0)="AEMN",DIC("A")="Select "_$S($D(VAUTF):"Form",$D(VAUTG):"Clinic Group",1:"Clinic")_" you wish to move to: "
 S:$D(VAUTC) DIC("S")="I $P(^SC(+Y,0),U,3)=""C""" D ^DIC K DIC
 I X["^" S VALMBG=1,VALMBCK="R" Q
 ;
 ;
JUMP1 I Y<0 G JUMP
 N IBDFCAT
 S IBDFCAT=$S($D(VAUTF):$P(^IBE(357,+Y,0),"^",1),$D(VAUTG):$P(^IBD(357.99,+Y,0),"^",1),1:$P(^SC(+Y,0),"^",1))
 I '$D(IBDF(IBDFCAT)) W !!,"There is no data listed for this Clinic Group" G JMP
 S VALMBG=+IBDF(IBDFCAT) S VALMBCK="R" Q
 Q
 ;
 ;
JSEL ; -- Convert number selected to name
 S IBDVALM=X I $D(^TMP("CGIDX",$J,IBDVALM)) S X=$P(^TMP("CGIDX",$J,IBDVALM),"^",2),X=$P(^IBD(357.99,X,0),"^",1)
 Q
 ;
 ;
CHGLST ;  -- Code to change list display
 D FULL^VALM1
 S IBDFDIS1=IBDFDIS,IBDFINT1=IBDFINT,IBDFACT1=IBDFACT
 D EXIT1^IBDFUTL,OUT^IBDFUTL
 Q
 ;
 ;
DELETE ;  -- Delete invalid code from the selection list/block
 N IBDFVALM,VALMY,IBBLK,IBFORM,DA,IBDN,IBDX,IBD9,IBD10
 S VALMBCK=""
 D EN^VALM2($G(XQORNOD(0))) G REP:'$O(VALMY(0)) S IBDFVALM=0
 D FULL^VALM1 S VALMBCK="R"
 F IBDFVALM=0:0 S IBDFVALM=$O(VALMY(IBDFVALM)) Q:IBDFVALM']""  S DA=$P($G(^TMP("CPTIDX",$J,IBDFVALM)),"^",4) I DA]"" S IBFORM=$P($G(^TMP("CPTIDX",$J,IBDFVALM)),"^",5),IBBLK=$P($G(^TMP("CPTIDX",$J,IBDFVALM)),"^",6) D
 .S DIK="^IBE(357.3,",DA=DA D ^DIK K DIK D BLKCHNG^IBDF19(IBFORM,IBBLK)
 K IBDF,^TMP("UTIL",$J)
 S IBDN="",(IBD9,IBD10)=0 F  S IBDN=$O(^IBE(357.2,"C",IBBLK,IBDN)) Q:IBDN=""  S IBDX=$P($G(^IBE(357.2,IBDN,0)),U,11) I IBDX?1.N S IBDX=$E($P($G(^IBE(357.6,IBDX,0)),U,1),1,30) D
 .I IBDX="DG SELECT ICD-9 DIAGNOSIS CODE" S IBD9=1
 .I IBDX="DG SELECT ICD-10 DIAGNOSIS COD" S IBD10=1
 ;Now update history if ICD-9 or ICD-10 was present before or after the change
 N IBDX
 I IBD9 S IBDX=$$CSUPD357^IBDUTICD(IBFORM,1,"",$$NOW^XLFDT(),DUZ)
 I IBD10 S IBDX=$$CSUPD357^IBDUTICD(IBFORM,30,"",$$NOW^XLFDT(),DUZ)
 ;
 ;  -- Redo list
REP K IBDF D INIT^IBDFUTL S VALMBG=1,VALMBCK="R"
 Q
