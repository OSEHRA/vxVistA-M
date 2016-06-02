ORWLEX ; ISL/JER - RPCs wrapping Lexicon APIs;03/22/13  16:24 ;12/05/13  13:15
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**385**;Dec 17, 1997;Build 12
 Q
GETI10DX(ORY,ORX,ORDT) ; RPC ORWLEX GET10DX
 N FILTER,PSFIL S (FILTER,PSFIL)=""
 S:+$G(ORDT)'>0 ORDT=DT
 S ORX=$$UP^XLFSTR(ORX)
 I ORX[" NOT " D
 . N I,XNOT,XCT,X1,X2,FIL
 . S XCT=$L(ORX," NOT ")
 . F I=2:1:XCT S XNOT=$P(ORX," NOT ",I) Q:$L(XNOT)=0  D
 .. S FILTER=FILTER_"I $$UP^XLFSTR(^LEX(757.01,+Y,0))'["""_XNOT_""" "
 .. S PSFIL=PSFIL_"I $$UP^XLFSTR(ORTXT)'["""_XNOT_""" "
 . I $E(FILTER,$L(FILTER))=" " S FILTER=$E(FILTER,1,$L(FILTER)-1)
 . I $E(PSFIL,$L(PSFIL))=" " S PSFIL=$E(PSFIL,1,$L(PSFIL)-1)
 . S XCT=$L(ORX," ")
 . F I=1:1:XCT S X1=$P(ORX," ",I) D
 .. I X1'="NOT" S X2=$G(X2)_X1_" " Q
 .. I X1="NOT" S I=I+1
 . S ORX=X2
 . S FIL=$G(^TMP("LEXSCH",$J,"FIL",0)) I FIL'="" S FILTER=FIL_" "_FILTER
 . S ^TMP("LEXSCH",$J,"FIL",0)=FILTER
 I ORX[" OR " D  Q
 . N XCT,XCT1,XN,XN1
 . S ^TMP($J,"ORWLEX","STEXT")=ORX
 . S XCT1=$L(ORX," OR ")
 . F XN=1:1:XCT1 S ORX=$P(^TMP($J,"ORWLEX","STEXT")," OR ") Q:$L(ORX)=0  S ^("STEXT")=$P(^TMP($J,"ORWLEX","STEXT")," OR ",2,XCT1) D
 .. D SEARCH(.ORY,ORX,ORDT,FILTER,PSFIL)
 .. M ^TMP($J,"ORWLEX","STEXT",XN)=ORY
 .. K ORY
 . S (XN,XCT)=0
 . F  S XN=$O(^TMP($J,"ORWLEX","STEXT",XN)) Q:+XN'>0  D
 .. S XN1=0
 .. F  S XN1=$O(^TMP($J,"ORWLEX","STEXT",XN,XN1)) Q:+XN1'>0  S XCT=XCT+1,ORY(XCT)=^(XN1)
 . K ^TMP($J,"ORWLEX","STEXT")
 ; execute the search
 D SEARCH(.ORY,ORX,ORDT,FILTER,PSFIL)
 Q
SEARCH(ORY,ORX,ORDT,ORFILTER,ORPSFIL) ; Call $$DIAGSRCH^LEX10CS to fetch I10 categories &/or codes
 N ORLEXY,ORESULTS,ORCNT,ORI,ORJ,ORPRUNE,ORCODSYS,ORIMPDT
 S ORIMPDT=$$IMPDATE^LEXU("10D")
 S ORDT=$G(ORDT,DT),ORFILTER=$G(ORFILTER),ORPSFIL=$G(ORPSFIL)
 S ORCODSYS=$S(ORDT'<ORIMPDT:"ICD-10-CM",1:"ICD-9-CM")
 ; Set Applications Default Flag (Lexicon can not overwrite filter)
 S ^TMP("LEXSCH",$J,"ADF",0)=1
 S ORLEXY=$$DIAGSRCH^LEX10CS(ORX,.ORESULTS,ORDT,"",ORFILTER)
 I +ORLEXY=-1 D  Q
 . S ORY(1)=ORLEXY_U_ORCODSYS_U
 S ORCNT=+$P(ORLEXY,U),ORPRUNE=+$P(ORLEXY,U,2)
 S (ORI,ORJ)=0
 F  S ORI=$O(ORESULTS(ORI)) Q:+ORI'>0  D
 . N ORLEX,ORTXT,ORCODE,ORICDID
 . S ORJ=ORJ+1
 . S ORLEX=+$G(ORESULTS(ORI,"LEX",1)) S:ORLEX=0 ORLEX="+"
 . S ORTXT=$G(ORESULTS(ORI,"MENU"))
 . I $L(ORPSFIL) X ORPSFIL Q:'$T
 . S ORCODE=$P($G(ORESULTS(ORI,0)),U),ORICDID=+$$ICDDATA^ICDXCODE("DIAG",ORCODE,ORDT,"E")
 . S ORY(ORJ)=$$SETELEM^ORWPCE4(ORLEX,ORTXT,ORCODSYS,ORCODE,ORDT)
 . S $P(ORY(ORJ),U,9)=$S(+ORICDID:ORICDID,1:"")
 I +ORLEXY=-2 S ORY(ORJ+1)=ORLEXY_U_ORCODSYS_U
 Q
GETFREQ(ORY,ORSRCHTX) ; Call $$FREQ^LEXU to fetch the frequency of use of keywords contained in search string
 S ORY=$$FREQ^LEXU(ORSRCHTX) ; ICR #5679
 Q
