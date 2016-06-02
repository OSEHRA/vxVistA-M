TIUBR1 ;SLC/JER - Enter TIU Browse with DFN and TIUDA ;8/21/01 [12/15/04 9:18am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**31,100,123,176,157,241**;Jun 20, 1997;Build 7
 ; Move LOADSIG, XTRASIG, LOADFOR, LOADREC from TIUBR. **100**
 ;
LOADREC(TIUDA,TIUL,TIUGDATA,TIUGWHOL) ; Load ^TMP
 ;Requires TIUDA, array TIUL, TIUGDATA
 ;Optional TIUGWHOL = 1 if we're mid-load for browse, and we're already
 ;                    loading the whole note after the selected child,
 ;                    so DON'T load the whole note again.
 N TIUKID,TIUI,CANSEE,TIUPARNT,TIUPNAME,TIUPDATE
 N TIUGPRNT,TIUPDATA,TIUHASKD
 S TIUI=0
 ; ---- If user cannot view TIUDA, say so,
 ;      [load the rest of the ID note], & quit: ----
 S CANSEE=$S(+$$ISCOMP^TIUBR(TIUDA)>0:1,1:$$CANDO^TIULP(+TIUDA,"VIEW"))
 I +CANSEE'>0 D  Q
 . S TIUL=+$G(TIUL)+1
 . S @VALMAR@(TIUL,0)=$P(CANSEE,U,2)
 . I $P(TIUGDATA,U,2)!$P(TIUGDATA,U,3) D IDREST(TIUDA,.TIUL,TIUGDATA,.TIUGWHOL)
 ; ---- Load text of TIUDA: ----
 F  S TIUI=$O(^TIU(8925,+TIUDA,"TEXT",TIUI)) Q:+TIUI'>0  D
 . S TIUL=+$G(TIUL)+1
 . S @VALMAR@(TIUL,0)=$G(^TIU(8925,+TIUDA,"TEXT",+TIUI,0))
 ; ---- If TIUDA is a COMPONENT, QUIT
 Q:+$$ISCOMP^TIUBR(TIUDA)
 ; ---- If TIUDA **IS** an addendum, load addm signature,
 ;         load original document, quit: ----
 I +$$ISADDNDM^TIULC1(+TIUDA) D  Q
 . N TIULINE S $P(TIULINE,"=",79)=""
 . D LOADSIG(TIUDA,.TIUL)
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=""
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=TIULINE
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=""
 . S TIUPARNT=+$P(^TIU(8925,+TIUDA,0),U,6)
 . S TIUPNAME=$$PNAME^TIULC1(+^TIU(8925,TIUPARNT,0))
 . S TIUPDATE=+$G(^TIU(8925,TIUPARNT,13))
 . S TIUPDATE=$$DATE^TIULS(TIUPDATE,"MM/DD/YY")
 . S TIUPDATA=$$IDDATA^TIURECL1(TIUPARNT)
 . S TIUHASKD=$P(TIUPDATA,U,2),TIUGPRNT=+$P(TIUPDATA,U,3)
 . S TIUL=+$G(TIUL)+1
 . I 'TIUHASKD,'TIUGPRNT D
 . . S @VALMAR@(TIUL,0)=" --- Original Document ---"
 . . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=""
 . . S TIUL=+$G(TIUL)+1
 . . S @VALMAR@(TIUL,0)=TIUPDATE_" "_TIUPNAME_":"
 . . D LOADREC(TIUPARNT,.TIUL,TIUGDATA)
 . I TIUHASKD D
 . . S @VALMAR@(TIUL,0)=" --- Addended Interdisciplinary Note ---"
 . . D LOADID^TIUGBR(TIUPARNT,.TIUL,TIUPDATA,1)
 . I TIUGPRNT D
 . . S @VALMAR@(TIUL,0)=" --- Original Interdisciplinary Entry ---"
 . . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=""
 . . S TIUL=+$G(TIUL)+1
 . . S @VALMAR@(TIUL,0)=TIUPDATE_" "_TIUPNAME_":"
 . . D LOADREC(TIUPARNT,.TIUL,TIUGDATA)
 . . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=""
 . . S TIUL=+$G(TIUL)+1
 . . S @VALMAR@(TIUL,0)=" --- Interdisciplinary Note ---"
 . . D LOADID^TIUGBR(TIUGPRNT,.TIUL,TIUPDATA,1)
 ; ---- Load components of TIUDA: ----
 S TIUKID=0
 F  S TIUKID=$O(^TIU(8925,"DAD",+TIUDA,TIUKID)) Q:+TIUKID'>0  D
 . I +$$ISADDNDM^TIULC1(TIUKID)'>0 D LOADREC(TIUKID,.TIUL,TIUGDATA)
 ; ---- Load signature of TIUDA if TIUDA is not addm
 ;           or comp: ----
 I '$$ISCOMP^TIUBR(TIUDA) D LOADSIG(TIUDA,.TIUL)
 ; ---- Load addenda of TIUDA: ----
 S TIUKID=0
 F  S TIUKID=$O(^TIU(8925,"DAD",+TIUDA,TIUKID)) Q:+TIUKID'>0  D
 . ; If an addendum has focus, don't show it again unless
 . ; loading whole ID note:
 . I '$G(TIUGWHOL),+TIUKID=+$G(^TMP("TIU FOCUS",$J)) Q
 . I +$$ISADDNDM^TIULC1(TIUKID) D LOADADD^TIUBR(TIUKID,.TIUL)
 ; ---- Load the rest of the ID note display: ----
 I $P(TIUGDATA,U,2)!$P(TIUGDATA,U,3) D IDREST(TIUDA,.TIUL,TIUGDATA,.TIUGWHOL)
 Q
 ;
IDREST(TIUDA,TIUL,TIUGDATA,TIUGWHOL) ; Load rest of ID note display
 N IDDAD
 S IDDAD=+$P(TIUGDATA,U,3)
 ; ---- If Browsed Record is an ID child, & this cycle hasn't begun
 ;      loading the whole note, then load the whole ID Note after
 ;      the browsed child: ----
 I IDDAD,'$G(TIUGWHOL) D  Q
 . S TIUGWHOL=1
 . N TIULINE S $P(TIULINE,"=",79)=""
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=""
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=TIULINE
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=""
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=" --- Interdisciplinary Note ---"
 . D LOADID^TIUGBR(IDDAD,.TIUL,TIUGDATA,TIUGWHOL)
 ; ---- If Browsed Record is an ID parent, & this cycle has
 ;      just loaded the parent entry, OR
 ;      If Browsed Record is an ID child, & this cycle has begun
 ;      loading the whole ID note, and is currently loading the first
 ;      entry of the whole note,
 ;      Then load kids: ----
 I $P(TIUGDATA,U,2)&(TIUDA=+TIUGDATA)!(IDDAD&$G(TIUGWHOL)&(TIUDA=IDDAD)) D
 . D LOADKIDS^TIUBR(TIUDA,.TIUL,TIUGDATA,$G(TIUGWHOL)) K TIUGWHOL
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=""
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)="                      << Interdisciplinary Note - End >>"
 Q
EXSTNOTE(DFN,TIUDA) ; Sample/display existing notes
 N TIU,TIUPRM0,TIUPRM1,TIUSEE,TIUOUT,TIUY,TIUQUIT
 D SETPARM^TIULE
 Q:TIUDA'>0
 D GETTIU^TIULD(.TIU,+TIUDA)
 I $D(TIU) D
 . S TIUSEE=$$CANDO^TIULP(TIUDA,"VIEW")
 . I 'TIUSEE D  Q
 . . W !!,$C(7),$P(TIUSEE,U,2),!
 . . W:$$READ^TIUU("FOA","Press RETURN to continue...") ""
 . D EN^VALM("TIU BROWSE FOR CLINICIAN")
 . K ^TMP("TIUVIEW",$J)
 . S:$D(TIUQUIT) TIUOUT=1
 Q
 ;
LOADSIG(DA,TIUL) ; Get signature and co-signature blocks
 N DIC,DIQ,DR,TIUSIG,TIUESIG1,TIUESIG2,TIUSIG1,TIUSIG2,TIUS1,TIUS2
 N TIUSNM,TIUSTTL,TIUS1DT,TIUS2DT,TIUSDT
 ;VMP/ELR CHANGED NEXT LINE FROM QUIT IF NOT DEFINED TO GO TO XTRA
 I '$D(^TIU(8925,DA,15)) G XTRA
 S DIC=8925,DIQ="TIUSIG(",DIQ(0)="IE",DR="1204;1208;1501:1505;1507:1513;1601:1605"
 D EN^DIQ1 I '$D(TIUSIG) Q
 S TIUS1=$S(TIUSIG(8925,DA,1505,"I")="E":"/es/ ",TIUSIG(8925,DA,1505,"I")="C":"/s/ ",1:"")_$G(TIUSIG(8925,DA,1503,"E"))
 S TIUS2=$S(TIUSIG(8925,DA,1511,"I")="E":"/es/ ",TIUSIG(8925,DA,1511,"I")="C":"/s/ ",1:"")_$G(TIUSIG(8925,DA,1509,"E"))
 S TIUESIG1=$G(TIUSIG(8925,DA,1204,"I"))
 S TIUSIG1=$G(TIUSIG(8925,DA,1502,"I"))
 S TIUS1DT=$S(+$G(TIUSIG(8925,DA,1501,"I")):"Signed: "_$$DATE^TIULS($G(TIUSIG(8925,DA,1501,"I")),"MM/DD/CCYY HR:MIN"),1:"")
 S TIUESIG2=$G(TIUSIG(8925,DA,1208,"I"))
 S TIUS2DT=$S(+$G(TIUSIG(8925,DA,1507,"I")):"Cosigned: "_$$DATE^TIULS($G(TIUSIG(8925,DA,1507,"I")),"MM/DD/CCYY HR:MIN"),1:"")
 S TIUSIG2=$G(TIUSIG(8925,DA,1508,"I"))
 S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=" "
 S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=TIUS1
 S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=$G(TIUSIG(8925,DA,1504,"E"))
 S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=TIUS1DT
 I $G(TIUSIG(8925,DA,1505,"I"))="C" D
 . N TIUONCH
 . S TIUONCH=$G(TIUSIG(8925,DA,1512,"E")) I '$L(TIUONCH) S TIUONCH=$G(TIUSIG(8925,DA,1513,"E"))
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)="Marked signed on chart by: "_TIUONCH
 I TIUSIG1]"",(TIUSIG1'=TIUESIG1) D LOADFOR(TIUSIG1,TIUESIG1,.TIUL)
 I +$G(TIUSIG(8925,DA,1507,"I"))>0 D
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=" "
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=TIUS2
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=$G(TIUSIG(8925,DA,1510,"E"))
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=TIUS2DT
 . I $G(TIUSIG(8925,DA,1511,"I"))="C" D
 . . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)="Marked cosigned on chart by: "_$G(TIUSIG(8925,DA,1513,"E"))
 I TIUSIG2]"",(TIUSIG2'=TIUESIG2) D LOADFOR(TIUSIG2,TIUESIG2,.TIUL)
XTRA I +$O(^TIU(8925.7,"B",DA,0)) D XTRASIG(DA,.TIUL)
 I +$G(TIUSIG(8925,DA,1601,"I")) D
 . N TIUMODE
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=""
 . S TIUL=+$G(TIUL)+1
 . S @VALMAR@(TIUL,0)=$$DATE^TIULS(TIUSIG(8925,DA,1601,"I"),"MM/DD/CCYY HR:MIN")_"  AMENDMENT FILED:"
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)="",TIUL=+$G(TIUL)+1
 . S TIUMODE=$S(+$G(TIUSIG(8925,DA,1603,"I")):"/es/ ",1:" /s/ ")
 . S @VALMAR@(TIUL,0)=TIUMODE_$S($G(TIUSIG(8925,DA,1604,"E"))]"":$G(TIUSIG(8925,DA,1604,"E")),1:$G(TIUSIG(8925,DA,1602,"E")))
 . I $L($G(TIUSIG(8925,DA,1605,"E"))) D
 . . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=$G(TIUSIG(8925,DA,1605,"E"))
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=$P($G(TIUPRM1),U,5)
 Q
XTRASIG(TIUDA,TIUL) ; Load additional signature blocks
 N TIUI,DA,DR,DIC,DIQ,TIUXTRA S TIUI=0
 S DIC="^TIU(8925.7,",DIQ="TIUXTRA"
 S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=" "
 S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)="Receipt Acknowledged By:"
 F  S TIUI=$O(^TIU(8925.7,"B",TIUDA,TIUI)) Q:+TIUI'>0  D
 . N TIUX,TIUSGNR,TIUSDT
 . S DA=TIUI,DR=".03:.08",DIQ(0)="IE" D EN^DIQ1 Q:+$D(TIUXTRA)'>9
 . S TIUSGNR=$S($L($G(TIUXTRA(8925.7,DA,.06,"E"))):"/es/ "_$G(TIUXTRA(8925.7,DA,.06,"E")),1:"     "_$G(TIUXTRA(8925.7,DA,.03,"E")))
 . S TIUSDT=$S(+$G(TIUXTRA(8925.7,DA,.04,"I")):$$DATE^TIULS(TIUXTRA(8925.7,DA,.04,"I"),"MM/DD/CCYY HR:MIN"),1:"* AWAITING SIGNATURE *")
 . S TIUX=$$SETSTR^VALM1(TIUSDT,$G(TIUX),1,38)
 . S TIUX=$$SETSTR^VALM1(TIUSGNR,$G(TIUX),25,55)
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=TIUX,TIUX=""
 . S TIUX=$$SETSTR^VALM1($G(TIUXTRA(8925.7,DA,.07,"E")),$G(TIUX),30,50)
 . S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=TIUX
 . I $G(TIUXTRA(8925.7,DA,.05,"I")),$G(TIUXTRA(8925.7,DA,.05,"I"))'=$G(TIUXTRA(8925.7,DA,.03,"I")) D
 . . N TIUFOR
 . . S TIUX=""
 . . S TIUFOR="for "_$P($G(TIUXTRA(8925.7,DA,.03,"E")),",",2)_" "_$P($G(TIUXTRA(8925.7,DA,.03,"E")),",")
 . . S TIUX=$$SETSTR^VALM1(TIUFOR,$G(TIUX),26,55)
 . . S TIUL=TIUL+1,@VALMAR@(TIUL,0)=TIUX
 Q
LOADFOR(TIUS1,TIUES1,TIUL) ; Apply "for" block
 N TIUESN1,TIUEST1,TIUFORN,TIUFORT
 S TIUESN1="for "_$$SIGNAME^TIULS(TIUES1),TIUEST1=$$SIGTITL^TIULS(TIUES1)
 I +$G(TIUS1),($G(TIUS1)'=$G(TIUES1)) S TIUFORN=$$SETSTR^VALM1(TIUESN1,$G(TIUFORN),1,50),TIUFORT=$$SETSTR^VALM1(TIUEST1,$G(TIUFORT),1,50)
 S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=TIUFORN
 S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=TIUFORT
 Q
