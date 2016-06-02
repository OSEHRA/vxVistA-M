VFDCSV01 ;DSS/LM - SAVE STATE RPC'S ;6/12/07  09:03
 ;;2011.1.2;DSS,INC VXVISTA OPEN SOURCE;;11 Jun 2013;Build 164
 ;Copyright 1995-2013,Document Storage Systems Inc. All Rights Reserved
 ;
 Q
ADD(VFDCRSLT,VFDCARRY) ;Add new entry to File 21651 (From ADD^VFDCSV)
 ; VFDCARRY - Input array by reference
 ;            FieldName~Value
 ;            FieldName~Value
 ;            . . .
 ;            . . .
 ;            $TEXT
 ;            State Text (WP)
 ;            
 ; VFDCRSLT - IEN of new entry or -1^Error
 ;
 N VFDCI,VFDCFDA,VFDCFLD,VFDCR,VFDCTEXT,VFDCX,VFDCY
 S (VFDCI,VFDCTEXT)="",VFDCR=$NA(VFDCFDA(21651))
 F VFDCI=1:1 Q:'$D(VFDCARRY(VFDCI))!VFDCTEXT  S VFDCX=VFDCARRY(VFDCI) D
 .I $E(VFDCX,1,5)="$TEXT" S VFDCTEXT=1 Q
 .I $F(VFDCX,"~") S VFDCY=$P(VFDCX,"~",2,99),VFDCX=$P(VFDCX,"~") Q:'$L(VFDCX)
 .S VFDCFLD=$$FLDNUM^DILFD(21651,VFDCX) Q:'VFDCFLD  S VFDCFLD(VFDCFLD)=VFDCY
 .S @VFDCR@("+1,",VFDCFLD)=VFDCY
 .Q
 I $G(VFDCFLD(.03)),$D(^VFD(21650,+VFDCFLD(.03))) ;Required APPLICATION
 E  S VFDCRSLT="-1^Missing or invalid APPLICATION" Q
 N VFDCKEY,VFDCXKEY S VFDCXKEY=$G(VFDCFLD(.02))_U_$G(VFDCFLD(.03))_U_$G(VFDCFLD(3.01))
 S VFDCKEY=$$UP^XLFSTR($G(VFDCFLD(.04))_U_$G(VFDCFLD(.05))_U_$G(VFDCFLD(.06))_U_$G(VFDCFLD(.07)))_U_VFDCXKEY
 I $D(^VFD(21651,"C",VFDCKEY)) S VFDCRSLT="-1^Cannot ADD existing key" Q
 I VFDCTEXT N VFDCJ,VFDCWP
 F VFDCJ=VFDCI:1 Q:'$D(VFDCARRY(VFDCJ))  S VFDCWP(VFDCJ-VFDCI+1,0)=VFDCARRY(VFDCJ)
 I '$D(VFDCFDA) S VFDCRSLT="-1^Nothing to add" Q
 N VFDC,VFDCIENR,VFDCERR
 S (@VFDCR@("+1,",.01),VFDCIENR(1))=1+$O(^VFD(21651," "),-1)
 S @VFDCR@("+1,",.08)=$$DT^XLFDT,@VFDCR@("+1,",.09)=$G(DUZ)
 D UPDATE^DIE(,$NA(VFDCFDA),$NA(VFDCIENR),$NA(VFDCERR))
 I $D(VFDCERR) S VFDCRSLT="-1^UPDATE~DIE failed. Error: "_$G(VFDCERR("DIERR",1,"TEXT",1)) Q
 N VFDCIEN S VFDCIEN=$G(VFDCIENR(1))
 I VFDCIEN<1 S VFDCRSLT="-1^UPDATE~DIE failed. Error: "_$G(VFDCERR("DIERR",1,"TEXT",1)) Q
 S VFDCRSLT=VFDCIEN Q:'$D(VFDCWP)
 K VFDCERR D WP^DIE(21651,VFDCIEN_",",2,,$NA(VFDCWP),$NA(VFDCERR))
 I $D(VFDCERR) S VFDCRSLT="-1^WP~DIE failed. Error: "_$G(VFDCERR("DIERR",1,"TEXT",1))
 Q
MOD(VFDCRSLT,VFDCARRY) ;Modify existing entry in File 21651 (From MOD^VFDCSV)
 ; VFDCARRY - Input array by reference - Must include complete key
 ;            FieldName~Value
 ;            FieldName~Value
 ;            . . .
 ;            . . .
 ;            $TEXT
 ;            State Text (WP)
 ;            
 ; VFDCRSLT - 0 (zero) for success or -1^Error
 ;
 N VFDCI,VFDCFDA,VFDCFLD,VFDCR,VFDCTEXT,VFDCX,VFDCY
 S (VFDCI,VFDCTEXT)="",VFDCR=$NA(VFDCFDA(21651))
 F VFDCI=1:1 Q:'$D(VFDCARRY(VFDCI))!VFDCTEXT  S VFDCX=VFDCARRY(VFDCI) D
 .I $E(VFDCX,1,5)="$TEXT" S VFDCTEXT=1 Q
 .I $F(VFDCX,"~") S VFDCY=$P(VFDCX,"~",2,99),VFDCX=$P(VFDCX,"~") Q:'$L(VFDCX)
 .S VFDCFLD=$$FLDNUM^DILFD(21651,VFDCX) Q:'VFDCFLD  S VFDCFLD(VFDCFLD)=VFDCY
 .S @VFDCR@("+1,",VFDCFLD)=VFDCY
 .Q
 I $G(VFDCFLD(.03)),$D(^VFD(21650,+VFDCFLD(.03))) ;Required APPLICATION
 E  S VFDCRSLT="-1^Missing or invalid APPLICATION" Q
 N VFDCKEY,VFDCXKEY S VFDCXKEY=$G(VFDCFLD(.02))_U_$G(VFDCFLD(.03))_U_$G(VFDCFLD(3.01))
 S VFDCKEY=$$UP^XLFSTR($G(VFDCFLD(.04))_U_$G(VFDCFLD(.05))_U_$G(VFDCFLD(.06))_U_$G(VFDCFLD(.07)))_U_VFDCXKEY
 N VFDCIENS S VFDCIENS=$$FIND1(VFDCKEY)_","
 I 'VFDCIENS S VFDCRSLT="-1^Lookup failed" Q
 N VFDC01 S VFDC01=$$GET1^DIQ(21651,VFDCIENS,.01,"I")
 I '$L(VFDC01) S VFDCRSLT="-1^Invalid RECORD NUMBER" Q  ;Should not happen
 ; Delete existing entry - Business rule for modify is delete and recreate.
 N DA,DIK S DA=+VFDCIENS,DIK="^VFD(21651," D ^DIK K DA,DIK
 I VFDCTEXT N VFDCJ,VFDCWP
 F VFDCJ=VFDCI:1 Q:'$D(VFDCARRY(VFDCJ))  S VFDCWP(VFDCJ-VFDCI+1,0)=VFDCARRY(VFDCJ)
 I '$D(VFDCFDA) S VFDCRSLT="-1^Nothing to add" Q
 N VFDC,VFDCIENR,VFDCERR
 S (@VFDCR@("+1,",.01),VFDCIENR(1))=VFDC01 ;Force preserve #.01
 S @VFDCR@("+1,",.08)=$$DT^XLFDT,@VFDCR@("+1,",.09)=$G(DUZ)
 D UPDATE^DIE(,$NA(VFDCFDA),$NA(VFDCIENR),$NA(VFDCERR))
 I $D(VFDCERR) S VFDCRSLT="-1^UPDATE~DIE failed (Entry deleted). Error: "_$G(VFDCERR("DIERR",1,"TEXT",1)) Q
 S VFDCRSLT=VFDC01 Q:'$D(VFDCWP)
 K VFDCERR D WP^DIE(21651,VFDCIENS,2,,$NA(VFDCWP),$NA(VFDCERR))
 I $D(VFDCERR) S VFDCRSLT="-1^WP~DIE failed. Error: "_$G(VFDCERR("DIERR",1,"TEXT",1))
 Q
DEL(VFDCRSLT,VFDCARRY) ;Delete existing entry in File 21651 (From DEL^VFDCSV)
 ; VFDCARRY - Input array by reference - Must include complete key
 ;            FieldName~Value
 ;            FieldName~Value
 ;            
 ; VFDCRSLT - 0 (zero) for success or -1^Error
 ;
 N VFDCI,VFDCFLD,VFDCIEN,VFDCKEY,VFDCTEXT,VFDCX,VFDCY
 S (VFDCI,VFDCTEXT)=""
 F VFDCI=1:1 Q:'$D(VFDCARRY(VFDCI))!VFDCTEXT  S VFDCX=VFDCARRY(VFDCI) D
 .I $E(VFDCX,1,5)="$TEXT" S VFDCTEXT=1 Q
 .I $F(VFDCX,"~") S VFDCY=$P(VFDCX,"~",2,99),VFDCX=$P(VFDCX,"~") Q:'$L(VFDCX)
 .S VFDCFLD=$$FLDNUM^DILFD(21651,VFDCX) Q:'VFDCFLD  S VFDCFLD(VFDCFLD)=VFDCY
 .Q
 I $G(VFDCFLD(.03)),$D(^VFD(21650,+VFDCFLD(.03))) ;Required APPLICATION
 E  S VFDCRSLT="-1^Missing or invalid APPLICATION" Q
 N VFDCKEY,VFDCXKEY S VFDCXKEY=$G(VFDCFLD(.02))_U_$G(VFDCFLD(.03))_U_$G(VFDCFLD(3.01))
 S VFDCKEY=$$UP^XLFSTR($G(VFDCFLD(.04))_U_$G(VFDCFLD(.05))_U_$G(VFDCFLD(.06))_U_$G(VFDCFLD(.07)))_U_VFDCXKEY
 S VFDCIEN=$$FIND1(VFDCKEY)
 I 'VFDCIEN S VFDCRSLT="-1^Lookup failed" Q
 ; Delete existing entry - Business rule for modify is delete and recreate.
 N DA,DIK S DA=VFDCIEN,DIK="^VFD(21651," D ^DIK
 S VFDCRSLT=0
 Q
GET(VFDCRSLT,VFDCARRY) ;Retrieve data for existing entry in File 21651 (From GET^VFDCSV)
 ; VFDCARRY - Input array by reference - Must include complete key
 ;            FieldName~Value
 ;            FieldName~Value
 ;            
 ; VFDCRSLT - Array of return data or -1^Error
 ;
 N VFDCI,VFDCFLD,VFDCIENS,VFDCTEXT,VFDCX,VFDCY
 S (VFDCI,VFDCTEXT)=""
 F VFDCI=1:1 Q:'$D(VFDCARRY(VFDCI))!VFDCTEXT  S VFDCX=VFDCARRY(VFDCI) D
 .I $E(VFDCX,1,5)="$TEXT" S VFDCTEXT=1 Q
 .I $F(VFDCX,"~") S VFDCY=$P(VFDCX,"~",2,99),VFDCX=$P(VFDCX,"~") Q:'$L(VFDCX)
 .S VFDCFLD=$$FLDNUM^DILFD(21651,VFDCX) Q:'VFDCFLD  S VFDCFLD(VFDCFLD)=VFDCY
 .Q
 I $G(VFDCFLD(.03)),$D(^VFD(21650,+VFDCFLD(.03))) ;Required APPLICATION
 E  S VFDCRSLT="-1^Missing or invalid APPLICATION" Q
 N VFDCKEY,VFDCXKEY S VFDCXKEY=$G(VFDCFLD(.02))_U_$G(VFDCFLD(.03))_U_$G(VFDCFLD(3.01))
 S VFDCKEY=$$UP^XLFSTR($G(VFDCFLD(.04))_U_$G(VFDCFLD(.05))_U_$G(VFDCFLD(.06))_U_$G(VFDCFLD(.07)))_U_VFDCXKEY
 S VFDCIENS=$$FIND1(VFDCKEY)_","
 I 'VFDCIENS S VFDCRSLT(1)="-1^Lookup failed" Q
 ; Retrieve data
 S VFDCRSLT(1)="-1^No data"
 N VFDCDATA D GETS^DIQ(21651,VFDCIENS,"1.01:1.04;2",,$NA(VFDCDATA)) Q:'($D(VFDCDATA)>1)
 S VFDCRSLT(1)="DATA1~"_VFDCDATA(21651,VFDCIENS,1.01)
 S VFDCRSLT(2)="DATA2~"_VFDCDATA(21651,VFDCIENS,1.02)
 S VFDCRSLT(3)="DATA3~"_VFDCDATA(21651,VFDCIENS,1.03)
 S VFDCRSLT(4)="DATA4~"_VFDCDATA(21651,VFDCIENS,1.04)
 Q:'$D(VFDCDATA(21651,VFDCIENS,2,1))
 S VFDCRSLT(5)="$TEXT"
 N VFDCJ S VFDCJ=0
 F VFDCI=6:1 S VFDCJ=$O(VFDCDATA(21651,VFDCIENS,2,VFDCJ)) Q:'VFDCJ  D
 .S VFDCRSLT(VFDCI)=VFDCDATA(21651,VFDCIENS,2,VFDCJ)
 .Q
 Q
LIST(VFDCRSLT,VFDCFROM,VFDCPART,VFDCSCR,VFDCNDX,VFDCNUM) ;Retrieve list of entries from File 21651
 ; VFDCFROM - See LIST^DIC
 ; VFDCPART - [Optional] See LIST^DIC
 ; VFDCSCR  - [Optional] Array of screen field-value pairs
 ;            PATIENT~DFN
 ;            APPLICATION~IEN
 ;            NEW PERSON~DUZ
 ;            
 ; VFDCNDX  - Index to select/sort by PATIENT=D, NEW PERSON=E
 ; VFDCNUM  - [Optional] Maximum number of entries to return
 ; 
 ; VFDCRSLT - Array of return data or -1^Error
 ;            DFN^PATIENT NAME^KEY1^KEY2^KEY3
 ;            DFN^PATIENT NAME^KEY1^KEY2^KEY2
 ;            Etc.
 ;
 S VFDCFROM=$G(VFDCFROM,""),VFDCNDX=$G(VFDCNDX) I "DE"[VFDCNDX
 E  S VFDCRSLT(1)="-1^Invalid Index" Q
 N VFDCI S VFDCSCR="I 1",VFDCI="" F  S VFDCI=$O(VFDCSCR(VFDCI)) Q:'VFDCI  D
 .N X S X=$$UP^XLFSTR($G(VFDCSCR(VFDCI))) Q:'$L(X)
 .I $P(X,"~")="PATIENT" S VFDCSCR=VFDCSCR_",$P(^(0),U,2)="_$P(X,"~",2)
 .I $P(X,"~")="APPLICATION" S VFDCSCR=VFDCSCR_",$P(^(0),U,3)="_$P(X,"~",2)
 .I $P(X,"~")="NEW PERSON" S VFDCSCR=VFDCSCR_",$P(^(3),U)="_$P(X,"~",2)
 .Q
 S VFDCPART=$G(VFDCPART),VFDCNUM=$G(VFDCNUM,200) N VFDCDATA,VFDCERR
 D LIST^DIC(21651,,"@;.02EI;.03EI;.04;.05;.06;.07;3.01EI",,VFDCNUM,VFDCFROM,,VFDCNDX,VFDCSCR,,$NA(VFDCDATA),$NA(VFDCERR))
 I $D(VFDCERR) S VFDCRSLT(1)="-1^LIST~DIC failed. Error: "_$G(VFDCERR("DIERR",1,"TEXT",1)) Q
 I '$D(VFDCDATA) S VFDCRSLT(1)="-1^No matching entries found"
 N VFDCI,VFDCJ S (VFDCI,VFDCJ)=0 F  S VFDCI=$O(VFDCDATA("DILIST","ID",VFDCI)) Q:'VFDCI  D
 .S VFDCJ=VFDCJ+1,VFDCRSLT(VFDCJ)=$G(VFDCDATA("DILIST","ID",VFDCI,.02,"I"))
 .S VFDCRSLT(VFDCJ)=VFDCRSLT(VFDCJ)_U_$G(VFDCDATA("DILIST","ID",VFDCI,.02,"E"))
 .S VFDCRSLT(VFDCJ)=VFDCRSLT(VFDCJ)_U_$G(VFDCDATA("DILIST","ID",VFDCI,.03,"I"))
 .S VFDCRSLT(VFDCJ)=VFDCRSLT(VFDCJ)_U_$G(VFDCDATA("DILIST","ID",VFDCI,.03,"E"))
 .S VFDCRSLT(VFDCJ)=VFDCRSLT(VFDCJ)_U_$G(VFDCDATA("DILIST","ID",VFDCI,.04))
 .S VFDCRSLT(VFDCJ)=VFDCRSLT(VFDCJ)_U_$G(VFDCDATA("DILIST","ID",VFDCI,.05))
 .S VFDCRSLT(VFDCJ)=VFDCRSLT(VFDCJ)_U_$G(VFDCDATA("DILIST","ID",VFDCI,.06))
 .S VFDCRSLT(VFDCJ)=VFDCRSLT(VFDCJ)_U_$G(VFDCDATA("DILIST","ID",VFDCI,.07))
 .S VFDCRSLT(VFDCJ)=VFDCRSLT(VFDCJ)_U_$G(VFDCDATA("DILIST","ID",VFDCI,3.01,"I"))
 .S VFDCRSLT(VFDCJ)=VFDCRSLT(VFDCJ)_U_$G(VFDCDATA("DILIST","ID",VFDCI,3.01,"E"))
 .Q
 Q
FIND1(VFDCKEY) ;;File 21651 entry matching VFDCKEY exactly and uniquely
 ; VFDCKEY=Full "C" index key
 ; Return IEN or null if not an exact and unique match
 ; 
 Q:'$L($G(VFDCKEY)) ""  N VFDCIEN S VFDCIEN=$O(^VFD(21651,"C",VFDCKEY,""))
 Q $S($O(^VFD(21651,"C",VFDCKEY,VFDCIEN)):"",1:VFDCIEN)
 ;
SETC ;;File 21651, cross-reference "C", SET LOGIC
 N VFDCKEYS S VFDCKEYS=X(1)_U_X(2)_U_X(3)_U_X(4)_U_X(5)_U_X(6)_U_X(7)
 S ^VFD(21651,"C",VFDCKEYS,DA)="" Q:VFDCKEYS="^^^^^^"
 K ^VFD(21651,"C","^^^^^^",DA)
 Q
KILLC ;;File 21651, cross-reference "C", KILL LOGIC
 N VFDCKEYS S VFDCKEYS=X(1)_U_X(2)_U_X(3)_U_X(4)_U_X(5)_U_X(6)_U_X(7)
 K ^VFD(21651,"C",VFDCKEYS,DA)
 Q
