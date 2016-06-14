VFDDGRPD ;DSS/WLC - ENROLLMENT HISTORY UTILITIES ; 9/9/15 10:45am
 ;;2013.1;DSS,INC VXVISTA OPEN SOURCE;**9,66**;28 Jan 2013;Build 3
 ;Copyright 1995-2013,Document Storage Systems Inc. All Rights Reserved
 ;
CL(VFDRET,VFDDFN,VFDFG)  ; RPC:  VFD
 ; return and/or format the clinic/program enrollment display
 ;
 ;  INPUT:  VFDDFN - req - Patient DFN (pointer to file #2)
 ;          VFDFG  - opt - Flag to indicate type of output:
 ;                   1 = format output,return in array, default value
 ;                   2 = return data in "^" delimited array
 ;                   3 = do not return array, just write out results
 ;
 ;  OUTPUT:  .VFDRET = called by reference
 ;  Only return -1^msg if vfdfg<3
 ;
 ;Patch 9--adding Non-Traditional Patient Type info for display-bg
 N I,J,K,X,Y,Z,CL,CLNCN,CNT,DAT,DATE,DIS,EN,ENR,HD,ID,SP,VFDTMP,TYPE
 S CNT=0,VFDDFN=$G(VFDDFN),VFDFG=$G(VFDFG) K VFDRET
 I $S(VFDFG'?1N:1,1:123'[VFDFG) S VFDFG=1
 I VFDDFN<1 D SET(1) Q
 I '$D(^DPT(VFDDFN,0)) D SET(2) Q
 I '$O(^DPT(VFDDFN,"DE",0)) D SET(3) Q
 ; RAC - S20490, CR166 - Issue 494 Defects 663&560 Get parameter value 9/9/15
 ; Show only most recent Program ID (EOC #) for OMH only
 I $T(^JNYMPTINQ)]""&(+$$GET^XPAR("SYS","JNYM PROGRAM ID SINGLE")) D EN^JNYMPTINQ Q
 S CL=0 F  S CL=$O(^DPT(VFDDFN,"DE",CL)) Q:'CL  S X=^(CL,0) D
 . ;Q:$P(X,U,2)="I"   ; inactive
 . Q:'X  ; no clinic pointer
 . I '$O(^DPT(VFDDFN,"DE",CL,1,0)) Q  ;          no enrollments
 . S CLNCN=$$DIQ(44,+X,.01) Q:CLNCN=""  ; clinic name
 . S EN=0 F  S EN=$O(^DPT(VFDDFN,"DE",CL,1,EN)) Q:'EN  S X=^(EN,0) D
 . . S ENR=+X,ENR(0)=9999999-ENR,DIS=+$P(X,U,3),DIS(0)=9999999-DIS
 . . S ID=$P($G(^DPT(VFDDFN,"DE",CL,1,EN,21600)),U),TYPE=$$GET1^DIQ(21630.002,$P($G(^(21600)),U,2),.02)
 . . I +ID S ID=$P($G(^VFD(21630.001,ID,0)),U)
 . . ; vfdtmp(0 or 1,inv_dischdt,inv_enrolldt,clinname,x)=program_id
 . . S VFDTMP((DIS'=0),DIS(0),ENR(0),CLNCN,EN,$S(TYPE'="":TYPE,1:0))=ID
 . . Q
 . Q
 ;
 ; set up return array, active enrollments in VFDTMP(0)
 I '$D(VFDTMP) D SET(3) Q
 S CNT=0,$P(SP," ",80)=""
 S HD(1)="Clinic/Program Name:" S:VFDFG#2 HD(1)=$E(HD(1)_SP,1,27)
 S HD(2)="Type" I VFDFG#2 S HD(2)=$E(HD(2)_SP,1,14)
 S HD(3)="Discharge Date" I VFDFG#2 S HD(3)=$E(HD(3)_SP,1,18)
 S HD(4)="Enroll Date" I VFDFG#2 S HD(4)=$E(HD(4)_SP,1,18)
 S HD(5)="Program ID"
 I VFDFG#2 S HD(6)=HD(1)_HD(2)_HD(3)_HD(4)_HD(5)
 S Y=$TR(SP," ","-")
 S X=$E(Y,1,25)_"  "_$E(Y,1,12)_"  "_$E(Y,1,16)_"  "_$E(Y,1,16)_"  "_$E(Y,1,10)
 I VFDFG#2 S HD(7)=X
 I $D(VFDTMP(0)) D
 .S X="Current Clinic/Program Enrollments:" D SET(X)
 .I VFDFG=2 S X=HD(1)_U_HD(2)_U_HD(3)_U_HD(4)_U_HD(5) D SET(X)
 .I VFDFG#2 D SET(HD(6)),SET(HD(7))
 .S Z="VFDTMP(0)" F  S Z=$Q(@Z) Q:Z=""  Q:$QS(Z,1)'=0  D
 ..S Z(2)=$QS(Z,2),Z(3)=$QS(Z,3),Z(4)=$QS(Z,4),Z(5)=$QS(Z,5),Z(6)=$S($QS(Z,6)=0:"",1:$QS(Z,6))
 ..S DIS=$$DATE(Z(2)),ENR=$$DATE(Z(3))
 ..I VFDFG=2 S X=Z(4)_U_TYPE_U_DIS_U_ENR_U_@Z D SET(X)
 ..I VFDFG#2 S X=$E(Z(4)_SP,1,27)_$E(Z(6)_SP,1,14)_$E(DIS_SP,1,18)_$E(ENR_SP,1,18)_@Z D SET(X)
 ..Q
 .Q
 I $D(VFDTMP(1)) D
 .D SET(" "),SET(" ")
 .S X="Previous Clinic/Program Enrollments:" D SET(X)
 .I VFDFG=2 S X=HD(1)_U_HD(2)_U_HD(3)_U_HD(4)_U_HD(5) D SET(X)
 .I VFDFG#2 D SET(HD(6)),SET(HD(7))
 .S Z="VFDTMP(1)" F  S Z=$Q(@Z) Q:Z=""  Q:$QS(Z,1)'=1  D
 ..S Z(2)=$QS(Z,2),Z(3)=$QS(Z,3),Z(4)=$QS(Z,4),Z(5)=$QS(Z,5),Z(6)=$S($QS(Z,6)=0:"",1:$QS(Z,6))
 ..S DIS=$$DATE(Z(2)),ENR=$$DATE(Z(3))
 ..I VFDFG=2 S X=Z(4)_U_DIS_U_ENR_U_@Z D SET(X)
 ..I VFDFG#2 S X=$E(Z(4)_SP,1,27)_$E(Z(6)_SP,1,14)_$E(DIS_SP,1,18)_$E(ENR_SP,1,18)_@Z D SET(X)
 ..Q
 .Q
 Q:VFDFG<3
 W ! F I=1:1 Q:'$D(VFDRET(I))  W !,VFDRET(I)
 W ! K VFDRET
 Q
 ;
DATE(T) ;
 N Y S Y=9999999-T I 'Y Q ""
 Q $TR($$FMTE^XLFDT($E(Y,1,12),"5Z"),"@"," ")
 ;
DIQ(FILE,IEN,FIELD) ;
 N I,J,K,X,Y,Z,DIERR,IENS,VFDER
 S IENS=IEN_"," I 'IEN Q ""
 S X=$$GET1^DIQ(FILE,IENS,FIELD,,,"VFDER") S:$D(DIERR) X=""
 Q X
 ;
SET(X) ;
 ;;No DFN received
 ;;Invalid DFN received
 ;;No enrollments found
 I X?1N,123[X,VFDFG=3 Q
 I X?1N,123[X S VFDRET(1)="-1^"_$P($T(SET+X),";",3) Q
 S CNT=CNT+1,VFDRET(CNT)=X
 Q
