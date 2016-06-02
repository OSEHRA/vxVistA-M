LEXLK2 ;ISL/KER - Look Up - Expression Attributes ;04/21/2014
 ;;2.0;LEXICON UTILITY;**6,19,80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.13)        N/A
 ;               
 ; External References
 ;    ^DIR                ICR  10026
 ;               
GET(Y) ; Build list in array LEX
 N LEXSPC,LEXSPCR,LEXSTR,LEXDIS,LEXMC,LEXMCE,LEXEXP
 S $E(LEXSPC,42)=" "
 K LEX
 ; PCH 6  add MD and CLC
 D MC,SY,LV,MD,DEF,STY,CLC,SRC
 K LEXC,LEXCODE,LEXCT,LEXDEF,LEXDIS,LEXEXP,LEXF
 K LEXFORM,LEXMC,LEXMCE,LEXNOM,LEXSCP,LEXSO,LEXSPC,LEXSPCR
 K LEXSR,LEXSRC,LEXSTR
 Q
MC ;    Major Concept
 N LEXMEX
 S LEXMC=+^LEX(757.01,+Y,1)
 S LEXMCE=+Y
 S LEXMEX=+^LEX(757,LEXMC,0)
 D BL,BL
 S LEXSTR="TERMS:" D TL,BL
 S LEXSTR="  Concept:  "_$E(^LEX(757.01,LEXMEX,0),1,66) D TL
 S LEXDIS=$$T(+Y) S LEXSTR="            "_LEXDIS D TL
 Q
SY ;    Synonyms
 N LEXEXP
 S LEXEXP=0
 F  S LEXEXP=$O(^LEX(757.01,"AMC",+LEXMC,LEXEXP)) Q:+LEXEXP=0  D
 .I $P(^LEX(757.01,LEXEXP,1),U,2)=2 D
 ..S LEXDIS=$$T(LEXEXP) D BL
 ..S LEXSTR="  Synonym:  "_$E(^LEX(757.01,LEXEXP,0),1,66) D TL
 ..S LEXSTR="            "_LEXDIS D TL
 Q
LV ;    Lexical Variants
 N LEXEXP
 S LEXEXP=0
 F  S LEXEXP=$O(^LEX(757.01,"AMC",+LEXMC,LEXEXP)) Q:+LEXEXP=0  D
 .I $P(^LEX(757.01,LEXEXP,1),U,2)=3 D
 ..S LEXDIS=$$T(LEXEXP) D BL
 ..S LEXSTR="  Variant:  "_$E(^LEX(757.01,LEXEXP,0),1,66) D TL
 ..S LEXSTR="            "_LEXDIS D TL
 Q
MD ;    Modifiers/Descendants    PCH 6  added
 Q:'$D(^LEX(757.01,"APAR",LEXMCE))
 D BL
 N LEXCHD,LEXORD,LEXSTR,LEXNO,LEXE,LEXCT,LEXTY,LEXL
 S (LEXCHD,LEXCT)=0
 S LEXSTR="  Modified/Descendant Terms" D TL,BL
 F  S LEXCHD=$O(^LEX(757.01,"APAR",LEXMCE,LEXCHD)) Q:+LEXCHD=0  D
 .S LEXE=$P($G(^LEX(757.01,LEXCHD,0)),"^") Q:'$L(LEXE)
 .S LEXTY=+$P($G(^LEX(757.01,LEXCHD,1)),"^",2) Q:LEXTY=0
 .S LEXCT=LEXCT+1
 .S LEXORD=+$P($G(^LEX(757.01,LEXCHD,1)),"^",10)
 .S LEXNO=$S(LEXORD>0:LEXORD,1:(9999+LEXCT))
 .S LEXL(LEXTY,LEXNO)=LEXE
 S LEXTY=0 F  S LEXTY=$O(LEXL(LEXTY)) Q:+LEXTY=0  D
 .S LEXNO=0 F  S LEXNO=$O(LEXL(LEXTY,LEXNO)) Q:+LEXNO=0  D
 ..S LEXSTR="            "_LEXL(LEXTY,LEXNO) D TL
 Q
DEF ;    Definition
 D BL
 I $D(^LEX(757.01,+Y,3)) D  D BL
 .S LEXSTR="DEFINITION:" D TL,BL
 .N LEXDEF S LEXDEF=0
 .F  S LEXDEF=$O(^LEX(757.01,+Y,3,LEXDEF)) Q:+LEXDEF=0  D
 ..S LEXSTR="  "_^LEX(757.01,+Y,3,LEXDEF,0) D TL
 Q
STY ;    Semantic Classes/Types
 S LEXSTR="SEMANTICS:" D TL,BL
 S LEXSTR="  CLASS                                 TYPE" D TL,BL
 N LEXC,LEXT,LEXCT,LEXTT S LEXC="",LEXT=0
 F  S LEXC=$O(^LEX(757.1,"AMCC",LEXMC,LEXC)) Q:LEXC=""  D
 .S LEXCT=$E($P(^LEX(757.11,+$O(^LEX(757.11,"B",LEXC,0)),0),U,2),1,38)
 .S LEXSTR="  "_LEXCT
 .S LEXT=0
 .F  S LEXT=$O(^LEX(757.1,"AMCC",LEXMC,LEXC,LEXT)) Q:+LEXT=0  D
 ..S LEXTT=$E($P(^LEX(757.12,+$P(^LEX(757.1,LEXT,0),U,3),0),U,2),1,38)
 ..S LEXSPCR=$E(LEXSPC,1,(40-$L(LEXSTR)))
 ..S LEXSTR=LEXSTR_LEXSPCR_LEXTT D TL S LEXSTR=""
 Q
CLC ;    Clinical Class   PCH 6  added
 N LEXCL,LEXGP,LEXSTR,LEXFM,LEXIND,LEXP,LEXMEM,LEXT,LEXTC
 S LEXCL=+$P($G(^LEX(757.01,+Y,1)),"^",11)
 S:LEXCL=0 LEXCL=+$P($G(^LEX(757.01,LEXMCE,1)),"^",11)
 Q:LEXCL=0  Q:'$D(^LEX(757.13,LEXCL,0))
 S LEXGP=$G(^LEX(757.13,LEXCL,5)) Q:'$L(LEXGP)
 D BL
 S LEXSTR="SOURCE CATEGORY:  "_LEXGP D TL,BL
 S LEXFM=$P($G(^LEX(757.13,LEXCL,3)),"^") Q:'$L(LEXFM)
 S LEXIND="  "
 F LEXP=1:1:$L(LEXFM,"~") D
 .S LEXMEM=+$P(LEXFM,"~",LEXP) Q:LEXMEM=0  Q:'$D(^LEX(757.13,LEXMEM,0))
 .S LEXT=$P($G(^LEX(757.13,LEXMEM,0)),"^") Q:LEXT=""
 .S LEXTC=$P($G(^LEX(757.13,LEXMEM,0)),"^",2)
 .S LEXIND=LEXIND_"  "
 .S LEXSTR=LEXIND_LEXT D TL
 Q
SRC ;    Classification Systems/Codes
 N LEXSR,LEXSO,LEXSPC
 K LEXSRC
 S LEXSO=0
 F  S LEXSO=$O(^LEX(757.02,"AMC",LEXMC,LEXSO)) Q:+LEXSO=0  D
 .Q:$P(^LEX(757.02,LEXSO,0),"^",6)=1
 .S LEXNOM=$P(^LEX(757.03,+$P(^LEX(757.02,LEXSO,0),U,3),0),U,2)
 .S LEXSR=$P(^LEX(757.03,+$P(^LEX(757.02,LEXSO,0),U,3),0),U,3)
 .S $E(LEXSPC,16)=" "
 .S LEXSPC=$E(LEXSPC,1,$L(LEXSPC)-$L(LEXNOM))
 .S LEXSR=LEXNOM_LEXSPC_LEXSR
 .S LEXCODE=$P(^LEX(757.02,LEXSO,0),U,2)
 .S LEXSRC(LEXSR,LEXCODE)=""
 I $D(LEXSRC) D  K LEXSRC
 .D BL S LEXSTR="CLASSIFICATION SYSTEMS/CODES:" D TL,BL
 .S LEXSR=""
 .F  S LEXSR=$O(LEXSRC(LEXSR)) Q:LEXSR=""  D
 ..D BL S LEXSTR="  "_LEXSR D TL
 ..S (LEXSTR,LEXCODE)=""
 ..F  S LEXCODE=$O(LEXSRC(LEXSR,LEXCODE)) Q:LEXCODE=""  D
 ...S LEXSTR=LEXSTR_"/"_LEXCODE
 ..S:$E(LEXSTR)="/" LEXSTR=$E(LEXSTR,2,$L(LEXSTR))
 ..S LEXSTR="                  "_LEXSTR
 ..D:$L(LEXSTR)>18 TL
 Q
T(X) ; Get Term Type
 N LEXSCP,LEXF
 S LEXF="",LEXFORM="",LEXEXP=+X,X=""
 S LEXSCP=$P(^LEX(757.01,LEXEXP,1),U,3)
 S LEXSCP=$S(LEXSCP="D":"Directly Linked to Concept",LEXSCP="I":"Indirectly Linked (via Synonym)",LEXSCP="B":"Broader View of Concept",LEXSCP="N":"Narrower View of Concept",LEXSCP="O":"Other View of Concept",1:"")
 S LEXF=$P(^LEX(757.01,LEXEXP,1),U,4) S:+LEXF=0 LEXF=""
 S:+LEXF>0 LEXF=$P($G(^LEX(757.014,+LEXF,0)),U,2)
 S X=LEXSCP_"/"_LEXF S:$P(X,"/",2)="" X=$P(X,"/",1)
 S:$E(X)="/" X=$E(X,2,$L(X))
 K LEXSCP,LEXF
 Q X
TL ; Create a Text Line
 Q:'$L($G(LEXSTR))
 N LEXC
 S LEXC=+$G(LEX(0)),LEXC=LEXC+1
 S LEX(LEXC)=LEXSTR
 S LEX(0)=LEXC
 Q
BL ; Create a Blank Line
 N LEXC
 S LEXC=+$G(LEX(0)),LEXC=LEXC+1
 S LEX(LEXC)="",LEX(0)=LEXC
 Q
LIST ; List the contents of the LEX array
 Q:'$G(LEX(0))  N LEXLC,LEXLN,LEXCONT,LEXCL,LEXE,LEXB
 S (LEXLN,LEXLC)=0,LEXCONT=""
 F  Q:LEXLN=LEX(0)!(LEXCONT["^")  D  Q:LEXLN=LEX(0)!(LEXCONT["^")
 .S LEXB=LEXLN+1,LEXE=LEXB+(IOSL-3)
 .F LEXCL=LEXB:1:LEXE D
 ..I $D(LEX(LEXCL)) W !,LEX(LEXCL) S LEXLN=LEXCL,LEXLC=LEXLC+1
 .I LEXLN'=LEX(0) D CONT Q
 W !
 S LEXLC=LEXLC+1
 I LEXLC=(IOSL-3) D CONT
 K LEXLC,LEXLN,LEXCONT,LEXCL,LEXE,LEXB
 Q
CONT ; Continue listing - Press <Return> to Continue
 W ! N X,Y S DIR(0)="E" D ^DIR S LEXLC=0,LEXCONT=X
 K DIR,DTOUT,DUOUT,DIRUT,DIROUT W !
 Q
