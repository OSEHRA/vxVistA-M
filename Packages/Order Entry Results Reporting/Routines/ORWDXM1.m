ORWDXM1 ;SLC/KCM - Order Dialogs, Menus;5/12/08 6:14am ;9/10/2010
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,131,132,141,178,185,187,215,243,280,331,388**;Dec 17, 1997;Build 29
 ;
BLDQRSP(LST,ORIT,FLDS,ISIMO,ENCLOC) ; Build responses for an order
 ; LST=QuickLevel^ResponseID(ORIT;$H)^Dialog^Type^FormID^DGrp
 ; LST(n)=verify or reject text
 ; ORIT= ptr to 101.41 for quick order, 100 for copy
 ; 1 2 3 4 5 6 7 8 11-20
 ; FLDS=DFN^LOC^ORNP^INPT^SEX^AGE^EVENT^SC%^^^Key Variables...
 ; ORIT=+ORIT: ptr to 101.41, $E(ORIT)=C: copy $E(ORIT)=X: change
 ; !! SHOULD CHECK for PRE-CPRS ORDERS (treat as text?)
 K ^TMP("ORWDXMQ",$J)
 N ORWMODE ; 0:Dlg,Quick 1:copy 2:change
 N TEMPCAT ; pt cat from DPT
 N ISXFER ; Trnsfr order?
 N ORIMO ;If IMO(inpt med on opt)
 N TEMPORIT
 N ADMLOC,PATLOC,ORDLOC,LEVEL,DELAY,SCHLOC,SCHTYP
 S PATLOC=$P(FLDS,U,2)
 S ORDLOC=$S(ORIT["C":+$P($G(^OR(100,+$P(ORIT,"C",2),0)),U,10),1:0)
 S ORIMO=$G(ISIMO)
 S ORWMODE=0,ISXFER=""
 S:$E(ORIT)="C" ORWMODE=1 S:$E(ORIT)="T" ORWMODE=1,ISXFER=";T" ;treat xfer as copy
 S:$E(ORIT)="X" ORWMODE=2
 S TEMPORIT=ORIT
 I ORWMODE S ORIT=$E(ORIT,2,999)
 S LST(0)=""
 ;disable
 D CHKDSBL^ORWDXM3(.LST,ORIT,ORWMODE) Q:+LST(0)=8
 ;action
 D CHKVACT^ORWDXM3(.LST,ORIT,ORWMODE,$P(FLDS,U,3)) Q:+LST(0)=8
 ;no copy
 I ORWMODE=1 D CHKCOPY^ORWDXM3(.LST,ORIT,FLDS) Q:+LST(0)=8
 ;change
 I ORWMODE=2 D BLD4CHG^ORWDXM3(.LST,ORIT,FLDS) Q
 I 'ORWMODE,($P(^ORD(101.41,+ORIT,0),U,4)="D"),'($O(^DIC(9.4,"C","OR",0))[$P(^ORD(101.41,+ORIT,0),U,7)) S LST(0)="0^0^"_$$DLGINFO^ORWDXM3(ORIT,ORWMODE_ISXFER) Q
 N ORIMTYPE,ORCOMP,ORTAS,LRFZX,LRFSAMP,LRFSPEC,LRFDATE,LRFURG,LRFSCH
 N ORTIME,ORCOLLCT,ORMAX,ORTEST,ORIMTIME,ORSMAX,ORSTMS,ORSCH
 N PSJNOPC,ORMORE,ORINPT,ORXNP,ORSCHED,ORQTY,ORNOUNS,ORXNP,OREFILLS
 N ORCOMPLX,ORQTY,ORCOPAY,ORDRUG,ORWPSPIK,ORWPSWRG,ORSD,ORDSUP,ORWP94
 N ORPARAM,ORNPO,ORTIME,ORMEAL,ORTRAY,ORDATE,GMRCNOPD,GMRCNOAT,GMRCREAF
 N ORTYPE,ORVP,ORL,ORNP,ORSEX,ORAGE,ORWARD,OREVENT,ORDIV,ORSC,KEYVAR
 N ORDG,ORDIALOG,ORCAT,FIRST,ORQUIT,X,ORTRAIL,ORLEAD,RSPREF,AUTOACK
 N OREVNTYP
 S ORWP94=$O(^ORD(101.41,"AB","PS MEDS",0))>0
 S ORVP=$P(FLDS,U,1)_";DPT(",ORNP=+$P(FLDS,U,3),ORSC=$P(FLDS,U,8)
 S ORL=$P(FLDS,U,2)_";SC(",ORL(2)=ORL
 S ORSEX=$P(FLDS,U,5),ORAGE=$P(FLDS,U,6),ORTYPE="Q",FIRST=1
 I $P(FLDS,U,4),$G(^SC(+ORL,42)) S ORWARD=+^SC(+ORL,42)
 I $L($P(FLDS,U,7)) D
 . S OREVENT=$P(FLDS,U,7)
 . S OREVNTYP=$P(OREVENT,";",2)
 . S OREVENT("TS")=$P(OREVENT,";",3)
 . S OREVENT("EFFECTIVE")=$P(OREVENT,";",4)
 . S OREVENT=+$P(OREVENT,";",1)
 I 'ORWMODE D
 . D SETKEYV^ORWDXM3($P(FLDS,U,11,20)) ; from menu path
 . S KEYVAR=$$KEYVAR^ORWDXM3(ORIT) ; from entry action
 . D SETKEYV^ORWDXM3(KEYVAR)
 K ^TMP("ORWORD",$J)
 ; init return record based on auto-accept
 I ORWMODE S LST(0)="2^"_ORIT ;verify on copy
 E  S LST(0)=+$P($G(^ORD(101.41,ORIT,5)),U,8)_U_ORIT
 S TEMPCAT=$S($L($P($G(^DPT(+ORVP,.1)),U)):"I",1:"O")
 I TEMPCAT="I",+$P(FLDS,U,4)=1,$E(TEMPORIT)="C",$P($G(^ORD(100.98,$P($G(^OR(100,+ORIT,0)),U,11),0)),U)="OUTPATIENT MEDICATIONS" S TEMPCAT="O"
 I $L($G(OREVNTYP)) D
 . S ORCAT=$S(OREVNTYP="A":"I",OREVNTYP="T":"I",OREVNTYP="O":TEMPCAT,OREVNTYP="M":TEMPCAT,OREVNTYP="C":TEMPCAT,1:"O") I $G(OREVENT) D
 .. N X S X=$$EVT^OREVNTX(OREVENT),X=$P($G(^ORD(100.5,+X,0)),U,7)
 .. I OREVNTYP="T",X,X<4 S ORCAT="O" ;To pass=outpt
 .. I OREVNTYP="D",X=41 S ORCAT="I" ;From ASIH=inpt
 E  S ORCAT=TEMPCAT
 D SETUP^ORWDXM4 Q:+LST(0)=8
 S X="OR GTX START DATE"_$S($G(ORWP94):"/TIME",1:"")
 I ORWMODE,(ORDG=+$O(^ORD(100.98,"B","O RX",0))) D  ;remove old values
 . K ORDIALOG($$PTR^ORCD(X),1)
 . I ORWMODE=2,$$DRAFT^ORWDX2(ORIT) Q  ;keep comments
 . K:ISXFER'["T" ORDIALOG($$PTR^ORCD("OR GTX WORD PROCESSING 1"),1)
 D SETUPS^ORWDXM4 ;moved to save space, expects X
 Q:+LST(0)=8
 I $G(ORQUIT) S LST(0)="0^0^"_$$DLGINFO^ORWDXM3(ORIT,ORWMODE_ISXFER)_"^"_$G(KEYVAR) Q
 N SEQ,DA,XCODE,MUSTASK,PROMPT,INST,KEY,IVFID
 S IVFID=$O(^ORD(101.41,"B","PSJI OR PAT FLUID OE",0))
 S AUTOACK=$S($D(ORWPSWRG):0,1:1)
 ; If copying, clear bad dates. Later, SETITEM will fill dates with default values. ;DJE-VM *331
 I ORWMODE=1 D  ;
 . I $L($$VAL^ORCD("START DATE")) D  ;
 . . S X=$$VAL^ORCD("START DATE"),%DT="TX" D ^%DT
 . . I Y'<$$DT^XLFDT,(($L($$VAL^ORCD("STOP DATE"))=0)!('$$FTDCOMP^ORCD("START DATE","STOP DATE",">"))) Q  ;quit if valid dates: start not in the past or stop after start
 . . K ORDIALOG($$PTR("START DATE"),1),ORDIALOG($$PTR("START DATE/TIME"),1) ;erase bad start and stop dates.
 . . K ORDIALOG($$PTR("STOP DATE"),1),ORDIALOG($$PTR("STOP DATE/TIME"),1)
 . ; check start and stop dates found in diet orders
 . I $L($$VAL^ORCD("EFFECTIVE DATE/TIME")) D  ;
 . . S X=$$VAL^ORCD("EFFECTIVE DATE/TIME"),%DT="TX" D ^%DT
 . . I Y'<$$DT^XLFDT,(($L($$VAL^ORCD("EXPIRATION DATE/TIME"))=0)!('$$FTDCOMP^ORCD("EFFECTIVE DATE/TIME","EXPIRATION DATE/TIME",">"))) Q  ;quit if valid dates: start not in the past or stop after start
 . . K ORDIALOG($P(ORDIALOG("B","EFFECTIVE DATE/TIME"),U,2),1) ;erase bad start and stop dates.
 . . K ORDIALOG($P(ORDIALOG("B","EXPIRATION DATE/TIME"),U,2),1)
 . ; check date desired field found in imaging orders
 . I $L($$VAL^ORCD("DATE DESIRED")) D  ;
 . . S X=$$VAL^ORCD("DATE DESIRED"),%DT="TX" D ^%DT
 . . I Y'<$$DT^XLFDT Q  ;quit if not a past date
 . . K ORDIALOG($P(ORDIALOG("B","DATE DESIRED"),U,2),1) ;erase bad date
 . ; check collection date field found in lab orders
 . I $L($$VAL^ORCD("COLLECTION DATE/TIME")) D  ;
 . . S X=$$VAL^ORCD("COLLECTION DATE/TIME")
 . . I X="NEXT" Q  ;No need to check this.
 . . S %DT="TX" D ^%DT
 . . I $P(Y,".",2),Y'<$E($$NOW^XLFDT,1,12) Q  ;quit if not a past date and time (lab is more precise than other dates)
 . . I $P(Y,".",2)="",Y'<$$DT^XLFDT Q  ;
 . . K ORDIALOG($P(ORDIALOG("B","COLLECTION DATE/TIME"),U,2),1) ;erase bad date
 S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ)) Q:'SEQ  D
 . S DA=0 F  S DA=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ,DA)) Q:'DA  D
 . . ; skip if child prmpt
 . . I $P(^ORD(101.41,+ORDIALOG,10,DA,0),U,11) Q
 . . ; set dflt for prmpt, chk if interactive
 . . S PROMPT=$P(^ORD(101.41,+ORDIALOG,10,DA,0),U,2)
 . . D SETITEM(DA,PROMPT,1,.MUSTASK)
 . . I MUSTASK S AUTOACK=0 Q
 . . ; iterate through child items if parent & edit only
 . . Q:'$D(^ORD(101.41,+ORDIALOG,10,"DAD",PROMPT))
 . . N CSEQ,CDA,CPROMPT,INST,ORQUIT
 . . S CSEQ=0 F  S CSEQ=$O(^ORD(101.41,+ORDIALOG,10,"DAD",PROMPT,CSEQ)) Q:'CSEQ  D  Q:$G(ORQUIT)
 . . . S CDA=$O(^ORD(101.41,+ORDIALOG,10,"DAD",PROMPT,CSEQ,0))
 . . . S CPROMPT=$P(^ORD(101.41,+ORDIALOG,10,CDA,0),U,2)
 . . . ; if req & no instances then need interaction
 . . . I $P(^ORD(101.41,+ORDIALOG,10,CDA,0),U,6),ORDIALOG'=IVFID,'$O(ORDIALOG(CPROMPT,0)) S AUTOACK=0
 . . . S INST=0 F  S INST=$O(ORDIALOG(CPROMPT,INST)) Q:'INST  D
 . . . . N ORASK D VBASK^ORWDXM4(INST) ; set ORASK for VBECS
 . . . . ; set dflt for each child prmpt
 . . . . D SETITEM(CDA,CPROMPT,INST,.MUSTASK)
 . . . . ; if no val & child prmpt req'd then need interaction
 . . . . I MUSTASK,$P(^ORD(101.41,+ORDIALOG,10,CDA,0),U,6) S AUTOACK=0
 N IVDLG
 S IVDLG=$O(^ORD(101.41,"AB","PSJI OR PAT FLUID OE",0))
 I $$ISMED(ORIT),(ORDIALOG'=IVDLG),(ORCAT="I") D
 . F P="PATIENT INSTRUCTIONS","DAYS SUPPLY","QUANTITY","REFILLS","ROUTING","SERVICE CONNECTED" K ORDIALOG($$PTR(P),1)
 . I '$$ISQO(ORIT) K ORDIALOG($$PTR("START DATE/TIME"),1) ; kill if not a non-VA med quick order. p388
 S KEY=$S(ORWMODE:"C",1:"")_ORIT_"-"_$P($H,",",2),SEQ=0
 I $$ISINPMED(ORIT) D
 .S LEVEL=$P(LST(0),U),DELAY=$S($P($G(OREVENT),";")>0:1,1:0)
 .I LEVEL=2!(ISIMO) D ADMTIME^ORWDXM2(ORDLOC,PATLOC,ENCLOC,DELAY,ISIMO)
 I ($$ISMED(ORIT)),'($$VALQO^ORWDXM3(ORIT)) S AUTOACK=0
 S PROMPT=0 F  S PROMPT=$O(ORDIALOG(PROMPT)) Q:'PROMPT  D
 . I '$D(^ORD(101.41,ORDIALOG,10,"D",PROMPT)) K ORDIALOG(PROMPT) Q
 . S INST=0 F  S INST=$O(ORDIALOG(PROMPT,INST)) Q:'INST  D
 . . S SEQ=SEQ+1,^TMP("ORWDXMQ",$J,KEY,SEQ,0)=U_PROMPT_U_INST
 . . ; save word proc val
 . . I $E(ORDIALOG(PROMPT,0))="W",$L(ORDIALOG(PROMPT,INST)) D
 . . . M ^TMP("ORWDXMQ",$J,KEY,SEQ,2)=@ORDIALOG(PROMPT,INST)
 . . ; save other val types
 . . E  S ^TMP("ORWDXMQ",$J,KEY,SEQ,1)=ORDIALOG(PROMPT,INST)
 I AUTOACK D
 . I ORWMODE S AUTOACK=2
 . I 'ORWMODE,($P(^ORD(101.41,ORIT,0),U,8)!'LST(0)) S AUTOACK=2
 ;I ($$ISMED(ORIT)),'($$VALQO^ORWDXM3(ORIT)) S AUTOACK=0
 I ORIMO,ORWMODE S AUTOACK=2
 ; accept Herbal/OTC/NonVA Med quick orders
 ;DSS/SMP - BEGIN MODS
 N VFD S VFD=$G(^%ZOSF("ZVX"))["VX"
 I VFD,$L($G(^ORD(101.41,+ORIT,0))),($P($G(^ORD(100.98,+$P(^ORD(101.41,+ORIT,0),U,5),0)),U,3)="NV RX"),($P($G(^ORD(101.41,+ORIT,5)),U,8)) S AUTOACK=1
 I 'VFD,$L($G(^ORD(101.41,+ORIT,0))),($P(^ORD(100.98,$P(^ORD(101.41,+ORIT,0),U,5),0),U,3)="NV RX"),($P($G(^ORD(101.41,+ORIT,5)),U,8)) S AUTOACK=1
 ;DSS/SMP - END MODS
 ;I AUTOACK=2,$$ISMED(ORIT),(ORDIALOG=IVDLG),$$VERORD^ORWDXM3=0 S AUTOACK=0
 I AUTOACK=2,$$ISMED(ORIT),$$VERORD^ORWDXM3(ORIT)=0 S AUTOACK=0
 I AUTOACK=2 D VERTXT^ORWDXM2
 S LST(0)=AUTOACK_U_KEY_U_$$DLGINFO^ORWDXM3(ORIT,ORWMODE_ISXFER)_"^"_$G(KEYVAR)
 I $P(LST(0),U,4)="D" S $P(LST(0),U,4)="Q"
 I ORWMODE=1 S $P(LST(0),U,4)="C"
 K ^TMP("ORWORD",$J)
 K ^TMP("PSJINS",$J),^TMP("PSJMR",$J),^TMP("PSJNOUN",$J)
 Q
SETITEM(DA,PROMPT,INST,MUSTASK) ; set dflt val & return if must prompt
 N EDITONLY,Y,VALIV,XCODE
 S MUSTASK=0,EDITONLY=0,VALIV=0
 I $D(^TMP("ORWDHTM",$J,ORDIALOG,PROMPT)) D
 . I $E(ORDIALOG(PROMPT,0))="W" D
 . . S ^TMP("ORWORD",$J,PROMPT,INST,1,0)=^TMP("ORWDHTM",$J,ORDIALOG,PROMPT)
 . . S ORDIALOG(PROMPT,INST)="^TMP(""ORWORD"","_$J_","_PROMPT_","_INST_")"
 . E  S ORDIALOG(PROMPT,INST)=^TMP("ORWDHTM",$J,ORDIALOG,PROMPT)
 I $D(^TMP("ORWDHTM",$J,ORIT,PROMPT)) D
 . S ORDIALOG(PROMPT,INST)=^TMP("ORWDHTM",$J,ORIT,PROMPT)
 . ; NEED TO CLEAN UP ^TMP("ORWDHTM") after process order set!!!
 ;
 ; skip if a value already exists for this prompt and not WP
 Q:$D(ORDIALOG(PROMPT,INST))&($E(ORDIALOG(PROMPT,0))'="W")
 ; execute default action if no value in QO, checking EDITONLY afterwards
 I '$D(ORDIALOG(PROMPT,INST)) D
 . ;
 . ;Intermittent IV orders do not require a solution or an infusion rate
 . I PROMPT=$$PTR("INFUSION RATE"),$$GETIVTYP^ORWDXM3="I" S VALIV=1 Q
 . I PROMPT=$$PTR("ORDERABLE ITEM"),$$GETIVTYP^ORWDXM3="I" S VALIV=1 Q
 . I $E(ORDIALOG(PROMPT,0))="W",$D(^ORD(101.41,+ORDIALOG,10,DA,8))>9 D
 . . M ^TMP("ORWORD",$J,PROMPT,INST)=^ORD(101.41,+ORDIALOG,10,DA,8)
 . . S ORDIALOG(PROMPT,INST)="^TMP(""ORWORD"","_$J_","_PROMPT_","_INST_")"
 . E  D
 . . S XCODE=$$SUBCODE($G(^ORD(101.41,+ORDIALOG,10,DA,7)))
 . . I $L(XCODE) X XCODE S:$D(Y) ORDIALOG(PROMPT,INST)=Y
 Q:VALIV=1
 Q:$G(EDITONLY)
 I 'ORWMODE,$P($G(^ORD(101.41,+ORDIALOG,10,DA,0)),U,8) Q
 I ORWMODE,($P($G(^ORD(101.41,+ORDIALOG,10,DA,0)),U,9)'["W"),'$P($G(^ORD(101.41,+ORDIALOG,10,DA,0)),U,6)!$D(ORDIALOG(PROMPT,INST)) Q
 I 'ORWMODE,LST(0),$D(ORDIALOG(PROMPT,INST)),($E(ORDIALOG(PROMPT,0))="W") Q
 I 'ORWMODE,LST(0),'$P($G(^ORD(101.41,+ORDIALOG,10,DA,0)),U,6) Q
 S XCODE=$$SUBCODE($G(^ORD(101.41,+ORDIALOG,10,DA,3)))
 I $L(XCODE) X XCODE Q:'$T
 S MUSTASK=1
 Q
SUBCODE(X) ; substitute code
 I X["$$REQDCOMM^ORCDLR" Q "I $$LRRQCM^ORWDXM2"
 I X["$$ASKSAMP^ORCDLR" Q "I $$LRASMP^ORWDXM2"
 I X["$$SCHEDULD^ORCDRA1" Q "I $$SCHEDULD^ORWDXM2"
 I X["(^PSX(550,""C"")" Q "S Y=$E($$DEFPICK^ORWDPS32) K:'$L(Y) Y"
 I X["I $$ASKURG^ORCDVBEC" Q "I 1"
 I X["K:$G(ORASK)" Q "I $G(ORASK)"
 Q X
PTR(NAME) ; -- Returns pointer to OR GTX NAME
 Q +$O(^ORD(101.41,"AB",$E("OR GTX "_NAME,1,63),0))
 ;
ISINPMED(IFN) ;
 N PKG,RESULT,Y
 I 'ORWMODE S PKG=$P($G(^ORD(101.41,IFN,0)),U,7)
 E  S PKG=$P($G(^OR(100,+IFN,0)),U,14)
 S Y=$$GET1^DIQ(9.4,+PKG_",",1)
 S RESULT=$S($E(Y,1,3)="PSJ":1,1:0)
 Q RESULT
 ;
ISMED(IFN) ; return 1 if pharmacy order dlg used
 N PKG
 I 'ORWMODE S PKG=$P($G(^ORD(101.41,IFN,0)),U,7)
 E  S PKG=$P($G(^OR(100,+IFN,0)),U,14)
 Q $$NMSP^ORCD(PKG)="PS"
SITEVAL() ;return 1 if site does want the reason for study to carry through from past orders of this ordering session
 I $$GET^XPAR("ALL^SRV.`"_+^VA(200,DUZ,5),"OR RA RFS CARRY ON")=0 Q 0
 Q 1
SVRPC(RET,X) ;RPC FOR SITEVAL
 S RET=$$SITEVAL
 Q
ISQO(IFN) ;return 1 if a non-VA medication quick order type of order dialog. p388
 I $P($G(^ORD(101.41,IFN,0)),U,5)'=$O(^ORD(100.98,"B","NV RX",0)) Q 0
 I $P($G(^ORD(101.41,IFN,0)),U,4)="Q" Q 1
 Q 0
