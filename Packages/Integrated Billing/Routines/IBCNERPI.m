IBCNERPI ;ALB/EJK - IBCNE EIV SECONDARY INSURANCE REPORT PRINT;08-APR-2013
 ;;2.0;INTEGRATED BILLING;**497**;08-APR-13;Build 120
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; variables from IBCNESI:
 ;  IBCNERTN = "IBCNERPI"
 ;  ^TMP($J,"IBCNESI1")
 ;  IBCNESPC("TYPE")
 ;  IBCOMP - FLAG FOR COMPLETED ENTRIES
 ;  IBSDT - REPORT START DATE
 ;  IBEDT - REPORT END DATE
 Q
 ;
EN ; Entry point
 N DLINE,CRT,DFN,EORMSG,IBDFN,IBDOB,IBDT,IBEIEN,IBURTE,IBSTR1,IBSEQ,IBCNT
 S (IBPYR,RIEN,IBELG,IBDT,IBDFN,IBRIEN,IBEIEN)=""
 S (IBPGC,IBPXT)=0
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S EORMSG="*** END OF REPORT ***"
 ;S NPROC="Not Processed"
 S TSTAMP=$$FMTE^XLFDT($$NOW^XLFDT,1) ; time of report
 S TYPE=$G(IBCNESPC("TYPE")) ; report type
 S WIDTH=$S(TYPE="S":79,1:131)
 S IBSDT=$$FMTE^XLFDT(IBSDT,"5Z"),IBEDT=$$FMTE^XLFDT(IBEDT,"5Z")
 ; Determine IO parameters
 S MAXCNT=IOSL-6,CRT=0
 S:IOST["C-" MAXCNT=IOSL-3,CRT=1
 ; print data
 D HEADER I $G(ZTSTOP)!IBPXT Q
 ; If global does not exist - display No Data message
 I '$D(^TMP($J,"IBCNESI1")) D LINE($$FO^IBCNEUT1(NONEMSG,$$CENTER(NONEMSG),"R")) G EXIT
 F  S IBDT=$O(^TMP($J,"IBCNESI1",IBDT)) Q:IBDT=""  D  Q:$G(ZTSTOP)!IBPXT
 .F  S IBDFN=$O(^TMP($J,"IBCNESI1",IBDT,IBDFN)) Q:IBDFN=""  D  Q:$G(ZTSTOP)!IBPXT
 ..F  S IBRIEN=$O(^TMP($J,"IBCNESI1",IBDT,IBDFN,IBRIEN)) Q:IBRIEN=""  D  Q:$G(ZTSTOP)!IBPXT
 ...D PTHDR Q:$G(ZTSTOP)!IBPXT
 ...F  S IBEIEN=$O(^TMP($J,"IBCNESI1",IBDT,IBDFN,IBRIEN,"INS",IBEIEN)) Q:IBEIEN=""  D PTDTL Q:$G(ZTSTOP)!IBPXT
 ...Q:$G(ZTSTOP)!IBPXT
 ...D PTCMT
 ...Q
 ..Q
 .Q
 I $G(ZTSTOP)!IBPXT Q
 ;
EXIT ;
 D LINE($$FO^IBCNEUT1(EORMSG,$$CENTER(EORMSG),"R"))
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL
 K IBCNESPC("TYPE"),IBELG,IBPGC,IBPXT,IBPYR,IBRIEN,MAXCNT,NONEMSG,RIEN,TSTAMP,TYPE,WIDTH,IBCOMP,IBEDT,IBSDT,IBSORT
 Q
 ;
EOL ; display "end of page" message and set exit flag
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIN
 I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S IBPXT=1
 Q
 ;
HEADER ; print header for each page
 N DASHES,HDR,OFFSET,SRT
 ;
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL I IBPXT Q
 S TSTAMP=$$FMTE^XLFDT($$NOW^XLFDT,1) ; time of report
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 Q
 S IBPGC=IBPGC+1
 W @IOF,!,"Pt. Secondary Insurance Report"
 S HDR=TSTAMP_"  Page: "_IBPGC,OFFSET=WIDTH-$L(HDR)
 W ?OFFSET,HDR,!
 I IBSORT="+1" W "Sort: Chronological Order"
 I IBSORT=-1 W "Sort: Reverse Chronological Order"
 S HDR=IBSDT_" - "_IBEDT
 S OFFSET=WIDTH-$L(HDR)
 W ?OFFSET,HDR,!
 W "Includes: "
 W $S(IBCOMP=3!(IBCOMP=4):"non-",1:""),"Completed Entries"
 W $S(IBCOMP=1!(IBCOMP=3):" without",1:" with")," associated comments"
 W !
 Q
 ;
PTHDR ;HEADER FOR EACH PATIENT ENTRY
 N REVSTAT
 W !,$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"PATIENT NAME"))
 S IBDOB=$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"DOB"))
 I IBDOB>0 S IBDOB=17000000+IBDOB,IBDOB=$E(IBDOB,5,6)_"/"_$E(IBDOB,7,8)_"/"_$E(IBDOB,1,4)
 W "  "_IBDOB
 S REVSTAT=$P($G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"REV STATUS")),U)
 W "  Review Status: "_$S(REVSTAT=0:"Not Reviewed",REVSTAT=1:"In Process",REVSTAT=2:"Complete",1:"")
 S $P(DASHES,"-",WIDTH)="" D LINE(DASHES)
 Q
 ;
PTDTL ;PRINT PATIENT DETAIL LINES
 S DLINE=IBDT*IBSORT,DLINE=$$FMTE^XLFDT(DLINE,"5Z") D LINE(DLINE)
 S DLINE=$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"EMFLAG"))_"   "_$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"NAME")) D LINE(DLINE) Q:$G(ZTSTOP)!IBPXT
 I $G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"ID"))]"" S DLINE="     Payer ID: "_$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"ID")) D LINE(DLINE) Q:$G(ZTSTOP)!IBPXT
 I $G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"ADDRESS 1"))]"" S DLINE="     "_$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"ADDRESS 1")) D LINE(DLINE) Q:$G(ZTSTOP)!IBPXT
 I $G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"ADDRESS 2"))]"" S DLINE="     "_$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"ADDRESS 2")) D LINE(DLINE) Q:$G(ZTSTOP)!IBPXT
 S DLINE="     "
 S DLINE=DLINE_$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"CITY"))_", "
 S DLINE=DLINE_$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"STATE"))_" "
 S DLINE=DLINE_$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,"ZIP"))
 D LINE(DLINE) I $G(ZTSTOP)!IBPXT Q
 F IBURTE="TE","UR" D  I $G(ZTSTOP)!IBPXT Q
 . S IBSEQ=0,IBSEQ=$O(^TMP($J,"IBCNESI2",IBRIEN,"INS",IBEIEN,IBURTE,IBSEQ)) Q:'IBSEQ
 . S IBSTR1=$S(IBURTE="TE":"Phone: ",1:"Website: ")_^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"INS",IBEIEN,IBURTE,IBSEQ) D WRAP^IBCNESI2(.IBSTR1,70)
 . F IBCNT=1:1:$O(IBSTR1(""),-1) S DLINE="     "_IBSTR1(IBCNT) D LINE(DLINE) I $G(ZTSTOP)!IBPXT Q
 . Q
 I '$G(ZTSTOP)&'IBPXT D LINE("")
 Q
PTCMT ; print comments
 ; print comments
 N DIWF,DIWL,DIWR,IBCMDT,IBCMIEN,IBLN,IBRVIEN,IENS,X
 I '+$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"NO CMNT")) D
 .D LINE("") I $G(ZTSTOP)!IBPXT Q
 .D LINE("Comments:") I $G(ZTSTOP)!IBPXT Q
 .D LINE("") I $G(ZTSTOP)!IBPXT Q
 .S IBRVIEN=+$G(^TMP($J,"IBCNESI1",IBDT*IBSORT,IBDFN,IBRIEN,"REV IEN"))
 .I '$D(^IBCN(365.2,IBRVIEN,1)) D LINE("     No Comments Entered."),LINE("") Q
 .S IBCMDT="" F  S IBCMDT=$O(^IBCN(365.2,IBRVIEN,1,"B",IBCMDT),-1) Q:'IBCMDT!$G(ZTSTOP)!IBPXT  D
 ..S IBCMIEN=$O(^IBCN(365.2,IBRVIEN,1,"B",IBCMDT,"")) I IBCMIEN="" Q
 ..S IENS=IBCMIEN_","_IBRVIEN_","
 ..S DLINE=$$FMTE^XLFDT($$GET1^DIQ(365.21,IENS,.01),"5Z")_"     Entered by: "_$$GET1^DIQ(365.21,IENS,.02)
 ..D LINE(DLINE) I $G(ZTSTOP)!IBPXT Q
 ..K ^UTILITY($J,"W")
 ..F IBLN=1:1:$P($G(^IBCN(365.2,IBRVIEN,1,IBCMIEN,1,0)),U,3) S X=$G(^IBCN(365.2,IBRVIEN,1,IBCMIEN,1,IBLN,0)),DIWL=1,DIWR=70,DIWF="" D ^DIWP
 ..I $D(^UTILITY($J,"W")) S IBLN=0 F  S IBLN=$O(^UTILITY($J,"W",1,IBLN)) Q:'IBLN!$G(ZTSTOP)!IBPXT  D
 ...S DLINE="     "_$G(^UTILITY($J,"W",1,IBLN,0)) D LINE(DLINE)
 ...Q
 ..I '$G(ZTSTOP),'IBPXT,$O(^IBCN(365.2,IBRVIEN,1,"B",IBCMDT),-1)'="" D LINE("")
 ..Q
 .D LINE("") ; blank line before next person
 .Q
 K ^UTILITY($J,"W")
 Q
 ;
LINE(LINE) ; Print line of data
 I $Y+1>MAXCNT D HEADER I $G(ZTSTOP)!IBPXT Q
 W !,?1,LINE
 Q
 ;
CENTER(LINE) ; return length of a centered line
 ; LINE - line to center
 N LENGTH,OFFSET
 S LENGTH=$L(LINE),OFFSET=IOM-$L(LINE)\2
 Q OFFSET+LENGTH
