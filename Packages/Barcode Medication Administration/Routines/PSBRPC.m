PSBRPC ;BIRMINGHAM/EFC - BCMA RPC BROKER CALLS ; 19 Jul 2013  12:34 PM
 ;;3.0;BAR CODE MED ADMIN;**6,3,4,13,32,28,42,58,66,70**;Mar 2004;Build 29
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; File 211.4/1409
 ; CHECKAV^XUSRB/2882
 ; GUIMTD^DPTLK6/3023
 ; ^ORD(101.24/3429
 ; EN1^GMRVUT0/1446
 ; $$GETACT^DGPFAPI/3860
 ; File #40.8/2817
 ; $$GET^XPAR/2263
 ; $$GET1^DIQ/2056
 ; XMD/10070
 ; RPCVIC^DPTLK/5888
 ; File #42/1377
 ;
 ;*70 - remove restriction of allowing BCMA to view Discharged
 ;      patients
 ;    - add Tag GETLIST, RPC:PSB CLINICLIST (returns requested
 ;                                           clinic names)
 ;    - add to User load & User save 2 new varaibles, 1 for Last
 ;      Order mode and other for Last Clinic name search text
 ;    - 1489: Blended PSB*3*66 with PSB*3*70
 ;    - Add Registration API call to support VIC 4.0 cards
 ;
FMDATE(RESULTS,X) ;
 ; RPC: PSB FMDATE
 ; Descr: Returns FM Date/Time from Clnt DateToStr()
 ;
 I $P(X,"@",2)="0000" S $P(X,"@",2)="0001"
 ;if no time for dates like T-1, append the current time
 I $P(X,"@",2)="",X'?1"N" D  S $P(X,"@",2)=$P(Y,"@",2)
 . N X
 . S X="N",%DT="T" D ^%DT,DD^%DT
 S %DT="T" D ^%DT
 I +Y<1 S RESULTS(0)="-1^Invalid Date/Time" Q
 S RESULTS(0)=Y D D^DIQ
 S RESULTS(0)=RESULTS(0)_U_Y
 Q
 ;
USRLOAD(RESULTS,DUMMY) ;
 ;
 ; RPC: PSB USERLOAD
 ; Descr: Load wkst user
 ; 
 S RESULTS(0)=DUZ ;UsrIEN
 S RESULTS(1)=$$GET1^DIQ(200,DUZ_",",.01) ; Usr Nm
 S RESULTS(2)=$S($D(^XUSEC("PSB STUDENT",DUZ)):1,1:0) ; Studnt?
 S RESULTS(3)=$S($D(^XUSEC("PSB MANAGER",DUZ)):1,1:0) ; Mgr?
 S RESULTS(4)=$S($D(^XUSEC("PSB CPRS MED BUTTON",DUZ)):1,1:0)
 S RESULTS(5)=$$GET^XPAR("USR","PSB WINDOW")
 ;VDL Strng
 S X=$S(+$$GET^XPAR("ALL","PSB VDL INCL CONT"):"T",1:"F")
 S X=X_"/"_$S(+$$GET^XPAR("ALL","PSB VDL INCL PRN"):"T",1:"F")
 S X=X_"/"_$S(+$$GET^XPAR("ALL","PSB VDL INCL ONE-TIME"):"T",1:"F")
 S X=X_"/"_$S(+$$GET^XPAR("ALL","PSB VDL INCL ON-CALL"):"T",1:"F")
 S X=X_"/"_+$$GET^XPAR("ALL","PSB VDL SORT COLUMN")
 S X=X_"/"_+$$GET^XPAR("ALL","PSB VDL PB SORT COLUMN")
 S X=X_"/"_+$$GET^XPAR("ALL","PSB VDL IV SORT COLUMN")
 ;
 S RESULTS(6)=X ;VDL Setp
 S RESULTS(7)=+$G(DUZ(2))
 I RESULTS(7) S RESULTS(8)=$$GET1^DIQ(4,RESULTS(7)_",",.01)
 E  S RESULTS(8)="Undefined Division"
 N DVIEN S DVIEN=$O(^DG(40.8,"AD",RESULTS(7),""))
 S RESULTS(7)=RESULTS(7)_U_$P($$SITE^VASITE(DT,DVIEN),U,3)
 I $T(PROD^XUPROD)]"" S RESULTS(7)=RESULTS(7)_U_$$PROD^XUPROD(1)
 S RESULTS(9)=+$$GET^XPAR("DIV","PSB ADMIN ESIG")
 S RESULTS(10)=+$$GET^XPAR("DIV","PSB ONLINE")
 S RESULTS(11)=$G(DTIME,300)
 S RESULTS(12)=$$GET^XPAR("USR","PSB UNIT DOSE COLUMN WIDTHS")
 S RESULTS(13)=$J_"^"_$$BASE^XLFUTL($J,10,16)
 S RESULTS(14)=$$GET^XPAR("USR","PSB IVPB COLUMN WIDTHS")
 S RESULTS(15)=$$GET^XPAR("USR","PSB IV COLUMN WIDTHS")
 S RESULTS(16)=$$GET^XPAR("USR","PSB PRINTER USER DEFAULT")
 S RESULTS(17)=$$GET^XPAR("USR","PSB GUI DEFAULT PRINTER")
 S RESULTS(18)=$S($D(^XUSEC("PSB READ ONLY",DUZ)):1,1:0)
 S RESULTS(19)=$$GET^XPAR("USR","PSB COVERSHEET VIEWS COL SORT")
 S RESULTS(20)=$$GET^XPAR("USR","PSB COVERSHEET V1 COL WIDTHS")
 S RESULTS(21)=$$GET^XPAR("USR","PSB COVERSHEET V2 COL WIDTHS")
 S RESULTS(22)=$$GET^XPAR("USR","PSB COVERSHEET V3 COL WIDTHS")
 S RESULTS(23)=$$GET^XPAR("USR","PSB COVERSHEET V4 COL WIDTHS")
 S RESULTS(24)=$S($D(^XUSEC("PSB UNABLE TO SCAN",DUZ)):1,1:0)
 S RESULTS(25)=$$GET^XPAR("DIV","PSB 5 RIGHTS UNITDOSE")
 S RESULTS(26)=$$GET^XPAR("DIV","PSB 5 RIGHTS IV")
 S RESULTS(27)=$G(DUZ("AG"))  ;IHS/MSC/PLS
 S RESULTS(28)=$$GET^XPAR("USR","PSB ORDER MODE")           ;*70
 S RESULTS(29)=$$GET^XPAR("USR","PSB CLINIC SEARCH")        ;*70
 ;DSS/BG-BEGIN MOD-conditionally pass flag for vxvist system or not
 I $G(^%ZOSF("ZVX"))["VX" D
 .S RESULTS(21600)="21600^"_$$GET^XPAR("ALL","VFD PSB SCANPT ID TYPE",,"Q")
 ;DSS/BG-END MOD
 Q
 ;
USRSAVE(RESULTS,PSBWIN,PSBVDL,PSBUDCW,PSBPBCW,PSBIVCW,PSBDEV,PSBCSRT,PSBCV1,PSBCV2,PSBCV3,PSBCV4,PSBORMODE,PSBCLSRCH) ;
 ;
 ; RPC: PSB USERSAVE
 ; Descr: Saves user settings.
 ;
 S RESULTS(0)="-1^FAILED - Parameters Save"
 S PSBWIN=$G(PSBWIN),PSBVDL=$G(PSBVDL),PSBUDCW=$G(PSBUDCW)
 S PSBPBCW=$G(PSBPBCW),PSBIVCW=$G(PSBIVCW),PSBDEV=$G(PSBDEV)
 S PSBCSRT=$G(PSBCSRT),PSBCV1=$G(PSBCV1),PSBCV2=$G(PSBCV2),PSBCV3=$G(PSBCV3),PSBCV4=$G(PSBCV4)
 ;
 D EN^XPAR("USR","PSB WINDOW",1,PSBWIN)
 D EN^XPAR("USR","PSB VDL INCL CONT",1,$P(PSBVDL,"/",1)["T")
 D EN^XPAR("USR","PSB VDL INCL PRN",1,$P(PSBVDL,"/",2)["T")
 D EN^XPAR("USR","PSB VDL INCL ONE-TIME",1,$P(PSBVDL,"/",3)["T")
 D EN^XPAR("USR","PSB VDL INCL ON-CALL",1,$P(PSBVDL,"/",4)["T")
 D EN^XPAR("USR","PSB VDL SORT COLUMN",1,+$P(PSBVDL,"/",5))
 D EN^XPAR("USR","PSB VDL PB SORT COLUMN",1,+$P(PSBVDL,"/",6))
 D EN^XPAR("USR","PSB VDL IV SORT COLUMN",1,+$P(PSBVDL,"/",7))
 D EN^XPAR("USR","PSB UNIT DOSE COLUMN WIDTHS",1,PSBUDCW)
 D EN^XPAR("USR","PSB IVPB COLUMN WIDTHS",1,PSBPBCW)
 D EN^XPAR("USR","PSB IV COLUMN WIDTHS",1,PSBIVCW)
 D EN^XPAR("USR","PSB GUI DEFAULT PRINTER",1,PSBDEV)
 D EN^XPAR("USR","PSB COVERSHEET VIEWS COL SORT",1,PSBCSRT)
 D EN^XPAR("USR","PSB COVERSHEET V1 COL WIDTHS",1,PSBCV1)
 D EN^XPAR("USR","PSB COVERSHEET V2 COL WIDTHS",1,PSBCV2)
 D EN^XPAR("USR","PSB COVERSHEET V3 COL WIDTHS",1,PSBCV3)
 D EN^XPAR("USR","PSB COVERSHEET V4 COL WIDTHS",1,PSBCV4)
 D EN^XPAR("USR","PSB ORDER MODE",1,PSBORMODE)            ;*70
 D EN^XPAR("USR","PSB CLINIC SEARCH",1,PSBCLSRCH)         ;*70
 S RESULTS(0)="1^Parameters Saved"
 Q
 ;
INST(RESULTS,PSBACC,PSBVER) ;
 ;
 ; RPC: PSB INSTRUCTOR
 ; Descr:
 ; Used by frmInstructor to validate an instructor(s) at
 ; the client via encrypted A/V Code.
 ;
 S PSBACC=$$DECRYP^XUSRB1(PSBACC)
 S PSBVER=$$DECRYP^XUSRB1(PSBVER)
 S PSBINST=$$CHECKAV^XUSRB(PSBACC_";"_PSBVER)
 I PSBINST<1 S RESULTS(0)="-1^Invalid Instructor Sign-On" K PSBINST Q
 I '$D(^XUSEC("PSB INSTRUCTOR",PSBINST)) S RESULTS(0)="-1^Instructor doesn't have authority" K PSBINST Q
 S PSBINST(0)=$$GET1^DIQ(200,PSBINST_",",.01)
 S RESULTS(0)=PSBINST_U_PSBINST(0)
 Q
 ;
ESIG(RESULTS,PSBESIG) ;
 ;
 ; RPC: PSB VALIDATE ESIG
 ; Descr: Validate the data in PSBESIG against user (DUZ)
 ;
 S PSBDSIG=$P($G(PSBESIG),U,2) I PSBDSIG'="" S PSBDSIG=$$DECRYP^XUSRB1(PSBDSIG),PSBESIG=PSBDSIG
 I $G(PSBESIG)="" S RESULTS(0)="-1^Must Supply ESig" Q
 S X=PSBESIG D HASH^XUSHSHP
 I X'=$$GET1^DIQ(200,DUZ_",",20.4,"I") S RESULTS(0)="-1^Invalid ESig"
 E  S RESULTS(0)="1^ESig Verified"
 Q
 ;
SCANPT(RESULTS,PSBDATA) ; Lookup Pt by Full SSN
 ;
 ; RPC: PSB SCANPT
 ; Descr:
 ; File #2 lookup either by full SSN
 ; returns -1 on error or patient data
 ; Check for Interleave 2 of 5 Check Digit on SSN and remove
 ; 
 N DFN,PSBWARD   ;[*70-1489]
 ;DSS/BG-BEGIN MOD-modify for MRN lookup in vxVista context
 I $$VX Q:$$VFD<0
 ;DSS/BG-END MOD
 I "SS"[$P($G(PSBDATA),"^",3)  D  Q:RESULTS(1)<0
 .S:$P(PSBDATA,"^")?1"0"9N.U PSBDATA=$E(PSBDATA,2,99) N PSBCNT
 .;  IHS vs VA Agency check for Patient ID info
 .I $G(DUZ("AG"))'="I",$G(DUZ("AG"))'="V" S RESULTS(0)=1,RESULTS(1)="-1^Invalid Agency Code - Not IHS or VA" Q
 .I $G(DUZ("AG"))="I" D
 ..S X=-1
 ..I $P(PSBDATA,U)?12N S X=$$HRCNF^APSPFUNC($P(PSBDATA,U))
 ..S:X'>0 RESULTS(0)=1,RESULTS(1)="-1^Patient not found or # not 12 digit"
 .E  D
 ..;*70 Implement VIC 4.0 cards. Old Bar code with SSN still accepted
 ..S DPTDATA=$P(PSBDATA,U) ;,DPTDATA=$TR(DPTDATA,"|","^") ; ST - $TR not needed
 ..D RPCVIC^DPTLK(.DFN,DPTDATA)
 ..I DFN=""!(DFN<0) S DFN=$$FIND1^DIC(2,"","",DPTDATA,"SSN") S:'DFN DFN=-1 ;old SSN lookup
 .I DFN=-1 S RESULTS(0)=1,RESULTS(1)="-1^Invalid Patient Lookup"
 .;*End *70 Implement VIC 4.0 cards.
 .Q:$G(RESULTS(1))<0
 .S (RESULTS(1),PSBDFN)=DFN
 .S PSBICN=$$GETICN^MPIF001(PSBDFN) I +PSBICN=-1 S PSBICN=""
 I $G(DFN)']"" D  Q:+PSBDFN'>0
 .; CCOW !
 .I "DF"[$P($G(PSBDATA),"^",3) S PSBDFN=$P($G(PSBDATA),"^"),PSBICN=$$GETICN^MPIF001(PSBDFN) I +PSBICN=-1 S PSBICN="",RESULTS(0)=1,RESULTS(1)="-1^Cannot find ICN via DFN"
 .I "IC"[$P($G(PSBDATA),"^",3) S PSBICN=$P($G(PSBDATA),"^"),PSBDFN=$$GETDFN^MPIF001(PSBICN) I +PSBDFN=-1 S PSBDFN="",RESULTS(0)=1,RESULTS(1)="-1^Cannot find DFN via ICN" Q
 .S (DFN,RESULTS(1))=PSBDFN
 .;
 ;*70 get registration owned data for admit date or deceased date
 N VADM,VA,VAIN,VAIP,VA D DEM^VADPT,IN5^VADPT
 N QUIT                                                        ;*70
 ; remove discharge test                                       ;*70
 ; if patient is deceased                                      ;*70
 S QUIT=0
 I VADM(6)'="" D  Q:QUIT
 .S RESULTS(0)=1
 .S RESULTS(1)="-1^"_"This patient died "_$TR($P(VADM(6),U,2),"@"," ")
 .D:'$P(PSBDATA,U,2)      ;not read only/limited mode
 ..I ($P($G(PSBDATA),U,3)'["IC")&($P($G(PSBDATA),U,3)'["DF") S QUIT=1
 ;
 ; continue to load patient data
 S RESULTS(1)=PSBDFN
 F X=1,3,4,5 S RESULTS(X+1)=$G(VADM(X))
 ;  IHS/VA - use VA("PID") instead of VADM(2) for Pat ID
 S RESULTS(3)=$TR(VA("PID"),"-")_U_VA("PID")
 F X=3,4,5,6,7,8,9,10,11 S RESULTS(X+4)=$G(VAIP(X))
 ;
 ; IHS/MSC/PLS - 03/27/06 - Changed to call PCC Vitals based on
 ;  parameter flag DUZ("AG")="I" and PCC Vitals package usage
 ;  flag "BEHOVM USE VMSR"=1
 ;
 I $G(DUZ("AG"))="I",$$GET^XPAR("ALL","BEHOVM USE VMSR") D
 .S X=+$P($$VITAL^APSPFUNC(DFN,"HT"),U,2),X=$$VITCHT^APSPFUNC(X)\1,PSBHDR("HEIGHT")=$S(X:X_"cm",1:"*")
 .S X=+$P($$VITAL^APSPFUNC(DFN,"WT"),U,2),X=$$VITCWT^APSPFUNC(X)\1,PSBHDR("WEIGHT")=$S(X:X_"kg",1:"*")
 E  D
 .;DSS/SMP - BEGIN MODS
 .S GMRVSTR="HT" D EN6^GMRVUTL
 .S X=+$P(X,U,8) D  S PSBHDR("HEIGHT")=$S(X:X_"cm",1:"*")
 ..I $$VX S:X X=$$IN2CM^VFDXLF(X,0) Q
 ..S:X X=X*2.54\1
 .S GMRVSTR="WT" D EN6^GMRVUTL
 .S X=+$P(X,U,8) D  S PSBHDR("WEIGHT")=$S(X:X_"kg",1:"*")
 ..I $$VX S X=$$LB2KG^VFDXLF(X,2) Q
 ..S X=$J(X/2.2,0,2)
 .;DSS/SMP - END MODS
 ;
 S $P(RESULTS(9),U,3)=$$GET1^DIQ(42,$P(RESULTS(9),U)_",",44,"I")_"^"_$$GET1^DIQ(42,$P(RESULTS(9),U)_",",44)
 S PSBWARD=$P($G(RESULTS(9)),U,2) D IVBAGPAR(PSBWARD)   ;[*70-1489]
 S RESULTS(16)=PSBHDR("HEIGHT")
 S RESULTS(17)=PSBHDR("WEIGHT")
 S GMRA="0^0^111" D EN1^GMRADPT
 I $O(GMRAL(0)) S RESULTS(18)=1
 E  S RESULTS(18)=0
 ; Means Tst
 D GUIMTD^DPTLK6(.PSBDATA,PSBDFN)
 S RESULTS(19)=+$G(PSBDATA(1))_U_$G(PSBDATA(2))_U_$G(PSBDATA(3))
 S PSBICN=$$GETICN^MPIF001(PSBDFN) I +PSBICN=-1 S PSBICN=""
 S RESULTS(20)=PSBICN
 S RESULTS(21)="",RESULTS(0)=21
 S:VADM(6)'="" RESULTS(21)="This patient died "_$TR($P(VADM(6),U,2),"@"," ")
 S:('VAIP(13))&('VADM(6)) RESULTS(21)="Patient not Admitted"  ;*70
 S (RESULTS(0),PSBCNT)=22
 S RESULTS(PSBCNT)=""
 F PSBINDX=1:1:($$GETACT^DGPFAPI(PSBDFN,.PSBPTFLG)) D
 .Q:'$D(PSBPTFLG)  Q:'$D(@(PSBPTFLG_"(PSBINDX,""FLAG"")"))  S PSBPFLAG="PATFLG",$P(PSBPFLAG,U,2)=$P(@(PSBPTFLG_"(PSBINDX,""FLAG"")"),"^",2)
 .S $P(PSBPFLAG,U,3)=PSBINDX,PSBCNT=21+PSBINDX,RESULTS(PSBCNT)=PSBPFLAG
 S RESULTS(0)=PSBCNT
 I $D(PSBPTFLG) K @PSBPTFLG
 Q
 ;
MAX(RESULTS,PSBDAYS) ;
 ;
 ; RPC: PSB MAXDAYS  ; Max days user view/print MAH
 ;
 S X=$O(^ORD(101.24,"B","ORRP BCMA MAH",""))
 S RESULTS(0)=$$GET1^DIQ(101.24,X_",",.42)
 Q
 ;
NWLIST(RESULTS,DUMMY) ; ward list - NURS LOCATION, file 211.4
 ;
 ; RPC: PSB NURS WARDLIST
 ; 
 K ^TMP("PSB",$J)
 S PSBIEN=0 F  S PSBIEN=$O(^NURSF(211.4,PSBIEN)) Q:PSBIEN'?.N  D
 .S ^TMP("PSB",$J,$$GET1^DIQ(211.4,PSBIEN_",",.01)_" [NURS UNIT]")=PSBIEN
 .S PSBX=0 F  S PSBX=$O(^NURSF(211.4,PSBIEN,3,PSBX)) Q:PSBX=""  D
 ..S PSBWIEN=$P(^NURSF(211.4,PSBIEN,3,PSBX,0),"^")
 ..I $$GET1^DIQ(42,PSBWIEN_",",.01)]"" S ^TMP("PSB",$J,$$GET1^DIQ(42,PSBWIEN_",",.01)_" [MAS WARD]")=PSBIEN
 S RESULTS(0)=0
 S X="" F  S X=$O(^TMP("PSB",$J,X)) Q:X=""  D
 .S RESULTS(0)=RESULTS(0)+1
 .S RESULTS(RESULTS(0))=^TMP("PSB",$J,X)_U_X_U_$S(($$GET1^DIQ(211.4,^TMP("PSB",$J,X)_",",1)="ACTIVE")&($$GET1^DIQ(211.4,^TMP("PSB",$J,X)_",",1.5)'="**INACTIVE**"):"1",1:"0")
 K ^TMP("PSB",$J)
 Q
 ;
VITALS(RESULTS,DFN) ;Vitals API
 ;
 ; RPC PSB VITALS
 ; 
 ;Retrieve vitals from either the PCC V Measurment file or VA Vitals
 ; file.  Based on agency code = "I" & Vitals package flag=1 for the 
 ; PCC V Measurement file or "V" for the VA Vitals file.
 ;
 I $G(DUZ("AG"))="I",$$GET^XPAR("ALL","BEHOVM USE VMSR") D  Q
 .K RESULTS
 .N PSBNOW,PSBSTRT,VITS,CNT,VTYP,LP,DATA,NODE,XREF
 .S XREF("TMP")="T",XREF("PU")="P",XREF("BP")="BP",XREF("RS")="R",XREF("PA")="PN"
 .S PSBNOW=$$NOW^XLFDT(),PSBSTRT=$$FMADD^XLFDT(PSBNOW,-168)
 .S CNT=0 F LP="TMP","PU","RS","BP","PA" D
 ..S VTYP=$$FIND1^DIC(9999999.07,"","BX",LP)
 ..I VTYP S VITS(CNT+1)=VTYP,CNT=CNT+1
 .D GRID^BEHOVM(.DATA,DFN,PSBNOW,$$FMADD^XLFDT(PSBNOW,"",-168),0,.VITS)
 .;BUILD RESULTS ARRAY
 .I '$P(@DATA@(0),U,3) D  Q  ; No Results
 ..S RESULTS(0)=1,RESULTS(1)="No Vitals to report"
 .S (CNT,LP)=0 F  S LP=$O(@DATA@("R",LP)) Q:'LP  D
 ..S NODE=@DATA@("R",LP)
 ..S RESULTS(CNT+1)=XREF($P(@DATA@(0,$P(NODE,U,2)),U,4))_U_$E($$GET1^DIQ(9000010.01,$P(NODE,U,5),1201,"I"),1,12)_U_DFN_U_$P(NODE,U,3)
 ..S CNT=CNT+1
 .S RESULTS(0)=CNT
 ;
 K RESULTS
 N PSBSTRT,PSBSTOP,PSBNOW
 S PSBDFN=DFN,GMRVSTR="T;P;R;BP;PN"
 D NOW^%DTC S PSBNOW=%,PSBSTRT=$$FMADD^XLFDT(PSBNOW,"",-168),PSBSTOP=PSBNOW,GMRVSTR(0)=PSBSTRT_U_PSBSTOP_U_4_U
 K ^UTILITY($J,"GMRVD")
 D EN1^GMRVUT0
 S PSBCNT=1
 I '$D(^UTILITY($J,"GMRVD")) S RESULTS(0)=PSBCNT,RESULTS(PSBCNT)="No Vitals to report" Q
 S PSBTYP=""
 F  S PSBTYP=$O(^UTILITY($J,"GMRVD",PSBTYP)) Q:PSBTYP=""  D
 .S PSBRDT=""
 .F  S PSBRDT=$O(^UTILITY($J,"GMRVD",PSBTYP,PSBRDT)) Q:PSBRDT=""  D
 ..S PSBIEN=""
 ..F  S PSBIEN=$O(^UTILITY($J,"GMRVD",PSBTYP,PSBRDT,PSBIEN)) Q:PSBIEN=""  D
 ...S PSBDATA=($G(^UTILITY($J,"GMRVD",PSBTYP,PSBRDT,PSBIEN)))
 ...S RESULTS(PSBCNT)=PSBTYP_U_$P(PSBDATA,U,1,2)_U_$P(PSBDATA,U,8)
 ...S PSBCNT=PSBCNT+1
 S RESULTS(0)=PSBCNT-1
 K ^UTILITY($J,"GMRVD"),GMRBSTR,PSBDFN,PSBTYPE,PSBDATA,PSBCNT
 Q
 ;   ;[*70-1489]...start
IVBAGPAR(PSBWARD) ; Send Mailman Message to owners of PSB Manager Key if IV Bag Parameters are not set for this Ward
 Q:PSBWARD=""
 N PSBCSTR,PSBWDIV,PSB,PSBIVT,PSBFLAG,PSBSTNMB,PSBINST,PSBIVPAR
 S PSBCSTR="^ADDITIVE^STRENGTH^BOTTLE^SOLUTION^VOLUME^INFUSION RATE^MED ROUTE^SCHEDULE^ADMIN TIME^REMARKS^OTHER PRINT INFO^PROVIDER^START DATE/TIME^STOP DATE/TIME^PROVIDER COMMENTS"
 S PSBWARD=$O(^DIC(42,"B",PSBWARD,""))
 S PSBWDIV=$$GET1^DIQ(42,PSBWARD_",",.015,"I")
 I $G(PSBWDIV)']"" S PSBWDIV="DIV"
 E  S PSBWDIV=$P($$SITE^VASITE(DT,PSBWDIV),U,1),PSBWDIV="DIV.`"_PSBWDIV
 F PSBIVT="A","P","H","S","C" S PSBIVPAR=PSBIVT D
 .F PSBX=2:1 Q:$P(PSBCSTR,U,PSBX)=""  S PSBIVPAR=PSBIVPAR_U_$P($P($$GET^XPAR(PSBWDIV,"PSBIV "_$P(PSBCSTR,U,PSBX),PSBIVT,"B"),U,2),"-",1),^TMP("PSBWARD",PSBX,PSBIVT)=PSBIVPAR I $P(PSBIVPAR,U,PSBX)="" S PSBFLAG=""
 S PSBSTNMB=$$GET1^DIQ(4,($P(PSBWDIV,"`",2)),99)
 S:PSBSTNMB="" PSBINST=$$GET1^DIQ(4,($P(PSBWDIV,"`",2)),.01)
 I $D(PSBFLAG) D
 .N XMDUZ,XMSUB,XMTEXT,XMY,PSBERR,PSBMG1,PSBCNT
 .S PSBCNT=1
 .I PSBSTNMB'="" S XMSUB="ACTION NEEDED! DIV "_PSBSTNMB_" IV PARAMS NOT DEFINED"
 .E  S XMSUB=" ACTION NEEDED! INSTITUTION IV PARAMS NOT DEFINED"
 .S XMDUZ="BCMA PARAMETERS"
 .S XMTEXT="PSBERR("
 .S PSBMG1="" F  S PSBMG1=$O(^XUSEC("PSB MANAGER",PSBMG1)) Q:PSBMG1=""  S XMY(PSBMG1)=""
 .S PSBERR(PSBCNT)="The IV Bag Parameters are not defined",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="for Ward '"_$$GET1^DIQ(42,PSBWARD,.01)_"', which is associated ",PSBCNT=PSBCNT+1
 .I PSBSTNMB'="" S PSBERR(PSBCNT)="with Facility Division #"_PSBSTNMB_" and needs to",PSBCNT=PSBCNT+1
 .E  S PSBERR(PSBCNT)="with Institution '"_PSBINST_"' and needs to",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="be set immediately!",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="",PSBCNT=PSBCNT+1
 .I PSBSTNMB="" S PSBERR(PSBCNT)="A Station Number is not defined for",PSBCNT=PSBCNT+1 D
 ..S PSBERR(PSBCNT)="Institution '"_PSBINST_"'.",PSBCNT=PSBCNT+1
 ..S PSBERR(PSBCNT)="Please log a ticket with the VA Service Desk!!",PSBCNT=PSBCNT+1
 ..S PSBERR(PSBCNT)="Once a Station Number has been assigned,",PSBCNT=PSBCNT+1
 ..S PSBERR(PSBCNT)="please complete the following steps:",PSBCNT=PSBCNT+1
 .S:PSBSTNMB'="" PSBERR(PSBCNT)="To do so:  ",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="1. Log into the BCMA Parameters GUI.",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="2. Select Facility Division Number "_PSBSTNMB_".",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="3. Set IV Parameters desired for this Division.",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="4. Select OK.",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="Please log a ticket with the ",PSBCNT=PSBCNT+1
 .S PSBERR(PSBCNT)="VA Service Desk if you need assistance.",PSBCNT=PSBCNT+1
 .D ^XMD
 Q
 ;   ;[*70-1489]...end
GETLIST(RESULTS,PRE,CONTAIN) ; Get Clinics by name                     ;*70
 N LIN
 K ^TMP("PSBCLIN",$J)
 S RESULTS=$NAME(^TMP("PSBCLIN",$J))
 S LIN=0 D CLNLIST(PRE,CONTAIN,.LIN)
 ;set total rec counter
 I $D(^TMP("PSBCLIN",$J)) D
 . S ^TMP("PSBCLIN",$J,0)=LIN
 E  D
 . S ^TMP("PSBCLIN",$J,0)=1
 . S ^TMP("PSBCLIN",$J,1)="-1^Invalid Clinic Lookup"
 Q
 ;
CLNLIST(PR,CON,LN) ;return Clinic list in TMP by name                                *70
 N QQ,NODE0,INACTDT,NAME,REACTDT
 F QQ=0:0 S QQ=$O(^SC(QQ)) Q:'QQ  D
 . S NODE0=$G(^SC(QQ,0)) Q:NODE0=""
 . Q:$P(NODE0,U,3)'="C"                     ;type Clinic
 . S INACTDT=+$P($G(^SC(QQ,"I")),U)             ;inactive date
 . S REACTDT=+$P($G(^SC(QQ,"I")),U,2)
 . I INACTDT,INACTDT<DT I 'REACTDT!(REACTDT&((REACTDT<INACTDT)!(REACTDT>DT))) Q
 . S NAME=$P(NODE0,U)
 . I PR]"" D
 .. I $E(NAME,1,$L(PR))=PR,NAME[CON D
 ... S LN=LN+1,^TMP("PSBCLIN",$J,LN)=NAME
 . E  D
 .. I NAME[CON D
 ... S LN=LN+1,^TMP("PSBCLIN",$J,LN)=NAME
 Q
VFD() ;DSS/SGM/BG-BEGIN MODS-modify for MRN lookup
 ; extrinsic function, if 1 then successful MRN lookup
 ;                     if 0 then not MRN lookup or vxVistA
 ;                    if -1 then MRN lookup unsuccessful
 S PSBDATA=$G(PSBDATA)
 N X,Y,DIERR,VFD,VFDERR
 I $T(VFIELD^VFDCFM)="" Q 0
 I $$VFIELD^VFDCFM(,2,21600)'>0 Q 0
 S X=$$GET^XPAR("SYS","VFD PSB SCANPT ID TYPE")
 ; 3/21/2012 - sgm - program to allow for multiple values for VFD param
 ; code changed to enforce default behavior to be VistA
 ; parameters must be valued to invoke vxVistA logic
 I "^MRN^"'[(U_X_U) Q 0
 I "^MRN^"'[(U_$P(PSBDATA,U,3)_U) Q 0
 ; we have a param value for vxVistA lookup type
 S IDX=$S(X="MRN":"VFD",1:"") I IDX="" Q 0
 S X=$$FIND1^DIC(2,"","",$P(PSBDATA,U),IDX,,"VFDERR")
 I X>0 S (DFN,RESULTS(1),PSBDFN)=X Q 1
 S RESULTS(0)=1,RESULTS(1)="-1^Invalid Patient Lookup"
 I $D(DIERR) S RESULTS(1)="-1^"_$$MSG^VFDCFM(,,,,"VFDERR")
 Q -1
 ;
VX() ; vxVistA Check
 Q $G(^%ZOSF("ZVX"))["VX"
