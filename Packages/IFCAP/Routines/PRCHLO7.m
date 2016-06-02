PRCHLO7 ;SSOI&TFO/LKG-EXTRACT ROUTINE (cont.) CLO REPORT SERVER ;2/17/11  16:39
 ;;5.1;IFCAP;**154**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
INVCOMPL ;Compile list of invoices within date range
 K ^TMP($J,"PRCINVHDR"),^TMP($J,"PRCINVPAYT"),^TMP($J,"PRCINVFMS"),^TMP($J,"PRCINVCERTSVC")
 N PRCI,PRCINV,PRCJ,PRCK,PRCNOD0,PRCNOD1,PRCNOD2,PRCNOD21,PRCPER,PRCPOIEN,PRCSTUB,PRCVIEN,PRCX
 S PRCINV=0
 F  S PRCINV=$O(^PRCF(421.5,PRCINV)) Q:+PRCINV'=PRCINV  D
 . S PRCNOD0=$G(^PRCF(421.5,PRCINV,0)) Q:$P(PRCNOD0,U)'>0
 . S PRCNOD2=$G(^PRCF(421.5,PRCINV,2)),PRCNOD21=$G(^(2.1))
 . Q:$P(PRCNOD0,U,4)>CLOEND  Q:$P(PRCNOD0,U,5)>CLOEND
 . Q:$P(PRCNOD21,U,5)&($P(PRCNOD21,U,5)<CLOBGN)  Q:$P($P(PRCNOD21,U,5),".")>CLOEND
 . S PRCNOD1=$G(^PRCF(421.5,PRCINV,1)),PRCPOIEN=$P(PRCNOD0,U,7),PRCVIEN=$P(PRCNOD0,U,8)
 . I $$GET1^DIQ(442,PRCPOIEN_",",.1,"I")<CLOBGN,$P(PRCNOD21,U,5)<CLOBGN,$P(PRCNOD0,U,5)<CLOBGN Q
 . S PRCX=$P(PRCNOD0,U)_U_$P(PRCNOD1,U,2)_U_$S(PRCPOIEN>0:$$GET1^DIQ(442,PRCPOIEN_",",31),1:"")_U_MNTHYR_U_$P(PRCNOD0,U,3)_U_$$FMTE^XLFDT($P(PRCNOD0,U,4))
 . S PRCX=PRCX_U_$$FMTE^XLFDT($P(PRCNOD0,U,5))_U_$$GET1^DIQ(442,PRCPOIEN_",",.01)_U_PRCPOIEN_U_$$GET1^DIQ(442,PRCPOIEN_",",.02)_U_$P(PRCNOD1,U,3)
 . S PRCX=PRCX_U_$$GET1^DIQ(421.5,PRCINV_",",.6)_U_$$GET1^DIQ(421.5,PRCINV_",",4)
 . S ^TMP($J,"PRCINVHDR",PRCINV,1)=PRCX_U
 . S PRCX=$$GET1^DIQ(440,PRCVIEN_",",.01)_U_PRCVIEN_U_$$GET1^DIQ(440,PRCVIEN_",",34)_U_$$GET1^DIQ(440,PRCVIEN_",",35)_U_$$GET1^DIQ(440,PRCVIEN_",",18.3)
 . S PRCX=PRCX_U_$P(PRCNOD0,U,12)_U_$$GET1^DIQ(421.5,PRCINV_",",11)_U_$$FMTE^XLFDT($P(PRCNOD0,U,21))_U_$S($P(PRCNOD0,U,14)'="":$FN($P(PRCNOD0,U,14)/100,"",2),1:"")
 . S PRCX=PRCX_U_$S($P(PRCNOD0,U,15)'="":$FN($P(PRCNOD0,U,15)/100,"",2),1:"")
 . S PRCX=PRCX_U_$$FMTE^XLFDT($P(PRCNOD1,U,4))_U_$$GET1^DIQ(421.5,PRCINV_",",25)_U_$P(PRCNOD1,U,6)_U_$P(PRCNOD1,U,7)
 . S PRCX=PRCX_U_$S($P(PRCNOD1,U,8)'="":$FN($P(PRCNOD1,U,8)/100,"",2),1:"")
 . S PRCX=PRCX_U_$S($P(PRCNOD1,U,9)'="":$FN($P(PRCNOD1,U,9)/100,"",2),1:"")
 . S PRCX=PRCX_U_$$GET1^DIQ(421.5,PRCINV_",",50)_U_$P(PRCNOD2,U,2)_U_$P(PRCNOD2,U,3)_U_$P(PRCNOD2,U,4)_U_$TR($$FMTE^XLFDT($P(PRCNOD2,U,5)),"@"," ")
 . S ^TMP($J,"PRCINVHDR",PRCINV,2)=PRCX_U
 . S PRCPER=$P(PRCNOD2,U,17),PRCX=$$GET1^DIQ(200,PRCPER_",",.01)_U_PRCPER_U_$$GET1^DIQ(200,PRCPER_",",29)
 . S PRCX=PRCX_U_$$FMTE^XLFDT($P(PRCNOD2,U,6))_U_$$FMTE^XLFDT($P(PRCNOD2,U,7))_U_$$FMTE^XLFDT($P(PRCNOD2,U,8))_U_$$FMTE^XLFDT($P(PRCNOD2,U,9))
 . S PRCPER=$P(PRCNOD2,U,10),PRCX=PRCX_U_$$GET1^DIQ(200,PRCPER_",",.01)_U_PRCPER_U_$$GET1^DIQ(200,PRCPER_",",29)
 . S PRCPER=$P(PRCNOD2,U,11) S PRCX=PRCX_U_$$GET1^DIQ(200,PRCPER_",",.01)_U_PRCPER_U_$$GET1^DIQ(200,PRCPER_",",29)
 . S PRCX=PRCX_U_$$GET1^DIQ(421.5,PRCINV_",",61)_U_$TR($$FMTE^XLFDT($P(PRCNOD21,U,5)),"@"," ")_U_$$GET1^DIQ(421.5,PRCINV_",",62)_U_$TR($$FMTE^XLFDT($P(PRCNOD21,U,6)),"@"," ")
 . S ^TMP($J,"PRCINVHDR",PRCINV,3)=PRCX_U
 . S PRCX=$$GET1^DIQ(421.5,PRCINV_",",63)_U_$TR($$FMTE^XLFDT($P(PRCNOD2,U,15)),"@"," ")
 . S PRCPER=$P(PRCNOD2,U,18) S PRCX=PRCX_U_$$GET1^DIQ(200,PRCPER_",",.01)_U_PRCPER_U_$$GET1^DIQ(200,PRCPER_",",29)_U_$TR($$FMTE^XLFDT($P(PRCNOD21,U,9)),"@"," ")_U_$P(PRCNOD1,U,11)
 . S PRCX=PRCX_U_$$FMTE^XLFDT($P(PRCNOD1,U,19))_U_$$FMTE^XLFDT($P(PRCNOD1,U,20))
 . S ^TMP($J,"PRCINVHDR",PRCINV,4)=PRCX_U
 . N PRCARRAY S PRCX=$$GET1^DIQ(421.5,PRCINV_",",23,"","PRCARRAY","PRCERR")
 . S PRCI=0,PRCJ=4,PRCK=0
 . F  S PRCI=$O(PRCARRAY(PRCI)) Q:PRCI=""  D
 . . S PRCJ=PRCJ+1,^TMP($J,"PRCINVHDR",PRCINV,PRCJ)=$S(PRCK:" ",1:"")_$TR(PRCARRAY(PRCI),"^"),PRCK=PRCK+1
 . K PRCARRAY
 . S PRCSTUB=$P(PRCNOD0,U)_U_$P(PRCNOD1,U,2)_U_MNTHYR_U_U_$P(PRCNOD0,U,3)_U_$$GET1^DIQ(442,PRCPOIEN_",",.01)_U_PRCPOIEN
 . D PAYTERMS(PRCINV,PRCSTUB)
 . D FMSLINE(PRCINV,PRCSTUB)
 . D CERTSVC(PRCINV,PRCSTUB)
 Q
 ;
PAYTERMS(PRCID,PRCY) ;Compile Prompt Payment Terms for Invoice
 N PRCJ,PRCPTNOD
 S PRCJ=0
 F  S PRCJ=$O(^PRCF(421.5,PRCID,6,PRCJ)) Q:+PRCJ'=PRCJ  D
 . S PRCPTNOD=$G(^PRCF(421.5,PRCID,6,PRCJ,0)) Q:PRCPTNOD=""
 . S PRCX=PRCY,$P(PRCX,U,4)=PRCJ
 . S PRCX=PRCX_U_$P(PRCPTNOD,U)_U_$$GET1^DIQ(421.531,PRCJ_","_PRCID_",",1)_U_$P(PRCPTNOD,U,3)_U_$P(PRCPTNOD,U,4)_U_$P(PRCPTNOD,U,5)
 . S ^TMP($J,"PRCINVPAYT",PRCID,PRCJ)=PRCX
 Q
 ;
FMSLINE(PRCID,PRCY) ;Compile FMS Line Data
 N PRCJ,PRCFMSND
 S PRCJ=0
 F  S PRCJ=$O(^PRCF(421.5,PRCID,5,PRCJ)) Q:+PRCJ'=PRCJ  D
 . S PRCFMSND=$G(^PRCF(421.5,PRCID,5,PRCJ,0)) Q:PRCFMSND=""
 . S PRCX=PRCY,$P(PRCX,U,4)=PRCJ
 . S PRCX=PRCX_U_$P($$GET1^DIQ(421.541,PRCJ_","_PRCID_",",.01)," ")_U_$S($P(PRCFMSND,U,2)'="":$FN($P(PRCFMSND,U,2),"",2),1:"")_U_$S($P(PRCFMSND,U,3)'="":$FN($P(PRCFMSND,U,3),"",2),1:"")
 . S PRCX=PRCX_U_$$GET1^DIQ(421.541,PRCJ_","_PRCID_",",3)_U_$P(PRCFMSND,U,5)
 . S ^TMP($J,"PRCINVFMS",PRCID,PRCJ)=PRCX
 Q
 ;
CERTSVC(PRCID,PRCY) ;Compile Certifying Service
 N PRCJ,PRCPER,PRCSVCND
 S PRCJ=0
 F  S PRCJ=$O(^PRCF(421.5,PRCID,3,PRCJ)) Q:+PRCJ'=PRCJ  D
 . S PRCSVCND=$G(^PRCF(421.5,PRCID,3,PRCJ,0)) Q:PRCSVCND=""
 . S PRCX=PRCY,$P(PRCX,U,4)=PRCJ
 . S PRCX=PRCX_U_$$GET1^DIQ(421.51,PRCJ_","_PRCID_",",.01)_U_$TR($$FMTE^XLFDT($P(PRCSVCND,U,2)),"@"," ")
 . S PRCPER=$P(PRCSVCND,U,3)
 . S PRCX=PRCX_U_$$GET1^DIQ(200,PRCPER_",",.01)_U_PRCPER_U_$$GET1^DIQ(200,PRCPER_",",29)
 . S ^TMP($J,"PRCINVCERTSVC",PRCID,PRCJ)=PRCX
 Q
 ;
INVOICEH ;Invoice Header
 W "InvID^Stn^SubStn^MonthYrRun^InvNbr^InvDt^DtRec^POPtr^POIdNum^MOP^PONbr^"
 W "CertReq^PPType^VendorNm^VendorIEN^VendFMSCode^VendAltI^DUNS^DiscDays^"
 W "DiscTerms^DtSvcRec^AppShipAmt^AmtCertPay^DtSuspLtr^SusLtrReq^PartialNbr^"
 W "FMSPayVoucher^GrossAmt^GrossShip^Status^POSuffix^ExpandedPO^CurrLoc^"
 W "DtCurrLoc^ChargeLocNm^ChargeLocDuz^ChargeLocSvc^DiscPayDt^NetPayDt^"
 W "DtDueFisc^DtRetFisc^CertPayNm^CertPayDuz^CertPaySvc^CompletedNm^"
 W "CompletedDuz^CompletedSvc^CertValCode^CertDtTime^CompValCode^"
 W "CompletedDtTime^BullSentYN^BullSentDt^CPCertNm^CPCertDuz^CPCertSvc^"
 W "CPSignDt^CertCP^FMSTxnDt^AcctMY^SusReason",!
 Q
INVOICEW ;Write Invoice Header Data
 N PRCI,PRCJ
 S PRCI="",PRCJ=""
 F  S PRCI=$O(^TMP($J,"PRCINVHDR",PRCI)) Q:+PRCI'=PRCI  D
 . F  S PRCJ=$O(^TMP($J,"PRCINVHDR",PRCI,PRCJ)) Q:PRCJ=""  W $G(^TMP($J,"PRCINVHDR",PRCI,PRCJ))
 . W !
 Q
 ;
INVPAYH ;Invoice Payment Terms Header
 W "InvID^Stn^MonthYrRun^PPTIEN^InvNbr^POPtr^POIdNum^PPTNbr^TermsType^DiscPcnt^DiscAmt^DiscDays",!
 Q
INVPAYW ;Write Payment Terms Data
 N PRCI,PRCJ
 S PRCI="",PRCJ=""
 F  S PRCI=$O(^TMP($J,"PRCINVPAYT",PRCI)) Q:+PRCI'=PRCI  D
 . F  S PRCJ=$O(^TMP($J,"PRCINVPAYT",PRCI,PRCJ)) Q:PRCJ=""  W $G(^TMP($J,"PRCINVPAYT",PRCI,PRCJ)),!
 Q
 ;
INVFMSH ;FMS Line Header
 W "InvID^Stn^MonthYrRun^FMSLIEN^InvNbr^PoPtr^POIdNum^BOC^AcctLnAmt^LiqAmt^LiqCode^FMSLNbr",!
 Q
INVFMSW ;Write FMS Line Data
 N PRCI,PRCJ
 S PRCI="",PRCJ=""
 F  S PRCI=$O(^TMP($J,"PRCINVFMS",PRCI)) Q:+PRCI'=PRCI  D
 . F  S PRCJ=$O(^TMP($J,"PRCINVFMS",PRCI,PRCJ)) Q:PRCJ=""  W $G(^TMP($J,"PRCINVFMS",PRCI,PRCJ)),!
 Q
 ;
CERTH ;Write Certifying Service Header
 W "InvID^Stn^MonthYrRun^CertIEN^InvNbr^POPtr^POIdNum^CertSvc^DTChargeOUT^ChargeByName^ChargeByDuz^ChargeBySvc",!
 Q
CERTW ;Write Certifying Service Data
 N PRCI,PRCJ
 S PRCI="",PRCJ=""
 F  S PRCI=$O(^TMP($J,"PRCINVCERTSVC",PRCI)) Q:+PRCI'=PRCI  D
 . F  S PRCJ=$O(^TMP($J,"PRCINVCERTSVC",PRCI,PRCJ)) Q:PRCJ=""  W $G(^TMP($J,"PRCINVCERTSVC",PRCI,PRCJ)),!
 Q
 ;
INVHDR ;Create flat file for Invoice header #421.5
 N OUTFL24
 S OUTFL24="IFCP"_STID_"F24.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFL24,"W") ;Open the file
 D USE^%ZISUTL("FILE1")
 D INVOICEH
 D INVOICEW
 D CLOSE^%ZISH("FILE1")
 Q
INVPAY ;Create flat file for Invoice payment Terms subfile #421.531
 N OUTFL25
 S OUTFL25="IFCP"_STID_"F25.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFL25,"W")
 D USE^%ZISUTL("FILE1")
 D INVPAYH
 D INVPAYW
 D CLOSE^%ZISH("FILE1")
 Q
INVFMS ;Create flat file for Invoice FMS lines subfile #421.541
 N OUTFL26
 S OUTFL26="IFCP"_STID_"F26.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFL26,"W")
 D USE^%ZISUTL("FILE1")
 D INVFMSH
 D INVFMSW
 D CLOSE^%ZISH("FILE1")
 Q
INVCERT ;Create flat file for Invoice Certifying Services subfile #421.51
 N OUTFL27
 S OUTFL27="IFCP"_STID_"F27.TXT"
 D OPEN^%ZISH("FILE1",FILEDIR,OUTFL27,"W")
 D USE^%ZISUTL("FILE1")
 D CERTH
 D CERTW
 D CLOSE^%ZISH("FILE1")
 Q
