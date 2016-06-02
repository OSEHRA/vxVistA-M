PSBOML ;BIRMINGHAM/EFC-MEDICATION LOG ;11/14/12 11:58am
 ;;3.0;BAR CODE MED ADMIN;**3,11,50,54,70**;Mar 2004;Build 1
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ^DPT/10035
 ; SENDMSG^XMXAPI/2729
 ;
 ;*70 - Add Witness for High Risk Drug to report
 ;    - print Clinic name with each order that occurred in a clinic
 ;    - set psbclinord=2 for dual hdr text
 ;    - create var for Search list and use for both IM & CO, pass to
 ;      PSBOHDR api
 ;    - 1489: Blended PSB*3*54 with PSB*3*70
 ;
EN ; Begin printing
 N PSBSTRT,PSBSTOP,PSBHDR,DFN,PSBSORT,PSBSRCHL
 S PSBSORT=$P(PSBRPT(.1),U,1)                                     ;*70
 S PSBSTRT=$P(PSBRPT(.1),U,6)+$P(PSBRPT(.1),U,7)
 S PSBSTOP=$P(PSBRPT(.1),U,8)+$P(PSBRPT(.1),U,9)
 S PSBAUDF=$P(PSBRPT(.2),U,9)
 S PSBHDR(0)="Medication Log Report"
 S PSBHDR(1)="Continuing/PRN/Stat/One Time Medication/Treatment Record (Detailed Log) (VAF 10-2970 B, C, D)"
 ;DSS/BG - BEGIN MODS - Deveteranize
 I $G(^%ZOSF("ZVX"))["VX" S PSBHDR(1)="Continuing/PRN/Stat/One Time Medication/Treatment Record (Detailed Log)"
 ;DSS/BG - END MOD
 ;check Clinic or Nurs Unit search list                *70
 S PSBSRCHL=$$SRCHLIST^PSBOHDR()
 ;
 ; Patient Report
 ;
 D:PSBSORT="P"
 .S PSBHDR(2)="Log Type: INDIVIDUAL PATIENT"
 .S DFN=+$P(PSBRPT(.1),U,2)
 .W $$PTHDR()
 .S X=$O(^PSB(53.79,"AADT",DFN,PSBSTRT-.0000001))
 .;DSS/RAC - BEGIN MOD - DE9903-Add footer when no data; original commented 
 .;I X>PSBSTOP!(X="") W !!?10,"<<<< NO MEDICATIONS FOUND FOR THIS TIME FRAME >>>>",!! Q
 .I X>PSBSTOP!(X="") W !!?10,"<<<< NO MEDICATIONS FOUND FOR THIS TIME FRAME >>>>",!! W $$PTFTR^PSBOHDR() Q
 .;DSS/RAC - END MOD
 .S PSBGBL=$NAME(^PSB(53.79,"AADT",DFN,PSBSTRT-.0000001))
 .F  S PSBGBL=$Q(@PSBGBL) Q:PSBGBL=""  Q:$QS(PSBGBL,2)'="AADT"!($QS(PSBGBL,3)'=DFN)!($QS(PSBGBL,4)>PSBSTOP)  D
 ..S PSBIEN=$QS(PSBGBL,5) Q:'$D(^PSB(53.79,PSBIEN))
 ..I $P(^PSB(53.79,PSBIEN,0),U,6)'=$QS(PSBGBL,4) Q
 ..I $Y>(IOSL-10) W $$PTFTR^PSBOHDR(),$$PTHDR()
 ..W $$LINE(PSBIEN)
 .W $$PTFTR^PSBOHDR()
 ;
 ; Ward Output
 ;
 D:PSBSORT="W"
 .S PSBHDR(2)="LOG TYPE: WARD"
 .W $$WDHDR(PSBWRD)
 .S PSBTMPG=$NAME(^TMP("PSBO",$J,"B"))
 .F  S PSBTMPG=$Q(@PSBTMPG) Q:PSBTMPG=""  Q:$QS(PSBTMPG,1)'="PSBO"!($QS(PSBTMPG,2)'=$J)  D
 ..S DFN=$QS(PSBTMPG,5)
 ..I $Y>(IOSL-14) W $$WDHDR(PSBWRD)
 ..;DSS/SMP - BEGIN MODS
 ..I $G(^%ZOSF("ZVX"))["VX" D  I 1
 ...W !,$P(^DPT(DFN,0),U),"  (",$$ID^VFDDFN(DFN,,,,1,3),")"
 ..E  W !,$P(^DPT(DFN,0),U),"  (",$P(^(0),U,9),")"
 ..;DSS/SMP - END MODS
 ..W !,"Ward: ",$G(^DPT(DFN,.1),"***"),"  Rm-Bed: ",$G(^DPT(DFN,.101),"***"),!
 ..S X=$O(^PSB(53.79,"AADT",DFN,PSBSTRT-.0000001))
 ..I X>PSBSTOP!(X="") W !!?10,"<<<< NO MEDICATIONS FOUND FOR THIS TIME FRAME >>>>",!! Q
 ..S PSBGBL=$NAME(^PSB(53.79,"AADT",DFN,PSBSTRT-.0000001))
 ..F  S PSBGBL=$Q(@PSBGBL) Q:PSBGBL=""  Q:$QS(PSBGBL,2)'="AADT"!($QS(PSBGBL,3)'=DFN)!($QS(PSBGBL,4)>PSBSTOP)  D
 ...S PSBIEN=$QS(PSBGBL,5) I $P(^PSB(53.79,PSBIEN,0),U,6)'=$QS(PSBGBL,4) Q
 ...W:$Y>(IOSL-10) $$WDHDR(PSBWRD)
 ...W $$LINE(PSBIEN)
 Q
 ;
LINE(PSBIEN) ; Displays the med log entry in PSBIEN
 N PSBX,PSBASTUS,PSBMME,PSBEXIST
 S X=$P($G(^PSB(53.79,PSBIEN,.1)),U)
 I X="" W !,"Error: Med Log Entry ",PSBIEN," has no order reference number!" Q ""
 I 'PSBAUDF,$P(^PSB(53.79,PSBIEN,0),U,9)="N" Q ""
 D CLEAN^PSBVT
 D PSJ1^PSBVT(DFN,X,,.PSBEXIST)
 ;   ;[*70-1489]...start
 I '$G(PSBEXIST),($G(PSBSCRT)="-1") D  ;send email to BCMA UKNOWN ACTIONS group if order given in BCMA does not have a corresponding # 55 file entry
 .N XMDUZ,XMSUB,XMTEXT,XMY,PSBERR,PSBPARAM,PSBMG
 .S XMSUB="Order given in BCMA does not exist in Pharmacy Patient file"
 .S XMDUZ=DUZ
 .S XMTEXT="PSBERR"
 .S PSBMG=$$GET^XPAR("DIV","PSB MG ADMIN ERROR",,"E"),PSBMG="G."_PSBMG
 .S XMY(PSBMG)=""
 .S PSBERR(1)="Order #"_$G(PSBIEN)_" given in BCMA no longer has"
 .S PSBERR(2)="a corresponding entry in the Pharmacy Patient (#55) file."
 .S PSBERR(3)="Please submit a remedy ticket for this issue."
 .D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY)
 .Q
  ;   ;[*70-1489]...end
 I PSBDFN="-1" W !,"Error: Inpatient Meds API Failure!" Q ""
 M PSBX=^PSB(53.79,PSBIEN)
 S Y=$P(PSBX(0),U,4)+.0000001
 ;*70 print location name per each clinic order
 S PSBMME=$$MME(+$G(PSBIEN)) I $G(PSBMME),($TR($P(PSBX(0),U,2)," ","")="") S $P(PSBX(0),U,2)="MME/UNKNOWN LOCATION"
 W:$P(PSBX(0),U,2)]"" !,?3,$P(PSBX(0),U,2)
 W !,$E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3)
 W " ",$E(Y,9,10),":",$E(Y,11,12)
 S Y=$$GET1^DIQ(53.79,PSBIEN_",",.08)
 S Y=Y_" ["_$G(PSBDOSE)_$G(PSBIFR)_" "_$G(PSBSCH)   ;[*70-1489]
 S Y=Y_" "_$G(PSBMRAB)                              ;[*70-1489]
 S:$P($G(^PSB(53.79,PSBIEN,.1)),U,6)]"" Y=Y_" Inj Site: "_$P(^(.1),U,6)
 S Y=Y_"]"
 W $$WRAP^PSBO(16,32,Y)
 W ?50,$$GET1^DIQ(53.79,PSBIEN_",","ACTION BY:INITIAL")
 S X=$P(PSBX(0),U,9)
 S PSBASTUS=$S(X="G":"Given",X="H":"Held",X="R":"Refused",X="I":"Infusing",X="C":"Completed",X="S":"Stopped",X="N":"Not Given",X="RM":"Removed",X="M":"Missing dose",1:"Status Unknown")
 S Y=$P(PSBX(0),U,6)+.0000001
 S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_" "_$E(Y,9,10)_":"_$E(Y,11,12)
 S Y=Y_" "_$G(PSBASTUS)   ;[*70-1489]
 W $$WRAP^PSBO(57,15,Y)
 W:$P(PSBX(.1),U)["V" ?75,"Bag ID #",$$GET1^DIQ(53.79,PSBIEN,"IV UNIQUE ID")
 W:$P(PSBX(.1),U)["V" ?107,"NA",?115,"NA",?120,"NA"
 W !,$TR($$FMTE^XLFDT($G(PSBOST),2),"@"," ")_">"   ;[*70-1489]
 F PSBZ=.5,.6,.7 S PSBDHIT=0 F PSBY=0:0 S PSBY=$O(PSBX(PSBZ,PSBY)) Q:'PSBY  D
 .W:$X>75 !
 .S PSBDD=$S(PSBZ=.5:53.795,PSBZ=.6:53.796,1:53.797)
 .S Y=$$EXTERNAL^DILFD(PSBDD,.01,"",$P(PSBX(PSBZ,PSBY,0),U,1))
 .W $$WRAP^PSBO(75,28,Y)
 .I $P(PSBX(.1),U)["U" W ?105,$J($P(PSBX(PSBZ,PSBY,0),U,2),6,2),?113,$J($P(PSBX(PSBZ,PSBY,0),U,3),6,2) W $$WRAP^PSBO(120,12,$P(PSBX(PSBZ,PSBY,0),U,4)) S PSBDHIT=1
 .W:$P(PSBX(.1),U)["V"&($X+3+$L($P(PSBX(PSBZ,PSBY,0),U,3))>105) !?75
 .W:$P(PSBX(.1),U)["V" " - ",$P(PSBX(PSBZ,PSBY,0),U,3)
 D:$P($G(^PSB(53.79,PSBIEN,.1)),U,2)="P"
 .W !?16,"PRN Reason: ",?30,$$GET1^DIQ(53.79,PSBIEN_",",.21)
 .W !?16,"PRN Effectiveness: "
 .I $P($G(^PSB(53.79,PSBIEN,.2)),U,2)="" W "<No PRN Effectiveness Entered>" Q
 .N PSBEIECMT S PSBEIECMT="" I $P($G(^PSB(53.79,PSBIEN,.2)),U,2)'="",$P(PSBRPT(.2),U,8)=0 S PSBEIECMT=$$PRNEFF^PSBO(PSBEIECMT,PSBIEN)
 .W $$WRAP^PSBO(20,100,$$GET1^DIQ(53.79,PSBIEN_",",.22)_PSBEIECMT)
 .W !?20,"Entered By: ",$$GET1^DIQ(53.79,PSBIEN_",",.23)
 .W " Date/Time: ",$$GET1^DIQ(53.79,PSBIEN_",",.24)
 .W " Minutes: ",$$GET1^DIQ(53.79,PSBIEN_",",.25)
 D:$P(PSBRPT(.2),U,8)
 .W !?16,"Comments: ",?30 I '$O(PSBX(.3,0)) W "<No Comments>"
 .F PSBY=0:0 S PSBY=$O(PSBX(.3,PSBY)) Q:'PSBY  D
 ..W:$X>30 !?30
 ..S Y=$P(PSBX(.3,PSBY,0),U,3)+.0000001
 ..W $E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3)
 ..W " ",$E(Y,9,10),":",$E(Y,11,12)
 ..W ?46,$$GET1^DIQ(53.793,PSBY_","_PSBIEN_",","ENTERED BY:INITIAL")
 ..W $$WRAP^PSBO(52,70,$P(PSBX(.3,PSBY,0),U,1))
 .;*70 Witness new line after Comments section chosen
 .N WITBY,WITDT,WITCM,WITHR,WITFL
 .S WITBY=$$GET1^DIQ(53.79,PSBIEN_",",.29)
 .S WITDT=$$GET1^DIQ(53.79,PSBIEN_",",.28,"I")
 .S WITCM=$$GET1^DIQ(53.79,PSBIEN_",",.31)
 .S WITHR=$$GET1^DIQ(53.79,PSBIEN_",",.32)
 .S WITFL=$$GET1^DIQ(53.79,PSBIEN_",",.33)
 .I WITBY]"" D
 ..W !?16,"Witnessed by:",?30,WITBY," on "
 ..W $P($$FMTE^XLFDT($$GET1^DIQ(53.79,PSBIEN_",",.28,"I"),2),":",1,2)
 .I WITFL="NO",WITBY="" D
 ..W !?16,"Witnessed?:",?30,WITFL
 .W:WITCM]"" !,$$WRAP^PSBO(30,102,WITCM)
 .;
 .W !,$TR($$FMTE^XLFDT($G(PSBOSP),2),"@"," ")_"<"   ;[*70-1489]
 .;
 D:PSBAUDF
 .W !?16,"Audits: ",?30 I '$O(PSBX(.9,0)) W "<No Audits>" Q
 .F PSBY=0:0 S PSBY=$O(PSBX(.9,PSBY)) Q:'PSBY  D
 ..W:$X>30 !?30
 ..S Y=$P(PSBX(.9,PSBY,0),U,1)+.0000001
 ..W $E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3)
 ..W " ",$E(Y,9,10),":",$E(Y,11,12)
 ..W ?46,$$GET1^DIQ(53.799,PSBY_","_PSBIEN_",","USER:INITIAL")
 ..W $$WRAP^PSBO(52,70,$P(PSBX(.9,PSBY,0),U,3))
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
WDHDR(PSBWARD) ;
 N PSBCLINORD S PSBCLINORD=2              ;2=both order type hdr   *70
 S PSBHDR(3)="",PSBHDR(4)="Ward Location: "
 D WARD^PSBOHDR(PSBWARD,.PSBHDR,,,PSBSRCHL)
 W $$SUB()
 Q ""
 ;
PTHDR() ;
 N PSBCLINORD S PSBCLINORD=2              ;2=both order type hdr   *70
 S:$G(PSBSRCHL)]"" PSBHDR(3)="",PSBHDR(4)="Ward Location: "
 D PT^PSBOHDR(DFN,.PSBHDR,,,PSBSRCHL)
 W $$SUB()
 Q ""
 ;
SUB() ; Med Log Sub Header
 W:$X>1 !
 W "Location",!
 W "Activity Date",?16,"Orderable Item",?50,"Action",?57,"Action"
 W !,"Start Date>",?16,"[Dose/Sched/Route/Inj Site]",?50,"By"
 W ?57,"Date/Time",?75,"Drug/Additive/Solution",?105," U/Ord"
 W ?113," U/Gvn",?120,"Unit",!,"Stop Date<"
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
MME(PSBIEN) ; Administered via Manual Med Entry?
 N MME,CMMT,CMMTND S MME=0
 S CMMT="" F  S CMMT=$O(^PSB(53.79,+PSBIEN,.3,CMMT)) Q:CMMT=""!$G(MME)  D
 .S CMMTND=$G(^PSB(53.79,+PSBIEN,.3,CMMT,0)) I CMMTND["Entry created with 'Manual Medication Entry'" S MME=1
 Q $S($G(MME):1,1:0)
