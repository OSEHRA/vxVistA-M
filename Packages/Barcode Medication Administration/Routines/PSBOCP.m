PSBOCP ;BIRMINGHAM/TEJ-COVERSHEET PRN OVERVIEW REPORT ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**32**;Mar 2004;Build 32
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; File 4/10090
EN ; Entry Point
 N PSBX1X,RESULTS,RESULT,PSBFUTR
 S PSBFUTR=$TR(PSBRPT(1),"~","^")
 S (PSBOCRIT,PSBXFLG,PSBCFLG)=""        ;  Order Status search criteria - "A"ctive, "D"C ed, "E"xpired"
 S:$P(PSBFUTR,U,7) PSBOCRIT=PSBOCRIT_"D" S:$P(PSBFUTR,U,8) PSBOCRIT=PSBOCRIT_"E" S:$P(PSBFUTR,U,5) PSBOCRIT=PSBOCRIT_"A"
 S:$P(PSBFUTR,U,4) PSBOCRIT=PSBOCRIT_"F"
 S:$P(PSBFUTR,U,11) PSBXFLG=1
 I $D(PSBRPT(.2)) I $P(PSBRPT(.2),U,8) S PSBCFLG=1
 K PSBSRTBY,PSBCMT,PSBADM,PSBDATA,PSBOUTP,PSBLGD
 S PSBSORT=1
 D NOW^%DTC S (Y,PSBNOWX)=% D DD^%DT S PSBDTTM=Y
 D GETPAR^PSBPAR("ALL","PSB ADMIN BEFORE")
 S PSBB4=0 S:RESULTS(0)>0 PSBB4=+RESULTS(0)
 D GETPAR^PSBPAR("ALL","PSB ADMIN AFTER")
 S PSBAFT=0 S:RESULTS(0)>0 PSBAFT=+RESULTS(0)
 K ^XTMP("PSBO",$J,"PSBLIST")
 S (PSBPGNUM,PSBLNTOT,PSBTOT,PSBX1X)=""
 K PSBLIST,PSBLIST2
 S PSBXDFN=$P(PSBRPT(.1),U,2)
 S PSBLIST(PSBXDFN)=""
 S (PSBX1X,PSBTOT)=0
 F  S PSBX1X=$O(PSBLIST(PSBX1X)) Q:+PSBX1X=0  D
 .D RPC^PSBCSUTL(.PSBAREA,PSBX1X)
 .M PSBDATA=@PSBAREA
 .S PSBX2X=1
 .S (PSBLIST2("ACTIVE"),PSBLIST2("FUTURE"),PSBLIST2("EXPIRED/DC'd"),PSBLIST2(" * ERROR * "))=0
 .F  S PSBX2X=$O(PSBDATA(PSBX2X)) Q:+PSBX2X=0  D
 ..S PSBDATA=PSBDATA(PSBX2X)
 ..I ($P(PSBDATA,U)="ORD") I $P(PSBDATA,U,6)'="P" F  S PSBX2X=$O(PSBDATA(PSBX2X)) S PSBDATA=PSBDATA(PSBX2X) Q:$P(PSBDATA,U)="END"
 ..I ($P(PSBDATA,U)="ORD") K PSBORDN  D  Q
 ...K PSBDRUGN
 ...S PSBSCHTY="P"
 ...S PSBORDN=$P(PSBDATA,U,3)
 ...S PSBTB=$P(PSBDATA,U,29) S PSBTB=$S(PSBTB=1:"UD",PSBTB=2:"IVPB",PSBTB=3:"IV",1:" * ERROR * ")
 ...S PSBTB(PSBORDN,PSBTB)=""
 ...S PSBSTS1=$P(PSBDATA,U,23)
 ...S PSBSTS=$S((PSBSTS1="A")&(($P(PSBDATA,U,27)>PSBNOWX)):"Active",PSBSTS1="H":"Hold",PSBSTS1="D":"Discontinued",PSBSTS1="DE":"Discontinued (Edit)",(PSBSTS1="E")!($P(PSBDATA,U,27)'>PSBNOWX):"Expired",1:" * ERROR * ")
 ...S PSBSTS(PSBORDN,PSBSTS)=""
 ...S V=$$FMADD^XLFDT(PSBNOWX,,,PSBB4)
 ...S PSBSTSX=$S($P(PSBDATA,U,27)'>PSBNOWX:"EXPIRED/DC'd",$P(PSBDATA,U,22)'>V:"ACTIVE",V:"FUTURE",1:" * ERROR * ")
 ...S PSBLIST2(PSBSTSX,$P(PSBDATA,U,9),PSBORDN)="" S PSBLIST2(PSBSTSX)=PSBLIST2(PSBSTSX)+1
 ...S:PSBOCRIT[$E(PSBSTSX,1) PSBTOT=PSBTOT+1
 ...S PSBSCHTY(PSBORDN,PSBSCHTY)=""
 ...S PSBDOSR=$P(PSBDATA,U,10)_", "_$P(PSBDATA,U,11)
 ...S PSBDOSR=$TR($E(PSBDOSR,1)," ")_$E(PSBDOSR,2,999)
 ...S PSBDOSR(PSBORDN,PSBDOSR)=""
 ...S PSBLSTG=$P(PSBDATA,U,28)
 ...I PSBLSTG]"" S PSBLSTG(PSBORDN,$$FMTDT^PSBOCE1($E(PSBLSTG,1,12)))=""
 ...S PSBLSTX=$S(PSBLSTG]"":$$LSTX(PSBLSTG,PSBNOWX),1:" ")
 ...S PSBLSTX(PSBORDN,PSBLSTX)=""
 ...; ** SPECIAL INSTRUCTIONS  **
 ...S PSBX2X=PSBX2X+1
 ...S PSBSI=$P(PSBDATA(PSBX2X),U,2)
 ...I PSBSI]" " S PSBSI(PSBORDN,PSBSI)=""
 ...S PSBOSTDT=$P(PSBDATA,U,22)
 ...S PSBOSTDT(PSBORDN,PSBOSTDT)=""
 ...S PSBOSPDT=$P(PSBDATA,U,27)
 ...S PSBOSPDT(PSBORDN,PSBOSPDT)=""
 ..Q:'$D(PSBORDN)
 ..I "^DD^ADD^SOL"[(U_$P(PSBDATA(PSBX2X),U)) D  Q
 ...F I=PSBX2X:1 S PSBDATA1=PSBDATA(I) D  Q:$D(PSBOMDR(PSBORDN))
 ....I "^DD^ADD^SOL"[(U_$P(PSBDATA1,U)) S PSBX2X=I S PSBDRUGN=$G(PSBDRUGN,"")_$P(PSBDATA1,U,3)_", " Q
 ....S $E(PSBDRUGN,$L(PSBDRUGN)-1)="" S PSBDRUGN(PSBORDN,$E(PSBDRUGN,1,250))=PSBDRUGN
 ....S PSBOMDR(PSBORDN,$E((PSBDRUGN_"; "_PSBDOSR),1,250))=PSBDRUGN_"; "_PSBDOSR
 ..I $P(PSBDATA,U)="END" Q
 ..Q:'$D(PSBORDN)
 ..I $P(PSBDATA(PSBX2X),U)="ORF" D  Q
 ...S PSBDATA=PSBDATA(PSBX2X)
 ...S:$P(PSBDATA,U,2)]"" PSBFLGD(PSBORDN,$P(PSBDATA,U,3)_" - "_$P(PSBDATA,U,4))=""
 ..Q:'$D(PSBORDN)
 ..I ($P(PSBDATA,U)="ADM")&($P(PSBDATA,U,4)]"") D  Q
 ...S PSBXID=$P(PSBDATA,U,6)_U_$P(PSBDATA,U,4),PSBADM(PSBORDN,(-1*($P(PSBDATA,U,6))),PSBXID)=PSBDATA
 ...I $O(PSBSCHTY(PSBORDN,""))="P" S PSBPRNR(PSBORDN,$P(PSBDATA,U,4))=$P(PSBDATA,U,9)
 ...I $P(PSBDATA,U,3)]"" S PSBBID(PSBORDN,$P(PSBDATA,U,4))=$P(PSBDATA,U,3)
 ...S:PSBXFLG PSBLGD(PSBORDN,"X","INITIALS",$P(PSBDATA,U,8))=""
 ...I $P(PSBDATA(PSBX2X+1),U)="CMT"  S PSBX2X=PSBX2X+1 F PSBX3X=PSBX2X:1 S PSBDATA=PSBDATA(PSBX3X) Q:($P(PSBDATA,U)'="CMT")  D
 ....S PSBX2X=PSBX3X
 ....I $P(PSBDATA,U,3)]"" S PSBPRNEF(PSBORDN,$P(PSBXID,U,2))=$P(PSBDATA,U,3)
 ....I PSBCFLG I $P(PSBDATA,U,2)'="" S PSBLGD(PSBORDN,"C","INITIALS",$P(PSBDATA,U,4))="",PSBCMT(PSBORDN,$P(PSBXID,U,2),(-1*$P(PSBDATA,U,6)))=PSBDATA
 I +PSBTOT=0 K PSBLIST,^XTMP("PSBO",$J,"PSBLIST")
 D CREATHDR^PSBOCP1
 D SUBHDR^PSBOCE
 D BLDRPT
 D WRTRPT^PSBOCP1
 Q
BLDRPT ; Buld REPORT DATA
 K PSBL2ULN
 S PSBTOPHD=PSBLNTOT-2
 I '$D(PSBLIST2) D  Q
 .S PSBOUTP(0,PSBLNTOT)="W !!,""<<<< NO ORDERS TO DISPLAY >>>>"",!!"
 S PSBMORE=5 F PSBX1X="ACTIVE","FUTURE","EXPIRED/DC'd"," * ERROR * " D
 .I PSBX1X'=" * ERROR * " S PSBSUM=PSBX1X_" ["_PSBLIST2(PSBX1X)_$S(PSBLIST2(PSBX1X)=1:" Order",1:" Orders")_"]" S PSBOUTP($$PGTOT,PSBLNTOT)="W !!,"""_PSBSUM_""""
 .Q:PSBLIST2(PSBX1X)=0
 .Q:PSBOCRIT'[$E(PSBX1X,1)
 .S:$L(PSBSUM)>$G(PSBL2ULN,0) PSBL2ULN=$L(PSBSUM)
 .S PSBOUTP($$PGTOT(2),PSBLNTOT)="W !,$TR($J("""",PSBL2ULN),"" "",""=""),!"
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !"
 .K PSBDATA
 .S X0="",PSBTOT1=0
 .F  S X0=$O(PSBLIST2(PSBX1X,X0))  Q:X0=""  S PSBX2X="" F  S PSBX2X=$O(PSBLIST2(PSBX1X,X0,PSBX2X)) Q:PSBX2X=""  D
 ..M PSBLGD("INITIALS")=PSBLGD(PSBX2X,"X","INITIALS") M PSBLGD("INITIALS")=PSBLGD(PSBX2X,"C","INITIALS")
 ..S PSBDATA(1,1)=$O(PSBTB(PSBX2X,""))
 ..S PSBDATA(1,2)=$O(PSBSTS(PSBX2X,""))
 ..S PSBDATA(1,3)=$O(PSBSCHTY(PSBX2X,""))
 ..S Y0=$O(PSBOMDR(PSBX2X,"")) I Y0]"" S PSBDATA(1,4)="("_X0_")",PSBDATA(1,4,0)=PSBOMDR(PSBX2X,Y0)
 ..S PSBDATA(1,5)=$O(PSBLSTG(PSBX2X,""))
 ..S PSBDATA(1,6)=$O(PSBLSTX(PSBX2X,""))
 ..S PSBDATA(1,7)=$$FMTDT^PSBOCE1($O(PSBOSTDT(PSBX2X,"")))
 ..S PSBDATA(1,8)=$$FMTDT^PSBOCE1($E($O(PSBOSPDT(PSBX2X,"")),1,12))
 ..S PSBSIDAT(1)=$O(PSBSI(PSBX2X,""))
 ..S PSBTOT1=PSBTOT1+1
 ..K PSBDATA(2),PSBDATA(3),PSBSILN
 ..D BUILDLN,SIOPI^PSBOCM(.PSBSIDAT,PSBTAB8,$S(PSBX2X["V":"Other Print Info:",1:""))
 ..I $D(PSBRPLN) S PSBMORE=$O(PSBRPLN(""),-1)+6 I $D(PSBSILN) S PSBMORE=PSBMORE+$O(PSBSILN(""),-1)
 ..K PSB1 I $D(PSBFLGD(PSBX2X)) S PSB="" F  S PSB=$O(PSBFLGD(PSBX2X,PSB)) Q:PSB=""  I ($P(PSB,":")'="NOX")&($P(PSB,":")'="STAT") S PSB1=$G(PSB1,"")_PSB
 ..S PSBCNT=PSBTOT1_"   "_$G(PSB1,"")
 ..S PSBOUTP($$PGTOT,PSBLNTOT)="W """_PSBCNT_""""
 ..S I="" F  S I=$O(PSBRPLN(I)) Q:+I=0  D
 ...S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBRPLN(I)_""""
 ..S I="" F  S I=$O(PSBSILN(I)) Q:+I=0  D
 ...S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBSILN(I)_""""
 ..S PSBOUTP($$PGTOT(2),PSBLNTOT)="W !,$TR($J("""",PSBTAB8),"" "",""-""),!"
 ..K PSBRPLN,PSBDATA
 D:+PSBTOT>0 LGD^PSBOCM
 Q
BUILDLN ; Constr recs
 K J S J(0)="" F PSBFLD=1:1:8 S J=1 D FORMDAT(PSBFLD) S J($O(PSBRPLN(""),-1))=""
 ; Write administration info...
 Q:'PSBXFLG
 S J=($O(J(""),-1)+1),PSBRPLN(J)=PSBBLANK,J(J)="",J=J+1
 S (N,Y)=""
 F  S Y=$O(PSBADM(PSBX2X,Y)) Q:Y']""  D
 .F  S N=$O(PSBADM(PSBX2X,Y,N)) Q:N']""  D
 ..I $D(PSBBID(PSBX2X,$P(N,U,2))) S PSBDATA(2,0)="BAG ID: "_PSBBID(PSBX2X,$P(N,U,2))
 ..S $E(PSBDATA(2,0),25)="ACTION BY: "_$P(PSBADM(PSBX2X,Y,N),U,7)_" "_$$FMTDT^PSBOCE1($E($P(PSBADM(PSBX2X,Y,N),U,6),1,12))
 ..S X=$P(PSBADM(PSBX2X,Y,N),U,5) S $E(PSBDATA(2,0),56)="ACTION: "_$S(X="G":"GIVEN",X="R":"REFUSED",X="RM":"REMOVED",X="H":"HELD",X="S":"STOPPED",X="I":"INFUSING",X="C":"COMPLETED",X="M":"MISSING DOSE",X=" ":"*UNKNOWN*",1:" ")
 ..I $D(PSBPRNR(PSBX2X)) S $E(PSBDATA(2,0),72)="PRN REASON: "_PSBPRNR(PSBX2X,$P(N,U,2))
 ..I $G(PSBDATA(2,0))]" " D WRAPPER(1,132-1,PSBDATA(2,0)) K PSBDATA(2) S J=J+1
 ..I $D(PSBPRNEF(PSBX2X,$P(N,U,2))) S PSBDATA(2,0)="PRN EFFECTIVENESS: "_PSBPRNEF(PSBX2X,$P(N,U,2))
 ..I $G(PSBDATA(2,0))]" " D WRAPPER(30,132-30,PSBDATA(2,0)) K PSBDATA(2) S J=J+1
 ..I ('PSBCFLG)!('$D(PSBCMT(PSBX2X,$P(N,U,2)))) S PSBRPLN(J)=PSBBLANK,J(J)="",J=J+1 Q
 ..S X="" F   S X=$O(PSBCMT(PSBX2X,$P(N,U,2),X)) Q:X']""  D
 ...S PSBDATA(2,0)="COMMENT BY: "_$S($P(PSBCMT(PSBX2X,$P(N,U,2),X),U,5)]"":$P(PSBCMT(PSBX2X,$P(N,U,2),X),U,5)_" "_$$FMTDT^PSBOCE1($E($P(PSBCMT(PSBX2X,$P(N,U,2),X),U,6),1,12)),1:" n/a ")
 ...S PSBDATA(2,0)=PSBDATA(2,0)_"  COMMENT: "_$S($P(PSBCMT(PSBX2X,$P(N,U,2),X),U,2)]"":$P(PSBCMT(PSBX2X,$P(N,U,2),X),U,2),1:" ")
 ...I $G(PSBDATA(2,0))]" " D WRAPPER(30,132-30,PSBDATA(2,0)) K PSBDATA(2) S J=J+1
 ..S PSBRPLN(J)=PSBBLANK,J(J)="",J=J+1
 Q
FORMDAT(FLD) ;
 K PSBVAL
 Q:'$D(PSBDATA(1,FLD))
 S PSBVAL=PSBDATA(1,FLD)
 D WRAPPER(@("PSBTAB"_(FLD-1))+1,((@("PSBTAB"_(FLD))-(@("PSBTAB"_(FLD-1))+1))),PSBVAL)
 I FLD=4 S J=$O(J(""),-1)+1,PSBVAL=PSBDATA(1,4,0) D WRAPPER(@("PSBTAB"_(FLD-1))+1,((@("PSBTAB"_(FLD))-(@("PSBTAB"_(FLD-1))+1))),PSBVAL)
 Q
PGTOT(X) ;mnt PAGE Number
 I (PSBLNTOT+PSBMORE)>(IOSL) D PGC^PSBOCE1
 I $G(X,1) S PSBLNTOT=PSBLNTOT+$G(X,1),PSBMORE=PSBMORE-$G(X,1)
 Q PSBPGNUM
WRAPPER(X,Y,Z) ;  Text WRAP
 N PSB
 I ($L(Z)>0),$F(Z,"""")>1 F  Q:$F(Z,"""")'>1  S Z=$TR(Z,"""","^")
 F  Q:'$L(Z)  D
 .I $L(Z)<Y S $E(PSBRPLN(J),X)=Z S Z="" Q
 .F PSB=Y:-1:0 Q:$E(Z,PSB)=" "
 .S:PSB<1 PSB=Y
 .S $E(PSBRPLN(J),X)=$E(Z,1,PSB)
 .I $L(PSBRPLN(J),"^")>1 F X=1:1:$L(PSBRPLN(J),"^")-1 S $P(PSBRPLN(J),"^",X)=$P(PSBRPLN(J),"^",X)_""""
 .S PSBRPLN(J)=$TR(PSBRPLN(J),"^","""")
 .S Z=$E(Z,PSB+1,250),J=J+1,J(J)=""
 Q ""
LSTX(P,O) ;
 S DT=$$FMDIFF^XLFDT(O,P,2)
 I ((DT\60)<1) Q "0d 0h 1m"
 S D=(DT\(60*60*24)) S DT=DT-(D*(60*60*24))
 S H=(DT\(60*60)) S DT=DT-(H*(60*60))
 S M=((DT+30)\(60)) S DT=DT-(M*(60))
 Q D_"d "_H_"h "_M_"m"