PRSXP134 ;WCIOFO/RRG - COMP TIME REPORT FOR NNU SETTLEMENT ;2/7/12  11:49
 ;;4.0;PAID;**134**;Sep 21, 1995;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ;
ENTRYPNT ;
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="NNU CT SETTLEMENT REPORT"
 . S ZTRTN="MAIN^PRSXP134"
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 E  D
 . D MAIN^PRSXP134
 D ^%ZISC
 Q
MAIN ;
 K ^XTMP("PRSXP134")
 ;S BPPD=$O(^PRST(458,"B","07-23",BPPD))
 ;S EPPD=$O(^PRST(458,"B","11-23",EPPD))
 ;
 S DFN=0,S8B=""
 F  S DFN=$O(^PRSPC(DFN)) Q:'DFN!(DFN'?1.99N)  D
 . I $P(^PRSPC(DFN,0),"^",17)["061050" S PAYPER="07-22" D
 . . F  S PPI=0 S PAYPER=$O(^PRST(458,"B",PAYPER)) Q:PAYPER=""!(PAYPER]"11-23")  S PPI=$O(^(PAYPER,PPI)) D
 . . . S S8B=$$GET8B^PRSPUT3(PPI,DFN)   ;GETS PROPER 8B STRING
 . . . F I="CE^3","CT^3","CU^3","CO^3" N AMT D
 . . . . S AMT=$$EXTR8BT^PRSPUT3(S8B,I) Q:AMT'>"0.0"
 . . . . S ^XTMP("PRSXP134",DFN,PPI,I)=AMT
 D REPORT
 K BPPD,EPPD,DFN,S8B,PPI,AMT,PAGE,DAT,PRSIEN,CETOT,CUTOT,STOP,I,FLAG,PAYPER,ZTREQ
 Q
 ;
REPORT ; report construct
 N PAGE,DAT S (PRSIEN,CETOT,CUTOT)=0
 S (PAGE,STOP)=0
 D HDR
 I '$D(^XTMP("PRSXP134")) W !,"NO RECORDS SELECTED" Q
 F  S PRSIEN=$O(^XTMP("PRSXP134",PRSIEN)) Q:PRSIEN=""  S PPI=0 D
 . F  S PPI=$O(^XTMP("PRSXP134",PRSIEN,PPI)) Q:PPI=""  S I="" D
 . . F  S I=$O(^XTMP("PRSXP134",PRSIEN,PPI,I)) Q:I=""  D
 . . . S CETOT=$S(I="CE^3":CETOT+(+^(I)),I="CT^3":CETOT+(+^(I)),1:CETOT)
 . . . S CUTOT=$S(I="CU^3":CUTOT+(+^(I)),I="CO^3":CUTOT+(+^(I)),1:CUTOT)
 . . D LINE Q:STOP
 Q
 ;
LINE ;
 Q:STOP
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() D HDR
 I $G(FLAG) S STOP=$$ASK^PRSLIB00()
 W !,$E($P(^PRSPC(PRSIEN,0),"^",1),1,20),?24,$P($G(^PRST(458,PPI,0)),"^",1),?38,CETOT,?58,CUTOT
 S (CETOT,CUTOT)=0
 Q
 ;
HDR ;
 W @IOF
 S PAGE=PAGE+1
 W ?30,"NNU Comp Time Settlement Report",?68,"PAGE ",PAGE
 W !,"NAME",?21,"PAY PERIOD",?35,"COMP TIME EARNED",?55,"COMP TIME USED"
 W !,"======================================================================="
 Q
 ;
