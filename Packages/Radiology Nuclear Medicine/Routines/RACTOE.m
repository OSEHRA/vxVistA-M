RACTOE ; GENERATED FROM 'RA ORDER EXAM' INPUT TEMPLATE(#1087), FILE 75.1;05/26/08
 D DE G BEGIN
DE S DIE="^RAO(75.1,",DIC=DIE,DP=75.1,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^RAO(75.1,DA,""))=""
 I $D(^(0)) S %Z=^(0) S %=$P(%Z,U,2) S:%]"" DE(2)=% S %=$P(%Z,U,3) S:%]"" DE(25)=% S %=$P(%Z,U,8) S:%]"" DE(11)=%
 I $D(^(.1)) S %Z=^(.1) S %=$P(%Z,U,1) S:%]"" DE(27)=%
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
BEGIN S DNM="RACTOE",DQ=1
 N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 M DIEZAR=^DIE(1087,"AR") S DICRREC="TRIG^DIE17"
 S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_",",DIEZ=1087,U="^"
1 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=1 D X1 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X1 I '$D(RACAT)!('$D(RADFN))!('$D(RADIV))!('$D(RALIFN))!('$D(RAPIFN)) W !?3,$C(7),"Variables RACAT,RADFN,RADIV,RALIFN and RAPIFN must be defined!" S Y="@999"
 Q
2 S DW="0;2",DV="*P71'XR",DU="",DLB="PROCEDURE",DIFLD=2
 S DE(DW)="C2^RACTOE"
 S DU="RAMIS(71,"
 S X=$S($D(^RAMIS(71,RAPRI,0)):$P(^(0),U),1:"")
 S Y=X
 G Y
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 K:$P(^RAO(75.1,DA,0),"^",21) ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),X,9999999.9999-$P(^(0),U,21),DA)
C2S S X="" G:DG(DQ)=X C2F1 K DB
 S X=DG(DQ),DIC=DIE
 S:$P(^RAO(75.1,DA,0),"^",21) ^RAO(75.1,"AP",+$P(^RAO(75.1,DA,0),U),X,9999999.9999-$P(^(0),U,21),DA)=""
C2F1 Q
X2 S DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X D:$D(X) ORDPRC^RAUTL2
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S RAPRI=X
 Q
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 S RAIMAG=$$ITYPE^RASITE(+RAPRI)
 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 S Y=$S('$D(^RA(79,+RADIV,.1)):"@2",$P(^(.1),"^",7)="Y"&($P(^RAMIS(71,RAPRI,0),"^",6)="B"):"@1",1:"@2")
 Q
6 S DQ=7 ;@1
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 W !?3,$C(7),"A 'detailed' procedure or a 'series' of procedures is required!" S Y=""
 Q
8 S DQ=9 ;@2
9 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=9 D X9 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X9 I $O(^RAMIS(71,RAPRI,3,0)) D EN2^RAPRI
 Q
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I $P(^RAMIS(71,RAPRI,0),"^",11)'="y" S Y="@3"
 Q
11 D:$D(DG)>9 F^DIE17,DE S DQ=11,DW="0;8",DV="*P200'XR",DU="",DLB="APPROVING RAD/NUC MED PHYS",DIFLD=8
 S DU="VA(200,"
 G RE
X11 S DIC("S")="I $S('$D(^(""RA"")):1,'$P(^(""RA""),U,3):1,DT'>$P(^(""RA""),U,3):1,1:0),$D(^VA(200,""ARC"",""S"",+Y))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
12 S DQ=13 ;@3
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 I '$D(RAMOD) S Y="@7"
 Q
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S RAI=""
 Q
15 S DQ=16 ;@5
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S RAI=$O(RAMOD(0)) I 'RAI S Y="@7"
 Q
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 S RAMODPRO=+$O(^RAMIS(71.2,"B",$G(RAMOD(RAI)),0))
 Q
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 S:'$D(^RAMIS(71.2,"AB",+$$ITYPE^RASITE(RAPRI),RAMODPRO)) Y="@8"
 Q
19 S D=0 K DE(1) ;125
 S DIFLD=125,DGO="^RACTOE1",DC="1^75.1125PA^M^",DV="75.1125M*P71.2'X",DW="0;1",DOW="PROCEDURE MODIFIERS",DLB="Select "_DOW S:D DC=DC_D
 S DU="RAMIS(71.2,"
 G RE:D I $D(DSC(75.1125))#2,$P(DSC(75.1125),"I $D(^UTILITY(",1)="" X DSC(75.1125) S D=$O(^(0)) S:D="" D=-1 G M19
 S D=$S($D(^RAO(75.1,DA,"M",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M19 I D>0 S DC=DC_D I $D(^RAO(75.1,DA,"M",+D,0)) S DE(19)=$P(^(0),U,1)
 S X=RAMOD(RAI)
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
R19 D DE
 G A
 ;
20 S DQ=21 ;@8
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 K RAMOD(RAI) S Y="@5"
 Q
22 S DQ=23 ;@7
23 S D=0 K DE(1) ;125
 S DIFLD=125,DGO="^RACTOE2",DC="1^75.1125PA^M^",DV="75.1125M*P71.2'X",DW="0;1",DOW="PROCEDURE MODIFIERS",DLB="Select "_DOW S:D DC=DC_D
 S DU="RAMIS(71.2,"
 G RE:D I $D(DSC(75.1125))#2,$P(DSC(75.1125),"I $D(^UTILITY(",1)="" X DSC(75.1125) S D=$O(^(0)) S:D="" D=-1 G M23
 S D=$S($D(^RAO(75.1,DA,"M",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M23 I D>0 S DC=DC_D I $D(^RAO(75.1,DA,"M",+D,0)) S DE(23)=$P(^(0),U,1)
 G RE
R23 D DE
 S D=$S($D(^RAO(75.1,DA,"M",0)):$P(^(0),U,3,4),1:1) G 23+1
 ;
24 S DQ=25 ;@9
25 S DW="0;3",DV="P79.2'",DU="",DLB="TYPE OF IMAGING",DIFLD=3
 S DU="RA(79.2,"
 S X=$P(RAIMAG,U)
 S Y=X
 S X=Y,DB(DQ)=1,DE(DW,"4/")="" G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD:X="@",Z
X25 Q
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 D X26 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X26 S RACOMENT="reason for study (RAREAST) is required with patch 75" K RACOMENT
 Q
27 S DW=".1;1",DV="RF",DU="",DLB="REASON FOR STUDY",DIFLD=1.1
 S X=RAREAST
 S Y=X
 G Y
X27 K:$L(X)>64!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
28 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=28 D X28 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X28 S RACOMENT="Clinical History is not longer required with patch 75." K RACOMENT
 Q
29 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=29 D X29 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X29 I $D(^RA(79,+RADIV,"HIS")) W !!?3,$C(7),^("HIS"),!
 Q
30 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=30 D X30 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X30 I $O(^TMP($J,"RAWP",0)) S ^RAO(75.1,DA,"H",0)=^(0) F RAI=1:1 Q:'$D(^TMP($J,"RAWP",RAI,0))  S ^RAO(75.1,DA,"H",RAI,0)=^(0)
 Q
31 S DQ=32 ;@10
32 D:$D(DG)>9 F^DIE17 G ^RACTOE3