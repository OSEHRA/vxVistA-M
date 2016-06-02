IBDFUTL5 ;ALB/MKN/CFS - CONTINUED FROM IBDUTL4 ;12/30/2011
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;Dec 30, 2011;Build 80
 ;
 ;
CHECKCL(IBDCLIN,IBDTAINS,IBDSORT,ARY,IBDGPNA) ;Check by Clinic
 ; -- input IBDCLIN = IEN of Clinic file
 ;         IBDTAINS = 9 or 10 or B or N or A
 ; -- output is an array in ARY as follows:
 ;          @ARY(0) = Number of rows in @ARY
 ;          @ARY(#) = P1 := Encounter Form name
 ;                    P2 := Contains ICD-9/ICD-10/BOTH
 ;                    P3 := Date Last Edited ICD-9
 ;                    P4 := Date Last Edited ICD-10
 ;                    P5 := ICD-10 Update Status
 ;                    P6 := Clinic Name
 ;
 N IBDI9,IBDI10,IBDX,IBDI,IBDQUIT,IBDFORMS,IBDFORM,IBDBLK,IBDY9,IBDY10,IBDLIST,IBDRES,IBDADD,IBDCLNA,IBDDATA,IBDBLKX
 N IBDFMNA,IBDFMX,IBDOK,IBDSUB,IBDDET,IBDSELX,IBDBLKNA,IBDLI,IBDSC
 ;
 I $G(IBDCLIN)="" G CHECKCLQ
 I $G(^SC(IBDCLIN,0))="" G CHECKCLQ
 S IBDCLNA=$P(^SC(IBDCLIN,0),U,1) S:IBDCLNA="" IBDCLNA="Unknown"
 S IBDFORMS=$G(^SD(409.95,+$O(^SD(409.95,"B",IBDCLIN,0)),0))
 G:IBDFORMS="" CHECKCLQ
 F IBDI=2,3,4,6,8,9 S IBDFORM=$P(IBDFORMS,U,IBDI) I IBDFORM?1.N D CHECKFRM
 ;
CHECKCLQ ;
 Q
 ;
CHECKFM(IBDEFORM,IBDTAINS,IBDSORT,ARY,IBDGPNA) ;Check by Form
 ; -- input IBDEFORM = IEN of Encounter Form file
 ;         IBDTAINS = 9 or 10 or B or N or A
 ; -- output is an array in ARY as follows:
 ;          @ARY(0) = Number of rows in @ARY
 ;          @ARY(#) = P1 := Encounter Form name
 ;                    P2 := Contains ICD-9/ICD-10/BOTH
 ;                    P3 := Date Last Edited ICD-9
 ;                    P4 := Date Last Edited ICD-10
 ;                    P5 := ICD-10 Update Status
 ;                    P6 := Clinic Name
 ;          
 N IBDI9,IBDI10,IBDX,IBDI,IBDQUIT,IBDFORMS,IBDFORM,IBDBLK,IBDY9,IBDY10,IBDLIST,IBDRES,IBDADD,IBDCLNA,IBDDATA,IBDBLKX
 N IBDFMNA,IBDFMX,IBDFMSTA,IBDOK,IBDSUB,IBD9ED,IBD10ED,IBDLTSEL,IBDDET,IBDSELX,IBDBLKNA,IBDLI,IBDSC,IBDSYS,IBDCL,IBDYES
 ;
 S IBDX=$G(^IBE(357,IBDEFORM,0)) I IBDX="" G CHECKFMQ
 S IBDFMNA=$P(^IBE(357,IBDEFORM,0),U,1) G:IBDFMNA="" CHECKFMQ
 I (+$P(IBDX,U,7))&(($P(IBDX,U)="TOOL KIT")!($P(IBDX,U)="WORKCOPY")) G CHECKFMQ ; Ignore TOOLKIT and WORCOPY forms per SMES 2/29/12
 S IBDFORM=IBDEFORM,IBDCL=$O(^TMP("IBDFUTL4",$J,"X","FMARR",IBDFMNA,""))
 I IBDCL="" S IBDCLNA="",IBDCLIN=""
 I IBDCL?1.N S IBDX=$G(^SC(IBDCL,0)) G:IBDX="" CHECKFMQ S IBDCLNA=$P(IBDX,U,1)
 D CHECKFRM
 ;
CHECKFMQ ;
 Q
 ;
CHECKFRM ;Check this Form - go through each Block attached to Form, check ICD-9/ICD-10 relevance against user input selection\
 ;
 N IBDBLHD,IBDPIEN,IBDX,IBDY,IBDADD,IBDWH,IBDQUIT,IBDRES,IBD9ED,IBD10ED,IBDFMSTA,IBD9HIS,IBD10HIS,IBDLTSEL,IBDSYS,IBDCODE
 S (IBDY9,IBDY10,IBDBLK,IBDADD,IBDYES,IBDQUIT)=0,(IBD9HIS,IBD10HIS,IBD9ED,IBD10ED,IBDFMSTA)=""
 S IBDX=$O(^IBE(357,IBDFORM,3,"B",1,"")) I IBDX?1.N S IBD9HIS=^IBE(357,IBDFORM,3,IBDX,0),IBDFMSTA=$P(IBD9HIS,U,2)
 S IBDX=$O(^IBE(357,IBDFORM,3,"B",30,"")) I IBDX?1.N S IBD10HIS=^IBE(357,IBDFORM,3,IBDX,0),IBDFMSTA=$P(IBD10HIS,U,2)
 I IBDINP("STATUS")'="A" D
 . I IBDX="",IBDINP("STATUS")'="I" S IBDQUIT=1 Q
 . I IBDX'="" D
 . . I IBDINP("STATUS")="I",IBDFMSTA'="" S IBDQUIT=1 Q
 . . I IBDINP("STATUS")="C",IBDFMSTA'="C" S IBDQUIT=1 Q
 . . I IBDINP("STATUS")="R",IBDFMSTA'="R" S IBDQUIT=1 Q
 Q:IBDQUIT
 ;
 S IBD9ED=$P(IBD9HIS,U,3),IBD10ED=$P(IBD10HIS,U,3) ;Seed the Edit Dates for checking at Selection level below
 ;
 K IBDDET ;This will contain Detail lines if Detail option selected
 S IBDFMX=$G(^IBE(357,IBDFORM,0)),IBDFMNA=$P(IBDFMX,U,1) S:IBDFMNA="" IBDFMNA="Unknown"
 I IBDINP("SORTBY")="SF" Q:'$D(IBDINP("FORM",IBDFMNA))
 I IBDINP("SORTBY")="RF" Q:IBDINP("FORM","RF",1)]IBDFMNA!(IBDFMNA]IBDINP("FORM","RF",2))
 ;This loop goes through all blocks and lists and sets the flags where ICD-9 or ICD-10 are present
 F  S IBDBLK=$O(^IBE(357.1,"C",IBDFORM,IBDBLK)) Q:'IBDBLK  S IBDLIST=0 D
 . S IBDX=^IBE(357.1,IBDBLK,0),IBDBLKNA=$P(IBDX,U,1),IBDBLHD=""
 . F  S IBDLIST=$O(^IBE(357.2,"C",IBDBLK,IBDLIST)) Q:'IBDLIST  D
 . . S IBDX=^IBE(357.2,IBDLIST,0),IBDPIEN=$P(IBDX,U,11) ;Package Interface IEN
 . . S IBDX=^IBE(357.6,IBDPIEN,0),IBDSYS=$P(IBDX,U,22) Q:IBDSYS'=1&(IBDSYS'=30)  ;Coding System field
 . . I IBDSYS?1.N S IBDX=$$SINFO^ICDEX(IBDSYS) S:$P(IBDX,U,2)="ICD-9-CM" IBDY9=1 S:$P(IBDX,U,2)="ICD-10-CM" IBDY10=1
 . . ;Now compare with the user selection - ICD9/ICD10/Both/Neither
 . . I IBDTAINS=9,IBDY9=0 Q
 . . I IBDTAINS=10,IBDY10=0 Q
 . . I IBDTAINS="B",IBDY9=0!(IBDY10=0) Q
 . . I IBDTAINS="N",IBDY9=1!(IBDY10=1) Q
 . . ;Now find ICD-9/10 Status and history dates at the Selection level and update Latest Edit date where required
 . . K ^TMP("IBDFUTL4X",$J,"X","BLCODE")
 . . S IBDLTSEL="" F  S IBDLTSEL=$O(^IBE(357.3,"C",IBDLIST,IBDLTSEL)) Q:IBDLTSEL=""  D
 . . . S IBDX=$G(^IBE(357.3,IBDLTSEL,4))
 . . . I $P(IBDX,U,1)>IBD9ED S IBD9ED=$P(IBDX,U,1)
 . . . I $P(IBDX,U,2)>IBD10ED S IBD10ED=$P(IBDX,U,1)
 . . . I IBDINP("SD")="D" D
 . . . . S:IBDBLHD="" IBDX=$O(IBDDET(""),-1)+1,IBDDET(IBDX)="BL^"_IBDBLKNA,IBDBLHD=IBDBLKNA
 . . . . S IBDX=^IBE(357.3,IBDLTSEL,0),IBDDATA=$$ICDDATA^ICDXCODE(IBDSYS,$P(IBDX,U,1)),IBDCODE=$P(IBDX,U,1)
 . . . . I '$D(^TMP("IBDFUTL4X",$J,"X","BLCODE",IBDCODE)) S IBDSELX="LT^"_IBDLTSEL_U_IBDCODE_U_$P(IBDDATA,U,4),IBDX=$O(IBDDET(""),-1)+1,IBDDET(IBDX)=IBDSELX,^TMP("IBDFUTL4X",$J,"X","BLCODE",IBDCODE)=""
 ;We are now back at form level (357) and we know this form needs to be included in the list if user selection agrees
 S IBDYES=1 D
 .I IBDTAINS=9&((IBDY9=0)!(IBDY10=1)) S IBDYES=0 Q
 .I IBDTAINS=10&((IBDY9=1)!(IBDY10=0)) S IBDYES=0 Q
 .I IBDTAINS="B"&((IBDY9=0)!(IBDY10=0)) S IBDYES=0 Q
 .I IBDTAINS="N"&((IBDY9=1)!(IBDY10=1)) S IBDYES=0 Q
 Q:IBDYES=0
 S IBDRES=""
 I IBDY9=1 S IBDRES="ICD9"
 I IBDY10=1 D
 . I IBDY9=1 S IBDRES="BOTH"
 . E  S IBDRES="ICD10"
 I $E(IBDSORT,2)="C" S IBDSUB=IBDCLNA D SET
 I $E(IBDSORT,2)="F" S IBDSUB=IBDFMNA D SET
 I $E(IBDSORT,2)="G" S IBDSUB=IBDGPNA D SET
 Q
 ;
SET ;
 N IBDY,IBD9DA,IBD10DA
 S (IBD9DA,IBD10DA)=""
 I IBD9ED>0 S IBD9DA=$E(IBD9ED,4,5)_"/"_$E(IBD9ED,6,7)_"/"_$E(IBD9ED,2,3)
 I IBD10ED>0 S IBD10DA=$E(IBD10ED,4,5)_"/"_$E(IBD10ED,6,7)_"/"_$E(IBD10ED,2,3)
 S IBDY=$S(IBDFMSTA="":"",IBDFMSTA="C":"COMP",IBDFMSTA="I":"",IBDFMSTA="R":"REV",1:"")
 I $E(IBDSORT,2)'="G" D
 . S @ARY@("S",IBDSUB,IBDFMNA)=IBDFMNA_U_IBDRES_U_IBD9DA_U_IBD10DA_U_IBDY_U_IBDCLNA_U_IBDCLIN_U_IBDFORM_U_$G(IBDGPNA)
 . I IBDINP("SD")="D" M @ARY@("S",IBDSUB,IBDFMNA,"D")=IBDDET
 I $E(IBDSORT,2)="G" D
 . I IBDGPNA="" S IBDGPNA="Unknown"
 . S @ARY@("S",IBDGPNA,IBDCLNA,IBDFMNA)=IBDFMNA_U_IBDRES_U_IBD9DA_U_IBD10DA_U_IBDY_U_IBDCLNA_U_IBDCLIN_U_IBDFORM_U_IBDGPNA
 . I IBDINP("SD")="D" M @ARY@("S",IBDGPNA,IBDCLNA,IBDFMNA,"D")=IBDDET
 Q
 ;
GRHEADNG(IBDGPNA,IBDCT) ;List each clinic under its grouped heading.
 N IBDX
 S IBDX="",IBDX=$$SETSTR^VALM1(" ",IBDX,1,3)
 S ^TMP("IBDFUTL4",$J,IBDCT,0)=IBDX
 S ^TMP("IBDFUTL4X",$J,"X","GPNA",IBDGPNA,IBDCT)=""
 S IBDCT=IBDCT+1,VALMCNT=VALMCNT+1
 S IBDVAL1=$L(IBDGPNA) S IBDVAL1=(80-IBDVAL1)/2 S IBDVAL1=IBDVAL1\1 S IBDX="",IBDX=$$SETSTR^VALM1(" ",IBDX,1,IBDVAL1)
 S IBDX=$$SETSTR^VALM1(IBDGPNA,IBDX,IBDVAL1,25)
 S ^TMP("IBDFUTL4",$J,IBDCT,0)=IBDX
 S ^TMP("IBDFUTL4X",$J,"X","GPNA",IBDGPNA,IBDCT)=""
 S IBDCT=IBDCT+1,VALMCNT=VALMCNT+1
 D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM,0)
 S IBDX="",IBDX=$$SETSTR^VALM1(" ",IBDX,1,3)
 S ^TMP("IBDFUTL4",$J,IBDCT,0)=IBDX
 S ^TMP("IBDFUTL4X",$J,"X","GPNA",IBDGPNA,IBDCT)=""
 S IBDCT=IBDCT+1,VALMCNT=VALMCNT+1
 Q
 ;
