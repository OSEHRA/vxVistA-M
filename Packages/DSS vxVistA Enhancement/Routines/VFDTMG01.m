VFDTMG01 ;DSS/SMP - VFDTMG RPCS ;12/11/2015 12:00
 ;;15.0;DSS,INC VXVISTA OPEN SOURCE;**36**;07 Feb 2014;Build 1
 ;Copyright 1995-2015,Document Storage Systems Inc. All Rights Reserved
 ;
 ;**********************************************************************
 ;*  TMG* is licensed by Dr. Kevin S. Toppenberg under Apache 2.0.     *
 ;*  VFDTMG** is derived from Dr. Toppenberg's TMG software and is     *
 ;*  released  under Apache 2.0.                                       *
 ;*                                                                    *
 ;* (c) 2015 Dr. Kevin S. Toppenberg                                   *
 ;* (c) 2015 DSS, Inc.                                                 *
 ;**********************************************************************
 ;
 Q
 ;
DEMOGET ; RPC - VFDTMG PATIENT DEMO GET
 ; Cloned from TMG GET PATIENT DEMOGRAPHICS (DFNINFO^TMGRPC1)
 ;
 N X,IEN,IENS,ITR,LCNT,PTRPARTS,TMGFDA,TMGMSG
 S IENS="",PTRPARTS=0,DFN=+$G(DFN)
 I DFN>0 D
 . S PTRPARTS=+$P($G(^DPT(DFN,"NAME")),"^",1) ;"ptr to file #20, NAME COMPONENTS
 . S IENS=DFN_","
 . D GETS^DIQ(2,IENS,"**","N","TMGFDA","TMGMSG")
 ;
 S LCNT=0
 S RESULT(LCNT)="IEN="_DFN S LCNT=LCNT+1
 S RESULT(LCNT)="COMBINED_NAME="_$G(TMGFDA(2,IENS,.01)) S LCNT=LCNT+1
 S X=""
 I PTRPARTS>0 S X=$G(^VA(20,PTRPARTS,1))
 S RESULT(LCNT)="LNAME="_$P(X,"^",1) S LCNT=LCNT+1
 S RESULT(LCNT)="FNAME="_$P(X,"^",2) S LCNT=LCNT+1
 S RESULT(LCNT)="MNAME="_$P(X,"^",3) S LCNT=LCNT+1
 S RESULT(LCNT)="PREFIX="_$P(X,"^",4) S LCNT=LCNT+1
 S RESULT(LCNT)="SUFFIX="_$P(X,"^",5) S LCNT=LCNT+1
 S RESULT(LCNT)="DEGREE="_$P(X,"^",6) S LCNT=LCNT+1
 S RESULT(LCNT)="DOB="_$G(TMGFDA(2,IENS,.03)) S LCNT=LCNT+1
 S RESULT(LCNT)="SEX="_$G(TMGFDA(2,IENS,.02)) S LCNT=LCNT+1
 ;S RESULT(LCNT)="SS_NUM="_$G(TMGFDA(2,IENS,.09)) S LCNT=LCNT+1
 S RESULT(LCNT)="EMAIL="_$G(TMGFDA(2,IENS,.133)) S LCNT=LCNT+1
 S RESULT(LCNT)="ADDRESS_LINE_1="_$G(TMGFDA(2,IENS,.111)) S LCNT=LCNT+1
 S RESULT(LCNT)="ADDRESS_LINE_2="_$G(TMGFDA(2,IENS,.112)) S LCNT=LCNT+1
 S RESULT(LCNT)="ADDRESS_LINE_3="_$G(TMGFDA(2,IENS,.113)) S LCNT=LCNT+1
 S RESULT(LCNT)="CITY="_$G(TMGFDA(2,IENS,.114)) S LCNT=LCNT+1
 S RESULT(LCNT)="STATE="_$G(TMGFDA(2,IENS,.115)) S LCNT=LCNT+1
 I $G(TMGFDA(2,IENS,.1112))'="" D   ;"was .1122   ?
 . S RESULT(LCNT)="ZIP4="_$G(TMGFDA(2,IENS,.1112)) S LCNT=LCNT+1
 E  I $G(TMGFDA(2,IENS,.116))'="" D   ;"was   .1116  ?
 . S RESULT(LCNT)="ZIP4="_$G(TMGFDA(2,IENS,.116)) S LCNT=LCNT+1
 S RESULT(LCNT)="BAD_ADDRESS="_$G(TMGFDA(2,IENS,.121)) S LCNT=LCNT+1
 S RESULT(LCNT)="TEMP_ADDRESS_ACTIVE="_$G(TMGFDA(2,IENS,.12105)) S LCNT=LCNT+1
 I $G(TMGFDA(2,IENS,.12105))="YES" D
 .S RESULT(LCNT)="TEMP_ADDRESS_LINE_1="_$G(TMGFDA(2,IENS,.1211)) S LCNT=LCNT+1
 .S RESULT(LCNT)="TEMP_ADDRESS_LINE_2="_$G(TMGFDA(2,IENS,.1212)) S LCNT=LCNT+1
 .S RESULT(LCNT)="TEMP_ADDRESS_LINE_3="_$G(TMGFDA(2,IENS,.1213)) S LCNT=LCNT+1
 .S RESULT(LCNT)="TEMP_CITY="_$G(TMGFDA(2,IENS,.1214)) S LCNT=LCNT+1
 .S RESULT(LCNT)="TEMP_STATE="_$G(TMGFDA(2,IENS,.1215)) S LCNT=LCNT+1
 .S RESULT(LCNT)="TEMP_ZIP4="_$G(TMGFDA(2,IENS,.1216)) S LCNT=LCNT+1
 .S RESULT(LCNT)="TEMP_STARTING_DATE="_$G(TMGFDA(2,IENS,.1217)) S LCNT=LCNT+1
 .S RESULT(LCNT)="TEMP_ENDING_DATE="_$G(TMGFDA(2,IENS,.1218)) S LCNT=LCNT+1
 .S RESULT(LCNT)="PHONE_TEMP="_$G(TMGFDA(2,IENS,.1219)) S LCNT=LCNT+1
 ;S RESULT(LCNT)="CONF_ADDRESS_LINE_1="_$G(TMGFDA(2,IENS,.1411)) S LCNT=LCNT+1
 ;S RESULT(LCNT)="CONF_ADDRESS_LINE_1="_$G(TMGFDA(2,IENS,.1412)) S LCNT=LCNT+1
 ;S RESULT(LCNT)="CONF_ADDRESS_LINE_1="_$G(TMGFDA(2,IENS,.1413)) S LCNT=LCNT+1
 ;S RESULT(LCNT)="CONF_CITY="_$G(TMGFDA(2,IENS,.1414)) S LCNT=LCNT+1
 ;S RESULT(LCNT)="CONF_STATE="_$G(TMGFDA(2,IENS,.1415)) S LCNT=LCNT+1
 ;S RESULT(LCNT)="CONF_ZIP4="_$G(TMGFDA(2,IENS,.1416)) S LCNT=LCNT+1
 ;S RESULT(LCNT)="CONF_STARTING_DATE="_$G(TMGFDA(2,IENS,.1417)) S LCNT=LCNT+1
 ;S RESULT(LCNT)="CONF_ENDING_DATE="_$G(TMGFDA(2,IENS,.1418)) S LCNT=LCNT+1
 ;S RESULT(LCNT)="CONF_ADDRESS_ACTIVE="_$G(TMGFDA(2,IENS,.14105)) S LCNT=LCNT+1
 S RESULT(LCNT)="PHONE_RESIDENCE="_$G(TMGFDA(2,IENS,.131)) S LCNT=LCNT+1
 S RESULT(LCNT)="PHONE_WORK="_$G(TMGFDA(2,IENS,.132)) S LCNT=LCNT+1
 S RESULT(LCNT)="PHONE_CELL="_$G(TMGFDA(2,IENS,.134)) S LCNT=LCNT+1
 ;
 ;"the GETS doesn't return ALIAS entries, so will DO manually:
 ;Rewritten by DSS/SMP
 ;S IEN=$$ITRINIT^TMGITR(2.01,.ITR,DFN_",")
 ;I IEN'="" F  D  Q:(+$$ITRNEXT^TMGITR(.ITR,.IEN)'>0)
 S IEN=0 F  S IEN=$O(^DPT(DFN,.01,IEN)) Q:'IEN  D
 . N X S X=$G(^DPT(DFN,.01,IEN,0))
 . I X="" Q
 . S RESULT(LCNT)="ALIAS "_IEN_" NAME="_$P(X,"^",1) S LCNT=LCNT+1
 . S RESULT(LCNT)="ALIAS "_IEN_" SSN="_$P(X,"^",2) S LCNT=LCNT+1
 . ;"maybe later DO something with NAME COMPONENTS in Alias.
 ;
 Q
 ;
DEMOSET ; RPC - VFDTMG PATIENT DEMO SET
 ; Cloned from TMG SET PATIENT DEMOGRAPHICS (STPTINFO^TMGRPC1)
 ;
 S RESULT=1  ;"default to success
 ;
 ;"KILL ^TMG("TMP","RPC")
 ;"MERGE ^TMG("TMP","RPC")=INFO   ;"temp... remove later
 ;
 N TEMPADDR,TMGFDA,TMGKEY,TMGMSG,IENS
 S IENS=DFN_",",TMGKEY=""
 F  S TMGKEY=$O(INFO(TMGKEY)) Q:(TMGKEY="")  D
 . I TMGKEY["TEMP_"!(TMGKEY="PHONE_TEMP") S TEMPADDR=1
 . I TMGKEY="COMBINED_NAME" S TMGFDA(2,IENS,.01)=INFO("COMBINED_NAME")
 . E  I +TMGKEY=TMGKEY S TMGFDA(2,IENS,TMGKEY)=INFO(TMGKEY)
 . E  I TMGKEY="DOB" S TMGFDA(2,IENS,.03)=INFO("DOB")
 . E  I TMGKEY="SEX" S TMGFDA(2,IENS,.02)=INFO("SEX")
 .; E  I TMGKEY="SS_NUM" S TMGFDA(2,IENS,.09)=INFO("SS_NUM")
 . E  I TMGKEY="ADDRESS_LINE_1" S TMGFDA(2,IENS,.111)=INFO("ADDRESS_LINE_1")
 . E  I TMGKEY="ADDRESS_LINE_2" S TMGFDA(2,IENS,.112)=INFO("ADDRESS_LINE_2")
 . E  I TMGKEY="ADDRESS_LINE_3" S TMGFDA(2,IENS,.113)=INFO("ADDRESS_LINE_3")
 . E  I TMGKEY="CITY" S TMGFDA(2,IENS,.114)=INFO("CITY")
 . E  I TMGKEY="STATE" S TMGFDA(2,IENS,.115)=INFO("STATE")
 . E  I TMGKEY="ZIP4" S TMGFDA(2,IENS,.1112)=INFO("ZIP4")
 . E  I TMGKEY="BAD_ADDRESS" S TMGFDA(2,IENS,.121)=INFO("BAD_ADDRESS")
 . E  I TMGKEY="TEMP_ADDRESS_LINE_1" S TMGFDA(2,IENS,.1211)=INFO("TEMP_ADDRESS_LINE_1")
 . E  I TMGKEY="TEMP_ADDRESS_LINE_2" S TMGFDA(2,IENS,.1212)=INFO("TEMP_ADDRESS_LINE_2")
 . E  I TMGKEY="TEMP_ADDRESS_LINE_3" S TMGFDA(2,IENS,.1213)=INFO("TEMP_ADDRESS_LINE_3")
 . E  I TMGKEY="TEMP_CITY" S TMGFDA(2,IENS,.1214)=INFO("TEMP_CITY")
 . E  I TMGKEY="TEMP_STATE" S TMGFDA(2,IENS,.1215)=INFO("TEMP_STATE")
 . E  I TMGKEY="TEMP_ZIP4" S TMGFDA(2,IENS,.12112)=INFO("TEMP_ZIP4")
 . E  I TMGKEY="TEMP_STARTING_DATE" S TMGFDA(2,IENS,.1217)=INFO("TEMP_STARTING_DATE")
 . E  I TMGKEY="TEMP_ENDING_DATE" S TMGFDA(2,IENS,.1218)=INFO("TEMP_ENDING_DATE")
 . E  I TMGKEY="TEMP_ADDRESS_ACTIVE" S TMGFDA(2,IENS,.12105)=INFO("TEMP_ADDRESS_ACTIVE")
 .; E  I TMGKEY="CONF_ADDRESS_LINE_1" S TMGFDA(2,IENS,.1411)=INFO("CONF_ADDRESS_LINE_1")
 .; E  I TMGKEY="CONF_ADDRESS_LINE_2" S TMGFDA(2,IENS,.1412)=INFO("CONF_ADDRESS_LINE_2")
 .; E  I TMGKEY="CONF_ADDRESS_LINE_3" S TMGFDA(2,IENS,.1413)=INFO("CONF_ADDRESS_LINE_3")
 .; E  I TMGKEY="CONF_CITY" S TMGFDA(2,IENS,.1414)=INFO("CONF_CITY")
 .; E  I TMGKEY="CONF_STATE" S TMGFDA(2,IENS,.1415)=INFO("CONF_STATE")
 .; E  I TMGKEY="CONF_ZIP" S TMGFDA(2,IENS,.1416)=INFO("CONF_ZIP")
 .; E  I TMGKEY="CONF_STARTING_DATE" S TMGFDA(2,IENS,.1417)=INFO("CONF_STARTING_DATE")
 .; E  I TMGKEY="CONF_ENDING_DATE" S TMGFDA(2,IENS,.1418)=INFO("CONF_ENDING_DATE")
 .; E  I TMGKEY="CONF_ADDRESS_ACTIVE" S TMGFDA(2,IENS,.14105)=INFO("CONF_ADDRESS_ACTIVE")
 . E  I TMGKEY="PHONE_RESIDENCE" S TMGFDA(2,IENS,.131)=INFO("PHONE_RESIDENCE")
 . E  I TMGKEY="PHONE_WORK" S TMGFDA(2,IENS,.132)=INFO("PHONE_WORK")
 . E  I TMGKEY="PHONE_CELL" S TMGFDA(2,IENS,.134)=INFO("PHONE_CELL")
 . E  I TMGKEY="PHONE_TEMP" S TMGFDA(2,IENS,.1219)=INFO("PHONE_TEMP")
 . E  I TMGKEY="EMAIL" S TMGFDA(2,IENS,.133)=INFO("EMAIL")
 ;
 ; Set the field TEMPORARY ADDRESS ACTIVE? in order to store data
 I $G(TEMPADDR) D
 .N VFDFDA,VFDERR
 .S VFDFDA(2,IENS,.12105)="Y" D FILE^DIE(,"VFDFDA","VFDERR")
 ;
 I $D(TMGFDA) D
 . D FILE^DIE("EKST","TMGFDA","TMGMSG")
 . I $D(TMGMSG("DIERR")) D
 . . S RESULT="-1^Filing Error Occured: "_$G(TMGMSG("DIERR",1,"TEXT",1))
 . . ;"MERGE ^TMG("TMP","RPC","DIERR")=TMGMSG("DIERR")
 . . ;"MERGE ^TMG("TMP","RPC","FDA")=TMGFDA
 ;
 ; Reset the field TEMPORARY ADDRESS ACTIVE? based on dates
 I $G(TEMPADDR) D
 .N BEG,VFDERR,VFDFDA
 .S BEG=$$GET1^DIQ(2,IENS,.1217,"I")
 .I '$G(BEG) S VFDFDA(2,IENS,.12105)="N" D FILE^DIE(,"VFDFDA","VFDERR")
 ;
 ;"now file Alias info separately
 I RESULT=1 D
 . N TEMPARR,INDEX,TMGKEY,TMGKEY2 S TMGKEY=""
 . F  S TMGKEY=$O(INFO(TMGKEY)) Q:(TMGKEY="")  D
 . . I TMGKEY["ALIAS" D
 . . . S INDEX=$P(TMGKEY," ",2) Q:(INDEX="")
 . . . S TMGKEY2=$P(TMGKEY," ",3)
 . . . S TEMPARR(INDEX,TMGKEY2)=INFO(TMGKEY)
 . S INDEX=0 F  S INDEX=$O(TEMPARR(INDEX)) Q:(INDEX="")!(RESULT'=1)  D
 . . N TMGFDA,TMGMSG,TMGIEN,NEWREC
 . . S NEWREC=0
 . . S TMGKEY="" F  S TMGKEY=$O(TEMPARR(INDEX,TMGKEY)) Q:(TMGKEY="")!(RESULT'=1)  D
 . . . I TMGKEY="NAME" S TMGFDA(2.01,INDEX_","_DFN_",",.01)=$G(TEMPARR(INDEX,"NAME"))
 . . . I TMGKEY="SSN" S TMGFDA(2.01,INDEX_","_DFN_",",1)=$G(TEMPARR(INDEX,"SSN"))
 . . . I INDEX["+" S NEWREC=1
 . . I $D(TMGFDA) D
 . . . I NEWREC=0 D FILE^DIE("EKST","TMGFDA","TMGMSG")
 . . . E  D UPDATE^DIE("ES","TMGFDA","TMGIEN","TMGMSG")
 . . I $D(TMGMSG("DIERR")) D
 . . . S RESULT="-1^Filing Error Occured: "_$G(TMGMSG("DIERR",1,"TEXT",1))
 . . . ;"MERGE ^TMG("TMP","RPC","DIERR")=TMGMSG("DIERR")
 . . . ;"MERGE ^TMG("TMP","RPC","FDA")=TMGFDA
 ;
 Q
 ;
