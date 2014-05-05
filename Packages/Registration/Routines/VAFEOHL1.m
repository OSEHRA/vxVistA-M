VAFEOHL1 ;ALB/JLU/CAW;generates the HL7 message to be sent(con't);6/29/93
 ;;5.3;Registration;**38**;Aug 13, 1993
 ;
MSH ;builds the MSH segment
 N X
 S VAFEDLCT=VAFEDLCT+1
 S X=HLMTN_$E(HLECH)_"R01"
 S VAFEDHL=$$MSH^HLFNC1(X)
 S $P(VAFEDHL,U,10)=$P(VAFEDHL,U,10)_"-"_HLEVN
 D LOG^VAFEDOHL
 Q
 ;
PID ;Builds the PID segment fields 2,3,5,7,8,11,19
 N VAFEDHL
 S VAFEDLCT=VAFEDLCT+1
 S $P(VAFEDHL,HLFS,1)="PID"
 S $P(VAFEDHL,HLFS,3)=$$M11^HLFNC($TR($G(VA("PID")),"-",""))
 S $P(VAFEDHL,HLFS,4)=$$M11^HLFNC(DFN)
 S $P(VAFEDHL,HLFS,6)=$$HLNAME^HLFNC(VADM(1))
 S $P(VAFEDHL,HLFS,8)=$$HLDATE^HLFNC(+VADM(3))
 S $P(VAFEDHL,HLFS,9)=$P(VADM(5),U)
 S $P(VAFEDHL,HLFS,12)=$$ADDR^VAFHLFNC(VAPA(1)_U_VAPA(2)_U_VAPA(3)_U_VAPA(4)_U_+VAPA(5)_U_$P(VAPA(11),U,2),+VAPA(7))
 S $P(VAFEDHL,HLFS,20)=$E($P(VADM(2),U,1),1,9)
 D LOG^VAFEDOHL
 Q
 ;
ZEL ;sets up the ZEL segment, fields 1,2 with elig of outpatient encounter
 N VAFEDHL
 S VAFEDLCT=VAFEDLCT+1
 I VAFELIG D  G LOG
 .S $P(VAFEDHL,HLFS,1)="ZEL",$P(VAFEDHL,HLFS,13)=""
 .S $P(VAFEDHL,HLFS,2)=1 ; Sequential number 
 .S $P(VAFEDHL,HLFS,3)=VAFELIG ; Eligibility code
 S VAFEDHL=$$EN^VAFHLZEL(DFN,"1,2",1)
LOG D LOG^VAFEDOHL
QUIT Q
 ;
PV1 ;sets up the PV1 segment and the fields 2,3,7,10,19,39
 N VAFEDHL,PROV
 S VAFEDLCT=VAFEDLCT+1
 S $P(VAFEDHL,HLFS,1)="PV1"
 S $P(VAFEDHL,HLFS,3)="O"
 S $P(VAFEDHL,HLFS,4)=HLQ
 S PROV=$P(VAFEDST1,U,4)
 I PROV]"" DO
 .S PROV=$P(^VA(200,+PROV,0),U,1)
 .S $P(VAFEDHL,HLFS,8)=$P(VAFEDST1,U,4)_$E(HLECH)_$$HLNAME^HLFNC(PROV)
 S $P(VAFEDHL,HLFS,11)=$S(VAFEDT=98:$P(VAFEDST1,U,3),1:HLQ)
 S $P(VAFEDHL,HLFS,20)=VAFEDD
 S $P(VAFEDHL,HLFS,40)=$P(VAFEDST1,U,2)
 D LOG^VAFEDOHL
 Q