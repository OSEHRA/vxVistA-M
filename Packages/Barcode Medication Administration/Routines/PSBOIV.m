PSBOIV ;BIRMINGHAM/TEJ-IV BAG STATUS REPORT ;8/30/12 10:56am
 ;;3.0;BAR CODE MED ADMIN;**32,68,70**;Mar 2004;Build 101
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; File 52.6/436
 ; File 52.7/437
 ; File 4/10090
 ; File 2/10035 
 ; GETSIOPI^PSJBCMA5/5763
 ; 
 ;*68 - change to accomodate unlimited lines for SIOPI array
 ;*70 - reset PSBCLINORD = 2 to signify combined orders report
 ;
EN ; Entry
 N PSB1,PSBFUTR,PSBSI,QQ,PSBHDR               ;*70 add psbhdr
 K PSBSRTBY,PSBOCRIT,PSBACRIT,NO S PSBCFLG=0
 S PSBFUTR=$TR(PSBRPT(1),"~","^")
 I $D(PSBRPT(.2)) I $P(PSBRPT(.2),U,8) S PSBCFLG=1
 S PSBDTST=+$P(PSBRPT(.1),U,6)+$P(PSBRPT(.1),U,7)
 S PSBDTSP=+$P(PSBRPT(.1),U,8)+$P(PSBRPT(.1),U,9)
 S PSBOCRIT=""        ;  Ord Sttus "A"ctive, "D"C ed, "E"xprd"
 S:$P(PSBFUTR,U,5) PSBOCRIT=PSBOCRIT_"A"
 S:$P(PSBFUTR,U,7) PSBOCRIT=PSBOCRIT_"D"
 S:$P(PSBFUTR,U,8) PSBOCRIT=PSBOCRIT_"E"
 S PSBACRIT=""        ;  Actn Sttus "C"ompl, "I"nfusi, "M"issng, "S"tpped, "H"ld, "R"efsd", "N"o Actn
 S:$P(PSBFUTR,U,12) PSBACRIT=PSBACRIT_"I"
 S:$P(PSBFUTR,U,13) PSBACRIT=PSBACRIT_"S"
 S:$P(PSBFUTR,U,14) PSBACRIT=PSBACRIT_"C"
 S:$P(PSBFUTR,U,15) PSBACRIT=PSBACRIT_"N"
 S:$P(PSBFUTR,U,16) PSBACRIT=PSBACRIT_"M"
 S:$P(PSBFUTR,U,17) PSBACRIT=PSBACRIT_"H"
 S:$P(PSBFUTR,U,18) PSBACRIT=PSBACRIT_"R"
 D NOW^%DTC S (Y,PSBXNOW)=% D DD^%DT S:PSBDTSP=0 PSBDTSP=Y S PSBDTTM=Y
 I +PSBDTST=0 S PSBDTST=X S PSBDTST=$$FMADD^XLFDT(PSBDTST,-3)_".0000"
 S (PSBPGNUM,PSBLNTOT,PSBTOT,PSB1)=""
 K PSBLIST,PSBLIST2,PSBBGS,PSBNOX
 S PSBXDFN=$P(PSBRPT(.1),U,2)
 S PSBLIST(PSBXDFN)=""
 S PSB1=$O(PSBLIST("")) I +PSB1'=0  K ^TMP("PSJ",$J) D EN^PSJBCMA(PSB1,PSBDTST,PSBDTST)
 I ^TMP("PSJ",$J,1,0)'=-1 D
 .S PINX=0 F  S PINX=$O(^TMP("PSJ",$J,PINX)) Q:+PINX'>0  D
 ..S PSB2=$P(^TMP("PSJ",$J,PINX,0),U,3)
 ..I PSB2["V" D  Q
 ...; flter critri
 ...D CLEAN^PSBVT,PSJ1^PSBVT(PSB1,PSB2)
 ...Q:$$IVPTAB^PSBVDLU3(PSBOTYP,PSBIVT,PSBISYR,PSBCHEMT,$G(PSBIVPSH,0))
 ...Q:PSBOST>PSBDTSP
 ...I "DE"'[PSBOSTS I PSBOSP'>PSBXNOW S PSBOSTS="E"
 ...Q:PSBOCRIT'[PSBOSTS  ;incl ord stat crit
 ...Q:(PSBOSP<PSBXNOW)&(PSBOCRIT'["E")&(PSBOSTS'="D")
 ...S PSBLIST2(PSB2,"OStart")=PSBOST
 ...S PSBLIST2(PSB2,"OStop")=PSBOSP
 ...S PSBLIST2(PSB2,"OStatus")=$S((PSBOSTS="D"):"Discontinued",(PSBOSTS="DE"):"Discontinued (Edit)",PSBXNOW>PSBOSP:"Expired",PSBOSTS="A":"Active",PSBOSTS="H":"On Hold",1:PSBOSTS)
 ...;  *68
 ...K ^TMP("PSJBCMA5",$J)
 ...I PSBSIFLG D GETSIOPI^PSJBCMA5(PSB1,PSB2,1)
 ...F QQ=0:0 S QQ=$O(^TMP("PSJBCMA5",$J,PSB1,PSB2,QQ)) Q:'QQ  D
 ....S PSBSI(PSB2,QQ)=^TMP("PSJBCMA5",$J,PSB1,PSB2,QQ)
 ...;  *68 end
 ...M PSBLIST2(PSB2,"ADD")=PSBADA
 ...M PSBLIST2(PSB2,"SOL")=PSBSOLA
 ...D EN^PSBPOIV(PSB1,PSB2)
 ...I +$O(^TMP("PSBAR",$J,""))>0 S X="" F  S X=$O(^TMP("PSBAR",$J,X)) Q:+X=0  S PSBBGS(PSB2,X)=$P(^TMP("PSBAR",$J,X),U,2)
 ...D:PSBACRIT["N"
 ....S NO=1
 ....I $D(PSBBGS(PSB2))  S X="" F  S X=$O(PSBBGS(PSB2,X)) Q:+X=0  I PSBBGS(PSB2,X)'="" S NO=0 Q
 ....I $D(^PSB(53.79,"AORDX",PSB1,PSB2)) S NO=0 Q
 ...I $G(NO,0) I PSBOSTS="A" S PSBNOX(PSB2)="",PSBTOT=PSBTOT+1 Q
 ...I $D(^PSB(53.79,"AUID",PSB1,PSB2)) M PSBBGS(PSB2)=^PSB(53.79,"AUID",PSB1,PSB2)
 ...; Get X - "ASSOC BAGS"
 ...S X="" F  S X=$O(PSBBGS(PSB2,X)) Q:+X=0  I $G(PSBBGS(PSB2,X),"")'=""  D
 ....S Y="" F  S Y=$O(^PSB(53.79,"AUID",PSB1,Y)) Q:Y=""  D  Q:Y="DONE"
 .....I $D(^PSB(53.79,"AUID",PSB1,Y,X)) S PSBBGS(PSB2,X,$O(^PSB(53.79,"AUID",PSB1,Y,X,"")))="" S Y="DONE"
 ...S X="" F  S X=$O(PSBBGS(PSB2,X)) Q:+X=0  I $O(PSBBGS(PSB2,X,""))="" K PSBBGS(PSB2,X)
 ...S PSB3="" F  S PSB3=$O(PSBBGS(PSB2,PSB3)) Q:PSB3=""  D
 ....S PSB4="" F  S PSB4=$O(PSBBGS(PSB2,PSB3,PSB4)) Q:+PSB4=0  D
 .....I ($$GET1^DIQ(53.79,PSB4_",",.06,"I")'>PSBDTST)!($$GET1^DIQ(53.79,PSB4_",",.06,"I")'<PSBDTSP) K PSBBGS(PSB2,PSB3) Q
 .....I PSBACRIT'[$$GET1^DIQ(53.79,PSB4_",",.09,"I") K PSBBGS(PSB2,PSB3) Q
 .....S PSBBSTS(PSB2,PSB3,$$GET1^DIQ(53.79,PSB4_",",.09))=$$GET1^DIQ(53.79,PSB4_",",.06,"I"),PSBTOT=PSBTOT+1
 .....I "SI"[$$GET1^DIQ(53.79,PSB4_",",.09,"I") I PSBXNOW>$$FMADD^XLFDT($$GET1^DIQ(53.79,PSB4_",",.06,"I"),,24) S PSB24HR(PSB2,PSB3)=""
 .....I PSBCFLG S PSB5=0 F  S PSB5=$O(^PSB(53.79,PSB4,.3,PSB5)) Q:+PSB5=0  D
 ......I $P(^PSB(53.79,PSB4,.3,PSB5,0),U,3)=$$GET1^DIQ(53.79,PSB4_",",.06,"I") S PSBCMNT(PSB2,PSB3)="Comment: "_$P(^PSB(53.79,PSB4,.3,PSB5,0),U)
 S INX="" F  S INX=$O(PSBLIST2(INX)) Q:INX=""  I '$D(PSBBGS(INX))&'$D(PSBNOX(INX)) K PSBLIST2(INX)
 I +PSBTOT=0 K PSBLIST
 S Y=PSBDTST D DD^%DT S Y1=Y S Y=PSBDTSP D DD^%DT S Y2=Y
 D CREATHDR
 D SUBHDR^PSBOIV1
 D BLDRPT
 D WRTRPT
 K PSBSILN,PSBOUTP,PSBLIST2,PSBCMNT,PSBNOX
 Q
BLDRPT ; Buld Reprt
 S (PSB2,PSB3,PSB4)=""
 S PSBTOPHD=PSBLNTOT
 I '$D(PSBLIST2) D  Q
 .S PSBOUTP(0,14)="W !!,""<<<< NO DATA TO DISPLAY >>>>"",!!"
 S PSBTOT1=0
 K PSBDATA
 K J S J=1
 F  S PSB2=$O(PSBLIST2(PSB2)) Q:+PSB2=0  D
 .S PSBORDX="" S PSBORDX=PSB2
 .S PSBDATA(1)=$$FMTDT^PSBOIV1($E(PSBLIST2(PSB2,"OStart"),1,12))
 .S PSBDATA(2)=$$FMTDT^PSBOIV1($E(PSBLIST2(PSB2,"OStop"),1,12))
 .S PSBDATA(3)=PSBLIST2(PSB2,"OStatus")
 .M PSBDATA(4,"ADD")=PSBLIST2(PSB2,"ADD") I $D(PSBDATA(4,"ADD",1)) S PSBDATA(4)="MED"
 .M PSBDATA(4,"SOL")=PSBLIST2(PSB2,"SOL") I $D(PSBDATA(4,"SOL",1)) S PSBDATA(4)="MED"
 .; Bag(s)
 .I $D(PSBNOX(PSB2)) S PSBFLGD(PSB2," * No Action Taken On Order * ")=""
 .I '$D(PSBNOX(PSB2))!(PSBACRIT["N")  F  S PSB3=$O(PSBBGS(PSB2,PSB3)) Q:+PSB3=0  D
 ..S PSBDATA(5,PSB3)=PSB3
 ..S PSBDATA(6,PSB3)=$O(PSBBSTS(PSB2,PSB3,""))
 ..I $D(PSB24HR(PSB2,PSB3)) S PSBDATA(7,PSB3)=">24h"
 ..I '$D(PSBNOX(PSB2)) S PSBDATA(8,PSB3)=$$FMTDT^PSBOIV1($E(PSBBSTS(PSB2,PSB3,PSBDATA(6,PSB3)),1,12))
 ..E  S PSBDATA(8,PSB3)="No Action On Order"
 .K PSBOPDAT M PSBOPDAT=PSBSI(PSB2)               ;*68
 .S PSBTOT1=PSBTOT1+1
 .K PSBRPLN,PSBSILN
 .D BUILDLN,SIOPI^PSBOCM(.PSBOPDAT,PSBTAB8,"Other Print Info: ")
 .I $D(PSBRPLN) S PSBMORE=$O(PSBRPLN(""),-1)+4 I $D(PSBSILN) S PSBMORE=PSBMORE+$O(PSBSILN(""),-1)
 .S (PSB1,PSB)="" I $D(PSBFLGD(PSB2)) F  S PSB=$O(PSBFLGD(PSB2,PSB)) Q:PSB=""  I ($P(PSB,":")'="STAT") S PSB1=$G(PSB1,"")_PSB
 .S PSBCNT=PSBTOT1_"  ("_PSB2_") "_PSB1,$E(PSBCNT,IOM)="|"
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBCNT_""""
 .F N=$O(PSBRPLN("")):1:$O(PSBRPLN(""),-1)  D
 ..S PSB1X=0 S PSB1X=(($L(PSBRPLN(N),"""")-1)\2) I ($E(PSBRPLN(N),(PSBTAB8)+PSB1X)']" ") S $E(PSBRPLN(N),(PSBTAB8)+PSB1X)="|"
 ..S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBRPLN(N)_""""
 .K PSBRPLN,PSBDATA
 .S I="" F  S I=$O(PSBSILN(I)) Q:+I=0  D
 ..S PSB1X=0 S PSB1X=(($L(PSBSILN(I),"""")-1)\2)
 ..I ($E(PSBSILN(I),(PSBTAB8)+PSB1X)']" ") S $E(PSBSILN(I),(PSBTAB8)+PSB1X)="|"
 ..S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBSILN(I)_""""
 .S PSBOUTP($$PGTOT(2),PSBLNTOT)="W !,$TR($J("""",PSBTAB8),"" "",""-""),!"
 Q
BUILDLN ; Constr recs
 K J,LN S J(0)="" F PSBFLD=1:1:3 I $G(PSBDATA(PSBFLD))]"" S J=1 D FORMDAT^PSBOIV1(PSBFLD) S J=1
 F X=1:1 Q:'$D(PSBDATA(4,"ADD",X))  D
 .S PSBDATA(4)=$P(PSBDATA(4,"ADD",X),U,3)
 .D FORMDAT^PSBOIV1(4)
 .S J=$O(J(""),-1)+1
 F X=1:1 Q:'$D(PSBDATA(4,"SOL",X))  D
 .S PSBDATA(4)=$P(PSBDATA(4,"SOL",X),U,3)
 .D FORMDAT^PSBOIV1(4)
 .S J=$O(J(""),-1)+1
 F PSBFLD=5:1:8 I $D(PSBDATA(PSBFLD)) K J S J=1 D
 .S X="" F  S X=$O(PSBDATA(PSBFLD,X)) Q:+X=0  D
 ..S PSBDATA(PSBFLD)=PSBDATA(PSBFLD,X)
 ..I PSBFLD=5 S LN(X,J)=""
 ..D:PSBFLD'=8 FORMDAT^PSBOIV1(PSBFLD)
 ..S J=$O(J(""),-1)+1
 ..I (PSBCFLG&(PSBFLD=5)),($D(PSBCMNT(PSB2,X))) D WRAPPER^PSBOIV1(PSBTAB4+1,(PSBTAB8-PSBTAB4)-1,PSBCMNT(PSB2,X)),WRAPPER^PSBOIV1(PSBTAB4+1,PSBTAB8-PSBTAB4," ")
 .I PSBFLD=5 F J=1:1:$O(J(""),-1) S PREVLN(J)=$G(PSBRPLN(J),"")
 .I PSBFLD'=5 I $D(PREVLN) S X="" F  S X=$O(LN(X)) Q:X=""  S J=$O(LN(X,"")) D:$D(PSBDATA(PSBFLD,X))
 ..S $E(PREVLN(J),@("PSBTAB"_(PSBFLD-1))+1,@("PSBTAB"_(PSBFLD)))=PSBDATA(PSBFLD,X)
 I $D(PREVLN) F J=1:1:$O(PREVLN(""),-1) S PSBRPLN(J)=PREVLN(J)
 K PREVLN,LN
 Q
WRTRPT ;
 I $O(PSBOUTP(""),-1)<1 D  Q
 .X PSBOUTP($O(PSBOUTP(""),-1),14)
 .D FTR
 S PSBPGNUM=1
 S PSBZ="" F  S PSBZ=$O(PSBOUTP(PSBZ)) Q:PSBZ=""  D
 .I PSBPGNUM'=PSBZ D FTR S PSBPGNUM=PSBZ D HDR,SUBHDR^PSBOIV1
 .S PSB2="" F  S PSB2=$O(PSBOUTP(PSBZ,PSB2)) Q:PSB2=""  D
 ..X PSBOUTP(PSBZ,PSB2)
 D FTR
 Q
HDR ;
 W:$Y>1 @IOF
 W:$X>1 !
 S PSBRPNM="BCMA IV BAG STATUS REPORT"
 S LN=0
 D:$P(PSBRPT(.1),U,1)="P"
 .S LN=LN+1,PSBHDR(LN)=PSBRPNM_" for "_$$FMTE^XLFDT($P(PSBRPT(.1),U,6)+$P(PSBRPT(.1),U,7))_" to "_$$FMTE^XLFDT($P(PSBRPT(.1),U,8)+$P(PSBRPT(.1),U,9))
 .S LN=LN+1,PSBHDR(LN)="Order Status(es): --"
 .F Y=5,7,8 I $P(PSBFUTR,U,Y) S $P(PSBHDR(LN),": ",2)=$P(PSBHDR(LN),": ",2)_$S(PSBHDR(2)["--":"",1:"/ ")_$P("^^^^Active^^DC'd^Expired^^^^^^^^^^",U,Y)_" " S PSBHDR(LN)=$TR(PSBHDR(LN),"-","")
 .S LN=LN+1,PSBHDR(LN)="Bag Status(es): --"
 .F Y=12:1:18 I $P(PSBFUTR,U,Y) S $P(PSBHDR(LN),": ",2)=$P(PSBHDR(LN),": ",2)_$S(PSBHDR(LN)["--":"",1:"/ ")_$P("^^^^^^^^^^^Infusing^Stopped^Completed^No Action Taken^Missing Dose^Held^Refused",U,Y)_" " S PSBHDR(LN)=$TR(PSBHDR(LN),"-","")
 .I PSBCFLG S LN=LN+1,PSBHDR(LN)="Include Comments/Reasons"
 .N PSBCLINORD S PSBCLINORD=2     ;set psbclinord to both ord type *70
 .D PT^PSBOHDR(PSBXDFN,.PSBHDR) W !
 Q
FTR ;
 I (IOSL<100) F  Q:$Y>(IOSL-5)  W !,?(IOM-1),"|"
 S PSBPG="Page: "_PSBPGNUM_" of "_$S($O(PSBOUTP(""),-1)=0:1,1:$O(PSBOUTP(""),-1))
 S PSBPGRM=PSBTAB8-($L(PSBPG))
 D PTFTR^PSBOHDR()
 W !,PSBRPNM,"     ",?(PSBPGRM-($L(PSBDTTM)+3)),PSBDTTM_"  "_PSBPG
 Q
PGTOT(X) ;mnt PAGE Number
 I (PSBLNTOT+PSBMORE)>(IOSL) S PSBPGNUM=PSBPGNUM+1,PSBLNTOT=PSBTOPHD S PSBMORE=$S(PSBMORE>(IOSL-(PSBTOPHD)):(IOSL-(PSBTOPHD)),1:PSBMORE)
 I $G(X,1) S PSBLNTOT=PSBLNTOT+$G(X,1),PSBMORE=PSBMORE-$G(X,1)
 Q PSBPGNUM
CREATHDR ;
 K PSBHD1,PSBHD2
 I IOM'<132 S PSBMORE=4,PSBHD1=$P($T(HD132A),";",2),PSBHD2=$P($T(HD132B),";",2),PSBBLANK=$P($T(H132BLK),";",2)
 E  S PSBHD1="THIS REPORT SUPPORTS >131 CHAR./LINE PRINT FORMATS ONLY" K PSBLIST2 Q
 ; reset tabs
 S PSBTAB0=1 F PSBI=0:1:($L(PSBHD1,"|")-1) S:PSBI>0 @("PSBTAB"_PSBI)=($F(PSBHD1,"|",@("PSBTAB"_(PSBI-1))+1))-1
 S PSBPGNUM=1
 D HDR
 Q
HD132A ;     Order       |       Order       |    Order     |     Medication      |      Bag UID      |    Bag    |     | Action Date/Time |
 Q
HD132B ;   Start Date    |      Stop Date    |    Status    |                     |                   |   Status  |     |                  |
 Q
H132BLK ;;
 Q
