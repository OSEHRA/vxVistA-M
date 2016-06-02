ONCOTM ;HINES IRMFO/WAA-ONCO TUMOR MARKER PROMPT  1/7/98  10:33
 ;;2.2;ONCOLOGY;**1**;Jul 31, 2013;Build 8
 ;
TM(IEN,TUM) ;
 ; This routine will set the prompt base on the primary site
 ; X is the internal entry number of the entry in file 165.5
 ; TUM is which tumor marker this is.
 N %,D,DC,DIC,DIE,DIEL,DIFLD,DIP,DK,DM,DOV,DQ,DU,DV,DW,DXS
 N DH,DIR,DA,D0,D1,DIE,DR,DP,DO,DL,I,ICDO,X,TM1,TM2,TM,U
 K Y
 S DIE="^ONCO(165.5,",DA=IEN
 I TUM=1 S DR="25.1"_$$PROMPT(IEN,TUM)
 I TUM=2 S DR="25.2"_$$PROMPT(IEN,TUM)
 I TUM=3 S DR="25.3"_$$PROMPT(IEN,TUM)
 D ^DIE
 I $D(Y) S Y="@0" Q
 I TUM=1 S Y="@2510"
 I TUM=2 S Y="@2520"
 I TUM=3 S Y="@2530"
 Q
PRINT(IEN,TUM) ;
 ; This routine will set the prompt base on the primary site
 ; IEN is the internal entry number of the entry in file 165.5
 ; TUM is which tumor marker this is.
 N PROMPT,LOWER,CAP,I,WORD
 S PROMPT=$$PROMPT(IEN,TUM)
 S LOWER=$$LOW^XLFSTR(PROMPT)
 F I=1:1 S WORD=$P(LOWER," ",I) Q:WORD=""  D
 .I $E(WORD,1)="(" S $P(LOWER," ",I)=$P(PROMPT," ",I) Q
 .N NEW,OLD,NWORD
 .S OLD=$E(WORD,1)
 .S NEW=$$UP^XLFSTR(OLD)
 .S NWORD=NEW_$E(WORD,2,99999)
 .S $P(LOWER," ",I)=NWORD
 .Q
 S PROMPT=LOWER
 Q PROMPT
PROMPT(IEN,TUM) ; 
 ; This routine will set the prompt base on the primary site
 ; IEN is the internal entry number of the entry in file 165.5
 ; TUM is which tumor marker this is.
 N PROMPT
 S PROMPT=$S(TUM=1:"TUMOR MARKER 1",TUM=2:"TUMOR MARKER 2",TUM=3:"TUMOR MARKER 3",1:"TUMOR MARKER")
 I TUM=1 D TUMOR(TUM,"17-63")
 I TUM=2 D TUMOR(TUM,"49-63")
 I TUM=3 D TUMOR(TUM,"61-63")
 Q PROMPT
 ;
TUMOR(TUM,RANGE) ; Execute if valid tumor marker
 N PRIM1
 S PRIM1=$$GET1^DIQ(165.5,IEN,20,"I")
 I PRIM1'="" D
 .N PRIM2
 .S PRIM2=$$GET1^DIQ(164,PRIM1,1,"I")
 .I PRIM2'="" D
 ..N PRIM3,LINE,LOOP,NUMBER,FLG,X
 ..S PRIM3=$P(PRIM2,"C",2)
 ..I PRIM3'>$P(RANGE,"-")!(PRIM3'<$P(RANGE,"-",2)) Q
 ..S FLG=0
 ..S X="S LINE=$T(TABLE"_TUM_"+LOOP)"
 ..F LOOP=1:1 X X Q:$P(LINE,";",3)=""  D  Q:FLG
 ...S LINE=$P(LINE,";",3),NUMBER=$P(LINE,U)
 ...I NUMBER["-" D  Q 
 ....N NUM1,NUM2
 ....S NUM1=$P(NUMBER,"-"),NUM2=$P(NUMBER,"-",2)
 ....I PRIM3<NUM1 Q
 ....I PRIM3>NUM2 Q
 ....S FLG=1,PROMPT=$P(LINE,U,2)
 ....Q
 ...I PRIM3=NUMBER S FLG=1,PROMPT=$P(LINE,U,2)
 ...Q
 ..Q
 .Q
 I TUM=1,PROMPT="TUMOR MARKER 1",$$HIST^ONCFUNC(IEN)=95003 S PROMPT="TUMOR MARKER 1 (UC)"
 Q
 ;
TABLE1 ;;NUMBER/NUMBER-RANGE^NEW PROMPT
 ;;18.0-18.9^TUMOR MARKER 1 (CEA)
 ;;19.9^TUMOR MARKER 1 (CEA)
 ;;20.9^TUMOR MARKER 1 (CEA)
 ;;22.0^TUMOR MARKER 1 (AFP)
 ;;22.1^TUMOR MARKER 1 (AFP)
 ;;50.0-50.9^TUMOR MARKER 1 (ERA)
 ;;56.9^TUMOR MARKER 1 (CA-125)
 ;;61.9^TUMOR MARKER 1 (PAP)
 ;;62.0^TUMOR MARKER 1 (AFP)
 ;;62.1^TUMOR MARKER 1 (AFP)
 ;;62.9^TUMOR MARKER 1 (AFP)
 ;;
TABLE2 ;;NUMBER/NUMBER-RANGE^NEW PROMPT
 ;;50.0-50.9^TUMOR MARKER 2 (PRA)
 ;;61.9^TUMOR MARKER 2 (PSA)
 ;;62.0^TUMOR MARKER 2 (hCG)
 ;;62.1^TUMOR MARKER 2 (hCG)
 ;;62.9^TUMOR MARKER 2 (hCG)
 ;;
TABLE3 ;;NUMBER/NUMBER-RANGE^NEW PROMPT
 ;;62.0^TUMOR MARKER 3 (LDH)
 ;;62.1^TUMOR MARKER 3 (LDH)
 ;;62.9^TUMOR MARKER 3 (LDH)
 ;;
SCREEN ;;Tumor Marker screen
 I $$TNMED^ONCOU55(D0)<5,Y<7 Q
 I $$TNMED^ONCOU55(D0)>4,(($E($P($G(^ONCO(165.5,DA,2)),U,1),3,4)=62)&(Y<2!(Y>4)))!(($E($P($G(^ONCO(165.5,DA,2)),U,1),3,4)'=62)&(Y<7)) Q
