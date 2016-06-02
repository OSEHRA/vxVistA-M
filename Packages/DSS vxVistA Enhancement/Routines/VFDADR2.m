VFDADR2 ;DSS/LM - VFD ADDRESS file API support ;23 Nov 2010 10:04
 ;;2011.1.2;DSS,INC VXVISTA OPEN SOURCE;;11 Jun 2013;Build 164
 ;Copyright 1995-2013,Document Storage Systems Inc. All Rights Reserved
 ;
 ;
 Q
LIST(VFDRSLT,VFDDATA) ;[Private] From LIST^VFDADR
 ;
 ; VFDDATA=[Required] Array of specifications - See RPC definition for details
 ; VFDRSLT=RPC return array by reference
 ; 
 I '$O(VFDDATA(0)) S VFDRSLT(1)="-1^Missing or invalid input array" Q
 N VFDI,VFDR
 S VFDI=0 F  S VFDI=$O(VFDDATA(VFDI)) Q:'VFDI  D
 .K VFDR D ONE(.VFDR,VFDDATA(VFDI))
 .D APPEND(.VFDRSLT,.VFDR)
 .Q
 I '$O(VFDDATA(0)) S VFDRSLT(1)="-1^No data found" Q
 Q
ONE(VFDRSLT,VFDDATA) ;[Private] Process one order
 ;
 ; VFDDATA=[Required] ORDER IEN^TYPE
 ; VFDRSLT=Return array by reference
 ;
 N VFDERR,VFDI,VFDOIEN,VFDTYPE S VFDERR=0
 S VFDDATA=$G(VFDDATA),VFDOIEN=$P(VFDDATA,U),VFDTYPE=$P(VFDDATA,U,2)
 S VFDI=1,VFDRSLT(VFDI)=""
 S VFDRSLT(VFDI)="$START "_VFDDATA
 I 'VFDOIEN S VFDERR=1 D
 .S VFDI=VFDI+1
 .S VFDRSLT(VFDI)="ERROR^Missing or invalid order IEN"
 .Q
 E  I '$D(^OR(100,VFDOIEN)) D  Q
 .S VFDI=VFDI+1
 .S VFDRSLT(VFDI)="ERROR^Order "_VFDOIEN_" not found."
 .S VFDI=VFDI+1,VFDRSLT(VFDI)="$END "_VFDOIEN
 .Q
 I '("^CLID^PSRX^PSFT^"[VFDTYPE) S VFDERR=1 D
 .S VFDI=VFDI+1
 .S VFDRSLT(VFDI)="ERROR^Missing or invalid type"
 .Q
 D:'VFDERR @VFDTYPE
 S VFDI=VFDI+1,VFDRSLT(VFDI)="$END "_VFDOIEN
 Q
APPEND(VFDOUT,VFDIN) ;[Private] Append VFDIN to end of VFDOUT
 ;
 ; VFDOUT=[Required] Target array by reference
 ; VFDIN=[Required] Source array by reference
 ; 
 N VFDI,VFDJ S VFDI=+$O(VFDOUT(""),-1),VFDJ=0
 F  S VFDJ=$O(VFDIN(VFDJ)) Q:'VFDJ  D
 .S VFDI=VFDI+1,VFDOUT(VFDI)=VFDIN(VFDJ)
 .Q
 Q
CLID ;[Private] Type Continuation of ONE
 ; Assumes context variables, including VFDI and VFDOIEN
 ; 
 N VFDOLOC S VFDOLOC=$$GET1^DIQ(100,VFDOIEN,6,"I")
 I '($P(VFDOLOC,";",2)="SC(") D  Q
 .S VFDI=VFDI+1
 .S VFDRSLT(VFDI)="ERROR^Order "_VFDOIEN_" does not point to HOSPITAL LOCATION."
 .Q
 N VFDHLOC S VFDHLOC=$$GET1^DIQ(44,+VFDOLOC,.01)
 N VFDCLID S VFDCLID=$$GET1^DIQ(44,+VFDOLOC,21600.02)
 I '$L(VFDCLID) D  Q
 .S VFDI=VFDI+1
 .S VFDRSLT(VFDI)="ERROR^Hospital Location "_VFDHLOC_" does not have a client ID."
 .Q
 N VFDAIEN S VFDAIEN=$$FIND1^DIC(21612,,"X",VFDCLID,"C")
 I '$L(VFDAIEN) D  Q
 .S VFDI=VFDI+1
 .S VFDRSLT(VFDI)="ERROR^VFD ADDRESS file does not contain an entry for client ID "_VFDCLID_"."
 .Q
 D ADR(VFDAIEN)
 Q
PSRX ;[Private] Type continuation of ONE
 ; Assumes context variables, including VFDI and VFDOIEN
 ; 
 N VFDXIEN S VFDXIEN=$$FIND1^DIC(52,,"X",VFDOIEN,"APL")
 N VFDINST S VFDINST=$$INST^VFDPSUTL(VFDOIEN,VFDXIEN)
 I 'VFDINST D  Q
 .S VFDI=VFDI+1
 .I 'VFDXIEN D  Q
 ..S VFDRSLT(VFDI)="ERROR^Could not identify PRESCRIPTION for order "_VFDOIEN
 ..Q
 .S VFDRSLT(VFDI)="ERROR^Could not identify INSTITUTION for order "_VFDOIEN
 .Q
 N VFDAIEN
 ; 7/19/2010 - Use File 21612 pointer to File 4
 S VFDAIEN=$$AP4^VFDADR1(+VFDINST,1) I VFDAIEN D ADR(VFDAIEN) Q
 ; 7/19/2010 - End insert
 S VFDAIEN=$$GET1^DIQ(4,VFDINST,21612.01,"I")
 I 'VFDAIEN D  Q
 .S VFDI=VFDI+1
 .S VFDRSLT(VFDI)="ERROR^Could not identify RX PRINT ADDRESS for INSTITUTION IEN="_VFDINST
 .Q
 D ADR(VFDAIEN)
 Q
PSFT ;[Private] Type continuation of ONE
 ; Assumes context variables, including VFDI and VFDOIEN
 ;
 N VFDOLOC S VFDOLOC=$$GET1^DIQ(100,VFDOIEN,6,"I")
 I '($P(VFDOLOC,";",2)="SC(") D  Q
 .S VFDI=VFDI+1
 .S VFDRSLT(VFDI)="ERROR^Order "_VFDOIEN_" does not point to HOSPITAL LOCATION."
 .Q
 N VFDHLOC S VFDHLOC=$$GET1^DIQ(44,+VFDOLOC,.01)
 N VFDINST S VFDINST=$$GET1^DIQ(44,+VFDOLOC,3,"I")
 I 'VFDINST D  Q
 .S VFDI=VFDI+1
 .S VFDRSLT(VFDI)="ERROR^Hospital Location "_VFDHLOC_" does not have an INSTITUTION (#3) value."
 .Q
 N VFDAIEN
 ; 7/19/2010 - Use File 21612 pointer to File 4
 S VFDAIEN=$$AP4^VFDADR1(+VFDINST,1) I VFDAIEN D ADR(VFDAIEN) Q
 ; 7/19/2010 - End insert
 S VFDAIEN=$$GET1^DIQ(4,VFDINST,21612.01,"I")
 I 'VFDAIEN D  Q
 .S VFDI=VFDI+1
 .S VFDRSLT(VFDI)="ERROR^Could not identify RX PRINT ADDRESS for INSTITUTION IEN="_VFDINST
 .Q
 D ADR(VFDAIEN)
 Q
ADR(VFDAIEN) ;[Private] Append address
 ; Assumes context variables, including VFDI and VFDOIEN
 ; 
 N VFDARY,VFDR D GETS^DIQ(21612,VFDAIEN,"*",,$NA(VFDARY))
 S VFDR=$NA(VFDARY(21612,VFDAIEN_","))
 S:@VFDR@(.01)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="NAME^"_@VFDR@(.01)
 S:@VFDR@(.03)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="PRINT NAME^"_@VFDR@(.03)
 S:@VFDR@(.111)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="LINE 1^"_@VFDR@(.111)
 S:@VFDR@(.112)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="LINE 2^"_@VFDR@(.112)
 S:@VFDR@(.113)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="LINE 3^"_@VFDR@(.113)
 S:@VFDR@(.114)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="CITY^"_@VFDR@(.114)
 S:@VFDR@(.115)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="STATE^"_@VFDR@(.115)
 S:@VFDR@(.116)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="ZIP^"_@VFDR@(.116)
 S:@VFDR@(.131)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="PHONE 1^"_@VFDR@(.131)
 S:@VFDR@(.132)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="PHONE 2^"_@VFDR@(.132)
 S:@VFDR@(.133)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="PHONE 3^"_@VFDR@(.133)
 S:@VFDR@(1.01)]"" VFDI=VFDI+1,VFDRSLT(VFDI)="CLIENT ID^"_@VFDR@(1.01)
 Q
