ECXLARPT ;ALB/DHH-LAR Results LOINC CODE Report ;10/22/13  17:36
 ;;3.0;DSS EXTRACTS;**112,120,144,148**;Dec 22, 1997;Build 3
 ;
EN ; entry point
 N X,Y,DATE,ECRUN,ECXDESC,ECXSAVE,ECXTL,ECTHLD,CNT,ECXPORT ;144
 N ECSD,ECSD1,ECSTART,ECED,ECEND,ECXERR,QFLG,ECXFLAG
 ; get today's date
 D NOW^%DTC S DATE=X,Y=$E(%,1,12) D DD^%DT S ECRUN=$P(Y,"@") K %DT
 S ECXDESC="LAB Results LOINC CODE Report"
 S ECXSAVE("EC*")=""
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I ECXPORT D  Q  ;144
 .K ^TMP($J,"ECXPORT") ;144
 .S ^TMP($J,"ECXPORT",0)="LAR TEST# (#727.29)^LAR TEST NAME (#727.29)^LAR UNITS (#727.29)^LAR LOINC (#727.29)^FLAG^LOCAL TEST NAME (#64)^LOC SPEC TYPE (#64)^LOC WKLD IEN (#64)^LOC WKLD CODE (#64)" ;144
 .S CNT=1 ;144
 .D PROCESS ;144
 .D EXPDISP^ECXUTL1 ;144
 .D ^ECXKILL ;144
 W !!,"This report requires 132-column format."
 D EN^XUTMDEVQ("PROCESS^ECXLARPT",ECXDESC,.ECXSAVE)
 I POP W !!,"No device selected...exiting.",! Q
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
 ;
PROCESS ; entry point for queued report
 S ZTREQ="@" N ECXDIV
 D DEFAULT^ECXDVSN(.ECXDIV,1,.ECXERR)
 Q:ECXERR=1
 N TNUM,DSSNM,TSTNM,SPECNM,RU,ECXLNC,LLNC,I,J,K,L,M,N,WKLD,WKLDCD,SPEC,TA,LTEST,A
 S A("ALL")=""
 D LOINC^ECXUTL6(.A)
 K ^TMP($J,"ECXLARPT")
 S ECXLNC="" F I=0:0 S ECXLNC=$O(^TMP($J,"ECXUTL6",ECXLNC)) Q:ECXLNC']""  D
 . S RU=$P(^TMP($J,"ECXUTL6",ECXLNC),U,4) S:$G(RU)="" RU="UNKNOWN"
 . S TNUM=$P(^TMP($J,"ECXUTL6",ECXLNC),U,2)
 . S DSSNM=$P(^TMP($J,"ECXUTL6",ECXLNC),U,3)
 . I '$O(^TMP($J,"ECXUTL6",ECXLNC,0)) D
 .. S ^TMP($J,"ECXLARPT",TNUM,DSSNM,"ZZZZ","ZZZZ",RU,ECXLNC)=""
 . S WKLD="" F J=0:0 S WKLD=$O(^TMP($J,"ECXUTL6",ECXLNC,WKLD)) Q:WKLD']""  D
 .. S SPEC="" F K=0:0 S SPEC=$O(^TMP($J,"ECXUTL6",ECXLNC,WKLD,SPEC)) Q:SPEC']""  D
 ... S LTEST="" F M=0:0 S LTEST=$O(^TMP($J,"ECXUTL6",ECXLNC,WKLD,SPEC,LTEST)) Q:LTEST']""  D
 .... S SPECNM=$P(^TMP($J,"ECXUTL6",ECXLNC,WKLD,SPEC,LTEST),U,2)
 .... I SPECNM="DEFAULT LOINC" Q  ;ECXUTL6 default loinc not functionally correct
 .... ;I SPECNM="DEFAULT LOINC" S SPECNM="ZZDEFAULT LOINC"
 .... S TSTNM=$P(^TMP($J,"ECXUTL6",ECXLNC,WKLD,SPEC,LTEST),U,3) S:$G(TSTNM)="" TSTNM="UNKNOWN"
 .... S WKLDCD=$S($D(^LAM(WKLD,0)):$P(^(0),"^",2),1:"")
 .... S LLNC=$P(^TMP($J,"ECXUTL6",ECXLNC,WKLD,SPEC,LTEST),U,4)
 .... S ^TMP($J,"ECXLARPT",TNUM,DSSNM,TSTNM,SPECNM,RU,ECXLNC)=WKLD_"^"_WKLDCD_"^"_LLNC
 D PRINT
 Q
 ;
PRINT ; process temp file and print report
 N PG,QFLG,GTOT,LN,COUNT,VOL,SUB,REC,WKLD1
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (PG,QFLG,GTOT,COUNT)=0,$P(LN,"-",132)=""
 I '$G(ECXPORT) D HEADER Q:QFLG  ;144
 S COUNT=COUNT+1
 S TNUM=0 F I=0:0 S TNUM=$O(^TMP($J,"ECXLARPT",TNUM)) Q:'TNUM  D  Q:QFLG
 . S DSSNM="" F J=0:0 S DSSNM=$O(^TMP($J,"ECXLARPT",TNUM,DSSNM)) Q:DSSNM']""  D  Q:QFLG
 .. S TSTNM="" F K=0:0 S TSTNM=$O(^TMP($J,"ECXLARPT",TNUM,DSSNM,TSTNM)) Q:TSTNM']""  D  Q:QFLG
 ... S SPECNM="" F L=0:0 S SPECNM=$O(^TMP($J,"ECXLARPT",TNUM,DSSNM,TSTNM,SPECNM)) Q:SPECNM']""  D  Q:QFLG
 .... S RU="" F M=0:0 S RU=$O(^TMP($J,"ECXLARPT",TNUM,DSSNM,TSTNM,SPECNM,RU)) Q:RU']""  D  Q:QFLG
 ..... S ECXLNC="" F N=0:0 S ECXLNC=$O(^TMP($J,"ECXLARPT",TNUM,DSSNM,TSTNM,SPECNM,RU,ECXLNC)) Q:ECXLNC']""  D  Q:QFLG
 ...... S WKLD1=$P(^TMP($J,"ECXLARPT",TNUM,DSSNM,TSTNM,SPECNM,RU,ECXLNC),"^")
 ...... S WKLDCD=$P(^TMP($J,"ECXLARPT",TNUM,DSSNM,TSTNM,SPECNM,RU,ECXLNC),"^",2)
 ...... S LLNC=$P(^TMP($J,"ECXLARPT",TNUM,DSSNM,TSTNM,SPECNM,RU,ECXLNC),"^",3)
 ...... I $G(ECXPORT) D  Q  ;144
 ....... S ^TMP($J,"ECXPORT",CNT)=TNUM_U_DSSNM_U_RU_U_ECXLNC_U_$S(WKLD1="":"*",1:"")_U_$S(TSTNM'="ZZZZ":TSTNM,1:"")_U_$S(SPECNM'="ZZZZ":$S(SPECNM="ZZDEFAULT LOINC":"DEFAULT LOINC",1:SPECNM),1:"")_U_WKLD1_U_WKLDCD ;144
 ....... S CNT=CNT+1 ;144
 ...... W !,$$RJ^XLFSTR(TNUM,4,"0"),?11,$E(DSSNM,1,24),?37,$E(RU,1,13),?53,$$RJ^XLFSTR(ECXLNC,10," ") ;,?56,$$RJ^XLFSTR(LLNC,10," ")
 ...... I WKLD1="" W ?67,"*"
 ...... ;I SPECNM'="ZZDEFAULT LOINC",$P(LLNC,"(")'=ECXLNC W ?67,"*"
 ...... W ?71,$S(TSTNM'="ZZZZ":$E(TSTNM,1,24),1:" ")
 ...... W ?97,$S(SPECNM'="ZZZZ":$S(SPECNM="ZZDEFAULT LOINC":"DEFAULT LOINC",1:$E(SPECNM,1,13)),1:" "),?112,$$RJ^XLFSTR(WKLD1,8," "),?122,$$RJ^XLFSTR(WKLDCD,10," ")
 ...... S COUNT=COUNT+1
 ...... I $Y+3>IOSL D HEADER Q:QFLG
 I $G(ECXPORT) Q  ;144 stop processing if exporting
 W !!,"FLG ('*'=site not using LOINC code that DSS collects)"
 Q:QFLG
CLOSE ;
 I $E(IOST)="C",'QFLG D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 K ^TMP($J,"ECXLARPT")
 Q
 ;
HEADER ;header and page control
 N SS,JJ
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,"LAB RESULTS DSS LOINC CODE REPORT",?124,"Page: "_PG
 W !,"Report Run Date/Time: "_ECRUN
 W !,"DSS Site:             "_$P(ECXDIV(1),U,2)_" ("_$P(ECXDIV(1),U,3)_")"
 ;W !,?97,"LOC",?117,"LOC",?122,"LOC"
 ;W !!,?68,"F",!,"LAR",?49,"LAR",?61,"LOCAL",?68,"L",?97,"LOC SPEC",?113,"LOC WKLD",?122,"LOC WKLD"
 ;W !,"TEST#",?7,"LAR TEST NAME",?33,"LAR UNITS",?49,"LOINC",?61,"LOINC",?68,"G",?71,"LOCAL TEST NAME",?99,"TYPE",?115,"IEN",?125,"CD"
 W !!,?67,"F",?97,"LOC SPEC",?113,"LOC WKLD",?122,"LOC WKLD"
 W !,"LAR TEST#",?11,"LAR TEST NAME",?37,"LAR UNITS",?53,"LAR LOINC",?67,"L",?71,"LOCAL TEST NAME",?99,"TYPE",?115,"IEN",?124,"CODE"
 W !,"(#727.29)",?13,"(#727.29)",?37,"(#727.29)",?53,"(#727.29)",?67,"G",?76,"(#64)",?99,"(#64)",?115,"(#64)",?124,"(#64)"
 W !,LN,!
 Q
 ;
