PSIVQUI ;BIR/RGY,MLM-HANDLE QUICK CODE ENTRIES ;15 Dec 98 / 8:29 AM
 ;;5.0;INPATIENT MEDICATIONS;**21,50,65,73,76,93,104,110,275**;16 DEC 97;Build 157
 ;
 ;Reference to ^PS(51.1 is supported by DBIA 2177
 ;Reference to ^PS(51.2 is supported by DBIA 2178
 ;Reference to ^PS(52.6 is supported by DBIA 1231
 ;Reference to ^PS(52.7 is supported by DBIA 2173
 ;
 N X,PSIVSC1 S (PSIVAT,PSIVAAT,PSIVWAT)="",PSIVQUIY=Y,(X,PSIVQUIX)=PSIVX
 Q:'Y!(PSIVQUIX="")  S PSIVX0=$O(^PS(52.6,"C",X,+Y,0)),PSIVX0=$G(^PS(52.6,+Y,1,PSIVX0,0))
 I $P(PSIVX0,"^",5)]""!$P(PSIVX0,"^",6)!(P(5)) S PSIVAAT=$P(PSIVX0,"^",6)
 K PSIVX0 S Y=PSIVQUIY,Y(0)=$G(^PS(52.6,+Y,0)),X=PSIVQUIX
 Q:$S('$D(X):1,'$D(^PS(52.6,"C",X)):1,1:0)!'$D(P(4))
SET K DRG S PSIVX0=$S($D(^PS(52.6,+Y,1,+$O(^PS(52.6,"C",X,+Y,0)),0)):^(0),1:""),(DRGI,DRG("AD",0))=1,TDRG("AD",+Y,DRGI)="",DRG("AD",DRGI)=+Y_U_$P(Y(0),U)_U_$P(PSIVX0,"^",2)_U_U_$P(Y(0),U,13)_U_$P(Y(0),U,11)
 N PSIVQZ,PSIVADD0,PSIVSZ,PSIVAZ,PSIVXAT,PSIVSIEN,PSIVXW S PSIVSIEN=0
 I $P(PSIVX0,U,4)]"" S P("OPI")=$P(PSIVX0,U,4) K ^PS(53.45,+$G(PSJSYSP),6) S ^PS(53.45,+$G(PSJSYSP),6,0)="^^1^1^",^(1,0)=P("OPI")
 I $P(PSIVX0,U,7)?1N.N D  Q:$G(PSGORQF)
 . S ND=$G(^PS(52.7,$P(PSIVX0,U,7),0))
 . W !!,"SOLUTION: ",$P(ND,U),!
 . N FIL S FIL="52.7",DRGTMP=$P(PSIVX0,U,7) D ORDERCHK^PSIVEDRG(DFN,ON55,1)
 . I $G(PSGORQF) S X="^",DONE=1 Q
 . S DRG("SOL",0)=1,DRG("SOL",1)=$P(PSIVX0,U,7)_U_$P(ND,U)_U_$P(ND,U,3)_U_U_$P(ND,U,13)_U_$P(ND,U,11),TDRG("SOL",$P(PSIVX0,U,7),1)=""
 I $P(PSIVX0,U,5)]""!P(5) S X=$P(PSIVX0,U,5)
 S PSIVQZ=$P(PSIVX0,U,5),PSIVQAZ=$P(PSIVX0,U,6),PSIVADD0=$G(^PS(52.6,+PSIVQUIY,0)),X=PSIVQZ
 S PSIVSZ=$P(PSIVADD0,"^",5),PSIVAZ=$P(PSIVADD0,"^",6)
 S PSIVAAT=$S(PSIVQZ]""&(PSIVQAZ]""):PSIVQAZ,PSIVQZ=""&(PSIVSZ]""):PSIVAZ,PSIVQZ=PSIVSZ:PSIVAZ,1:"")
 I $P(PSIVX0,U,5)']""!P(5) S X=$S(X]"":X,1:$P($G(^PS(52.6,+PSIVQUIY,0)),"^",5))
 ;
 ; If a sched was found, check all matching schedules 
 ; in 51.1 against $P(PSIVX0,"^",5), PSIVAAT, PSIVWAT
 I PSIVQZ]"",$G(X)'="" S ZZ=0 D
 .;if ZZ sched/times matches quick code sched/times, use the schedule
 .F  S ZZ=$O(^PS(51.1,"AC","PSJ",X,ZZ)) Q:'ZZ!PSIVSIEN  D  Q:PSIVSIEN
 ..N PSIVXAT S PSIVXAT=$P(^PS(51.1,ZZ,0),"^",2) Q:PSIVXAT=""
 ..I PSIVXAT=$P(PSIVX0,"^",6) S PSIVAT=$P(PSIVX0,"^",6),PSIVSIEN=ZZ
 ;
 ; If quick code has no schedule, check IV additive
 I PSIVAT="",$P(PSIVX0,"^",5)="",$G(X)'="" S ZZ=0 D 
 .F  S ZZ=$O(^PS(51.1,"AC","PSJ",X,ZZ)) Q:'ZZ!PSIVSIEN  D  Q:PSIVSIEN
 ..N PSIVXAT S PSIVXAT=$P(^PS(51.1,ZZ,0),"^",2) Q:PSIVXAT=""
 ..I PSIVAAT=PSIVXAT,(X=PSIVSZ) S PSIVAT=PSIVAAT,PSIVSIEN=ZZ
 .I PSIVAT="",PSIVAAT]"" S PSIVAT=PSIVAAT,$P(PSIVX0,"^",6)=PSIVAAT,$P(PSIVX0,"^",5)=PSIVSZ,PSIVSIEN=-1
 ;
 ; If quick code has schedule, no admin times, use ward times
 I PSIVAT="",PSIVQZ]"",$G(X)'="" D
 .S PSIVXW=$S($G(WSCHADM):WSCHADM,$G(VAIN(4)):+VAIN(4),1:"") Q:'PSIVXW
 .S ZZ=0 F  S ZZ=$O(^PS(51.1,"AC","PSJ",X,ZZ)) Q:'ZZ!PSIVSIEN  D  Q:PSIVSIEN
 ..N PSIVXAT S PSIVXAT=$P(^PS(51.1,ZZ,0),"^",2) Q:PSIVXAT=""
 ..S PSIVWAT=$P($G(^PS(51.1,ZZ,1,+PSIVXW,0)),"^",2)
 ..I PSIVWAT]"" S PSIVAT=PSIVWAT,PSIVSIEN=ZZ
 ;
 ; No ward times; go back to IV additive. If quick code has schedule,
 ; make sure it matches IV additive
 I PSIVAT="",PSIVAAT]"",PSIVWAT="",$G(X) D
 .S ZZ=0 F  S ZZ=$O(^PS(51.1,"AC","PSJ",X,ZZ)) Q:'ZZ!PSIVSIEN  D  Q:PSIVSIEN
 ..N PSIVXAT S PSIVXAT=$P(^PS(51.1,ZZ,0),"^",2) Q:PSIVXAT=""
 ..I (PSIVQZ=X&(PSIVQZ=PSIVSZ))!(PSIVQZ=""&(PSIVSZ]"")) I PSIVXAT=PSIVAAT D  Q
 ...S PSIVAT=PSIVAAT,PSIVSIEN=ZZ
 .I PSIVAT="" S PSIVAT=PSIVAAT,$P(PSIVX0,"^",6)=PSIVAAT,$P(PSIVX0,"^",5)=X,PSIVSIEN=-1
 I $G(PSIVSIEN) S Y=$S(PSIVSIEN>0:PSIVSIEN,1:"") N PSGOES S PSGOES=1
 I X="" S (Y,PSIVQUIY)=""
 S PSIVSPQF=1 D EN^PSIVSP K PSIVSPQF
 S P(11)=$S($P(PSIVX0,"^",6)]"":$P(PSIVX0,"^",6),(PSIVQZ]""&(PSIVWAT]"")):PSIVWAT,PSIVAAT]"":PSIVAAT,$G(P(11))]"":$G(P(11)),1:PSIVAT)
 S X=$P(PSIVX0,"^",3)
 I $P(PSIVX0,U,8) D
 .S P("MR")=+$P(PSIVX0,U,8)_U_$S($P($G(^PS(51.2,+$P(PSIVX0,U,8),0)),U,3):$P($G(^PS(51.2,+$P(PSIVX0,U,8),0)),U,3),1:$E($P($G(^PS(51.2,+$P(PSIVX0,U,8),0)),U),1,5))
 W " ",X D ENI^PSIVSP I '$D(X) W $C(7),"  --> Invalid infusion rate !!" I '$$SCHREQ^PSJLIVFD(.P) S P(15)=0
 I $$SCHREQ^PSJLIVFD(.P),'$$DOW^PSIVUTL($G(P(9))),'(P(15)>0) S P(15)=$$INTERVAL^PSIVUTL(.P)
 S PSIVOK="57^58^59^3^26^39^63^64^"_$S($E(P("OT"))="I":"101^109^",1:"")_"10^25^1"
 S P(17)="A",P(8)=$S($D(X):X,1:""),PSIVE=0,PSIVSTR="QUICK CODE",(DRG(2),Y)="",EDIT=$S(+P("MR"):"",1:"3^")_$P(EDIT,"64^",2) K ND,PSIVX0,PSIVSC,PSIVX
 Q
