RACTWR ; GENERATED FROM 'RA REPORT EDIT' INPUT TEMPLATE(#1069), FILE 74;12/30/15
 D DE G BEGIN
DE S DIE="^RARPT(",DIC=DIE,DP=74,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RARPT(DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,5) S:%]"" DE(33)=%,DE(42)=%,DE(44)=% S %=$P(%Z,U,6) S:%]"" DE(3)=% S %=$P(%Z,U,8) S:%]"" DE(8)=% S %=$P(%Z,U,9) S:%]"" DE(47)=%
 I $D(^("P")) S %Z=^("P") S %=$E(%Z,1,240) S:%'?." " DE(34)=%
 I $D(^("T")) S %Z=^("T") S %=$P(%Z,U,1) S:%]"" DE(4)=%
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
BEGIN S DNM="RACTWR",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(1069,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=1069,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I '$D(RACT) W !?3,$C(7),"Variable RACT must be defined to continue!" S Y="@99"
 Q
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S:RACT'="I" Y="@10"
 Q
3 S DW="0;6",DV="D",DU="",DLB="DATE REPORT ENTERED",DIFLD=6
 S X="NOW"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X3 S %DT="STX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
4 S DW="T;1",DV="*P200'",DU="",DLB="TRANSCRIPTIONIST",DIFLD=11
 S DE(DW)="C4^RACTWR"
 S DU="VA(200,"
 S X=DUZ
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C4 G C4S:$D(DE(4))[0 K DB
 S X=DE(4),DIC=DIE
 K:$P($G(^RARPT(DA,0)),U,6)]"" ^RARPT("AD",$E(X,1,30),$P(^RARPT(DA,0),U,6),DA)
C4S S X="" G:DG(DQ)=X C4F1 K DB
 S X=DG(DQ),DIC=DIE
 S:$P($G(^RARPT(DA,0)),U,6)]"" ^RARPT("AD",$E(X,1,30),$P(^RARPT(DA,0),U,6),DA)=""
C4F1 Q
X4 Q
5 S DQ=6 ;@10
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 S RATRSC=$P(^RARPT(DA,"T"),U)
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 I $D(RARPDT) I (RADTE\1)>(($E(RARPDT,7,10)-1700)_$E(RARPDT,1,2)_$E(RARPDT,4,5)) K RARPDT
 Q
8 D:$D(DG)>9 F^DIE17,DE S DQ=8,DW="0;8",DV="DX",DU="",DLB="REPORTED DATE",DIFLD=8
 S X=$S($D(RARPDT):RARPDT,1:"")
 S Y=X
 G Y
X8 S %DT="EX",%DT(0)=$P($G(^RARPT(D0,0)),U,3)\1 D ^%DT K %DT(0) S X=Y K:Y<1 X
 Q
 ;
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 S:X?7N RARPDT=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3))
 Q
10 S DQ=11 ;@15
11 S D=0 K DE(1) ;100
 S DIFLD=100,DGO="^RACTWR1",DC="10^74.01DA^L^",DV="74.01RD",DW="0;1",DOW="LOG DATE",DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 I $D(DSC(74.01))#2,$P(DSC(74.01),"I $D(^UTILITY(",1)="" X DSC(74.01) S D=$O(^(0)) S:D="" D=-1 G M11
 S D=$S($D(^RARPT(DA,"L",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M11 I D>0 S DC=DC_D I $D(^RARPT(DA,"L",+D,0)) S DE(11)=$P(^(0),U,1)
 S X="""NOW"""
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
R11 D DE
 G A
 ;
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 S:RACT="V" Y="@99"
 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 W !,"------------------------------------------------------------------------------"
 Q
14 S DQ=15 ;@1
15 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=15 D X15 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X15 D CHPRINT^RAUTL9
 Q
16 S D=0 K DE(1) ;400
 S Y="ADDITIONAL CLINICAL HISTORY^W^^0;1^Q",DG="H",DC="^74.04" D DIEN^DIWE K DE(1) G A
 ;
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 S RANODE="H"
 Q
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 I $O(^RARPT(DA,RANODE,0)) D UPDT^RAUTL3("^RARPT("_DA_","""_RANODE_""",")
 Q
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 W !,"------------------------------------------------------------------------------"
 Q
20 S DQ=21 ;@2
21 S D=0 K DE(1) ;200
 S Y="REPORT TEXT^W^^0;1^Q",DG="R",DC="^74.02" D DIEN^DIWE K DE(1) G A
 ;
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 D X22 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X22 S RANODE="R" D EXIST^RAUTL9
 Q
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 I $O(^RARPT(DA,RANODE,0)) D UPDT^RAUTL3("^RARPT("_DA_","""_RANODE_""",")
 Q
24 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=24 D X24 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X24 W !,"------------------------------------------------------------------------------"
 Q
25 S DQ=26 ;@3
26 S D=0 K DE(1) ;300
 S Y="IMPRESSION TEXT^W^^0;1^Q",DG="I",DC="^74.03" D DIEN^DIWE K DE(1) G A
 ;
27 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=27 D X27 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X27 S RANODE="I" D EXIST^RAUTL9
 Q
28 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=28 D X28 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X28 I $O(^RARPT(DA,RANODE,0)) D UPDT^RAUTL3("^RARPT("_DA_","""_RANODE_""",")
 Q
29 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=29 D X29 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X29 W !,"------------------------------------------------------------------------------"
 Q
30 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=30 D X30 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X30 I $O(^RARPT(DA,"I",0))>0 S Y=$S($D(RAONLINE):"@99",1:"@30")
 Q
31 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=31 D X31 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X31 I $D(^RADPT(+$P(^RARPT(DA,0),U,2),"DT",(9999999.9999-$P(^RARPT(DA,0),U,3)),0)),$D(^RA(79,+$P(^(0),U,3),.1)),$P(^(.1),U,16)'["Y" S Y=$S($D(RAONLINE):"@99",1:"@30")
 Q
32 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=32 D X32 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X32 I '$O(^RARPT(DA,"R",0)) S Y="@99"
 Q
33 S DW="0;5",DV="RSX",DU="",DLB="REPORT STATUS",DIFLD=5
 S DE(DW)="C33^RACTWR"
 S DU="V:VERIFIED;R:RELEASED/NOT VERIFIED;PD:PROBLEM DRAFT;D:DRAFT;EF:ELECTRONICALLY FILED;X:DELETED;"
 S Y="PROBLEM DRAFT"
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C33 G C33S:$D(DE(33))[0 K DB
 S X=DE(33),DIC=DIE
 X "D ^RABUL2 Q"
 S X=DE(33),DIC=DIE
 N RAXREF K RASET S RAXREF="ARES",RARAD=12,RAKILL="" D XREF^RAUTL2 S RASECOND="SRR" D SECXREF^RADD1 K RAKILL,RARAD
 S X=DE(33),DIC=DIE
 N RAXREF K RASET S RAXREF="ASTF",RARAD=15,RAKILL="" D XREF^RAUTL2 S RASECOND="SSR" D SECXREF^RADD1 K RAKILL,RARAD
 S X=DE(33),DIC=DIE
 K ^RARPT("ASTAT",$E(X,1,30),DA)
C33S S X="" G:DG(DQ)=X C33F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 N RAXREF K RAKILL I X'="V"&(X'="X") S RAXREF="ARES",RARAD=12,RASET="" D XREF^RAUTL2 S RASECOND="SRR" D SECXREF^RADD1 K RARAD,RASET
 S X=DG(DQ),DIC=DIE
 N RAXREF K RAKILL I X'="V"&(X'="X") S RAXREF="ASTF",RARAD=15,RASET="" D XREF^RAUTL2 S RASECOND="SSR" D SECXREF^RADD1 K RARAD,RASEC
 S X=DG(DQ),DIC=DIE
 S:"Vv"'[$E(X) ^RARPT("ASTAT",$E(X,1,30),DA)=""
C33F1 Q
X33 D EN1^RAUTL4
 Q
 ;
34 D:$D(DG)>9 F^DIE17,DE S DQ=34,DW="P;E1,240",DV="F",DU="",DLB="PROBLEM STATEMENT",DIFLD=25
 S Y="No Impression was entered for this report."
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X34 K:$L(X)>240!($L(X)<2) X
 I $D(X),X'?.ANP K X
 Q
 ;
35 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=35 D X35 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X35 W !!?3,$C(7),"NOTE: This report does not have an impression.  As a result,",!?3,"      the report will be placed in a 'PROBLEM DRAFT' status",!?3,"      with an appropriate 'PROBLEM STATEMENT' entered as well.",!
 Q
36 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=36 D X36 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X36 S Y="@99"
 Q
37 S DQ=38 ;@30
38 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=38 D X38 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X38 D EN1^RAUTL9
 Q
39 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=39 D X39 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X39 S:'$D(DIRUT) Y="@40"
 Q
40 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=40 D X40 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X40 D:$D(DIE("NO^"))&($G(DIE("NO^"))'="OUTOK")&($G(DIE("NO^"))'="BACKOUTOK") EN^DDIOL("EXIT NOT ALLOWED ??"_$C(7),"","!!?3")
 Q
41 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=41 D X41 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X41 S:$D(DIE("NO^"))&($G(DIE("NO^"))'="OUTOK")&($G(DIE("NO^"))'="BACKOUTOK") Y="@30"
 Q
42 S DW="0;5",DV="RSX",DU="",DLB="REPORT STATUS",DIFLD=5
 S DE(DW)="C42^RACTWR"
 S DU="V:VERIFIED;R:RELEASED/NOT VERIFIED;PD:PROBLEM DRAFT;D:DRAFT;EF:ELECTRONICALLY FILED;X:DELETED;"
 S X="^"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C42 G C42S:$D(DE(42))[0 K DB
 S X=DE(42),DIC=DIE
 X "D ^RABUL2 Q"
 S X=DE(42),DIC=DIE
 N RAXREF K RASET S RAXREF="ARES",RARAD=12,RAKILL="" D XREF^RAUTL2 S RASECOND="SRR" D SECXREF^RADD1 K RAKILL,RARAD
 S X=DE(42),DIC=DIE
 N RAXREF K RASET S RAXREF="ASTF",RARAD=15,RAKILL="" D XREF^RAUTL2 S RASECOND="SSR" D SECXREF^RADD1 K RAKILL,RARAD
 S X=DE(42),DIC=DIE
 K ^RARPT("ASTAT",$E(X,1,30),DA)
C42S S X="" G:DG(DQ)=X C42F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 N RAXREF K RAKILL I X'="V"&(X'="X") S RAXREF="ARES",RARAD=12,RASET="" D XREF^RAUTL2 S RASECOND="SRR" D SECXREF^RADD1 K RARAD,RASET
 S X=DG(DQ),DIC=DIE
 N RAXREF K RAKILL I X'="V"&(X'="X") S RAXREF="ASTF",RARAD=15,RASET="" D XREF^RAUTL2 S RASECOND="SSR" D SECXREF^RADD1 K RARAD,RASEC
 S X=DG(DQ),DIC=DIE
 S:"Vv"'[$E(X) ^RARPT("ASTAT",$E(X,1,30),DA)=""
C42F1 Q
X42 D EN1^RAUTL4
 Q
 ;
43 S DQ=44 ;@40
44 D:$D(DG)>9 F^DIE17,DE S DQ=44,DW="0;5",DV="RSX",DU="",DLB="REPORT STATUS",DIFLD=5
 S DE(DW)="C44^RACTWR"
 S DU="V:VERIFIED;R:RELEASED/NOT VERIFIED;PD:PROBLEM DRAFT;D:DRAFT;EF:ELECTRONICALLY FILED;X:DELETED;"
 S X=RASTATX
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C44 G C44S:$D(DE(44))[0 K DB
 S X=DE(44),DIC=DIE
 X "D ^RABUL2 Q"
 S X=DE(44),DIC=DIE
 N RAXREF K RASET S RAXREF="ARES",RARAD=12,RAKILL="" D XREF^RAUTL2 S RASECOND="SRR" D SECXREF^RADD1 K RAKILL,RARAD
 S X=DE(44),DIC=DIE
 N RAXREF K RASET S RAXREF="ASTF",RARAD=15,RAKILL="" D XREF^RAUTL2 S RASECOND="SSR" D SECXREF^RADD1 K RAKILL,RARAD
 S X=DE(44),DIC=DIE
 K ^RARPT("ASTAT",$E(X,1,30),DA)
C44S S X="" G:DG(DQ)=X C44F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 N RAXREF K RAKILL I X'="V"&(X'="X") S RAXREF="ARES",RARAD=12,RASET="" D XREF^RAUTL2 S RASECOND="SRR" D SECXREF^RADD1 K RARAD,RASET
 S X=DG(DQ),DIC=DIE
 N RAXREF K RAKILL I X'="V"&(X'="X") S RAXREF="ASTF",RARAD=15,RASET="" D XREF^RAUTL2 S RASECOND="SSR" D SECXREF^RADD1 K RARAD,RASEC
 S X=DG(DQ),DIC=DIE
 S:"Vv"'[$E(X) ^RARPT("ASTAT",$E(X,1,30),DA)=""
C44F1 Q
X44 D EN1^RAUTL4
 Q
 ;
45 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=45 D X45 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X45 S:RASTATX="V" RACT=RASTATX S:RASTATX'="V" Y=$S($E(RASTATX)="P":"@50",1:"@99") I $E(RASTATX)'="P" K ^RARPT(DA,"P")
 Q
46 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=46 D X46 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X46 I X="V",'$D(^XUSEC("RA VERIFY",DUZ)) W !!,$C(7),"You do not have the appropriate privileges to verify a report." S Y="@35"
 Q
47 D:$D(DG)>9 F^DIE17,DE S DQ=47,DW="0;9",DV="*P200'X",DU="",DLB="VERIFYING PHYSICIAN",DIFLD=9
 S DU="VA(200,"
 S X=$S($D(RAELESIG):"`"_DUZ,1:"")
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X47 S DIC("S")="N RAINADT X ^DD(74,9,9.2) I $S('RAINADT:1,DT'>RAINADT:1,1:0),$D(^XUSEC(""RA VERIFY"",+Y)),($D(^VA(200,""ARC"",""R"",+Y))!($D(^VA(200,""ARC"",""S"",+Y))))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
48 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=48 D X48 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X48 S:$D(RAELESIG) Y="@33"
 Q
49 D:$D(DG)>9 F^DIE17 G ^RACTWR2
