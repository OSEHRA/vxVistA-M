ICDDRG5 ;ALB/GRR/EG/MRY/ADL - FIX SURGERY HIERARCHY ;3/20/03 10:36am
 ;;18.0;DRG Grouper;**2,5,7,10,20,22,31,37,64**;Oct 20, 2000;Build 103
 ;
 Q:$O(ICDODRG(0))'>0  K ICDJ,ICDJJ F ICDJ=0:0 S ICDJ=$O(ICDODRG(ICDJ)) Q:ICDJ'>0  S ICDJJ(ICDJ)="" D
 .I ICDDATE<3051001 D F Q
 .E  I ICDDATE<3071001 D FY2007 Q
 .E  I ICDDATE<3081001 D FY2008 Q
 .E  D FY2009
END S ICDJ=$O(ICDJ(0)) Q:ICDJ'>0  S ICDJ=ICDJ(ICDJ) K ICDODRG S ICDODRG(ICDJ)="" Q
F I ICDJ=103 S ICDJ(1)=ICDJ Q
 I ICDJ=525 S ICDJ(2)=ICDJ Q
 I ICDJ=104 S ICDJ(3)=ICDJ Q
 I ICDJ=535 S ICDJ(4)=ICDJ Q
 I ICDJ=536 S ICDJ(5)=ICDJ Q
 I ICDJ=515 S ICDJ(6)=ICDJ Q
 I ICDJ=108 S ICDJ(7)=ICDJ Q
 I ICDJ=106 S ICDJ(8)=ICDJ Q
 I ICDJ=110 S ICDJ(9)=ICDJ Q
 I ICDJ=111 S ICDJ(10)=ICDJ Q
 I ICDJ=113 S ICDJ(11)=ICDJ Q
 I ICDJ=115 S ICDJ(12)=ICDJ Q
 I ICDJ=116 S ICDJ(13)=ICDJ Q
 I ICDJ=526 S ICDJ(14)=ICDJ Q
 I ICDJ=527 S ICDJ(15)=ICDJ Q
 I ICDJ=516 S ICDJ(16)=ICDJ Q
 I ICDJ=517 S ICDJ(17)=ICDJ Q
 I ICDJ=518 S ICDJ(18)=ICDJ Q
 I ICDJ=478 S ICDJ(19)=ICDJ Q
 I ICDJ=479 S ICDJ(20)=ICDJ Q
 ;I ICDJ=112 S ICDJ(13)=ICDJ Q
 I ICDJ=114 S ICDJ(21)=ICDJ Q
 I ICDJ=118 S ICDJ(22)=ICDJ Q
 I ICDJ=117 S ICDJ(23)=ICDJ Q
 I ICDJ=119 S ICDJ(24)=ICDJ Q
 I ICDJ=120 S ICDJ(25)=ICDJ
 Q
FY2007 ;
 I ICDJ=103 S ICDJ(1)=ICDJ Q
 I ICDJ=525 S ICDJ(2)=ICDJ Q
 I ICDJ=104 S ICDJ(3)=ICDJ Q
 I ICDJ=535 S ICDJ(4)=ICDJ Q
 I ICDJ=536 S ICDJ(5)=ICDJ Q
 I ICDJ=515 S ICDJ(6)=ICDJ Q
 I ICDJ=108 S ICDJ(7)=ICDJ Q
 I ICDJ=106 S ICDJ(8)=ICDJ Q
 I ICDJ=110 S ICDJ(9)=ICDJ Q
 I ICDJ=111 S ICDJ(10)=ICDJ Q
 I ICDJ=547 S ICDJ(11)=ICDJ Q
 I ICDJ=548 S ICDJ(12)=ICDJ Q
 I ICDJ=549 S ICDJ(13)=ICDJ Q
 I ICDJ=550 S ICDJ(14)=ICDJ Q
 I ICDJ=113 S ICDJ(15)=ICDJ Q
 I ICDJ=551 S ICDJ(16)=ICDJ Q
 I ICDJ=552 S ICDJ(17)=ICDJ Q
 I ICDJ=557 S ICDJ(18)=ICDJ Q
 I ICDJ=555 S ICDJ(19)=ICDJ Q
 I ICDJ=558 S ICDJ(20)=ICDJ Q
 I ICDJ=556 S ICDJ(21)=ICDJ Q
 I ICDJ=518 S ICDJ(22)=ICDJ Q
 I ICDJ=553 S ICDJ(23)=ICDJ Q
 I ICDJ=554 S ICDJ(24)=ICDJ Q
 I ICDJ=478 S ICDJ(25)=ICDJ Q
 I ICDJ=479 S ICDJ(26)=ICDJ Q
 I ICDJ=114 S ICDJ(27)=ICDJ Q
 I ICDJ=118 S ICDJ(28)=ICDJ Q
 I ICDJ=117 S ICDJ(29)=ICDJ Q
 I ICDJ=119 S ICDJ(30)=ICDJ Q
 I ICDJ=120 S ICDJ(31)=ICDJ
 Q
FY2008 ;
 I ICDJ=215 S ICDJ(1)=ICDJ Q
 I ICDJ=221 S ICDJ(2)=ICDJ Q
 I ICDJ=223 S ICDJ(3)=ICDJ Q
 I ICDJ=225 S ICDJ(4)=ICDJ Q
 I ICDJ=227 S ICDJ(5)=ICDJ Q
 I ICDJ=230 S ICDJ(6)=ICDJ Q
 I ICDJ=232 S ICDJ(7)=ICDJ Q
 I ICDJ=234 S ICDJ(8)=ICDJ Q
 I ICDJ=236 S ICDJ(9)=ICDJ Q
 I ICDJ=238 S ICDJ(10)=ICDJ Q
 I ICDJ=241 S ICDJ(11)=ICDJ Q
 I ICDJ=244 S ICDJ(12)=ICDJ Q
 I ICDJ=245 S ICDJ(13)=ICDJ Q
 I ICDJ=247 S ICDJ(14)=ICDJ Q
 I ICDJ=249 S ICDJ(15)=ICDJ Q
 I ICDJ=251 S ICDJ(16)=ICDJ Q
 I ICDJ=254 S ICDJ(17)=ICDJ Q
 I ICDJ=257 S ICDJ(18)=ICDJ Q
 I ICDJ=259 S ICDJ(19)=ICDJ Q
 I ICDJ=262 S ICDJ(20)=ICDJ Q
 I ICDJ=263 S ICDJ(21)=ICDJ Q
 I ICDJ=264 S ICDJ(22)=ICDJ Q
 Q
FY2009 ;
 I ICDJ=215 S ICDJ(1)=ICDJ Q
 I ICDJ=221 S ICDJ(2)=ICDJ Q
 I ICDJ=223 S ICDJ(3)=ICDJ Q
 I ICDJ=225 S ICDJ(4)=ICDJ Q
 I ICDJ=227 S ICDJ(5)=ICDJ Q
 I ICDJ=230 S ICDJ(6)=ICDJ Q
 I ICDJ=232 S ICDJ(7)=ICDJ Q
 I ICDJ=234 S ICDJ(8)=ICDJ Q
 I ICDJ=236 S ICDJ(9)=ICDJ Q
 I ICDJ=238 S ICDJ(10)=ICDJ Q
 I ICDJ=241 S ICDJ(11)=ICDJ Q
 I ICDJ=244 S ICDJ(12)=ICDJ Q
 I ICDJ=245 S ICDJ(13)=ICDJ Q
 I ICDJ=265 S ICDJ(14)=ICDJ Q
 I ICDJ=247 S ICDJ(15)=ICDJ Q
 I ICDJ=249 S ICDJ(16)=ICDJ Q
 I ICDJ=251 S ICDJ(17)=ICDJ Q
 I ICDJ=254 S ICDJ(18)=ICDJ Q
 I ICDJ=257 S ICDJ(19)=ICDJ Q
 I ICDJ=259 S ICDJ(20)=ICDJ Q
 I ICDJ=262 S ICDJ(21)=ICDJ Q
 I ICDJ=263 S ICDJ(22)=ICDJ Q
 I ICDJ=264 S ICDJ(23)=ICDJ Q
 Q
EN1 S (ICDCC3,ICDCC2)=0
 I $D(ICDOP(" 00.50")) S ICDCC3=1
 I $D(ICDOP(" 00.52")) I $D(ICDOP(" 00.53")) S ICDCC3=1
 I $D(ICDOP(" 37.70"))!($D(ICDOP(" 37.71")))!($D(ICDOP(" 37.73"))) D MORE Q
 I $D(ICDOP(" 37.72")) I $D(ICDOP(" 37.80"))!($D(ICDOP(" 37.83"))) S ICDCC3=1 Q
 I $D(ICDOP(" 37.74")) I $D(ICDOP(" 37.80"))!($D(ICDOP(" 37.81")))!($D(ICDOP(" 37.82")))!($D(ICDOP(" 37.83")))!($D(ICDOP(" 37.85")))!($D(ICDOP(" 37.86")))!($D(ICDOP(" 37.87"))) S ICDCC3=1 Q
 I $D(ICDOP(" 37.76")) I $D(ICDOP(" 37.80"))!($D(ICDOP(" 37.85")))!($D(ICDOP(" 37.86")))!($D(ICDOP(" 37.87"))) S ICDCC3=1 Q
 I $D(ICDOP(" 00.53")) I $D(ICDOP(" 37.70"))!($D(ICDOP(" 37.71")))!($D(ICDOP(" 37.72")))!($D(ICDOP(" 37.73")))!($D(ICDOP("37.74 ")))!($D(ICDOP(" 37.76"))) S ICDCC3=1
 I $D(ICDOP(" 00.54"))!$D(ICDOP(" 37.95"))!$D(ICDOP(" 37.96"))!$D(ICDOP(" 37.97"))!$D(ICDOP(" 37.98"))!$D(ICDOP(" 00.52")) S ICDCC2=1
 Q
MORE I $D(ICDOP(" 37.80"))!($D(ICDOP(" 37.81")))!($D(ICDOP(" 37.82")))!($D(ICDOP(" 37.85")))!($D(ICDOP(" 37.86")))!($D(ICDOP(" 37.87"))) S ICDCC3=1 Q
 Q
VALV ;valve procedure
 N ICDTMP
 S (ICDCATH,ICDAJ)="" F ICDI=1:1 Q:'$D(ICDPRC(ICDI))  S ICDAJ=ICDPRC(ICDI),ICDTMP=$$ICDOP^ICDEX(+ICDAJ,$G(ICDDATE),2,"I"),$P(ICDTMP,"^",3)=$TR($P(ICDTMP,"^",3),";",""),ICDY(0)=$S((ICDTMP>0&$P(ICDTMP,U,10)):$P(ICDTMP,U,2,99),1:0) I ICDY(0) D
 . S ICDOP($P(ICDY(0),"^",1))="",ICDCATH=ICDCATH_$P(ICDY(0),"^",2)
 S ICDE1=$S($D(ICDOP(37.95))&($D(ICDOP(37.96))):1,1:0),ICDE2=$S($D(ICDOP(37.97))&($D(ICDOP(37.98))):1,1:0)
 Q
 S:ICDCATH["H" ICDRG=$S(ICDCATH["N"&ICDE1:104,ICDCATH["N"&ICDE2:104,ICDCATH["O":104,1:ICDRG)
 S:ICDCATH'["H" ICDRG=$S(ICDCATH["N"&ICDE1:105,ICDCATH["N"&ICDE2:105,ICDCATH["O":105,1:ICDRG)
 K ICDCATH,ICDAJ,ICDE1,ICDE2,ICDI,ICDOP,ICDY Q
VALV1 ;dx combo's for DRG120
 S ICDE1=$S($D(ICDOP(" 37.95"))&($D(ICDOP(" 37.96"))):1,1:0),ICDE2=$S($D(ICDOP(" 37.97"))&($D(ICDOP(" 37.98"))):1,1:0)
 S ICDRG=$S((ICDE1&(ICDOR["H")):104,(ICDE1&(ICDOR'["H")):105,(ICDE2&(ICDOR["H")):104,(ICDE2&(ICDOR'["H")):105,1:120)
 K ICDE1,ICDE2
 Q
