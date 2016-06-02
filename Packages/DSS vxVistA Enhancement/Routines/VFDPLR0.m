VFDPLR0 ;DSS/MKN/RBN-PRINTS PICK LIST REPORT (CONT.) ;02 FEB 2014 / 03:34 PM
 ;;5.0; INPATIENT MEDICATIONS ;**15,34,58**;02 FEB 2014;Build 20
 ;Copyright 1995-2014,Document Storage Systems Inc. All Rights Reserved
 ; Reference to ^PS(55 is supported by DBIA 2191
 ;
B0 ;
 F  S (PW,WDN)=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN)) Q:WDN=""  D:FFF=1 FCL S FIRST=1 F  S (PRM,RM)=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM)) Q:RM=""  F  S PN=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN)) Q:PN=""  D B1
 Q
 ;
B1 ;
 I $G(PSGPLSTR)'="" S TM=$P(PSGPLSTR,"^",1),WDN=$P(PSGPLSTR,"^",2),RM=$P(PSGPLSTR,"^",3),PN=$P(PSGPLSTR,"^",4,5) K PSGPLSTR
 S PPN=$G(^PS(53.5,PSGPLG,1,+$P(PN,U,2),0)),PPN=$P(PPN,U,3,4)
 S PSGP=$P(PN,"^",2) S:WSF PW=$P(PPN,"^") S PRM=$P(PPN,"^",2),PRM=$S($P(TND,U,6):$P(PRM,"-",2)_"-"_$P(PRM,"-"),1:PRM) D P1 S FIRST=0
 S PST=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN,"")) I PST="NO ORDERS" W !?18,"No orders found for this patient." Q
 I PST="A" D EXH S DRG="" F  S DRG=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN,"A",DRG)) Q:DRG=""  D GTORDER,PLN3
 I PST="A",$O(^PS(53.5,PSGPLG,TM,WDN,RM,PN,"A"))]"" W ! W:OCNT !?3,OLINE W !?18,"**** ACTIVE ORDERS ****" W:'OCNT !?3,OLINE
 S PST="A" F  S PST=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN,PST)) Q:"Z"[PST  S DRG="" F  S DRG=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN,PST,DRG)) Q:DRG=""  D GTDOSES,P2
 I PST="Z" D EXH S DRG="" F  S DRG=$O(^PS(53.5,PSGPLXR,PSGPLG,TM,WDN,RM,PN,"Z",DRG)) Q:DRG=""   D GTORDER,PLN3
 Q
 ;
GTORDER ; Get order number of order in 55.
 S PSJJORD=+$G(^PS(53.5,PSGPLG,1,PSGP,1,+$P(DRG,U,2),0))
 ;
GTDOSES ; Set # dispense drugs and times to be admined.
 S PSJORDN=$P($G(^PS(53.5,PSGPLG,1,PSGP,1,+$P(DRG,U,2),0)),U,4)_U_$P($G(^(1,0)),U,4)
 Q
 ;
P1 ;
 S ND=$G(^DPT(PSGP,0)),PPN=$S($P(ND,"^")]"":$P(ND,"^"),1:PSGP),PSSN=$E($P(ND,"^",9),6,9),PW=$S(PW="zz":"* N/F *",1:PW),WL="",$P(WL,"=",37-($L(PW)/2))="" D:FFF=2 FCL I $Y+6>IOSL D
 . D HEADER
PLN1 I FIRST W !!,WL," WARD: ",PW," ",WL
 ;DSS/RBN BEGIN MODS
 ; Change pt ssn to pt mrn
 ;W !,$S(PPN'=PSGP:PPN,1:"NOT FOUND ("_PSGP_")"),$S(PSSN:"  ("_PSSN_")",1:""),":"
 W !,$S(PPN'=PSGP:PPN,1:"NOT FOUND ("_PSGP_")"),$S($L(VA("MRN")):"  ("_VA("MRN")_")",1:""),":"
 ;DSS/RBN END MODS
 S OCNT=0
 Q
 ;
P2 ;
 S PSJJORD=+$G(^PS(53.5,PSGPLG,1,PSGP,1,+$P(DRG,U,2),0))
 D:$Y+9+$P(PSJORDN,"^",2)>IOSL HEADER,PLN1 S OCNT=OCNT+1 W ! W:OCNT>1 !?3,OLINE
 S ND0=$G(^PS(55,PSGP,5,PSJJORD,0)),ND1=$G(^(.2)),ND2=$G(^(2)),ND6=$P($G(^(6)),"^"),RTE=$P(ND0,"^",3),SM=$S('$P(ND0,"^",5):0,$P(ND0,"^",6):2,1:1),PDRG=$$ENPDN^PSGMI($P(ND1,"^")),DO=$P(ND1,"^",2),Y="" I ND6]"" S Y=$$ENSET^PSGSICHK(ND6)
 S SD=$P(ND2,"^",2),(FD,STPDT)=$P(ND2,"^",4),AT=$P(ND2,"^",5),FQC=$P(ND2,"^",6),SCH=$P(ND2,"^") S:SCH="" SCH="SCHEDULE NF" S RTE=$$ENMRN^PSGMI(RTE) F X="SD","FD" S @X=$$ENDTC^PSGMI(@X) I PST'="R",FQC="D",AT="" S AT=$E($P(SD,".",2)_"0000",1,4)
 D DD^VFDPLR1
 Q
 ;
PLN3 ;
 D:$Y+9+$P(PSJORDN,"^",2)>IOSL HEADER,PLN1,EXH S OCNT=OCNT+1 W ! W:OCNT>1 !?3,OLINE
 S RTE=$P($G(^PS(55,PSGP,5,PSJJORD,0)),"^",3,9),SCH=$G(^(2)),DR=$G(^(.2)),DIS=$P(RTE,"^",7),RTE=$P(RTE,"^"),DO=$P(DR,"^",2),SD=$P(SCH,"^",2),(FD,STPDT)=$P(SCH,"^",4),SCH=$P(SCH,"^"),DIS=$S(DIS'["D":"EXPIRED",1:"DISCONTINUED")
 S DR=$$ENPDN^PSGMI($P(DR,"^")),RTE=$$ENMRN^PSGMI(RTE)
 F X="SD","FD" S @X=$$ENDTC^PSGMI(@X)
 D EXDD^VFDPLR1
 Q
 ;
FCL ;
 I PGN,CML,$P(PSGPLWGP,"^",6) D PAGECK^PSGPLR W !!?25,"FILLED BY: ",FACL,!!?25,"CHECKED BY: "_FACL
 ;
HEADER ;
 S PGN=PGN+1 W:$Y @IOF
 W ?1,"(",PSGPLG,")",?$S($D(PSGPLUPF):27,1:32),"PICK LIST REPORT" W:$D(PSGPLUPF) " (UPDATE)" W ?64,PPLD,!,"Ward group: ",WGPN,?73-$L(PGN),"Page: ",PGN,!?18,"For ",PSD," through ",PFD W:NPLF !,"Team: ",$S(TM'["zz":TM,1:"** N/F **")
 W !!,"Patient",?52,"Units",?59,"Units",!?3,"Medication",?40,"ST",?54,"U/D",?58,"Needed",?66,"Disp'd",!,LINE Q
 ;
EXH ;
 W !?6,OLINE
 W !,?9,"*** DC'D OR EXPIRED WITHIN LAST 24 HOURS ***"
 Q
 ;
HEADSP ;Screen stops
 K PSJDLW,DIR S DIR(0)="E" D ^DIR I $D(DTOUT)!$D(DUOUT) S PSJDLW=1
 Q
