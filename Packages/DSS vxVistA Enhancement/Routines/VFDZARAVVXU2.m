VFDZARAVVXU2 ;DSS/PDW - GENERATE IMMUNIZATION MESSAGE ; 18 April 2011
 ;;2012.1.1;VENDOR - DOCUMENT STORAGE SYS;;24 Jun 2013;Build 136
 ;Copyright 1995-2013,Document Storage Systems Inc. All Rights Reserved
 ;DSS/BUILD - VFDHHL HL7 EXCHANGE 2012.1.1 * 06/23/15 * vxdev64v2k8_VX13 * 2012.1 T22
 ;DSS/BUILD - VFDHHL HL7 EXCHANGE 2012.1.1 * 02/02/14 * vxdev64v2k8_DEVXOS * 2012.1.1T21
VISIT ;entry to select visit and review or send immunizations
 ;
 N DIC,VFDVSTDA,Y,D,V,VFDTMP,VFDMSG,VFDRSLT
 N VFDENC,VFDG,VFDVST,HLA
 W !,?20,"Immunization Registry Review & Transmission",!
 S VFDVSTDA=$$SELECT(.XXX)
 I VFDVSTDA'>0 Q
 K DIR S DIR(0)="SO^1:Visit Immunization Review;2:Visit Immunzation Transmit;Q:Quit"
 D ^DIR
 ;select calls ENCEVENT^PXAPI
 I Y=1 D REVIEW(VFDVSTDA) G VISIT
 I Y=2 D TRANSMIT(VFDVSTDA) G VISIT
 I Y="Q" Q
 Q
ENTEST ; no news
 K DIC,VFDVSTDA,Y,D,V,VFDTMP,VFDMSG,VFDRSLT
 K VFDENC,VFDG,VFDVST,HLA
 W !,"This will allow selection of a visit and it's immunizations"
 W !,"will be transmitted to the config server folder C:\hfs\hl7\ARRA."
 S DIC=9000010,DIC(0)="AEQM",D="C"
 D IX^DIC
 I '+Y Q
 I +Y S VFDVSTDA=+Y
 D ENCEVENT^PXAPI(VFDVSTDA)
 S VFDENC=$NA(^TMP("PXKENC",$J)),VFDG=$NA(^TMP("PXKENC",$J,VFDVSTDA,"IMM"))
 I '$D(@VFDG) D  G VISIT
 .W !,"There are no Immunizations associated with this visit.",!
 W !!,"Please insure that the following demographics indicate the"
 W !,"proper encounter to be sent:"
 K VFDTMP,VFDMSG
 D GETS^DIQ(9000010,VFDVSTDA,".01;.05;.08","IE","VFDTMP","VFDMSG")
 M VFDVST=VFDTMP(9000010,VFDVSTDA_",")
 W !,?5,"Patient:",?20,VFDVST(.05,"E")
 W !,?5,"Date/Time:",?20,VFDVST(.01,"E")
 W !,?5,"Clinic:",?20,VFDVST(.08,"E")
 W !!,?5,"Immunization(s)"
 S VFDVIMDA=0 F  S VFDVIMDA=$O(@VFDG@(VFDVIMDA)) Q:VFDVIMDA'>0  W !,?5,$$GET1^DIQ(9000010.11,VFDVIMDA,.01)
 K DIR S DIR(0)="Y",DIR("A")="Is the above correct?" D ^DIR
 I Y'=1 G VISIT
 S VFDVSTDA=+Y
 W !,"Transmitting HL7 message"
 D VSITSEND(VFDVSTDA,.VFDMSGID) ; return message ID
 W !,"Message Sent with ID: ",+VFDMSGID
 Q
VSITSEND(VFDVSTDA,VFDMSGID) ; send message return message ID
 ; the message HL7 v 1.6 lines are put into @VFDHLTMP@
 ; here it is a local array as messages are small
 S VFDHLTMP="HLA(""HLS"")"
 S VFDDFN=VFDVST(.05,"I")
 D PIDSEG
 ;S VFDVIMDA=0 F  S VFDVIMDA=$O(@VFDG@(VFDVIMDA)) Q:VFDVIMDA'>0  D RXASEG
 D VIMSFIND^VFDZARAVVXU1(.VFDVIM,VFDVSTDA)
 S VFDVIMDA=0 F  S VFDVIMDA=$O(VFDVIM(VFDVIMDA)) Q:VFDVIMDA'>0  D RXASEG
 ;the HLA array has been built
 D SEND
 Q
 ;PID
PIDSEG ;set variables, load segment array, load array into HL7 message
 N PID,VFDPIC,VFDPID
 D PIDVARS
 D ADDHL16^VFDHHLOT(VFDHLTMP,.VFDHL16) ;HL1.6
 K SEG
 Q
 ;
PIDVARS ; set variables for segment PID
 ; @VFDHLTMP@ is to be the HL16 total array location is 'REQUIRED'
 ;Sequence  Name                             Type      Variable          Rep Req
 ;1.0.0.0   Set ID - PID "0001"              ST        VFDPID("SEQ")         
 ;2.1.0.0   ID                               ST        VFDPID("PTID")        
 ;3.1.0.0   ID                               ST        VFDPID("PATID")       Y
 ;3.4.1.0   namespace ID 300                 MPI*      VFDPID("ASGAUTH")     Y
 ;3.4.2.0   universal ID                     ST        VFDPID("ASGID")       Y
 ;3.4.3.0   universal ID type 301            ISO*      VFDPID("ASGGRP")      Y
 ;3.5.0.0   identifier type code 203         MR*       VFDPID("<L>")         Y
 ;5.1.0.0   family name                      ST        VFDPID("LNAME")       Y
 ;5.2.0.0   given name                       ST        VFDPID("FNAME")       Y
 ;7.0.0.0   Date/Time Of Birth               TS        VFDPID("PTDOB")       Y
 ;8.0.0.0   0001 Administrative Sex          0001      VFDPID("PTSEX")       Y
 ;10.1.0.0  RACE identifier                  0005      VFDPID("RACEID")      Y
 ;10.2.0.0  text                             ST        VFDPID("RACETXT")     Y
 ;10.3.0.0  name of coding system            396       VFDPID("RACESYS")     Y
 ;11.1.0.0  (sad) street address             ST        VFDPID("PTADDLINE1")  Y
 ;11.2.0.0  other designation                ST        VFDPID("PTADDLINE2")  
 ;11.3.0.0  city                             ST        VFDPID("PTADDCITY")   Y
 ;11.4.0.0  state or province                ST        VFDPID("PTADDSTATE")  Y
 ;11.5.0.0  zip or postal code               ST        VFDPID("PTADDZIP")    Y
 ;11.7.0.0  (190) address type               ST        VFDPID("PTADDTYP")    
 ;13.1.0.0  telephone any text               ST        VFDPID("PHONE#")      
 ;13.2.0.0  telecommunication use code       ST        VFDPID("PHONECD")     Y
 ;13.3.0.0  (202) tele equip type            PH*       VFDPID("PHONETYPE")   Y
 ;13.6.0.0  area/city code                   NM        VFDPID("PHONEAREA")   Y
 ;13.7.0.0  phone number                     NM        VFDPID("PHONELOCAL")  Y
 ;22.1.0.0  (189) identifier                 N*        VFDPID("ETHNICGRP")   Y ;22.2.0.0  text                             Not Hispanic or Latino*VFDPID("ETHNICTXT")                                                                      Y
 ;22.3.0.0  (396) name of coding system      HL70189*  VFDPID("ETHNICSYS")   Y
 ;29.0.0.0  Patient Death Date and Time      TS        VFDPID("PTDOD")       
 ;30.0.0.0  Patient Death Indicator          ST        VFDPID("DODIND")      
 ;Use @VAR@("HL")=VALUE to bypass FM to HL7 transform
 ;
 N VFDELM,VFDPTPID,VFDPIDSG,VFDPID,VFDSGMNT,VFDSEG,VFDE,VFDC,VFDS
T1 ;
 K VFDELM,VFDPTPID,VFDPIDSG,VFDPID,VFDSGMNT,VFDSEG,VFDE,VFDC,VFDS
 D EN^VFDHLPID(.VFDPIDSG,VFDDFN,,,,"S")
 D PARSE^VFDHHLOT(.VFDPTPID,VFDPIDSG,1) ;HL7.e.c.s subscripting
 F VFDELM=1,2,4,6,9,12 K VFDPTPID(VFDELM)
 F VFDELM=14:1:21 K VFDPTPID(VFDELM)
 S VFDE=11 F VFDC=2,6 K VFDPTPID(VFDE,1,VFDC)
 S VFDE=3 F VFDC=2,3 K VFDPTPID(VFDE,1,VFDC)
 F I=2:1:5 K VFDPTPID(3,I)
 S VFDPTPID(3,1,4,1)="MPI"
 S VFDPTPID(3,1,4,2)=+$$SITE^VASITE_"."_VFDDFN
 S VFDPTPID(3,1,4,3)="ISO"
 S VFDPTPID(3,1,5,1)="MR"
 S VFDPTPID(10,1,3,1)="HL70005"
 S VFDPTPID(13,1,6,1)=$E(VFDPTPID(13,1,1,1),1,3)
 S VFDPTPID(13,1,7,1)=$E(VFDPTPID(13,1,1,1),4,10)
 K VFDPTPID(13,1,1,1)
 ;use what the PID generator provides
 ;S VFDPTPID(22,1,1,1)="N"
 ;S VFDPTPID(22,1,2,1)="Not Hispanic or Latino"
 S VFDPTPID(22,1,3,1)="HL70189"
 ;step 'D SEGSET^VFDHHLOT(' skipped here as array already exists
 M VFDSEG=VFDPTPID ;move working array into position for call to build^
 D BUILD^VFDHHLOT(.VFDSGMNT,.VFDSEG,1) ; assemble array VFDSEG into one VFDSGMNT
 D SPLIT^VFDHHLOT(.VFDHL16,VFDSGMNT) ; split VFDSGMNT into 240 lengths elements
 Q
 ;RXA
RXASEG ;set variables, load segment array, load array into HL7 message
 N VFDRXA
 D RXAVARS
 D ADDHL16^VFDHHLOT(VFDHLTMP,.VFDHL16) ;HL1.6
 K SEG
 Q
 ;
RXAVARS ; set variables for segment RXA
 ; @VFDHLTMP@ is to be the HL16 total array location is 'REQUIRED'
 ;Sequence  Name                             Type      Variable          Rep Req
 ;1.0.0.0   Give Sub-ID Counter              0*        VFDRXA("GVNSUBIDCNT") Y
 ;2.0.0.0   Administration Sub-ID Counter    1*        VFDRXA("ADMSUBIDCNT") Y
 ;3.0.0.0   Date/Time Start of Administrat   TS        VFDRXA("ADMDTMBEG")   Y
 ;4.0.0.0   Date/Time End of Administratio   TS        VFDRXA("ADMDTMEND")   Y
 ;5.1.0.0   (292) identifier                 292       VFDRXA("ADMCDID")     Y
 ;5.2.0.0   text                             ST        VFDRXA("ADMCDTXT")    Y
 ;5.3.0.0   (396) name of coding system      ST        VFDRXA("ADMCDSYS")    Y
 ;6.0.0.0   Administered Amount              NM        VFDRXA("AMOUNT")      Y
 ;7.1.0.0   identifier                       ST        VFDRXA("UNITID")      Y
 ;7.2.0.0   text                             ST        VFDRXA("UNITTXT")     Y
 ;7.3.0.0   (396) name of coding system      ST        VFDRXA("UNITSYS")     Y
 ;15.0.0.0  Substance Lot Number             ST        VFDRXA("LOTNUM")      Y
 ;17.1.0.0  identifier                       ST        VFDRXA("MFGID")       Y
 ;17.2.0.0  text                             ST        VFDRXA("MFGTXT")      Y
 ;17.3.0.0  (396) coding system              MVX*      VFDRXA("MFGSYS")      Y
 ;21.0.0.0  (323) Action Code-RXA            A*        VFDRXA("ACTCD")       
 ;Use @VAR@("HL")=VALUE to bypass FM to HL7 transform
 ;
 ;arrays used
 ;VFDVIM     V Immunizations
 ;VFDVFD     VFD Immunization
 ;VFDROW     Row from VX HL7x tables
 ;Find related file IENS
 ;S VFDVIMDA ; passed in partition
 N VFDTMP,VFDMSG,VFDVIM,VFDVSTDA,VFDVST,VFDVFDDA,VFDSEG,VFDRXA
 N VFDTABIS,VFDROWDA,VFDROW,VFDROWIS,VFDMFG,SEG
 N VFGD227,VFD227DA,VF227GIS,VFD292,VFD292DA,VFDV292IS
T2 ;
 K VFDTMP,VFDMSG,VFDVIM,VFDVSTDA,VFDVST,VFDVFDDA,VFDSEG,VFDRXA
 K VFDTABIS,VFDROWDA,VFDROW,VFDROWIS,VFDMFG,SEG,VFDMFG
 K VFDMFG,VFDMFGDA,VFDMFGIS,VFDVAX,VFDVAXDA,VFD292IS
 ;pull V IMMU data
 D GETS^DIQ(9000010.11,VFDVIMDA,".01;.02;.03;21600.01;21600.02;21600.03","I","VFDTMP","VFDMSG")
 ;VFDTMP(9000010.11,"27,",.01,"I")=19
 M VFDVIM=VFDTMP(9000010.11,VFDVIMDA_",")
 ;S VFDRXA("GVNSUBIDCNT")="" ; static '0'
 ;S VFDRXA("ADMSUBIDCNT")="" ; static '1'
 S VFDVSTDA=VFDVIM(.03,"I")
 S VFDRXA("ADMDTMBEG")=$$GET1^DIQ(9000010,VFDVSTDA,.01,"I")
 S VFDRXA("ADMDTMEND")=VFDRXA("ADMDTMBEG")
 ;pull values from VX0292 vacines table with IEN of IM file
 S VFDIMDA=VFDVIM(.01,"I")
 D TABPATH^VFDHHLOT(.VFD292IS,"ARRA","VX0292") ;VFDTBLIS="21625.0106^174,4,"
 S VFD292IS=","_$P(VFD292IS,U,2)
 K VFDMSG,VFDTMP,VFD292
 S (VFDFILE,VFDIENS,VFDFLGS,VFDVAL,VFDINDX,VFDSCR,VFDMSG)=""
 S VFDMSG="VFDMSG",VFDVAL=VFDIMDA,VFDTMP="VFDTMP"
 S VFDFILE=21625.0106,VFDIENS=VFD292IS,VFDVAL=VFDIMDA,VFDINDX="D"
 S VFD292DA=$$FIND1^DIC(VFDFILE,VFDIENS,VFDFLGS,.VFDVAL,.VFDINDX,.VFDSCR,VFDMSG)
 S VFD292IS=VFD292DA_VFD292IS
 D GETS^DIQ(21625.0106,VFD292IS,".01;.02;.05",,VFDTMP,VFDMSG)
 M VFD292=VFDTMP(21625.0106,VFD292IS)
 S VFDRXA("ADMCDID")=VFDIMDA
 S VFDRXA("ADMCDTXT")=VFD292(.02)
 S VFDRXA("ADMCDSYS")=VFD292(.05)
UNIT D UNITS
 I '+VFDVIM(21600.01,"I") G NODOSE
 I +VFDVIM(21600.01,"I")=999 G NODOSE
 K VFDTMP,VFDMSG,VFDVFD
 S VFDTMP="VFDTMP",VFDMSG="VFDMSG"
 S VFDVFDDA=$G(VFDVIM(21600.03,"I"))
 D GETS^DIQ(21630.01,VFDVFDDA,".01;.02;.03;.04;1;1.1",,VFDTMP,VFDMSG)
 M VFDVFD=VFDTMP(21630.01,VFDVFDDA_",")
 S VFDRXA("LOTNUM")=VFDVFD(.02)
 S VFDRXA("MFGTXT")=VFDVFD(.03)
 ;use MFGTXT, VFDVFD(.03) to lookup in VX0227 table
 D TABPATH^VFDHHLOT(.VFD227IS,"ARRA","VX0227") ;VFDTBLIS="21625.0106^174,4,"
 S VFD227IS=","_$P(VFD227IS,U,2)
 S (VFDFILE,VFDIENS,VFDFLGS,VFDVAL,VFDINDX,VFDSCR,VFDMSG)=""
 S VFDFILE=21625.0106,VFDIENS=VFD227IS,VFDINDX="C"
 K VFDMSG,VFDTMP,VFD227
 S VFDMSG="VFDMSG",VFDTMP="VFDTMP"
 S VFDVAL=VFDVFD(.03)
 S VFD227DA=$$FIND1^DIC(VFDFILE,VFDIENS,VFDFLGS,.VFDVAL,.VFDINDX,.VFDSCR,VFDMSG)
 S VFD227IS=VFD227DA_VFD227IS
 D GETS^DIQ(21625.0106,VFD227IS,".01;.02;.05",,VFDTMP,VFDMSG)
 M VFD227=VFDTMP(21625.0106,VFD227IS)
 S VFDRXA("MFGID")=VFD227(.01)
 S VFDRXA("MFGSYS")=VFD227(.05)
 ;S VFDRXA("ACTCD")=""
NODOSE ; if no dose no units, no manufacturer
 K VFDSEG
 D SEGSET^VFDHHLOT("ARRA","RXA",.VFDSEG)
 N VFDSGMNT
 D BUILD^VFDHHLOT(.VFDSGMNT,.VFDSEG) ; assemble array VFDSEG into one VFDSGMNT
 D SPLIT^VFDHHLOT(.VFDHL16,VFDSGMNT) ; split VFDSGMNT into 240 length elements
 Q
UNITS ; per RXA.6 set RXA.7 items
 I +VFDVIM(21600.01,"I") D  I 1
 . S VFDRXA("AMOUNT")=VFDVIM(21600.01,"I")
 . ;all ARRA is ml^milliliter^ISO+
 . S VFDRXA("UNITID")="ml"
 . S VFDRXA("UNITTXT")="milliliter"
 . S VFDRXA("UNITSYS")="ISO+"
 E  S VFDRXA("AMOUNT")=999
 Q
SEND(VFDRSLT) ; generate HL message
 N VFDFILE,VFDIENS,VFDFLGS,VFDVAL,VFDINDX,VFDSCR,VFDMSG
 S VFD101NM="VFDH ARRA VXU-V04 SERVER"
 S (VFDFILE,VFDIENS,VFDFLGS,VFDVAL,VFDINDX,VFDSCR,VFDMSG)=""
 S VFDFILE=101,VFDVAL=VFD101NM,VFDMSG="VFDMSG"
 S VFD101DA=$$FIND1^DIC(VFDFILE,VFDIENS,VFDFLGS,.VFDVAL,.VFDINDX,.VFDSCR,VFDMSG)
 N VFDDIR,VFDHFSNM
 D INIT^HLFNC2(VFD101DA,.HL)
 ;build HLA("HLS",I)
 K HLA("HLS",0)
 D GENERATE^HLMA(VFD101DA,"LM",1,.VFDRSLT)
 Q
SELECT(VFDVSTDA) ;$$
 K DIC,Y,VFDG,VFDENC,VFDG,DIR
 K VFDTMP,VFDMSG,VFDVST,VFDTMP,VFDIMDA
 K ^TMP("PXKENC",$J)
 S VFDVSTDA=0
 S DIC=9000010,DIC(0)="AEQM",D="C"
 D IX^DIC
 I Y'>0 Q 0
 I +Y S VFDVSTDA=+Y
 D ENCEVENT^PXAPI(VFDVSTDA)
 S VFDENC=$NA(^TMP("PXKENC",$J)),VFDG=$NA(^TMP("PXKENC",$J,VFDVSTDA,"IMM"))
 I '$D(@VFDG) D  D E
 .W !,"There are no Immunizations associated with this visit.",!
 W !!,"Please insure that the following demographics indicate the"
 W !,"proper encounter to be sent:"
 D GETS^DIQ(9000010,VFDVSTDA,".01;.05;.08","IE","VFDTMP","VFDMSG")
 M VFDVST=VFDTMP(9000010,VFDVSTDA_",")
 W !,?5,"Patient:",?20,VFDVST(.05,"E")
 W !,?5,"Date/Time:",?20,VFDVST(.01,"E")
 W !,?5,"Clinic:",?20,VFDVST(.08,"E")
 W !!,?5,"Immunization(s)"
 S VFDVIMDA=0 F  S VFDVIMDA=$O(@VFDG@(VFDVIMDA)) Q:VFDVIMDA'>0  W !,?5,$$GET1^DIQ(9000010.11,VFDVIMDA,.01)
 K DIR S DIR(0)="Y",DIR("A")="Is the above correct?" D ^DIR
 I Y'=1 Q 0
 Q VFDVSTDA
 Q
TRANSMIT(VFDVSTDA) ;
 W !!,"Transmitting HL7 message",!
 D VSITSEND^VFDZARAVVXU1(VFDVSTDA,.VFDMSGID) ; return message ID
 W !!,"Message Sent with ID: ",+VFDMSGID,!
 D E
 Q
REVIEW(VFDVSTDA) ;
 D ^%ZIS
 N VFDVALS,VFDTAR,VFDFLDS,VFDDFN,VFDLN,VFDENC,VFDFILE,VFDMSG,VFDRPC
 N VFDVIMDA
 N VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX
 N VFDSCR,VFDIDENT,VFDTAR,VFDMSG,DA,VFDRACE,VFDROW,VFDVALS,VFDRCEXX
 K VFDVALS,VFDTAR,VFDFLDS,VFDDFN,VFDLN,VFDENC,VFDFILE,VFDMSG,VFDRPC
 K VFDVIMDA
 K VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX
 K VFDSCR,VFDIDENT,VFDTAR,VFDMSG,DA,VFDRACE,VFDROW,VFDVALS,VFDRCEXX
 K VFDRPC S VFDRPC(0)=""
 K ^TMP("PXKENC",$J),LINE
 K VFDRPC S VFDRPC(0)="" ;clear & set root
 D ENCEVENT^PXAPI(VFDVSTDA)
 S VFDENC=$NA(^TMP("PXKENC",$J)),VFDG=$NA(^TMP("PXKENC",$J,VFDVSTDA,"IMM"))
 ; PATIENT INFORMATION
 S XX=": PATIENT file entry :"
 K LINE S $P(LINE,"=",$L(XX)+1)="",X=""
 F Y=X,X,LINE,XX,LINE,X D STUFFRPC(Y)
 S VFDDFN=$$GET1^DIQ(9000010,VFDVSTDA,.05,"I")
 S VFDFILE=2
 K VFDTAR,VFDMSG,VFDVALS,VFDFLDS
 S VFDFLDS=".01;.02;.03;.06;.111;.114;.115;.116;.131"
 ;S VFDTAR=$NA(^TMP("VFDHTMP",$J))
 S GBL="VFDTAR"
 D GETS^DIQ(VFDFILE,VFDDFN,VFDFLDS,,"VFDTAR","VFDMSG")
 M VFDVALS=VFDTAR(VFDFILE,VFDDFN_",")
 D STUFFLDS(VFDFILE,VFDFLDS,.VFDVALS) ;
 S XX=": Patient Race Multiple :"
 K LINE S $P(LINE,"=",$L(XX)+1)="",X=""
 F Y=X,X,LINE,XX,LINE,X D STUFFRPC(Y)
 S (VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)=""
 ;Set needed variables
 S VFDFILE=2.02,VFDFLDS=".01;.02",VFDFLGS=""
 K VFDTAR,VFDMSG,VFDVALS
 S DA(1)=VFDDFN S VFDIENS=$$IENS^DILF(.DA)
 D LIST^DIC(VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,"VFDTAR","VFDMSG")
 M VFDRCEXX=VFDTAR("DILIST","ID")
 ;VFDVRCEXX(1,.01)="DECLINED TO ANSWER"
 ;VFDVALS(2,.01)="NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER"
 S VFDRCEN=0 F  S VFDRCEN=$O(VFDRCEXX(VFDRCEN)) Q:VFDRCEN'>0  K VFDVALS M VFDVALS=VFDRCEXX(VFDRCEN) D STUFFLDS(VFDFILE,VFDFLDS,.VFDVALS)
 ;
 S XX=": Ethnicity :"
 K LINE S $P(LINE,"=",$L(XX)+1)="",X=""
 F Y=X,X,LINE,XX,LINE,X D STUFFRPC(Y)
 S (VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)=""
 ;Set needed variables
 S VFDFILE=2.06,VFDFLDS=".01;.02",VFDFLGS=""
 K VFDTAR,VFDMSG,VFDVALS,VFDXXX
 S DA(1)=VFDDFN S VFDIENS=$$IENS^DILF(.DA)
 D LIST^DIC(VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,"VFDTAR","VFDMSG")
 M VFDXXX=VFDTAR("DILIST","ID")
 S VFDXXXDA=0 F  S VFDXXXDA=$O(VFDXXX(VFDXXXDA)) Q:VFDXXXDA'>0  K VFDVALS M VFDVALS=VFDXXX(VFDXXXDA) D STUFFLDS(VFDFILE,VFDFLDS,.VFDVALS)
 S (VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)=""
 ;
 S XX=": Patient IDs :"
 K LINE S $P(LINE,"=",$L(XX)+1)="",X=""
 F Y=X,X,LINE,XX,LINE,X D STUFFRPC(Y)
 S (VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)=""
 ;Set needed variables
 S VFDFILE=2.0216,VFDFLDS=".01;.02;.05",VFDFLGS=""
 K VFDTAR,VFDMSG,VFDVALS,VFDXXX
 S DA(1)=VFDDFN S VFDIENS=$$IENS^DILF(.DA)
 D LIST^DIC(VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,"VFDTAR","VFDMSG")
 M VFDXXX=VFDTAR("DILIST","ID")
 S VFDXXXDA=0 F  S VFDXXXDA=$O(VFDXXX(VFDXXXDA)) Q:VFDXXXDA'>0  K VFDVALS M VFDVALS=VFDXXX(VFDXXXDA) D STUFFLDS(VFDFILE,VFDFLDS,.VFDVALS)
 ; loop and call Immunizations
 ;S VFDVIMDA=0 F  S VFDVIMDA=$O(@VFDG@(VFDVIMDA)) Q:VFDVIMDA'>0  D VIMREV(VFDVIMDA)
 D VIMSFIND^VFDZARAVVXU1(.VFDVIM,VFDVSTDA)
 S VFDVIMDA=0 F  S VFDVIMDA=$O(VFDVIM(VFDVIMDA)) Q:VFDVIMDA'>0  D VIMREV(VFDVIMDA)
 ; review gathered
 S VFDLN=0
 F VFDLN=1:1 Q:'$D(VFDRPC(VFDLN))  U IO W !,VFDRPC(VFDLN)
 D ^%ZISC
 Q
 ;
VIMREV(VFDVIMDA) ; IMMUNIZATIONS
 N VFDVALS,VFDMSG,XX,LINE,VFDFLDS,VFDMSG,VFDVFDDA,VFDTAR
 S X="",XX=": V IMMUNIZATION file entry :"
 K LINE S $P(LINE,"=",$L(XX)+1)=""
 F Y=X,X,LINE,XX,LINE,X D STUFFRPC(Y)
 ;K DIC,DA,DR S DIC="^AUPNVIMM(",DA=VFDVIMDA D EN^DIQ
 S VFDFLDS=".01;.02;.03;1201;21600.01;21600.02;21600.03"
 S VFDFILE=9000010.11
 D GETS^DIQ(VFDFILE,VFDVIMDA,VFDFLDS,,"VFDTAR","VFDMSG")
 K VFDVALS
 M VFDVALS=VFDTAR(VFDFILE,VFDVIMDA_",") ;VFDVALS(.01)="HEPATITIS B"
 D STUFFLDS(VFDFILE,VFDFLDS,.VFDVALS)
 S X="",XX=": VFD IMMUNIZATION file entry :"
 K LINE S $P(LINE,"=",$L(XX)+1)=""
 F Y=X,X,LINE,XX,LINE,X D STUFFRPC(Y)
 S VFDVFDDA=$$GET1^DIQ(9000010.11,VFDVIMDA,21600.03,"I")
 K VFDVALS,VFDMSG,VFDTAR
 S VFDFLDS=".01;.02;.03;.04;3;3.1;4",VFDFILE=21630.01
 D GETS^DIQ(VFDFILE,VFDVFDDA,VFDFLDS,,"VFDTAR","VFDMSG")
 K VFDVALS
 M VFDVALS=VFDTAR(VFDFILE,VFDVFDDA_",") ;VFDVALS(.01)="HEPATITIS B CORE ANTIBODY"
 D STUFFLDS(VFDFILE,VFDFLDS,.VFDVALS)
 Q
E N DIR S DIR(0)="EO",DIR("A")="<CR> - Continue" D ^DIR
 Q
STUFFLDS(VFDFILE,VFDFLDS,VFDVALS) ; STUFFRPC
 N VFDFLD,I,VFDSTR
 F I=1:1 S VFDFLD=$P(VFDFLDS,";",I) Q:VFDFLD'>0  D SETSTR
 Q
SETSTR ;caled by STUFFLDS(VFDFILE,VFDFLDS,VFDTAR)
 ;given file, field(s)(.01)=, load field label(s) and value int VFDRPC
 N VFDFLDD,VFDSTR,X
 D FIELD^DID(VFDFILE,VFDFLD,"","LABEL","VFDFLDD","VFDMSG")
 S VFDSTR=VFDFLDD("LABEL")_":"
 S X=VFDVALS(VFDFLD)
 S VFDSTR=$$SETSTR^VALM1(X,VFDSTR,25,$L(X))
 D STUFFRPC(VFDSTR)
 Q
STUFFRPC(VFDSTR) ;"VFDRPC" target needs to be preset
 N VFDLNLN
 S VFDLN=$O(VFDRPC(""),-1)+1
 S VFDRPC(VFDLN)="    "_VFDSTR
 Q
VIMRPC(VFDRSLT,VFDVIMDA) ;
 N VFDRPC
 K VFDRPC S VFDRPC(0)=""
 D VIMREV(VFDVIMDA) ;generate Immunization review
 S TMP=$NA(^XTMP("VFDVXA",$J)) K @TMP
 M @TMP=VFDRPC
 K VFDRSLT S VFDRSLT=TMP
 Q
