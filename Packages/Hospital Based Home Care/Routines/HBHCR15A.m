HBHCR15A ;LR VAMC(IRMS)/MJT-HBHC rpt using file 634.6, user selects date/forms from last 12 transmit batchs, fields: form#, pat name, last 4, form date, + action on form 3, prov #, & prov name on visits, & Adm or D/C on form 6 ;2/5/98
 ;;1.0;HOSPITAL BASED HOME CARE;**6,8,9,13,15,24**;NOV 01, 1993;Build 201
 ; Medical Foster Home (MFH) recs are only included if MFH Site; sorted alphabetically by MFH Name & includes Form # & Opened Date
 ; Calls HBHCR15B
 ; Report can also be generated by Transmit File option [HBHCXMT] if default printer is defined in sys param (631.9).  If no printer defined, no report.  User selects forms to include, date is transmit date
 ; HBHCXMT calls entry points:  PROMPT2^HBHCR15B & DQ^HBHCR15A
 I '$D(^HBHC(634.6,"C")) W $C(7),!,"No transmit history data on file." H 3 Q
 I $P(^HBHC(631.9,1,0),U,6)]"" W $C(7),!,"Transmission in progress; history data being updated.  Please try again later." H 3 Q
 D PROMPT1^HBHCR15B
 G:$D(DIRUT) EXIT
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCR15A",ZTDESC="HBPC Transmit History Report",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 S (HBHCPAGE,HBHCCNTA,HBHCCNTR,HBHCCNT4,HBHCCNT5,HBHCCNT6,HBHCCNT7)=0,$P(HBHCY,"-",81)="",HBHCCOLM=(80-(30+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 S HBHCHDR=$S(HBHCDIR="S":"W ?36,""Summary""",1:"W ?31,""Last"",!?4,""#"",?8,""Patient Name"",?31,""Four"",?38,""Date""")
LOOP ; Loop thru HBHC(634.6,"C" (transmit date) cross-ref to build report
 S HBHCIEN=0 F  S HBHCIEN=$O(^HBHC(634.6,"C",HBHCXMDT,HBHCIEN)) Q:HBHCIEN'>0  S HBHCINFO=$P(^HBHC(634.6,HBHCIEN,0),U) D PROCESS
 D END^HBHCR15B
EXIT ; Exit module
 D ^%ZISC
 K DIR,DIRUT,HBHC,HBHCACTN,HBHCCC,HBHCCNT,HBHCCNTA,HBHCCNTR,HBHCCNT4,HBHCCNT5,HBHCCNT6,HBHCCNT7,HBHCCOLM,HBHCDATE,HBHCDFN,HBHCDIR,HBHCDSDT,HBHCFLG,HBHCFORM,HBHCHEAD,HBHCHDR,HBHCI,HBHCIEN,HBHCINFO,HBHCIOP,HBHCLST4,HBHCMFHS
 K HBHCNAME,HBHCPAGE,HBHCPIEN,HBHCPRV,HBHCPRVN,HBHCTDY,HBHCTIME,HBHCTYPE,HBHCXMDT,HBHCY,HBHCY0,HBHCZ,X,Y,TMP,^TMP("HBHC",$J),^TMP($J)
 Q
PROCESS ; Process records
 S (HBHCACTN,HBHCPRV)="Z",(HBHCPRVN,HBHCTIME,HBHCTYPE)=""
 D:($E(HBHCINFO)=3)&((HBHCDIR=3)!(HBHCDIR="A")!(HBHCDIR="S")) FORM3
 D:($E(HBHCINFO)=4)&((HBHCDIR=4)!(HBHCDIR="A")!(HBHCDIR="S")) FORM4
 D:($E(HBHCINFO)=5)&((HBHCDIR=5)!(HBHCDIR="A")!(HBHCDIR="S")) FORM5
 D:($E(HBHCINFO)=6)&((HBHCDIR=6)!(HBHCDIR="A")!(HBHCDIR="S")) FORM6
 I $D(HBHCMFHS) D:($E(HBHCINFO)=7)&((HBHCDIR=7)!(HBHCDIR="A")!(HBHCDIR="S")) FORM7
 Q
FORM3 ; Process Form 3 (Admission) records
 S HBHCDATE=$E(HBHCINFO,18,25)
 S:$E(HBHCINFO,55)=1 HBHCCNTA=HBHCCNTA+1,HBHCACTN="Admit"
 S:$E(HBHCINFO,55)=2 HBHCCNTR=HBHCCNTR+1,HBHCACTN="Reject"
 Q:HBHCDIR="S"
 S HBHCFORM="A"
 S HBHCDFN="" F  S HBHCDFN=$O(^DPT("SSN",$E(HBHCINFO,9,17),HBHCDFN)) Q:HBHCDFN=""  S HBHCNAME=$E($P(^DPT(HBHCDFN,0),U),1,20)
 S HBHCLST4=$E(HBHCINFO,14,17)
 D SET
 Q
FORM4 ; Process Form 4 (Visit) records
 S HBHCCNT4=HBHCCNT4+1
 S HBHCFORM="V"
 S HBHCDFN="" F  S HBHCDFN=$O(^DPT("SSN",$E(HBHCINFO,9,17),HBHCDFN)) Q:HBHCDFN=""  S HBHCNAME=$E($P(^DPT(HBHCDFN,0),U),1,20)
 S HBHCLST4=$E(HBHCINFO,14,17)
 S HBHCDATE=$E(HBHCINFO,18,25)
 S HBHCTIME=$E(HBHCINFO,26,27)_":"_$E(HBHCINFO,28,29)
 S HBHCPRVN=+$E(HBHCINFO,30,33)
 S (HBHCFLG,HBHCPIEN)=0 F  S HBHCPIEN=$O(^HBHC(631.4,"B",HBHCPRVN,HBHCPIEN)) Q:HBHCPIEN'>0  D NAME
 D SET
 Q
NAME ; Form 4 Name
 I HBHCFLG=1 S HBHCPRV="**  Duplicate Prov #" Q
 S HBHCFLG=1,HBHCPRV=$E($P(^VA(200,$P(^HBHC(631.4,HBHCPIEN,0),U,2),0),U),1,20)
 Q
FORM5 ; Process Form 5 (Discharge) records
 S HBHCCNT5=HBHCCNT5+1
 Q:HBHCDIR="S"
 S HBHCFORM="D"
 S HBHCDFN="" F  S HBHCDFN=$O(^DPT("SSN",$E(HBHCINFO,9,17),HBHCDFN)) Q:HBHCDFN=""  S HBHCNAME=$E($P(^DPT(HBHCDFN,0),U),1,20)
 S HBHCLST4=$E(HBHCINFO,14,17)
 S HBHCDATE=$E(HBHCINFO,18,25)
 D SET
 Q
FORM6 ; Process Form 6 (Correction) records
 S HBHCCNT6=HBHCCNT6+1
 Q:HBHCDIR="S"
 S HBHCFORM=6
 S HBHCDFN="" F  S HBHCDFN=$O(^DPT("SSN",$E(HBHCINFO,9,17),HBHCDFN)) Q:HBHCDFN=""  S HBHCNAME=$E($P(^DPT(HBHCDFN,0),U),1,20)
 S HBHCLST4=$E(HBHCINFO,14,17)
 S HBHCDSDT=$TR($E(HBHCINFO,56,63)," ","")
 ; Use Discharge date if exists, otherwise use Admission date
 S HBHCDATE=$S(HBHCDSDT]"":HBHCDSDT,1:$E(HBHCINFO,18,25))
 S HBHCTYPE=$S(HBHCDSDT]"":"Discharge",1:"Evaluation/Admission")
 D SET
 Q
FORM7 ; Process Form 7 Medical Foster Home (MFH) records
 S HBHCCNT7=HBHCCNT7+1
 Q:HBHCDIR="S"
 S HBHCFORM="Z"
 S HBHCNAME=$E(HBHCINFO,9,38)
 S HBHCDATE=$E(HBHCINFO,84,91)
 S HBHCLST4=9999
 D SET
 Q
SET ; Set TMP node
 ; By design, records are processed/printed in the following order by form number:  6, 3 (A), 5 (D), 4 (V), & 7 (Z)
 S:HBHCDIR'="S" ^TMP("HBHC",$J,HBHCFORM,HBHCACTN,HBHCNAME,HBHCLST4,HBHCDATE,HBHCPRV,HBHCIEN)=HBHCPRVN_U_HBHCTYPE_U_HBHCTIME
 S:HBHCFORM="V" ^TMP($J,HBHCNAME,HBHCLST4,HBHCDATE_HBHCTIME,HBHCPRV)=""
 Q
