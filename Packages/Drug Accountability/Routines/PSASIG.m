PSASIG ;BIR/JMB-Transfer Signature Sheet ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97;Build 2
 ;This routine prints transfer signature sheets.
 ;
TEMP ;Entry point for printing immediately after transfer is entered. It is
 ;called by PSATRAN1. All transactions are placed in ^TMP("PSASIG",$J)
 ;while inputing the transaction. The transfer sheets are printed using
 ;this array.
 W ! S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 .S ZTDESC="Drug Acct.-Print Transfer Signature Sheets",ZTRTN="TQUE^PSASIG"
 .S ZTSAVE("^TMP(""PSASIG"",$J,")="" D ^%ZTLOAD
TQUE S PSAOUT=0,PSAFIRST=1,PSASLN="",$P(PSASLN,"-",80)="",PSADLN="",$P(PSADLN,"=",80)=""
 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S PSARPDT=Y
 S PSAFROM=0 F  S PSAFROM=+$O(^TMP("PSASIG",$J,PSAFROM)) Q:'PSAFROM!(PSAOUT)  S PSATO=0 F  S PSATO=+$O(^TMP("PSASIG",$J,PSAFROM,PSATO)) Q:'PSATO!(PSAOUT)  D
 .S PSAPG=0,PSALOC=PSAFROM D SITES^PSAUTL1 S PSAFROMN=$P(^PSD(58.8,PSALOC,0),"^")_PSACOMB
 .S PSALOC=PSATO D SITES^PSAUTL1 S PSATON=$P(^PSD(58.8,PSALOC,0),"^")_PSACOMB
 .D HDR Q:PSAOUT
 .S PSADA=0 F  S PSADA=$O(^TMP("PSASIG",$J,PSAFROM,PSATO,PSADA)) Q:'PSADA!(PSAOUT)  D PRINT S PSAFIRST=0
EXIT I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSAOUT D
 .S PSASS=21-$Y F PSAKK=1:1:PSASS W !
 .S DIR(0)="E",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR W @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 K ^TMP("PSASIG",$J),%,%ZIS,DIR,DTOUT,PSABAL,PSABEG,PSACHK,PSACNT,PSACOMB,PSADA,PSADLN,PSADRG,PSADT,PSAEND,PSAFIRST,PSAFROM,PSAFROMN,PSAKK
 K PSALOC,PSALOCA,PSALOCN,PSANODE,PSAOUT,PSAPG,PSAQTY,PSAREPRT,PSARPDT,PSASAVE,PSASEL,PSASLN,PSASS,PSATO,PSATON,PSATRAN,PSATRDT,PSAWHO,Y,ZTDESC,ZTRTN,ZTSAVE
 Q
 ;
REPRINT ;Entry point for Transfer Signature Sheets. It prompts for the
 ;dispensing pharmacy location, receiving pharmacy location, beginning
 ;date, then ending date.
 S PSAREPRT=1,(PSACNT,PSAOUT)=0,PSATRAN="F"
 D ^PSAUTL3 G:PSAOUT EXIT S PSACNT=0,PSACHK=$O(PSALOC(""))
 I PSACHK="",'PSALOC W !,"There are no active pharmacy locations." G EXIT
 S PSAFROM=+PSALOC,PSAFROMN=PSALOCN D TO^PSATRAN
 ;DSS/SMP - BEGIN MOD
 ;D BDATE^PSAPV - Before
 D BDATE^PSAPV S:'$D(PSABEG) PSABEG=DT S:'$D(PSAEND) PSAEND=DT
 ;DSS/SMP - END MOD
 W ! S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 .S ZTDESC="Drug Acct.-Reprint Transfer Signature Sheets",ZTRTN="RQUE^PSASIG"
 .F PSASAVE="PSABEG","PSAEND","PSAFROM","PSAFROMN","PSATO","PSATON" S:$D(PSASAVE) ZTSAVE(PSASAVE)=""
 .S ZTSAVE("^TMP(""PSASIG"",$J,")="" D ^%ZTLOAD
RQUE S (PSAPG,PSAOUT)=0,PSAREPRT=1,PSASLN="",$P(PSASLN,"-",80)="",PSADLN="",$P(PSADLN,"=",80)="",PSADT=PSABEG
 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S PSARPDT=Y,PSAFIRST=1
 D HDR S PSAFIRST=0
 F  S PSADT=+$O(^PSD(58.81,"AF",PSADT)) Q:'PSADT!($P(PSADT,".")>PSAEND)!(PSAOUT)  S PSADA=0 F  S PSADA=+$O(^PSD(58.81,"AF",PSADT,PSAFROM,24,PSADA)) Q:'PSADA!(PSAOUT)  D
 .S PSANODE=$G(^PSD(58.81,PSADA,0)) I $P(PSANODE,"^",6)<0,$P($G(^PSD(58.81,+$P(PSANODE,"^",17),0)),"^",3)=PSATO D PRINT
 G EXIT
 ;
PRINT ;
 ;DSS/SMP - BEGIN MOD
 N UOU
 S PSANODE=$G(^PSD(58.81,PSADA,0)),PSATRDT=$E($$FMTE^XLFDT($P(PSANODE,"^",4),1),1,18),PSADRG=$P(PSANODE,"^",5),PSAQTY=$P(PSANODE,"^",6)
 I $$VFD D
 .N BAL,FSN S FSN=$P(^PSDRUG(PSADRG,0),U,6)
 .S BAL=$P(PSANODE,"^",6)     ;rac-$P($G(^PSD(58.8,PSALOC,1,PSADRG,0)),U,4) chgd 1/4/15 using incorrect qty.
 .S:BAL<0 BAL=-BAL
 .S PSATRDT=$TR($P($$FMTE^XLFDT($P(PSANODE,"^",4),2),":",1,2),"@"," ")
 .S UOU=$$VFDUOU(BAL,FSN)
 S PSAQTY=$P(PSANODE,"^",6),PSAWHO=$P($G(^VA(200,+$P(PSANODE,"^",7),0)),"^"),PSABAL=+$P(PSANODE,"^",10)
 S:PSAQTY<0 PSAQTY=-PSAQTY D:$Y+7>IOSL HDR Q:PSAOUT
 I $$VFD W !,PSATRDT,?14,$J(PSAQTY,6),$J(UOU,6)
 E  W !,PSATRDT,?20,$J(PSAQTY,6)
 W ?30,$S($P($G(^PSDRUG(PSADRG,0)),"^")'="":$P($G(^PSDRUG(PSADRG,0)),"^"),1:"UNKNOWN"),?73,$S(+PSABAL:$J((PSABAL-PSAQTY),6),1:"UNKNOWN")
 ;DSS/SMP - END MOD
 W !!,?2,"Dispensed by:  "_$S(PSAWHO'="":PSAWHO,1:"_____________________"),?40,"Rec'd by:  ____________________________"
 W !,?20,"(Full Name)",?55,"(Full Name)",!,PSADLN
 Q
 ;
HDR ;Header
 I $E(IOST,1,2)="C-",'PSAFIRST D  I 'Y S PSAOUT=1 Q
 .S PSASS=21-$Y F PSAKK=1:1:PSASS W !
 .S DIR(0)="E" D ^DIR K DIR
 I $E(IOST,1,2)="C-",'PSAPG W @IOF
 W:$E(IOST,1,2)'="C-"&('PSAPG)&('PSAFIRST) @IOF
 W:PSAPG @IOF S PSAPG=PSAPG+1
 W:$G(PSAREPRT) !,?32,"*** REPRINT ***"
 W !,PSARPDT,?20,"DRUG ACCOUNTABILITY/INVENTORY INTERFACE",?72,"Page: ",PSAPG
 W !?18,"DRUG TRANSFER BETWEEN PHARMACIES SIGNATURE SHEET"
 W:$L(PSAFROMN)>76 !!,$P(PSAFROMN,"(IP)",1)_"(IP)",!?17,$P(PSAFROMN,"(IP)",2) W:$L(PSAFROMN)<77 !?((80-$L(PSAFROMN))/2),PSAFROMN
 ;DSS/SMP - BEGIN MOD
 I $$VFD D
 .W !!!,"TRANSFERRED TO: " W:$L(PSATON)>63 $P(PSATON,"(IP)",1)_"(IP)",!?17,$P(PSATON,"(IP)",2) W:$L(PSATON)<74 PSATON W !,PSASLN
 .W !,"TRANSFER DATE",?17,"QTY",?23,"UOU",?30,"DRUG",?68,"NEW BALANCE",!,PSASLN
 E  D
 .W !!!,"TRANSFERRED TO: " W:$L(PSATON)>63 $P(PSATON,"(IP)",1)_"(IP)",!?17,$P(PSATON,"(IP)",2) W:$L(PSATON)<74 PSATON W !,PSASLN
 .W !,"TRANSFER DATE",?23,"QTY",?30,"DRUG",?68,"NEW BALANCE",!,PSASLN
 ;DSS/SMP - END MOD
 Q
 ;
 ;DSS/SMP - BEGIN MOD
VFD() ; vxVistA check and parameter check
 N RET S RET=$G(^%ZOSF("ZVX"))["VX"
 I 'RET Q 0
 Q $$GET1^VFDCXPR(,"ALL~VFD PSA UNIT OF USE~1",1)=1
 ;
VFDUOU(BAL,FSN) ; Unit Of Use
 N RET
 I 'FSN Q "***"
 S RET=BAL/FSN I RET["." S RET=$FN(RET,"",2)
 Q RET
