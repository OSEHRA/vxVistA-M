LRHY4X ;DALOI/HOAK - PHLEBOTOMY TAT ;4/13/1999
 ;;5.2;LAB SERVICE;**405,417,430**;Sep 27, 1994;Build 2
 ;
 ;
START ;
 ;
G ;
 K ^TMP("LRHYMEDTAT",$J)
 ;
 K ^TMP("LRHYCOLLECTOR",$J)
 ;
 K ^TMP("LRHYTATDALLAS",$J)
 K LRHYTECH1
 K %DT
 S %DT="AET"
 S %DT("A")="Please enter date and time to start search: "
 D ^%DT
 Q:Y=-1
 S LRSDT=Y
 S LRODT=$P(LRSDT,".")
 S %DT("A")="Please enter date and time to end search: "
 D ^%DT
 Q:Y=-1
 S LREDT=Y
 ;
 D DEVICE
 K ^TMP("LRHYMEDTAT",$J),^TMP("LRHYMEDFINAL",$J)
 K ^TMP("LRHYCOLLECTOR",$J),^TMP("LRHYTATDALLAS",$J)
 QUIT
PAT ;
 ;
 ;
 S LREND=0
 S DIC="^DPT("
 S DIC(0)="AEMQZ"
 D ^DIC
 S DFN=+Y
 S LRDFN=$G(^DPT(DFN,"LR"))
 D ^VADPT,INP^VADPT
 ;
 QUIT
 ;
LRO69 ;
Q ;
 U IO
 S LREND=0
 S LRSTAR=0
 D HEAD
 S LRSN=0
 S LRSTOP=0
 S LRDRAW1=LRODT
 F  S LRDRAW1=$O(^LRHY(69.87,"COLT",LRDRAW1)) Q:+LRDRAW1'>0!(LRDRAW1>LREDT)!(LRSTOP)  D
 .  S LRUID=""
 .  F  S LRUID=$O(^LRHY(69.87,"COLT",LRDRAW1,LRUID)) Q:LRUID=""  D
 ..  ;
 ..  S LRUID=$G(^LRHY(69.87,LRUID,0))
 ..  I '$O(^LRO(68,"C",LRUID,0)) QUIT
 ..  S LRAA=$O(^LRO(68,"C",LRUID,0))
 ..  S LRAD=$O(^LRO(68,"C",LRUID,LRAA,0))
 ..  S LRAN=$O(^LRO(68,"C",LRUID,LRAA,LRAD,0))
 ..  D IN
 D DISP
 QUIT
IN ;
 S LR6987=$O(^LRHY(69.87,"B",LRUID,0)) Q:'$G(LR6987)
 D
 .  S LREND=0
 .  K LRARIVE
 .  S LRSN=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,5),LRORDT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,4)
 .  S LRACCTM=$G(^LRHY(69.87,LR6987,2))
 .  S LRTKX=$G(^LRHY(69.87,LR6987,6))
 .  S LRARIVE=$G(^LRHY(69.87,LR6987,8))
 .  K LRNCOL
 .  S LR3D=$P(LRDRAW1,".",2)
 .  I $L(LR3D)'>3 S LR3D=LR3D_"0"
 .  S LR3D=$E(LR3D,1,2)*60+$E(LR3D,3,4)
 .  S LR3T=$P(LRACCTM,".",2)
 .  I $L(LR3T)'>3 S LR3T=LR3T_"0"
 .  S LR3T=$E(LR3T,1,2)*60+$E(LR3T,3,4)
 .  S LRTAT=(LR3D-LR3T)
 .  S LRDRAW=$E($P(LRDRAW1,".",2),1,2)_":"_$E($P(LRDRAW1,".",2),3,4)
 .  S LRARIVE=$E($P(LRACCTM,".",2),1,2)_":"_$E($P(LRACCTM,".",2),3,4)
 .  ;
 .  K LRDFN
 .  S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0)
 .  K LRDPF D PT^LRX
 .  S LRSSN=$P(SSN,"-",3)
 .  S LRAC1=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2))
 .  I LRAC1="" S LRAC1=$E($P(^LRO(68,LRAA,0),U),1,2)_" "_$E(LRAD,4,7)_" "_LRAN
 .  S LRAANAME=$P(^LRO(68,LRAA,0),U)
 .  ; check specimen not urine
 .  S LRLLOC=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,7)
 .  S LRSC0=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,13)
 .  I $P($G(LRNCOL),U,4) S ^TMP("LRHYCOLLECTOR",$J,LRORDT_U_LRSN_U_LRUID,$P(LRNCOL,U,4))=""
 .  K LRHYTECH
 .  S LRHYTECH=$G(^LRHY(69.87,LR6987,12))
 .  ;
 .  ;
 .  S LRHYTECH=$G(LRTKX)
 .  I LRHYTECH S ^TMP("LRHYCOLLECTOR",$J,LRORDT_U_LRSN_U_LRUID,LRHYTECH)=""
 .  ;
 .  S LRSTAR=0
 .  ;
 .  S ^TMP("LRHYTATDALLAS",$J,$E(LRDRAW,1,2),LRORDT_U_LRSN_U_LRUID)=LRDRAW_U_PNM_U_LRSSN_U_LRARIVE_U_LRTAT_U_LRAC1_U_$G(LRSTAR)_U_$G(LRLLOC)
 ;
 QUIT
 ;
DISP ;
 ;
 ;
 S LRTOTAL=0
 S LRHYCT=0
 U IO
 S LRD=0
 S LR7MORE=0
 S LR7LESS=0
 S LR700=0
 N LRE,LRTECH,LREXLINE
 ;
 F  S LRD=$O(^TMP("LRHYTATDALLAS",$J,LRD)) Q:+LRD'>0  D
 .  S LRE=""
 .  F  S LRE=$O(^TMP("LRHYTATDALLAS",$J,LRD,LRE)) Q:+LRE'>0  S LRN=^(LRE) D
 ..  S LRSN=$P(LRE,U,2)
 ..  S LRDRAW=+LRN
 ..  S LRDRAW=$P(LRN,U)
 ..  S PNM=$P(LRN,U,2)
 ..  S LRSSN=$P(LRN,U,3)
 ..  S LRARIVE=$P(LRN,U,4)
 ..  S LRTAT=$P(LRN,U,5)
 ..  I LRTAT>7 S LR7MORE=LR7MORE+1
 ..  I LRTAT<7 S LR7LESS=LR7LESS+1
 ..  I LRTAT=7 S LR700=LR700+1
 ..  S LRAC1=$P(LRN,U,6)
 ..  S LRTECH=$O(^TMP("LRHYCOLLECTOR",$J,LRE,0))
 ..  S LREXLINE=$S($L(LRTECH)>6:1,1:0)
 ..  D CHK Q:LRSTOP
 ..  K LREXLINE
 ..  W !,+$E(LRD,1,2),?4,$E(PNM,1,14)," ",LRSSN,?25,"BLD",?30,LRARIVE,?37,LRDRAW,?44,LRTAT
 ..  W ?49,LRTECH
 ..  ;I $P(LRN,U,7)=1 W "*"
 ..  I $L(LRTECH)>6 W !
 ..  W ?56,LRAC1 ;accession
 ..  W ?73,$E($P(LRN,U,8),1,7) ;clinic
 ..  S LRHYCT=LRHYCT+1 S LRTOTAL=LRTOTAL+LRTAT
 ..  S ^TMP("LRHYMEDTAT",$J,LRE)=LRTAT
 Q:'LRHYCT
 W !!,?10,"Mean TAT: "
 W ?35,$P(LRTOTAL/LRHYCT,".")_"."_$E($P(LRTOTAL/LRHYCT,".",2),1,1),?41
 D MEDIAN W ?41," Minutes"
 W !,?10,"Total Time: ",?35,LRTOTAL,?41," Minutes"
 W !,?10,"Total Patients Drawn: ",?35,LRHYCT,!
 W !,?15,"TAT > 7 minutes: ",LR7MORE
 W !,?15,"TAT < 7 minutes: ",LR7LESS
 W !,?15,"TAT = 7 minutes: ",LR700
 I LRHYCT=0 S LRHYCT=1
 ;
 ;
 W !,?5,"Collectors: "
 S LRN5=0
 F  S LRN5=$O(^TMP("LRHYCOLLECTOR",$J,LRN5)) Q:+LRN5'>0  D
 .  S LRHYTECH=0
 .  F  S LRHYTECH=$O(^TMP("LRHYCOLLECTOR",$J,LRN5,LRHYTECH)) Q:+LRHYTECH'>0  D
 ..  S LRHYTECH1(LRHYTECH,LRN5)=""
 S LRHYTECH=0
 F  S LRHYTECH=$O(LRHYTECH1(LRHYTECH)) Q:+LRHYTECH'>0  D
 .  S LRHYCTC=0 S LRT0=0
 .  F  S LRT0=$O(LRHYTECH1(LRHYTECH,LRT0)) Q:+LRT0'>0  D
 ..  S LRHYCTC=LRHYCTC+1
 .  I $D(^VA(200,LRHYTECH)) W !,?10,$P(^VA(200,LRHYTECH,0),U)
 .  W ?40,LRHYCTC,?45," Drawn"
 K DIR I IOST["C-" S DIR(0)="E" D ^DIR
 D ^%ZISC
 QUIT
MEDIAN ;
 N LR334 S LR334=0
 F  S LR334=$O(^TMP("LRHYMEDTAT",$J,LR334)) Q:+LR334'>0  I +$G(^TMP("LRHYMEDTAT",$J,LR334))'>0 S ^TMP("LRHYMEDTAT",$J,LR334)=1
 S LRSTUCK=0
 K ^TMP("LRHYMEDFINAL",$J)
 K LRTATN
 S LRHYCT3=1
BAK S LRX=0 S LRKIL=0 S LRNONONO=0 S LRM3=0
 I $D(^TMP("LRHYMEDFINAL",$J)) D
 .  I '$D(^TMP("LRHYMEDFINAL",$J,LRHYCT3)) S LRSTUCK=LRSTUCK+1
STUCK I $G(LRSTUCK)>2 K ^TMP("LRHYMEDTAT",$J,LRDUP) S LRSTUCK=0
 I '$D(^TMP("LRHYMEDTAT",$J)) G DONE QUIT
 S LRHYCT3=LRHYCT3+1
 S LRM1=$O(^TMP("LRHYMEDTAT",$J,LRX)) S (LRX,LRDUP)=LRM1
 S LRM1=$G(^TMP("LRHYMEDTAT",$J,LRM1))
TIC F  S LRX=$O(^TMP("LRHYMEDTAT",$J,LRX)) Q:+LRX'>0  S LRM2=^(LRX) D
 .  S LRKIL=LRX
 .  I LRM2=LRM1 S LRKIL=LRX S LRNOT=0 D
 ..  F LRY=1:1:LRHYCT3 Q:'$D(^TMP("LRHYMEDFINAL",$J,LRY))  D
 ...  I LRM1>+$O(^TMP("LRHYMEDFINAL",$J,LRY,0)) S LRNOT=1
 K ^TMP("LRHYMEDTAT",$J,LRDUP) S LRKIL=LRX
 I $G(LRNOT)=1 S LRX=LRX+.05 S LRNOT=0 G TIC
 I LRKIL K ^TMP("LRHYMEDTAT",$J,LRKIL)
 I +$O(^TMP("LRHYMEDTAT",$J,0)) G BAK
 S LRHYCT3=0
 S LRX=0
 F  S LRX=$O(^TMP("LRHYMEDFINAL",$J,LRX)) Q:+LRX'>0  D
 .  S LRHYCT3=LRHYCT3+1
 .  S LRYTAT=$O(^TMP("LRHYMEDFINAL",$J,LRX,0))
 .  S LRTATN(LRHYCT3)=LRYTAT
 S LRX=LRHYCT3/2
 Q:'LRX
 I LRX[.5 S LRX1=$P(LRX,".") Q:'LRX1  S LRX2=LRX1+1 D
 .  S LRX3=(LRTATN(LRX1)+LRTATN(LRX2))/2
 E  S LRX3=LRTATN(LRX)
 W !,?10,"Median TAT:",?35,LRX3
 ;
 QUIT
HEAD ;
 S LRSTOP=0
 W @IOF
 W "Date:",$$Y2K^LRX(DT)," ",$$CJ^XLFSTR("PATIENT WAIT TIME",IOM)
 W !,"Time",?5,"Patient Name",?25,"Type",?30,"Arrive"
 W ?37,"Drawn",?44,"TAT",?49,"TECH",?57,"ACCN"
 W ?73,"Clinic"
 QUIT
CHK ;
 Q:LRSTOP
 S LRLINE=(IOSL-$Y)
 I $E(IOST,1,2)["P-" D  QUIT
 .  I LRLINE<(7+$G(LREXLINE)) D HEAD QUIT
 ;
 I LRLINE<(2+$G(LREXLINE)) D
 .  Q:$E(IOST,1,2)'["C-"
 .  K DIR S DIR(0)="E" D ^DIR
 .  I $D(DUOUT)!($D(DIRUT)) S LRSTOP=1 Q
 .  D HEAD
 QUIT
DONE ;
 S LRHYCT3=0
 S LRX=0
 F  S LRX=$O(^TMP("LRHYMEDFINAL",$J,LRX)) Q:+LRX'>0  D
 .  S LRHYCT3=LRHYCT3+1
 .  S LRYTAT=$O(^TMP("LRHYMEDFINAL",$J,LRX,0))
 .  S LRTATN(LRHYCT3)=LRYTAT
 S LRX=LRHYCT3/2
 I LRX[.5 S LRX1=$P(LRX,".") Q:'LRX1  S LRX2=LRX1+1 D
 .  S LRX3=(LRTATN(LRX1)+LRTATN(LRX2))/2
 E  S LRX3=LRTATN(LRX)
 W !,?10,"Median TAT:",?35,LRX3
 QUIT
DEVICE ;
 S ZTRTN="Q^LRHY4X"
 ;
 D IO^LRWU
 ;
 QUIT
 QUIT
