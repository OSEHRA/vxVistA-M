DVBHCE1 ; ;12/30/15
 D DE G BEGIN
DE S DIE="^DPT(",DIC=DIE,DP=2,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DPT(DA,""))=""
 I $D(^(.3)) S %Z=^(.3) S %=$P(%Z,U,1) S:%]"" DE(33)=% S %=$P(%Z,U,6) S:%]"" DE(26)=%
 I $D(^(.32)) S %Z=^(.32) S %=$P(%Z,U,3) S:%]"" DE(12)=% S %=$P(%Z,U,14) S:%]"" DE(6)=% S %=$P(%Z,U,15) S:%]"" DE(5)=% S %=$P(%Z,U,16) S:%]"" DE(3)=% S %=$P(%Z,U,17) S:%]"" DE(4)=% S %=$P(%Z,U,18) S:%]"" DE(7)=% S %=$P(%Z,U,20) S:%]"" DE(1)=%
 I $D(^(.36)) S %Z=^(.36) S %=$P(%Z,U,1) S:%]"" DE(36)=%
 I $D(^(.361)) S %Z=^(.361) S %=$P(%Z,U,1) S:%]"" DE(21)=% S %=$P(%Z,U,2) S:%]"" DE(23)=% S %=$P(%Z,U,5) S:%]"" DE(24)=%
 I $D(^("TYPE")) S %Z=^("TYPE") S %=$P(%Z,U,1) S:%]"" DE(31)=%
 I $D(^("VET")) S %Z=^("VET") S %=$P(%Z,U,1) S:%]"" DE(32)=%
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
BEGIN S DNM="DVBHCE1",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW=".32;20",DV="SX",DU="",DLB="Service NNTL Episode",DIFLD=.32945
 S DE(DW)="C1^DVBHCE1"
 S DU="Y:YES;N:NO;"
 G RE
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 ;
 S X=DE(1),DIC=DIE
 X ^DD(2,.32945,1,2,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.32)):^(.32),1:"") S X=$P(Y(1),U,15),X=X S DIU=X K Y S X="" S DIH=$G(^DPT(DIV(0),.32)),DIV=X S $P(^(.32),U,15)=DIV,DIH=2,DIG=.3296 D ^DICR
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 X "I X'=""Y"" S DGXRF=.32945 D ^DGDDC Q"
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.32945,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.32)):^(.32),1:"") S X=$P(Y(1),U,15),X=X S DIU=X K Y S X="" S DIH=$G(^DPT(DIV(0),.32)),DIV=X S $P(^(.32),U,15)=DIV,DIH=2,DIG=.3296 D ^DICR
C1F1 Q
X1 S DFN=DA D SV^DGLOCK I "N"'[$G(X),$D(^DPT(DFN,.32)),$P(^(.32),U,19)'="Y" W !?4,*7,"Other Periods of service are not indicated...NO EDITING!" K X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 I $P(^DPT(D0,.32),U,20)'="Y" S Y="@33"
 Q
3 D:$D(DG)>9 F^DIE17,DE S DQ=3,DW=".32;16",DV="DX",DU="",DLB="NNTL-EOD",DIFLD=.3297
 S DE(DW)="C3^DVBHCE1",DE(DW,"INDEX")=1
 G RE
C3 G C3S:$D(DE(3))[0 K DB
 S X=DE(3),DIC=DIE
 D EVENT^IVMPLOG(DA)
C3S S X="" G:DG(DQ)=X C3F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C3F1 S DIEZRXR(2,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=642 S DIEZRXR(2,DIXR)=""
 Q
X3 S %DT="E",%DT(0)=-DT D ^%DT K %DT S X=Y K:Y<1 X I $D(X) S DFN=DA D SER2^DGLOCK I $D(X) K:'$$VALMSE^DGRPMS(DFN,X,0,"MSNNTL") X I $D(X) S DGFRDT=X I $D(^DG(43,1)) S SD1=3 D POS^DGINP
 Q
 ;
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW=".32;17",DV="DX",DU="",DLB="NNTL-RAD",DIFLD=.3298
 S DE(DW)="C4^DVBHCE1",DE(DW,"INDEX")=1
 G RE
C4 G C4S:$D(DE(4))[0 K DB
 S X=DE(4),DIC=DIE
 D EVENT^IVMPLOG(DA)
C4S S X="" G:DG(DQ)=X C4F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C4F1 S DIEZRXR(2,DIIENS)=$$OREF^DILF($NA(@$$CREF^DILF(DIE)))
 F DIXR=642 S DIEZRXR(2,DIXR)=""
 Q
X4 S %DT="E",%DT(0)=-DT D ^%DT K %DT S X=Y K:Y<1 X I $D(X) S DFN=DA D SER2^DGLOCK I $D(X) K:'$$VALMSE^DGRPMS(DFN,X,1,"MSNNTL") X I $D(X),$D(^DG(43,1)) S SD1=3 D PS^DGINP
 Q
 ;
5 D:$D(DG)>9 F^DIE17,DE S DQ=5,DW=".32;15",DV="P23'X",DU="",DLB="NNTL-Bran. Ser.",DIFLD=.3296
 S DE(DW)="C5^DVBHCE1",DE(DW,"INDEX")=1
 S DU="DIC(23,"
 G RE
C5 G C5S:$D(DE(5))[0 K DB
 S X=DE(5),DIC=DIE
 I $P($G(^DPT(DA,.321)),U,14)]"" D FVP^DGRPMS
 S X=DE(5),DIC=DIE
 D EVENT^IVMPLOG(DA)
 S X=DE(5),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.3291)):^(.3291),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DPT(DIV(0),.3291)),DIV=X S $P(^(.3291),U,3)=DIV,DIH=2,DIG=.32913 D ^DICR
 S X=DE(5),DIC=DIE
 X "S DGXRF=.3296 D ^DGDDC Q"
C5S S X="" G:DG(DQ)=X C5F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.3291)):^(.3291),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" S DIH=$G(^DPT(DIV(0),.3291)),DIV=X S $P(^(.3291),U,3)=DIV,DIH=2,DIG=.32913 D ^DICR
 S X=DG(DQ),DIC=DIE
 ;
C5F1 N X,X1,X2 S DIXR=410 D C5X1(U) K X2 M X2=X D C5X1("O") K X1 M X1=X
 D
 . N DIEXARR M DIEXARR=X S DIEZCOND=1
 . S X=X2(1)=""
 . S DIEZCOND=$G(X) K X M X=DIEXARR Q:'DIEZCOND
 . D DELMSE^DGRPMS(DA,3)
 G C5F2
C5X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2,DIIENS,.3296,DION),$P($G(^DPT(DA,.32)),U,15))
 S X=$G(X(1))
 Q
C5F2 Q
X5 S DFN=DA K:X=$O(^DIC(23,"B","B.E.C.","")) X I $D(X) D SER2^DGLOCK S DGCOMBR=$G(Y) Q
 Q
 ;
6 D:$D(DG)>9 F^DIE17,DE S DQ=6,DW=".32;14",DV="P25'X",DU="",DLB="NNTL-Char. Ser.",DIFLD=.3295
 S DE(DW)="C6^DVBHCE1"
 S DU="DIC(25,"
 G RE
C6 G C6S:$D(DE(6))[0 K DB
 S X=DE(6),DIC=DIE
 D EVENT^IVMPLOG(DA)
C6S S X="" G:DG(DQ)=X C6F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C6F1 Q
X6 S DFN=DA D SER2^DGLOCK
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S DQ=7,DW=".32;18",DV="FX",DU="",DLB="NNTL-Ser. Num.",DIFLD=.3299
 S DE(DW)="C7^DVBHCE1"
 G RE
C7 G C7S:$D(DE(7))[0 K DB
 S X=DE(7),DIC=DIE
 D EVENT^IVMPLOG(DA)
C7S S X="" G:DG(DQ)=X C7F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C7F1 Q
X7 S DFN=DA D SER2^DGLOCK I $D(X) S:X?1"SS".E L=$S($D(^DPT(DA,0)):$P(^(0),U,9),1:X) W:X?1"SS".E "  ",L S:X?1"SS".E X=L K:$L(X)>15!($L(X)<1)!'(X?.N) X
 I $D(X),X'?.ANP K X
 Q
 ;
8 S DQ=9 ;@33
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I Z2'[4 S Y="@3"
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S DVBSCR=1 D ^DVBHS4
 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 S DVBJC2=$S($D(^DPT(D0,.32)):$P(^(.32),U,3),1:"")
 Q
12 D:$D(DG)>9 F^DIE17,DE S DQ=12,DW=".32;3",DV="*P21'X",DU="",DLB="PERIOD OF SERVICE",DIFLD=.323
 S DE(DW)="C12^DVBHCE1"
 S DU="DIC(21,"
 G RE
C12 G C12S:$D(DE(12))[0 K DB
 S X=DE(12),DIC=DIE
 K ^DPT("APOS",$E(X,1,30),DA)
 S X=DE(12),DIC=DIE
 ;
 S X=DE(12),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".323;" D AVAFC^VAFCDD01(DA)
 S X=DE(12),DIC=DIE
 D EVENT^IVMPLOG(DA)
C12S S X="" G:DG(DQ)=X C12F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^DPT("APOS",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.323,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,"ODS")):^("ODS"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y X ^DD(2,.323,1,2,1.1) X ^DD(2,.323,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".323;" D AVAFC^VAFCDD01(DA)
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C12F1 Q
X12 S DFN=DA D POS^DGLOCK1
 Q
 ;
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 I X'=DVBJC2 S DVBJ2=1
 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 K DVBJC2
 Q
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 D X15 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X15 S Y="@3"
 Q
16 S DQ=17 ;@104
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 D ^DVBHS5 S Y="@5" K DXS
 Q
18 S DQ=19 ;@204
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 I Z2'[1 S Y="@205"
 Q
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 S DVBSCR=1 D ^DVBHS5 S DVBJ2=1
 Q
21 D:$D(DG)>9 F^DIE17,DE S DQ=21,DW=".361;1",DV="SX",DU="",DLB="ELIGIBILITY STATUS",DIFLD=.3611
 S DE(DW)="C21^DVBHCE1"
 S DU="P:PENDING VERIFICATION;R:PENDING RE-VERIFICATION;V:VERIFIED;"
 G RE
C21 G C21S:$D(DE(21))[0 K DB
 S X=DE(21),DIC=DIE
 ;
 S X=DE(21),DIC=DIE
 ;
 S X=DE(21),DIC=DIE
 D EVENT^IVMPLOG(DA)
C21S S X="" G:DG(DQ)=X C21F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.361)):^(.361),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y X ^DD(2,.3611,1,1,1.1) X ^DD(2,.3611,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.361)):^(.361),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DT X ^DD(2,.3611,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C21F1 Q
X21 D EK^DGLOCK Q:'$D(X)
 Q
 ;
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 G A
23 D:$D(DG)>9 F^DIE17,DE S DQ=23,DW=".361;2",DV="DX",DU="",DLB="ELIGIBILITY STATUS DATE",DIFLD=.3612
 S DE(DW)="C23^DVBHCE1"
 S X="TODAY"
 S Y=X
 G Y
C23 G C23S:$D(DE(23))[0 K DB
 S X=DE(23),DIC=DIE
 ;
 S X=DE(23),DIC=DIE
 D EVENT^IVMPLOG(DA)
C23S S X="" G:DG(DQ)=X C23F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DPT(D0,.361)):^(.361),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X=DIV S X=$S(($D(DUZ)#2):DUZ,1:"") X ^DD(2,.3612,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C23F1 Q
X23 S %DT="E",%DT(0)=-DT D ^%DT K %DT S X=Y K:Y<1 X I $D(X) D EK^DGLOCK
 Q
 ;
24 D:$D(DG)>9 F^DIE17,DE S DQ=24,DW=".361;5",DV="FX",DU="",DLB="ELIGIBILITY VERIF. METHOD",DIFLD=.3615
 S DE(DW)="C24^DVBHCE1"
 S X="HINQ"
 S Y=X
 G Y
C24 G C24S:$D(DE(24))[0 K DB
 S X=DE(24),DIC=DIE
 D EVENT^IVMPLOG(DA)
C24S S X="" G:DG(DQ)=X C24F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C24F1 Q
X24 K:$L(X)>50!($L(X)<2) X I $D(X) D EK^DGLOCK
 I $D(X),X'?.ANP K X
 Q
 ;
25 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=25 G A
26 D:$D(DG)>9 F^DIE17,DE S DQ=26,DW=".3;6",DV="DX",DU="",DLB="MONETARY BEN. VERIFY DATE",DIFLD=.306
 S X="TODAY"
 S Y=X
 G Y
X26 S %DT="E",%DT(0)=-DT D ^%DT K %DT S X=Y K:Y<1 X I $D(X) D EK^DGLOCK
 Q
 ;
27 S D=0 K DE(1) ;361
 S DIFLD=361,DGO="^DVBHCE2",DC="3^2.0361IP^E^",DV="2.0361M*P8'X",DW="0;1",DOW="ELIGIBILITY",DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 S DU="DIC(8,"
 G RE:D I $D(DSC(2.0361))#2,$P(DSC(2.0361),"I $D(^UTILITY(",1)="" X DSC(2.0361) S D=$O(^(0)) S:D="" D=-1 G M27
 S D=$S($D(^DPT(DA,"E",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M27 I D>0 S DC=DC_D I $D(^DPT(DA,"E",+D,0)) S DE(27)=$P(^(0),U,1)
 G RE
R27 D DE
 S D=$S($D(^DPT(DA,"E",0)):$P(^(0),U,3,4),1:1) G 27+1
 ;
28 S DQ=29 ;@205
29 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=29 D X29 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X29 I Z2'[2 S Y="@206"
 Q
30 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=30 D X30 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X30 S DVBSCR=1 D ^DVBHS5 S DVBJ2=1
 Q
31 S DW="TYPE;1",DV="P391'",DU="",DLB="TYPE",DIFLD=391
 S DE(DW)="C31^DVBHCE1",DE(DW,"INDEX")=1
 S DU="DG(391,"
 G RE
C31 G C31S:$D(DE(31))[0 K DB
 S X=DE(31),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="391;" D AVAFC^VAFCDD01(DA)
C31S S X="" G:DG(DQ)=X C31F1 K DB
 S X=DG(DQ),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="391;" D AVAFC^VAFCDD01(DA)
C31F1 N X,X1,X2 S DIXR=643 D C31X1(U) K X2 M X2=X D C31X1("O") K X1 M X1=X
 I $G(X(1))]"" D
 . K ^DPT("APTYPE",X,DA)
 K X M X=X2 I $G(X(1))]"" D
 . S ^DPT("APTYPE",X,DA)=""
 G C31F2
C31X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2,DIIENS,391,DION),$P($G(^DPT(DA,"TYPE")),U,1))
 S X=$G(X(1))
 Q
C31F2 Q
X31 Q
32 D:$D(DG)>9 F^DIE17,DE S DQ=32,DW="VET;1",DV="SX",DU="",DLB="VETERAN (Y/N)?",DIFLD=1901
 S DE(DW)="C32^DVBHCE1"
 S DU="Y:YES;N:NO;"
 G RE
C32 G C32S:$D(DE(32))[0 K DB
 S X=DE(32),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DE(32),DIC=DIE
 S DFN=DA D EN^DGRP7CC
 S X=DE(32),DIC=DIE
 ;
 S X=DE(32),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(32),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF="1901;" D AVAFC^VAFCDD01(DA)
 S X=DE(32),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
C32S S X="" G:DG(DQ)=X C32F1 K DB
 D ^DVBHCE3
C32F1 Q
X32 I $D(X) S:'$D(DPTX) DFN=DA D:'$D(^XUSEC("DG ELIGIBILITY",DUZ)) VAGE^DGLOCK:X="Y" I $D(X) D:$D(DFN) EV^DGLOCK
 Q
 ;
33 D:$D(DG)>9 F^DIE17,DE S DQ=33,DW=".3;1",DV="SX",DU="",DLB="SERVICE CONNECTED?",DIFLD=.301
 S DE(DW)="C33^DVBHCE1"
 S DU="Y:YES;N:NO;"
 G RE
C33 G C33S:$D(DE(33))[0 K DB
 S X=DE(33),DIC=DIE
 ;
 S X=DE(33),DIC=DIE
 ;
 S X=DE(33),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(33),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".301;" D AVAFC^VAFCDD01(DA)
 S X=DE(33),DIC=DIE
 D:($T(ADGRU^DGRUDD01)'="") ADGRU^DGRUDD01(DA)
C33S S X="" G:DG(DQ)=X C33F1 K DB
 D ^DVBHCE4
C33F1 Q
X33 S DFN=DA D EV^DGLOCK I $D(X),X="Y" D VET^DGLOCK
 Q
 ;
34 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=34 D X34 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X34 I X="N" S Y="@2063"
 Q
35 S DQ=36 ;@2063
36 D:$D(DG)>9 F^DIE17,DE S DQ=36,DW=".36;1",DV="*P8'X",DU="",DLB="PRIMARY ELIGIBILITY CODE",DIFLD=.361
 S DE(DW)="C36^DVBHCE1",DE(DW,"INDEX")=1
 S DU="DIC(8,"
 G RE
C36 G C36S:$D(DE(36))[0 K DB
 D ^DVBHCE5
C36S S X="" G:DG(DQ)=X C36F1 K DB
 D ^DVBHCE6
C36F1 N X,X1,X2 S DIXR=840 D C36X1(U) K X2 M X2=X D C36X1("O") K X1 M X1=X
 D
 . D FC^DGFCPROT(.DA,2,.361,"KILL",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 K X M X=X2 D
 . D FC^DGFCPROT(.DA,2,.361,"SET",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 G C36F2
C36X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2,DIIENS,.361,DION),$P($G(^DPT(DA,.36)),U,1))
 S X=$G(X(1))
 Q
C36F2 Q
X36 S DFN=DA D EV^DGLOCK I $D(X) D ECD^DGLOCK1
 Q
 ;
37 S DQ=38 ;@206
38 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=38 D X38 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X38 I Z2'[3 S Y="@104"
 Q
39 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=39 D X39 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X39 S DVBSCR=1 D ^DVBHS5 S DVBJ2=1
 Q
40 D:$D(DG)>9 F^DIE17 G ^DVBHCE7
