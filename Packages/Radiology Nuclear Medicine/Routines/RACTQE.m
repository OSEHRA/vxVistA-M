RACTQE ; GENERATED FROM 'RA QUICK EXAM ORDER' INPUT TEMPLATE(#1086), FILE 75.1;12/30/15
 D DE G BEGIN
DE S DIE="^RAO(75.1,",DIC=DIE,DP=75.1,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RAO(75.1,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(2)=%,DE(9)=% S %=$P(%Z,U,3) S:%]"" DE(62)=% S %=$P(%Z,U,4) S:%]"" DE(26)=% S %=$P(%Z,U,8) S:%]"" DE(14)=% S %=$P(%Z,U,12) S:%]"" DE(28)=% S %=$P(%Z,U,13) S:%]"" DE(31)=%
 I  S %=$P(%Z,U,14) S:%]"" DE(63)=% S %=$P(%Z,U,20) S:%]"" DE(49)=%,DE(54)=%,DE(58)=% S %=$P(%Z,U,21) S:%]"" DE(39)=%,DE(42)=%,DE(45)=%
 I $D(^(.1)) S %Z=^(.1) S %=$P(%Z,U,1) S:%]"" DE(34)=%
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
BEGIN S DNM="RACTQE",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(1086,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=1086,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I '$D(RAPRI) S Y="@10"
 Q
2 S DW="0;2",DV="*P71'X",DU="",DLB="PROCEDURE",DIFLD=2
 S DE(DW)="C2^RACTQE"
 S DU="RAMIS(71,"
 S X=RAPRI
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 K:$P(^RAO(75.1,DA,0),"^",21) ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),X,9999999.9999-$P(^(0),U,21),DA)
C2S S X="" G:DG(DQ)=X C2F1 K DB
 S X=DG(DQ),DIC=DIE
 S:$P(^RAO(75.1,DA,0),"^",21) ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),X,9999999.9999-$P(^(0),U,21),DA)=""
C2F1 Q
X2 Q
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S RAIMAG=$$ITYPE^RASITE(+RAPRI)
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 S Y="@20"
 Q
5 S DQ=6 ;@10
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 D ^RAPRI
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S:'$D(RAPRI) Y="@99"
 Q
8 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=8 D X8 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X8 S:$E(RAPRI)="^"!('RAPRI) Y="@99"
 Q
9 D:$D(DG)>9 F^DIE17,DE S DQ=9,DW="0;2",DV="*P71'X",DU="",DLB="PROCEDURE",DIFLD=2
 S DE(DW)="C9^RACTQE"
 S DU="RAMIS(71,"
 S X=RAPRI
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
C9 G C9S:$D(DE(9))[0 K DB
 S X=DE(9),DIC=DIE
 K:$P(^RAO(75.1,DA,0),"^",21) ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),X,9999999.9999-$P(^(0),U,21),DA)
C9S S X="" G:DG(DQ)=X C9F1 K DB
 S X=DG(DQ),DIC=DIE
 S:$P(^RAO(75.1,DA,0),"^",21) ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),X,9999999.9999-$P(^(0),U,21),DA)=""
C9F1 Q
X9 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S RAIMAG=$$ITYPE^RASITE(+RAPRI)
 Q
11 S DQ=12 ;@20
12 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=12 D X12 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X12 I $O(^RAMIS(71,RAPRI,3,0)) D EN2^RAPRI
 Q
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 I $S('$D(^RAMIS(71,RAPRI,0)):1,1:$P(^(0),"^",11)'="y") S Y="@23"
 Q
14 D:$D(DG)>9 F^DIE17,DE S DQ=14,DW="0;8",DV="*P200'XR",DU="",DLB="APPROVING RAD/NUC MED PHYS",DIFLD=8
 S DU="VA(200,"
 G RE
X14 S DIC("S")="I $S('$D(^(""RA"")):1,'$P(^(""RA""),U,3):1,DT'>$P(^(""RA""),U,3):1,1:0),$D(^VA(200,""ARC"",""S"",+Y))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
15 S DQ=16 ;@23
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 I '$D(RAMOD) S Y="@35"
 Q
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 S RAI=""
 Q
18 S DQ=19 ;@25
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 S RAI=$O(RAMOD(0)) I 'RAI S Y="@35"
 Q
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 S RAMODPRO=+$O(^RAMIS(71.2,"B",$G(RAMOD(RAI)),0))
 Q
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 S:'$D(^RAMIS(71.2,"AB",+$$ITYPE^RASITE(RAPRI),RAMODPRO)) Y="@30"
 Q
22 S D=0 K DE(1) ;125
 S DIFLD=125,DGO="^RACTQE1",DC="1^75.1125PA^M^",DV="75.1125M*P71.2'X",DW="0;1",DOW="PROCEDURE MODIFIERS",DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 S DU="RAMIS(71.2,"
 G RE:D I $D(DSC(75.1125))#2,$P(DSC(75.1125),"I $D(^UTILITY(",1)="" X DSC(75.1125) S D=$O(^(0)) S:D="" D=-1 G M22
 S D=$S($D(^RAO(75.1,DA,"M",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M22 I D>0 S DC=DC_D I $D(^RAO(75.1,DA,"M",+D,0)) S DE(22)=$P(^(0),U,1)
 S X=RAMOD(RAI)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
R22 D DE
 G A
 ;
23 S DQ=24 ;@30
24 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=24 D X24 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X24 K RAMOD(RAI) S Y="@25"
 Q
25 S DQ=26 ;@35
26 S DW="0;4",DV="SX",DU="",DLB="CATEGORY OF EXAM",DIFLD=4
 S DU="I:INPATIENT;O:OUTPATIENT;C:CONTRACT;S:SHARING;E:EMPLOYEE;R:RESEARCH;"
 S X=$E(RACAT)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X26 Q
27 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=27 D X27 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X27 I '$D(RAPREOP1) S Y="@40"
 Q
28 S DW="0;12",DV="D",DU="",DLB="PRE-OP SCHEDULED DATE/TIME",DIFLD=12
 S X=RAPREOP1
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X28 S %DT="TX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
29 S DQ=30 ;@40
30 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=30 D X30 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X30 I '$D(RAPREG) S Y="@50"
 Q
31 S DW="0;13",DV="RS",DU="",DLB="PREGNANT",DIFLD=13
 S DU="y:YES;n:NO;u:UNKNOWN;"
 S X=RAPREG
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
X31 Q
32 S DQ=33 ;@50
33 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=33 D X33 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X33 S RACOMENT="reason for study is required, clinical history is not with the release of 75" K RACOMENT
 Q
34 S DW=".1;1",DV="RF",DU="",DLB="REASON FOR STUDY",DIFLD=1.1
 S X=RAREAST
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X34 Q
35 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=35 D X35 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X35 I $O(^TMP($J,"RAWP",0)) S ^RAO(75.1,DA,"H",0)=^(0) F RAI=1:1 Q:'$D(^TMP($J,"RAWP",RAI,0))  S ^RAO(75.1,DA,"H",RAI,0)=^(0)
 Q
36 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=36 D X36 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X36 I $O(^RAO(75.1,DA,"H",0)) D UPDT^RAUTL3("^RAO(75.1,"_DA_",""H"",")
 Q
37 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=37 D X37 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X37 S:($D(RAWHEN)#2)&($G(RADR1)) Y="@550"
 Q
38 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=38 D X38 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X38 S:$D(RAWHEN)#2 Y="@545"
 Q
39 S DW="0;21",DV="DR",DU="",DLB="DATE DESIRED (Not guaranteed)",DIFLD=21
 S DE(DW)="C39^RACTQE"
 G RE
C39 G C39S:$D(DE(39))[0 K DB
 S X=DE(39),DIC=DIE
 K ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),+$P(^(0),U,2),9999999.9999-$E(X,1,30),DA)
C39S S X="" G:DG(DQ)=X C39F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),+$P(^(0),U,2),9999999.9999-$E(X,1,30),DA)=""
C39F1 Q
X39 S %DT="ETX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
40 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=40 D X40 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X40 S Y="@560"
 Q
41 S DQ=42 ;@545
42 D:$D(DG)>9 F^DIE17,DE S DQ=42,DW="0;21",DV="DR",DU="",DLB="DATE DESIRED (Not guaranteed)",DIFLD=21
 S DE(DW)="C42^RACTQE"
 S X=RAWHEN
 S Y=X
 G Y
C42 G C42S:$D(DE(42))[0 K DB
 S X=DE(42),DIC=DIE
 K ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),+$P(^(0),U,2),9999999.9999-$E(X,1,30),DA)
C42S S X="" G:DG(DQ)=X C42F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),+$P(^(0),U,2),9999999.9999-$E(X,1,30),DA)=""
C42F1 Q
X42 S %DT="ETX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
43 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=43 D X43 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X43 S Y="@560"
 Q
44 S DQ=45 ;@550
45 D:$D(DG)>9 F^DIE17,DE S DQ=45,DW="0;21",DV="DR",DU="",DLB="DATE DESIRED (Not guaranteed)",DIFLD=21
 S DE(DW)="C45^RACTQE"
 S X=RAWHEN
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C45 G C45S:$D(DE(45))[0 K DB
 S X=DE(45),DIC=DIE
 K ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),+$P(^(0),U,2),9999999.9999-$E(X,1,30),DA)
C45S S X="" G:DG(DQ)=X C45F1 K DB
 S X=DG(DQ),DIC=DIE
 S ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),+$P(^(0),U,2),9999999.9999-$E(X,1,30),DA)=""
C45F1 Q
X45 S %DT="TX" D ^%DT S X=Y K:Y<1 X
 Q
 ;
46 S DQ=47 ;@560
47 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=47 D X47 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X47 S:$D(RAEXMUL)#2 RAWHEN=$$FMTE^XLFDT(X,1)
 Q
48 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=48 D X48 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X48 I $S('$D(RAILOC):1,'RAILOC:1,1:0) S Y="@60"
 Q
49 D:$D(DG)>9 F^DIE17,DE S DQ=49,DW="0;20",DV="*P79.1'",DU="",DLB="IMAGING LOCATION",DIFLD=20
 S DU="RA(79.1,"
 S X=RAILOC
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X49 Q
50 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=50 D X50 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X50 S Y="@70"
 Q
51 S DQ=52 ;@60
52 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=52 D X52 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X52 S RAREQLOC=$$ILOC^RAUTL18(RAPRI)
 Q
53 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=53 D X53 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X53 I 'RAREQLOC S Y="@62"
 Q
54 S DW="0;20",DV="*P79.1'",DU="",DLB="IMAGING LOCATION",DIFLD=20
 S DU="RA(79.1,"
 S X=RAREQLOC
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X54 Q
55 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=55 D X55 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X55 S Y="@67"
 Q
56 S DQ=57 ;@62
57 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=57 D X57 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X57 I '$D(RALOCFLG) S Y="@70"
 Q
58 S DW="0;20",DV="*P79.1'R",DU="",DLB="SUBMIT REQUEST TO",DIFLD=20
 S DU="RA(79.1,"
 G RE
X58 S DIC("S")="I $$SUBMIT^RAUTL13(DA,+Y)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
59 S DQ=60 ;@67
60 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=60 D X60 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X60 S:$D(RAEXMUL) RAILOC=X
 Q
61 S DQ=62 ;@70
62 S DW="0;3",DV="P79.2'",DU="",DLB="TYPE OF IMAGING",DIFLD=3
 S DU="RA(79.2,"
 S X=$P(RAIMAG,U)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X62 Q
63 S DW="0;14",DV="R*P200'X",DU="",DLB="REQUESTING PHYSICIAN",DIFLD=14
 S DU="VA(200,"
 S X=RAPIFN
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X63 Q
64 D:$D(DG)>9 F^DIE17 G ^RACTQE2
