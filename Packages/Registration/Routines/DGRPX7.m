DGRPX7 ; GENERATED FROM 'DG LOAD EDIT SCREEN 7' INPUT TEMPLATE(#420), FILE 2;12/30/15
 D DE G BEGIN
DE S DIE="^DPT(",DIC=DIE,DP=2,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DPT(DA,""))=""
 I $D(^(.29)) S %Z=^(.29) S %=$P(%Z,U,1) S:%]"" DE(20)=% S %=$P(%Z,U,2) S:%]"" DE(19)=% S %=$P(%Z,U,12) S:%]"" DE(17)=%
 I $D(^(.3)) S %Z=^(.3) S %=$P(%Z,U,1) S:%]"" DE(5)=% S %=$P(%Z,U,2) S:%]"" DE(7)=% S %=$P(%Z,U,4) S:%]"" DE(11)=% S %=$P(%Z,U,5) S:%]"" DE(9)=% S %=$P(%Z,U,12) S:%]"" DE(8)=% S %=$P(%Z,U,13) S:%]"" DE(13)=%
 I $D(^(.31)) S %Z=^(.31) S %=$P(%Z,U,3) S:%]"" DE(21)=% S %=$P(%Z,U,4) S:%]"" DE(22)=%
 I $D(^(.362)) S %Z=^(.362) S %=$P(%Z,U,12) S:%]"" DE(25)=% S %=$P(%Z,U,13) S:%]"" DE(26)=% S %=$P(%Z,U,14) S:%]"" DE(30)=%
 I $D(^(.385)) S %Z=^(.385) S %=$P(%Z,U,1) S:%]"" DE(33)=% S %=$P(%Z,U,2) S:%]"" DE(35)=%
 I $D(^("TYPE")) S %Z=^("TYPE") S %=$P(%Z,U,1) S:%]"" DE(2)=%
 I $D(^("VET")) S %Z=^("VET") S %=$P(%Z,U,1) S:%]"" DE(4)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") S:%]"" Y=%
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
SET N DIR S DIR(0)="SV"_$E("o",$D(DB(DQ)))_U_DU,DIR("V")=1
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 D ^DIR I 'DDER S %=Y(0),X=Y
 Q
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="DGRPX7",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(420,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=420,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 S:DGDR'["701" Y="@702"
 Q
2 S DW="TYPE;1",DV="P391'",DU="",DLB="TYPE",DIFLD=391
 S DE(DW)="C2^DGRPX7",DE(DW,"INDEX")=1
 S DU="DG(391,"
 G RE
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="391;" D AVAFC^VAFCDD01(DA)
C2S S X="" G:DG(DQ)=X C2F1 K DB
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="391;" D AVAFC^VAFCDD01(DA)
C2F1 N X,X1,X2 S DIXR=643 D C2X1(U) K X2 M X2=X D C2X1("O") K X1 M X1=X
 I $G(X(1))]"" D
 . K ^DPT("APTYPE",X,DA)
 K X M X=X2 I $G(X(1))]"" D
 . S ^DPT("APTYPE",X,DA)=""
 G C2F2
C2X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2,DIIENS,391,DION),$P($G(^DPT(DA,"TYPE")),U,1))
 S X=$G(X(1))
 Q
C2F2 Q
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 D SC7^DGRPV
 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="VET;1",DV="SX",DU="",DLB="VETERAN (Y/N)?",DIFLD=1901
 S DE(DW)="C4^DGRPX7"
 S DU="Y:YES;N:NO;"
 G RE
C4 G C4S:$D(DE(4))[0 K DB
 S X=DE(4),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DE(4),DIC=DIE
 S DFN=DA D EN^DGRP7CC
 S X=DE(4),DIC=DIE
 ;
 S X=DE(4),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(4),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="1901;" D AVAFC^VAFCDD01(DA)
 S X=DE(4),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
C4S S X="" G:DG(DQ)=X C4F1 K DB
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGRP7CC
 S X=DG(DQ),DIC=DIE
 X ^DD(2,1901,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X=DIV S X="N" X ^DD(2,1901,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="1901;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
C4F1 Q
X4 I $D(X) S:'$D(DPTX) DFN=DA D:'$D(^XUSEC("DG ELIGIBILITY",DUZ)) VAGE^DGLOCK:X="Y" I $D(X) D:$D(DFN) EV^DGLOCK
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW=".3;1",DV="SX",DU="",DLB="SERVICE CONNECTED?",DIFLD=.301
 S DE(DW)="C5^DGRPX7"
 S DU="Y:YES;N:NO;"
 G RE
C5 G C5S:$D(DE(5))[0 K DB
 S X=DE(5),DIC=DIE
 ;
 S X=DE(5),DIC=DIE
 ;
 S X=DE(5),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(5),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".301;" D AVAFC^VAFCDD01(DA)
 S X=DE(5),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
C5S S X="" G:DG(DQ)=X C5F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.301,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,.301,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.301,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X="" X ^DD(2,.301,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".301;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
C5F1 Q
X5 S DFN=DA D EV^DGLOCK I $D(X),X="Y" D VET^DGLOCK
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S:X'="Y" Y=.293
 Q
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW=".3;2",DV="NJ3,0X",DU="",DLB="SERVICE CONNECTED PERCENTAGE",DIFLD=.302
 S DE(DW)="C7^DGRPX7"
 G RE
C7 G C7S:$D(DE(7))[0 K DB
 S X=DE(7),DIC=DIE
 ;
 S X=DE(7),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(7),DIC=DIE
 ;
 S X=DE(7),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".302;" D AVAFC^VAFCDD01(DA)
 S X=DE(7),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
C7S S X="" G:DG(DQ)=X C7F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 X "S DFN=DA D EN^DGMTR K DGREQF"
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".302;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
C7F1 Q
X7 S DFN=DA D EV^DGLOCK Q:'$D(X)  K:+X'=X!(X>100)!(X<0)!(X?.E1"."1N.N) X I $D(X),$D(^DPT(DA,.3)),$P(^(.3),U,1)'="Y" W !?4,*7,"Only applies to service-connected applicants." K X
 Q
 ;
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW=".3;12",DV="DX",DU="",DLB="SC AWARD DATE",DIFLD=.3012
 G RE
X8 S %DT="E" D ^%DT S X=Y K:Y<1 X N DFN S DFN=DA D SC^DGLOCK1
 Q
 ;
9 S DW=".3;5",DV="S",DU="",DLB="UNEMPLOYABLE",DIFLD=.305
 S DE(DW)="C9^DGRPX7"
 S DU="Y:YES;N:NO;"
 G RE
C9 G C9S:$D(DE(9))[0 K DB
 S X=DE(9),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(9),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
C9S S X="" G:DG(DQ)=X C9F1 K DB
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
C9F1 Q
X9 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I $P($G(^DPT(DFN,.361)),U)="V" I $P($G(^DPT(DFN,.361)),U,3)="H" S Y="@293"
 Q
11 D:$D(DG)>9 F^DIE17,DE S DQ=11,DW=".3;4",DV="SX",DU="",DLB="P&T",DIFLD=.304
 S DE(DW)="C11^DGRPX7"
 S DU="Y:YES;N:NO;"
 G RE
C11 G C11S:$D(DE(11))[0 K DB
 S X=DE(11),DIC=DIE
 D EVENT^IVMPLOG(DA)
 S X=DE(11),DIC=DIE
 X ^DD(2,.304,1,2,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X="" S DIH=$G(^DPT(DIV(0),.3)),DIV=X S $P(^(.3),U,13)=DIV,DIH=2,DIG=.3013 D ^DICR
C11S S X="" G:DG(DQ)=X C11F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$C(59)_$P($G(^DD(2,.304,0)),U,3) S X=$P($P(Y(1),$C(59)_Y(0)_":",2),$C(59))'="Y" I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X="" X ^DD(2,.304,1,2,1.4)
C11F1 Q
X11 S DFN=DA D EV2^DGLOCK
 Q
 ;
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 S:X'="Y" Y=.293
 Q
13 D:$D(DG)>9 F^DIE17,DE S DQ=13,DW=".3;13",DV="DX",DU="",DLB="P&T EFFECTIVE DATE",DIFLD=.3013
 S DE(DW)="C13^DGRPX7"
 G RE
C13 G C13S:$D(DE(13))[0 K DB
 S X=DE(13),DIC=DIE
 D EVENT^IVMPLOG(DA)
C13S S X="" G:DG(DQ)=X C13F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C13F1 Q
X13 S %DT="EXP" D ^%DT S X=Y K:X<1!(DT<X) X I $D(X) S DFN=DA D PTDT^DGLOCK I $D(X) S DFN=DA D EV2^DGLOCK
 Q
 ;
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S Y=.293
 Q
15 S DQ=16 ;@293
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 W !,"No editing P&T Data, Eligibility record verified by HEC"
 Q
17 D:$D(DG)>9 F^DIE17,DE S DQ=17,DW=".29;12",DV="S",DU="",DLB="RATED INCOMPETENT?",DIFLD=.293
 S DE(DW)="C17^DGRPX7"
 S DU="0:NO;1:YES;"
 G RE
C17 G C17S:$D(DE(17))[0 K DB
 S X=DE(17),DIC=DIE
 D EVENT^IVMPLOG(DA)
C17S S X="" G:DG(DQ)=X C17F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C17F1 Q
X17 Q
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 S:'X Y=.313
 Q
19 D:$D(DG)>9 F^DIE17,DE S DQ=19,DW=".29;2",DV="DX",DU="",DLB="DATE RULED INCOMPETENT (CIVIL)",DIFLD=.292
 G RE
X19 S %DT="EP" D ^%DT S X=Y K:Y<1 X I $D(X) S DFN=DA D INCOM2^DGLOCK
 Q
 ;
20 S DW=".29;1",DV="DX",DU="",DLB="DATE RULED INCOMPETENT (VA)",DIFLD=.291
 G RE
X20 S %DT="E" D ^%DT S X=Y K:Y<1 X I $D(X) S DFN=DA D INCOM^DGLOCK
 Q
 ;
21 S DW=".31;3",DV="FXO",DU="",DLB="CLAIM NUMBER",DIFLD=.313
 S DQ(21,2)="S Y(0)=Y S Y=$E(Y,1,10)"
 S DE(DW)="C21^DGRPX7"
 G RE
C21 G C21S:$D(DE(21))[0 K DB
 S X=DE(21),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".313;" D AVAFC^VAFCDD01(DA)
 S X=DE(21),DIC=DIE
 D EVENT^IVMPLOG(DA)
C21S S X="" G:DG(DQ)=X C21F1 K DB
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".313;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C21F1 Q
X21 S DFN=DA D EV^DGLOCK I $D(X) S L=$S($D(^DPT(DA,0)):$P(^(0),U,9),1:X) W:X?1"SS".E "  ",L S:X?1"SS".E X=L K:$L(X)>9 X Q:'$D(X)  I X'=L K:$L(X)>8!($L(X)<7)!'(X?.N) X
 I $D(X),X'?.ANP K X
 Q
 ;
22 D:$D(DG)>9 F^DIE17,DE S DQ=22,DW=".31;4",DV="*P4'X",DU="",DLB="CLAIM FOLDER LOCATION",DIFLD=.314
 S DE(DW)="C22^DGRPX7"
 S DU="DIC(4,"
 G RE
C22 G C22S:$D(DE(22))[0 K DB
 S X=DE(22),DIC=DIE
 D KILL^DGREGDD(DA)
C22S S X="" G:DG(DQ)=X C22F1 K DB
 S X=DG(DQ),DIC=DIE
 D SET^DGREGDD(DA,X)
C22F1 Q
X22 S DIC("S")="I $$CFLTF^DGREGDD(Y)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
23 S DQ=24 ;@702
24 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=24 D X24 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X24 S:DGDR'["702" Y="@703"
 Q
25 D:$D(DG)>9 F^DIE17,DE S DQ=25,DW=".362;12",DV="SX",DU="",DLB="RECEIVING A&A BENEFITS?",DIFLD=.36205
 S DE(DW)="C25^DGRPX7"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 G RE
C25 G C25S:$D(DE(25))[0 K DB
 S X=DE(25),DIC=DIE
 X ^DD(2,.36205,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(2,.36205,1,1,2.4)
 S X=DE(25),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DE(25),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36205,1,3,2.4)
 S X=DE(25),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C25S S X="" G:DG(DQ)=X C25F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.36205,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(2,.36205,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36205,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C25F1 Q
X25 S DFN=DA D MV^DGLOCK I $D(X) S DFN=DA D EV^DGLOCK
 Q
 ;
26 D:$D(DG)>9 F^DIE17,DE S DQ=26,DW=".362;13",DV="SX",DU="",DLB="RECEIVING HOUSEBOUND BENEFITS?",DIFLD=.36215
 S DE(DW)="C26^DGRPX7"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 G RE
C26 G C26S:$D(DE(26))[0 K DB
 S X=DE(26),DIC=DIE
 X ^DD(2,.36215,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,.36215,1,1,2.4)
 S X=DE(26),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DE(26),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36215,1,3,2.4)
 S X=DE(26),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C26S S X="" G:DG(DQ)=X C26F1 K DB
 D ^DGRPX71
C26F1 Q
X26 S DFN=DA D MV^DGLOCK I $D(X) S DFN=DA D EV^DGLOCK
 Q
 ;
27 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=27 D X27 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X27 S:$P($G(^DPT(DFN,.385)),U,11)="Y" Y="@7025"
 Q
28 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=28 D X28 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X28 S:($P($G(^DPT(DFN,.385)),U,10)="Y")&($P($G(^DPT(DFN,.362)),U,14)="N") Y="@7025"
 Q
29 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=29 D X29 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X29 S:$P($G(^DPT(DFN,.385)),U,10)="Y" Y="@7022"
 Q
30 D:$D(DG)>9 F^DIE17,DE S DQ=30,DW=".362;14",DV="SX",DU="",DLB="RECEIVING A VA PENSION?",DIFLD=.36235
 S DE(DW)="C30^DGRPX7"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 G RE
C30 G C30S:$D(DE(30))[0 K DB
 D ^DGRPX72
C30S S X="" G:DG(DQ)=X C30F1 K DB
 D ^DGRPX73
C30F1 Q
X30 S DFN=DA D MV^DGLOCK
 Q
 ;
31 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=31 D X31 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X31 I X="Y" S Y="@7022"
 Q
32 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=32 G A
33 D:$D(DG)>9 F^DIE17,DE S DQ=33,DW=".385;1",DV="DX",DU="",DLB="PENSION AWARD EFFECTIVE DATE",DIFLD=.3851
 S DE(DW)="C33^DGRPX7"
 S X="@"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C33 G C33S:$D(DE(33))[0 K DB
 D ^DGRPX74
C33S S X="" G:DG(DQ)=X C33F1 K DB
 D ^DGRPX75
C33F1 Q
X33 S %DT="PX" D ^%DT S X=Y K:Y<1 X I $D(X) D H^DGUTL I $G(X)>0 S DFN=DA D DTCHK^DGRP7CP
 Q
 ;
34 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=34 G A
35 D:$D(DG)>9 F^DIE17,DE S DQ=35,DW=".385;2",DV="*P27.18'X",DU="",DLB="PENSION AWARD REASON",DIFLD=.3852
 S DE(DW)="C35^DGRPX7"
 S DU="DG(27.18,"
 S X="@"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C35 G C35S:$D(DE(35))[0 K DB
 D ^DGRPX76
C35S S X="" G:DG(DQ)=X C35F1 K DB
 D ^DGRPX77
C35F1 Q
X35 S:($G(X)]"")&(X'?1P.P) X=$$UPPER^DGUTL(X) S X=$$LOWER^DGUTL(X) S DIC("S")="I $P($G(^(0)),U)[""Original Award""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
36 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=36 D X36 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X36 S Y="@7026"
 Q
37 S DQ=38 ;@7022
38 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=38 D X38 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X38 S:($P($G(^DPT(DFN,.385)),U,10)'="Y") Y="@7023"
 Q
39 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=39 D X39 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X39 D EN^DDIOL("Pension Award Date and Pension Award Reason are editable only if VA Pension","","!!")
 Q
40 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=40 D X40 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X40 D EN^DDIOL("Indicator is Yes and Pension Award Reason is not 'Original Award'.  For any","","!")
 Q
41 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=41 D X41 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X41 D EN^DDIOL("other assistance, use the HEC Alert process.","","!")
 Q
42 S DQ=43 ;@7023
43 D:$D(DG)>9 F^DIE17 G ^DGRPX78
