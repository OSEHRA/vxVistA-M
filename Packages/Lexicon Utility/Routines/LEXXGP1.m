LEXXGP1 ;ISL/KER - Global Post-Install (Repair Expressions) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ;               
 ; Global Variables
 ;    ^TMP("LEXASL")      SACC 2.3.2.5.1
 ;    ^TMP("LEXASLU")     SACC 2.3.2.5.1
 ;    ^TMP("LEXAWRD")     SACC 2.3.2.5.1
 ;    ^TMP("LEXSUB")      SACC 2.3.2.5.1
 ;    ^TMP("LEXTKN")      SACC 2.3.2.5.1
 ;    ^TMP("LEXXGPDAT")   SACC 2.3.2.5.1
 ;    ^TMP("LEXXGPMSG")   SACC 2.3.2.5.1
 ;    ^TMP("LEXXGPRPT")   SACC 2.3.2.5.1
 ;    ^TMP("LEXXGPTIM")   SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZTLOAD            ICR  10063
 ;    $$S^%ZTLOAD         ICR  10063
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;    MES^XPDUTL          ICR  10141
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ; 
 ;    LEXMAIL   Set and Killed by the developer, used to 
 ;              report the timing of the task and
 ;              send to the user by MailMan message
 ;     
 ;    LEXHOME   Set and Killed by the developer in the
 ;              post-install, used to send the timing
 ;              message to G.LEXINS@FO.DOMAIN.EXT
 ;              (see entry point POST2)
 ;              
 ;                     FileMan           LEXXGP
 ;                 
 ;                        Lexicon           Lexicon
 ; Re-Index        Time  Available   Time  Available
 ; --------------  ----  ---------   ----  ---------
 ; Build 'AWRD'    33.5     No       8.5      Yes
 ; Replace 'AWRD'   --      --       2.5      No
 ; Build 'ASL'      8.5     No       6.5      Yes
 ; Replace 'ASL'    --      --       0.5      No
 ; Build 'ASUB'    15.5     No      11.5      Yes
 ; Replace 'ASUB'   --      --       1.5      No
 ; 
 ; Lexicon 
 ; Unavailable:    57.5              4.5 Minutes
 ; 
 Q
EN ; Interactive Entry Point
 D ALL
 Q
POST ; Entry Point from Post-Install
 N LEXMAIL,LEXHOME S LEXMAIL="" D POST3
 Q
POST2 ; Entry Point from Post-Install (home)
 N LEXMAIL,LEXHOME S LEXHOME="",LEXMAIL="" D POST3
 Q
POST3 ; Called by POST/POST2 starts task
 N Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ,LEXTN
 S ZTRTN="ALL^LEXXGP1"
 S (LEXTN,ZTDESC)="Repair indexes in files #757.01/757.21"
 I $D(LEXMAIL) S LEXMAIL=1,ZTSAVE("LEXMAIL")=""
 I $D(LEXHOME) S LEXHOME=1,ZTSAVE("LEXHOME")=""
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS I $D(LEXLOUD) D
 . S LEXT="  "_$G(LEXTN)_" tasked"
 . S:+($G(ZTSK))>0 LEXT=LEXT_" (#"_+($G(ZTSK))_")"
 . D MES^XPDUTL(LEXT)
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
ALL ;
 K ^TMP("LEXAWRD",$J),^TMP("LEXASL",$J),^TMP("LEXASLU",$J)
 K ^TMP("LEXSUB",$J),^TMP("LEXXGPTIM",$J) N DIC,DTOUT,DUOUT,LEX,LEX1
 N LEX2,LEX3,LEX4,LEXB,LEXBD,LEXBEG,LEXBEGD,LEXBEGT,LEXBT,LEXC,LEXCHR
 N LEXCHRS,LEXCMD,LEXCOM,LEXCTL,LEXD,LEXDF,LEXE,LEXEL,LEXELP,LEXELPT
 N LEXEND,LEXENDD,LEXENDT,LEXET,LEXEX,LEXEXP,LEXF,LEXFC,LEXFIR,LEXFUL
 N LEXHDR,LEXI,LEXID,LEXIDS,LEXIDX,LEXINAM,LEXIT,LEXJ,LEXLAST,LEXLN
 N LEXLOOK,LEXLOUD,LEXLWRD,LEXM,LEXMC,LEXMCEI,LEXMCI,LEXN,LEXNAM
 N LEXNEW,LEXNM,LEXNOD,LEXO,LEXO1,LEXO2,LEXP,LEXPDT,LEXPRE,LEXRI,LEXRT
 N LEXRT1,LEXRT2,LEXS,LEXSI,LEXSUB,LEXT,LEXTDAT,LEXTEST,LEXTEXP,LEXTK
 N LEXTKC,LEXTKN,LEXTMP,LEXTWRD,LEXTX,LEXTXT,LEXV,LEXX,X,XCNP,XMDUZ
 N XMSCR,XMSUB,XMTEXT,XMY,XMZ,Y S:'$D(LEXQUIT) LEXQUIT="ALL"
 N LEXTXT,LEXFUL S LEXFUL="" D EXP,SUB^LEXXGP2
 I '$D(ZTQUEUED) D
 . N LEXTXT S LEXTXT=$$FMTT Q:'$L(LEXTXT)  W !," ",LEXTXT
 I $G(LEXQUIT)="ALL" D
 . D:$D(LEXMAIL) XM^LEXXGP2
 . K ^TMP("LEXASL"),^TMP("LEXASLU"),^TMP("LEXAWRD")
 . K ^TMP("LEXSUB"),^TMP("LEXTKN"),^TMP("LEXXGPDAT")
 . K ^TMP("LEXXGPTIM"),^TMP("LEXXGPRPT")
 . K:'$D(LEXMAIL) ^TMP("LEXXGPMSG")
 . K LEXQUIT,ZTQUEUED,LEXMAIL,LEXHOME
 Q
 ;
EXP ; Expression file Main Indexes AWRD/ASL
 N LEXBEG,LEXBEGD,LEXBEGT,LEXDF,LEXELP,LEXEND,LEXENDD,LEXENDT
 N LEXTMP,LEXTXT S LEXTXT="Expression Indexes"
 S:'$D(LEXQUIT) LEXQUIT="EXP" K ^TMP("LEXAWRD",$J)
 K ^TMP("LEXASL",$J),^TMP("LEXASLU",$J) S LEXBEG=$$BEG
 D AWRDB,ASLB H 1 S LEXEND=$$END D SAV^LEXXGP2(LEXBEG,LEXEND,LEXTXT)
 S LEXELP=$$ELP(LEXBEG,LEXEND),LEXBEGD=$$ED(LEXBEG)
 S LEXBEGT=$$ET(LEXBEG),LEXENDT=$$ET(LEXEND),LEXDF=$$DF(LEXBEG)
 S LEXTXT=$G(LEXTXT)_$J(" ",(35-$L($G(LEXTXT))))
 S LEXTXT=LEXTXT_LEXDF_"   "_LEXBEGT_"   "_LEXENDT_"   "_LEXELP
 S LEXTXT=" "_LEXTXT W:'$D(ZTQUEUED) !,LEXTXT
 N ZTQUEUED,LEXTEST
 I $G(LEXQUIT)="EXP" D
 . D:$D(LEXMAIL) XM^LEXXGP2
 . K ^TMP("LEXASL"),^TMP("LEXASLU"),^TMP("LEXAWRD"),^TMP("LEXTKN")
 . K ^TMP("LEXXGPDAT"),^TMP("LEXXGPTIM"),^TMP("LEXXGPRPT")
 . K:'$D(LEXMAIL) ^TMP("LEXXGPMSG")
 . K LEXQUIT,ZTQUEUED,LEXMAIL,LEXHOME
 Q
AWRDB ;   AWRD Word Index Build                         8.5 minutes
 ;     Create the AWRD Index in the ^TMP global
 N LEXBEG,LEXBEGD,LEXBEGT,LEXCHK,LEXDF,LEXELP,LEXEND,LEXENDD,LEXENDT
 N LEXEX,LEXEXP,LEXIDX,LEXMC,LEXMCEI,LEXMCI,LEXRI,LEXSI,LEXTKC
 N LEXTKN,LEXTXT,X K ^TMP("LEXAWRD",$J) S:'$D(LEXQUIT) LEXQUIT="AWRDB"
 S LEXBEG=$$BEG,LEXEX=0,LEXTXT="Build 'AWRD' Word Index"
 I +($G(ZTSK))>0 S LEXCHK=$$S^%ZTLOAD((LEXTXT_" in file 757.01"))
 F  S LEXEX=$O(^LEX(757.01,LEXEX)) Q:+LEXEX'>0  D
 . N X,LEXEXP,LEXIDX,LEXMCI,LEXMCEI,LEXSI,LEXTKN,LEXTKC
 . S LEXEXP=$$UP^XLFSTR($G(^LEX(757.01,LEXEX,0))) Q:'$L(LEXEXP)
 . S LEXMCI=$P($G(^LEX(757.01,LEXEX,1)),"^",1) Q:+LEXMCI'>0
 . S LEXMCEI=$P($G(^LEX(757,LEXMCI,0)),"^",1) Q:+LEXMCEI'>0
 . ;       Words (main)
 . K ^TMP("LEXTKN",$J) S LEXIDX="",X=LEXEXP D PTX^LEXTOKN
 . I $D(^TMP("LEXTKN",$J,0)),^TMP("LEXTKN",$J,0)>0 D
 . . S LEXTKN="",LEXTKC=0
 . . F  S LEXTKC=$O(^TMP("LEXTKN",$J,LEXTKC)) Q:+LEXTKC'>0  D
 . . . S LEXTKN=$O(^TMP("LEXTKN",$J,LEXTKC,"")) Q:'$L(LEXTKN)
 . . . I '$D(^TMP("LEXAWRD",$J,LEXTKN,LEXMCEI)) D
 . . . . I '$D(^LEX(757.01,LEXEX,4,"B",LEXTKN)) D
 . . . . . S ^TMP("LEXAWRD",$J,LEXTKN,LEXMCEI,LEXEX)=""
 . K ^TMP("LEXTKN",$J)
 . ;       Supplemental Words
 . S LEXSI=0 F  S LEXSI=$O(^LEX(757.01,LEXEX,5,LEXSI)) Q:+LEXSI'>0  D
 . . N LEXTKN S LEXTKN=$G(^LEX(757.01,LEXEX,5,LEXSI,0)) Q:'$L(LEXTKN)
 . . S ^TMP("LEXAWRD",$J,$$UP^XLFSTR(LEXTKN),+LEXEX,+LEXMCEI,LEXSI)=""
 . ;       Linked Words
 . I $D(^LEX(757.05,"AEXP",LEXEX)) D
 . . N LEXRI S LEXRI=0
 . . F  S LEXRI=$O(^LEX(757.05,"AEXP",LEXEX,LEXRI)) Q:+LEXRI=0  D
 . . . N LEXTKN,LEXMC S LEXTKN=$P(^LEX(757.05,LEXRI,0),U,1) Q:LEXTKN=""
 . . . S LEXMC=$P($G(^LEX(757.01,LEXEX,1)),U,1) Q:+LEXMC'>0
 . . . S ^TMP("LEXAWRD",$J,LEXTKN,LEXEX,"LINKED")=""
 K ^TMP("LEXTKN",$J) H 1 S LEXEND=$$END D SAV^LEXXGP2(LEXBEG,LEXEND,LEXTXT)
 S LEXELP=$$ELP(LEXBEG,LEXEND),LEXBEGD=$$ED(LEXBEG)
 S LEXBEGT=$$ET(LEXBEG),LEXENDT=$$ET(LEXEND),LEXDF=$$DF(LEXBEG)
 S LEXTXT=$G(LEXTXT)_$J(" ",(35-$L($G(LEXTXT))))
 S LEXTXT=LEXTXT_LEXDF_"   "_LEXBEGT_"   "_LEXENDT_"   "_LEXELP
 S LEXTXT=" "_LEXTXT W:'$D(ZTQUEUED) !,LEXTXT
 D AWRDR N ZTQUEUED,LEXTEST
 I $G(LEXQUIT)="AWRDB" D
 . D:$D(LEXMAIL) XM^LEXXGP2
 . K ^TMP("LEXAWRD"),^TMP("LEXTKN"),^TMP("LEXXGPDAT")
 . K ^TMP("LEXXGPTIM"),^TMP("LEXXGPRPT")
 . K LEXQUIT,ZTQUEUED,LEXMAIL,LEXHOME
 Q
AWRDR ;   AWRD Word Index Replace                       2.5 minutes
 N LEX1,LEX2,LEX3,LEXBEG,LEXBEGD,LEXBEGT,LEXCHK,LEXCHR,LEXCHRS,LEXCMD
 N LEXCOM,LEXCTL,LEXDF,LEXELP,LEXEND,LEXENDD,LEXENDT,LEXLAST,LEXIT
 N LEXLWRD,LEXNOD,LEXRT,LEXRT1,LEXRT2,LEXTDAT,LEXTK,LEXTMP
 N LEXTWRD,LEXTXT S (LEX1,LEX2,LEX3)=0 Q:'$D(LEXQUIT)
 S LEXBEG=$$BEG,LEXTXT="Replace 'AWRD' Word Index"
 I +($G(ZTSK))>0 S LEXCHK=$$S^%ZTLOAD((LEXTXT_" in file 757.01"))
 K LEXCHRS S LEXRT1="^LEX(757.01,""AWRD"","
 S LEXRT2="^TMP(""LEXAWRD"","_$J_"," F LEXRT=LEXRT1,LEXRT2 D
 . S LEXTK="" F  S LEXTK=$O(@(LEXRT_""""_LEXTK_""")")) Q:'$L(LEXTK)  D
 . . S LEXCHR=$E($TR(LEXTK," ",""),1)
 . . S LEXTK=$E(LEXTK,1)_"~" S:$L(LEXCHR) LEXCHRS(LEXCHR)=""
 S LEXCHR="" F  S LEXCHR=$O(LEXCHRS(LEXCHR)) Q:'$L(LEXCHR)  D
 . ;     For words beginning with a character
 . W:'$D(ZTQUEUED)&($D(LEXTEST)) LEXCHR
 . S (LEXLWRD,LEXTWRD)=$C($A(LEXCHR)-1)_"~",LEXIT=0
 . F  S LEXLWRD=$O(^LEX(757.01,"AWRD",LEXLWRD)) D  Q:LEXIT>0
 . . S:'$L(LEXLWRD) LEXIT=1 S:$E(LEXLWRD,1)'=LEXCHR LEXIT=1
 . . Q:LEXIT>0  N LEXCMD
 . . ;       Delete words from the ^LEX global
 . . I $D(LEXFUL) D
 . . . N LEXNOD,LEXCTL,LEXIT S LEXIT=0
 . . . S LEXNOD="^LEX(757.01,""AWRD"","""_LEXLWRD_""")"
 . . . S LEXCTL="^LEX(757.01,""AWRD"","""_LEXLWRD_""","
 . . . F  S LEXNOD=$Q(@LEXNOD) D  Q:LEXIT>0
 . . . . S:'$L(LEXNOD) LEXIT=1 S:LEXNOD'[LEXCTL LEXIT=1
 . . . . Q:LEXIT>0  S LEX2=LEX2+1
 . . S LEXCMD="K ^LEX(757.01,""AWRD"","""_LEXLWRD_""")"
 . . X LEXCMD S LEX1=LEX1+1
 . S LEXIT=0 F  S LEXTWRD=$O(^TMP("LEXAWRD",$J,LEXTWRD)) D  Q:LEXIT>0
 . . S:'$L(LEXTWRD) LEXIT=1 S:$E(LEXTWRD,1)'=LEXCHR LEXIT=1
 . . Q:LEXIT>0  N LEXNOD,LEXCTL
 . . S LEXNOD="^TMP(""LEXAWRD"","_$J_","""_LEXTWRD_""")"
 . . S LEXCTL="^TMP(""LEXAWRD"","_$J_","""_LEXTWRD_""","
 . . F  S LEXNOD=$Q(@LEXNOD) Q:'$L(LEXNOD)!(LEXNOD'[LEXCTL)  D
 . . . ;       Copy Index from ^TMP to ^LEX
 . . . N LEXCMD
 . . . S LEXCMD="S ^LEX(757.01,""AWRD"""_$P(LEXNOD,$J,2,229)_"="""""
 . . . X LEXCMD S LEX3=LEX3+1
 . ;     Repeat for all characters
 H 1 S LEXEND=$$END D SAV^LEXXGP2(LEXBEG,LEXEND,LEXTXT)
 S LEXELP=$$ELP(LEXBEG,LEXEND),LEXBEGD=$$ED(LEXBEG)
 S LEXBEGT=$$ET(LEXBEG),LEXENDT=$$ET(LEXEND),LEXDF=$$DF(LEXBEG)
 S LEXTXT=$G(LEXTXT)_$J(" ",(35-$L($G(LEXTXT))))
 S LEXTXT=LEXTXT_LEXDF_"   "_LEXBEGT_"   "_LEXENDT_"   "_LEXELP
 S LEXTXT=" "_LEXTXT W:'$D(ZTQUEUED) !,LEXTXT
 I LEX1>0,$D(LEXFUL) D
 . S LEXCOM=LEX1_" Word"_$S(LEX1>1:"s",1:"")
 . D SAV^LEXXGP2(LEXBEG,"","",LEXCOM)
 . W:'$D(ZTQUEUED) !,"   ",LEXCOM
 I LEX3>0,$D(LEXFUL) D
 . S LEXCOM=LEX3_" 'AWRD' Index Node"_$S(LEX3>1:"s",1:"")
 . D SAV^LEXXGP2(LEXBEG,"","",LEXCOM)
 . W:'$D(ZTQUEUED) !,"   ",LEXCOM
 N ZTQUEUED,LEXTEST
 Q
 ; 
ASLB ;   ASL String Length Index Build                 6.5 minutes
 N LEXBEG,LEXBEGD,LEXBEGT,LEXCHK,LEXDF,LEXE,LEXELP,LEXEND,LEXENDD,LEXENDT
 N LEXF,LEXFC,LEXFIR,LEXM,LEXO,LEXP,LEXRT,LEXRT2,LEXS,LEXT,LEXTK,LEXIT
 N LEXTKN,LEXTMP,LEXTXT S LEXBEG=$$BEG S:'$D(LEXQUIT) LEXQUIT="ASLB"
 S LEXTXT="Build 'ASL' String Length Index"
 I +($G(ZTSK))>0 S LEXCHK=$$S^%ZTLOAD((LEXTXT_" in file 757.01"))
 S LEXRT="" S:$D(^LEX(757.01,"AWRD")) LEXRT="^LEX(757.01,""AWRD"","
 S:$D(^TMP("LEXAWRD",$J)) LEXRT="^TMP(""LEXAWRD"","_$J_"," Q:'$L(LEXRT)
 ;     For each Word
 K ^TMP("LEXASL",$J),^TMP("LEXASLU",$J) S (LEXFIR,LEXFC,LEXTK)=""
 F  S LEXTK=$O(@(LEXRT_""""_LEXTK_""")")) Q:'$L(LEXTK)  D
 . N LEXP,LEXS,LEXC,LEXF,LEXTKN S LEXTKN=LEXTK
 . F  Q:$E(LEXTKN,1)'=" "  S LEXTKN=$E(LEXTKN,2,$L(LEXTKN))
 . F  Q:$E(LEXTKN,$L(LEXTKN))'=" "  S LEXTKN=$E(LEXTKN,1,($L(LEXTKN)-1))
 . S LEXF=$E(LEXTKN,1)
 . W:'$D(ZTQUEUED)&($D(LEXTEST))&(LEXFIR'=LEXF)&(LEXFC'[LEXF) LEXF
 . S LEXFIR=LEXF S:LEXFC'[LEXF LEXFC=LEXFC_LEXF
 . ;     Count the occurrences of each string
 . F LEXP=1:1:$L(LEXTKN)  S LEXS=$$UP^XLFSTR($E(LEXTKN,1,LEXP)) D
 . . Q:'$L($G(LEXS))  I '$D(^TMP("LEXASLU",$J,LEXS)) D
 . . . N LEXE,LEXM,LEXO,LEXT S LEXT=0
 . . . I $L(LEXS)>1 D
 . . . . S LEXO=$E(LEXS,1,($L(LEXS)-1))
 . . . . S LEXO=LEXO_$C(($A($E(LEXS,$L(LEXS)))-1))_"~"
 . . . S:$L(LEXS)=1 LEXO=$C(($A(LEXS)-1))_"~" S LEXIT=0
 . . . F  S LEXO=$O(@(LEXRT_""""_LEXO_""")")) D  Q:LEXIT>0
 . . . . S:'$L(LEXO) LEXIT=1 S:$E(LEXO,1,$L(LEXS))'=LEXS LEXIT=1
 . . . . Q:LEXIT>0  N LEXM S LEXM=0
 . . . . F  S LEXM=$O(@(LEXRT_""""_LEXO_""","_LEXM_")")) Q:+LEXM'>0  D
 . . . . . N LEXE,LEXRT2 S LEXE=0,LEXRT2=LEXRT_""""_LEXO_""","_LEXM_","
 . . . . . F  S LEXE=$O(@(LEXRT2_LEXE_")")) Q:+LEXE'>0  S LEXT=LEXT+1
 . . . K:$L($G(LEXS)) ^TMP("LEXASL",$J,LEXS)
 . . . S:$L($G(LEXS))&(+($G(LEXT))>0) ^TMP("LEXASL",$J,LEXS,LEXT)=""
 . . S ^TMP("LEXASLU",$J,LEXS)=""
 H 1 S LEXEND=$$END D SAV^LEXXGP2(LEXBEG,LEXEND,LEXTXT)
 S LEXELP=$$ELP(LEXBEG,LEXEND),LEXBEGD=$$ED(LEXBEG)
 S LEXBEGT=$$ET(LEXBEG),LEXENDT=$$ET(LEXEND),LEXDF=$$DF(LEXBEG)
 S LEXTXT=$G(LEXTXT)_$J(" ",(35-$L($G(LEXTXT))))
 S LEXTXT=LEXTXT_LEXDF_"   "_LEXBEGT_"   "_LEXENDT_"   "_LEXELP
 S LEXTXT=" "_LEXTXT W:'$D(ZTQUEUED) !,LEXTXT
 D ASLR N ZTQUEUED,LEXTEST
 I $G(LEXQUIT)="ASLB" D
 . D:$D(LEXMAIL) XM^LEXXGP2
 . K ^TMP("LEXASL"),^TMP("LEXASLU"),^TMP("LEXAWRD"),^TMP("LEXTKN")
 . K ^TMP("LEXXGPDAT"),^TMP("LEXXGPTIM"),^TMP("LEXXGPRPT")
 . K LEXQUIT,ZTQUEUED,LEXMAIL,LEXHOME
 Q
ASLR ;   ASL String Length Index Replace               0.5 minutes
 N LEX1,LEX2,LEX3,LEXBEG,LEXBEGD,LEXBEGT,LEXCHK,LEXCHR,LEXCHRS,LEXCMD
 N LEXCOM,LEXCTL,LEXDF,LEXELP,LEXEND,LEXENDD,LEXENDT,LEXLWRD
 N LEXNOD,LEXRT,LEXRT1,LEXRT2,LEXTK,LEXTMP,LEXTWRD,LEXTXT
 S (LEX1,LEX2,LEX3)=0 Q:'$D(LEXQUIT)
 S LEXBEG=$$BEG,LEXTXT="Replace 'ASL' String Length Index"
 I +($G(ZTSK))>0 S LEXCHK=$$S^%ZTLOAD((LEXTXT_" in file 757.01"))
 K LEXCHRS S LEXRT1="^LEX(757.01,""AWRD"","
 S LEXRT2="^TMP(""LEXAWRD"","_$J_"," F LEXRT=LEXRT1,LEXRT2 D
 . N LEXTK S LEXTK=""
 . F  S LEXTK=$O(@(LEXRT_""""_LEXTK_""")")) Q:'$L(LEXTK)  D
 . . N LEXCHR S LEXCHR=$E($TR(LEXTK," ",""),1)
 . . S LEXTK=$E(LEXTK,1)_"~" S:$L(LEXCHR) LEXCHRS(LEXCHR)=""
 S LEXCHR="" F  S LEXCHR=$O(LEXCHRS(LEXCHR)) Q:'$L(LEXCHR)  D
 . ;     For strings beginning with character
 . N LEXLWRD,LEXTWRD,LEXIT
 . W:'$D(ZTQUEUED)&($D(LEXTEST)) LEXCHR
 . S (LEXLWRD,LEXTWRD)=$C($A(LEXCHR)-1)_"~" S LEXIT=0
 . F  S LEXLWRD=$O(^LEX(757.01,"ASL",LEXLWRD)) D  Q:LEXIT>0
 . . S:'$L(LEXLWRD) LEXIT=1 S:$E(LEXLWRD,1)'=LEXCHR LEXIT=1
 . . Q:LEXIT>0  N LEXNOD,LEXCTL,LEXCMD
 . . ;       Delete strings from the ^LEX global
 . . S LEXNOD="^LEX(757.01,""ASL"","""_LEXTWRD_""")"
 . . S LEXCTL="^LEX(757.01,""ASL"","""_LEXTWRD_""","
 . . F  S LEXNOD=$Q(@LEXNOD) Q:'$L(LEXNOD)!(LEXNOD'[LEXCTL)  D
 . . . S LEX2=LEX2+1
 . . S LEXCMD="K ^LEX(757.01,""ASL"","""_LEXLWRD_""")"
 . . X LEXCMD S LEX1=LEX1+1
 . S LEXTWRD=$C($A(LEXCHR)-1)_"~" S LEXIT=0
 . F  S LEXTWRD=$O(^TMP("LEXASL",$J,LEXTWRD)) D  Q:LEXIT>0
 . . S:'$L(LEXTWRD) LEXIT=1 S:$E(LEXTWRD,1)'=LEXCHR LEXIT=1
 . . Q:LEXIT>0  N LEXNOD,LEXCTL
 . . S LEXNOD="^TMP(""LEXASL"","_$J_","""_LEXTWRD_""")"
 . . S LEXCTL="^TMP(""LEXASL"","_$J_","""_LEXTWRD_""","
 . . F  S LEXNOD=$Q(@LEXNOD) Q:'$L(LEXNOD)!(LEXNOD'[LEXCTL)  D
 . . . ;       Copy Index from ^TMP to ^LEX
 . . . N LEXCMD
 . . . S LEXCMD="S ^LEX(757.01,""ASL"""_$P(LEXNOD,$J,2,229)_"="""""
 . . . X LEXCMD S LEX3=LEX3+1
 . ;     Repeat for all characters
 H 1 S LEXEND=$$END D SAV^LEXXGP2(LEXBEG,LEXEND,LEXTXT)
 S LEXELP=$$ELP(LEXBEG,LEXEND),LEXBEGD=$$ED(LEXBEG)
 S LEXBEGT=$$ET(LEXBEG),LEXENDT=$$ET(LEXEND),LEXDF=$$DF(LEXBEG)
 S LEXTXT=$G(LEXTXT)_$J(" ",(35-$L($G(LEXTXT))))
 S LEXTXT=LEXTXT_LEXDF_"   "_LEXBEGT_"   "_LEXENDT_"   "_LEXELP
 S LEXTXT=" "_LEXTXT W:'$D(ZTQUEUED) !,LEXTXT
 I LEX3>0,$D(LEXFUL) D
 . S LEXCOM=LEX3_" 'ASL' Index Node"_$S(LEX3>1:"s",1:"")
 . D SAV^LEXXGP2(LEXBEG,"","",LEXCOM)
 . W:'$D(ZTQUEUED) !,"   ",LEXCOM
 N ZTQUEUED,LEXTEST
 Q
 ;
SUB ; Subset file Indexes Aaaa
 D SUB^LEXXGP2
 Q
 ;
 ; Miscellaneous
FMTT(X) ;   Format Total
 N LEXI,LEXTXT,LEXTMP,LEXBEG,LEXBEGD,LEXBEGT,LEXEND,LEXENDD,LEXENDT,LEXELP
 S LEXBEG=$G(^TMP("LEXXGPTIM",$J,"BEG")) Q:$P(LEXBEG,".",1)'?7N ""
 S LEXEND=$G(^TMP("LEXXGPTIM",$J,"END")) Q:$P(LEXEND,".",1)'?7N ""
 Q:LEXEND'>LEXBEG ""  S LEXTXT="Total Time to Repair Indexes"
 S LEXELP=$$ELP(LEXBEG,LEXEND),LEXBEGD=$$ED(LEXBEG),LEXBEGT=$$ET(LEXBEG),LEXENDT=$$ET(LEXEND),LEXDF=$$DF(LEXBEG)
 Q:'$L(LEXBEGT) ""  Q:'$L(LEXENDT) ""  Q:'$L(LEXELP) ""
 S X=LEXTXT_$J(" ",(35-$L(LEXTXT)))_LEXBEGD_"   "_LEXBEGT_"   "_LEXENDT_"   "_LEXELP
 Q X
FMT(X,LEXBD,LEXBT,LEXET,LEXEL) ;   Format Line
 N LEXTX S LEXTX=$G(X),LEXBD=$G(LEXBD),LEXBT=$G(LEXBT),LEXET=$G(LEXET),LEXEL=$G(LEXEL)
 Q:'$L(LEXTX)!('$L(LEXBD))!('$L(LEXBT))!('$L(LEXET))!('$L(LEXEL)) ""
 S X=$G(LEXTX)_$J(" ",(35-$L($G(LEXTX))))_LEXBD_"   "_LEXBT_"   "_LEXET_"   "_LEXEL
 Q X
DF(X) ;   Date Display Format
 N LEXO,LEXD,LEXDF,LEXP,LEXC S (X,LEXD)=$P($G(X),".",1) Q:LEXD'?7N "--/--/----"
 S LEXP=$O(^TMP("LEXXGPDAT",$J,(LEXD_".001")),-1) S LEXC=1
 S:$L(LEXP) LEXC=$O(^TMP("LEXXGPDAT",$J,LEXP," "),-1)
 S LEXO=$$ED(LEXD) S:LEXP=LEXD&(LEXC>1) LEXO="  ""    ""  " S X=LEXO
 Q X
ED(X) ;   External Date from Fileman
 N LEX,LEXT,LEXBD S LEX=$G(X) Q:$P(LEX,".",1)'?7N ""
 S LEXT=$$FMTE^XLFDT($G(LEX),"5ZS"),X=$P(LEXT,"@",1)
 Q X
ET(X) ;   External Time from Fileman
 N LEX,LEXT,LEXBD S LEX=$G(X) Q:$P(LEX,".",1)'?7N ""
 S LEXT=$$FMTE^XLFDT($G(LEX),"5ZS"),X=$P(LEXT,"@",2)
 S:'$L(X) X="00:00:00" S:'$L($P(X,":",1)) $P(X,":",1)="00"
 S:'$L($P(X,":",2)) $P(X,":",2)="00" S:'$L($P(X,":",3)) $P(X,":",3)="00"
 Q X
BEG(X) ;   Begin Date/Time
 S X=$$NOW^XLFDT N Y S Y=$G(^TMP("LEXXGPTIM",$J,"BEG"))
 S:'$L(Y) Y=X S:+X<Y Y=X S:$P(Y,".",1)?7N ^TMP("LEXXGPTIM",$J,"BEG")=Y
 Q X
END(X) ;   End Date/Time
 S X=$$NOW^XLFDT N Y S Y=$G(^TMP("LEXXGPTIM",$J,"END"))
 S:'$L(Y) Y=X S:+X>Y Y=X S:$P(Y,".",1)?7N ^TMP("LEXXGPTIM",$J,"END")=Y
 Q X
ELP(X,Y) ;   Elapsed Time
 N LEXBEG,LEXEND,LEXELP S LEXBEG=$G(X),LEXEND=$G(Y)
 Q:$P(LEXBEG,".",1)'?7N "        "
 Q:$P(LEXEND,".",1)'?7N "        "
 S LEXELP=$TR($$FMDIFF^XLFDT(LEXEND,LEXBEG,3)," ","0")
 S X=LEXELP
 Q X
CLR ;   Clear Variables
 K LEXLOUD,LEXTEST,LEXJ,LEXMAIL,LEXHOME,LEXQUIT
 Q
