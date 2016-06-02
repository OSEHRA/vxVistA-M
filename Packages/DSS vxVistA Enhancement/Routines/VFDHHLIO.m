VFDHHLIO ;DSS/PDW - IMPORT EXPORT FUNCTIONS - ;22 MAR 2011
 ;;2012.1.1;VENDOR - DOCUMENT STORAGE SYS;;24 Jun 2013;Build 136
 ;Copyright 1995-2013,Document Storage Systems Inc. All Rights Reserved
 ;DSS/BUILD - VFDHHL HL7 EXCHANGE 2012.1.1 * 06/23/15 * vxdev64v2k8_VX13 * 2012.1 T22
 ;DSS/BUILD - VFDHHL HL7 EXCHANGE 2012.1.1 * 02/02/14 * vxdev64v2k8_DEVXOS * 2012.1.1T21
 ;^TMP("VFDHLIO",$J,"OUT",VFDLN,0)
 ;ENOUT
 ;ENIN
 Q
EXPORT ;
 N VFDSYSDA,VFDSYSNM,VFDLIST,VFDLAST,VFDTABNM,VFDTABDA
 N VFDEXPNM,VFDEXDT,VFDEXLOC,VFDLN,VFDNN,VFDGL
 N VFDSEG,VFDSEGNM,VFDSEGDA,VFDSTOP,VFDSEGIS
 N VFDTAGDA,VFDTABIS,VFDTABN,VFDTABS,VFDTABNM
 N VFDTAG,VFDTAR,VFDTDEL,VFDVAL,VFDVALNM
 N VLIST,VFDLIST,VFDINDX,VFDLL,VFDLN
 N VFDFLDS,VFDEXNM,VFDSEGS,VFDMSDA,VFDI,DIR,DA
 F  S VFDSYSDA=$$SELTRAN^VFDHHLOE Q:VFDSYSDA'>0  D
 .S VFDSYSNM=$$GET1^DIQ(21625.01,VFDSYSDA,.01)
 .N VFDTABS,VFDSTOP
 .D TABADD I $G(VFDSTOP) Q
 .D SEGADD I $G(VFDSTOP) Q
 .D DEVICE I POP Q
 .D OUT
 Q
TABADD ; COLLECT TABLES TO PUSH OUT
 F  S VFDTABDA=$$SELTAB^VFDHHLOE(VFDSYSDA) Q:VFDTABDA'>0  D
 . N VFDTABIS S VFDTABIS=VFDTABDA_","_VFDSYSDA_","
 . S VFDTABNM=$$GET1^DIQ(21625.0105,VFDTABIS,.01)
 . S VFDTABS(VFDTABDA)=VFDTABNM
 . S VFDTABS("B",VFDTABNM,VFDTABDA)=""
 . D TABDISP
QTAB ;
 D TABDISP
 W ! K DIR S DIR(0)="S^A:Add;D:Delete;Q:Quit;C:Continue" D ^DIR
 I Y="A" G TABADD
 I Y="D" D TABSDEL G QTAB
 I Y="Q" S VFDSTOP=1 K VFDTABS Q
 I Y="C" Q
 Q
TABSDEL ;
 N NM,VFDTDEL,VFDTABN,VFDLAST
 D TABDISP ;creates VFDLIST
 S VFDLAST=$O(VFDLIST("A"),-1)
 S DIR(0)="LO^1:"_VFDLAST,DIR("A")="Delete " D ^DIR
 Q:'+Y
 S VFDTDEL=Y
 F I=1:1 S VFDTABN=$P(VFDTDEL,",",I) Q:VFDTABN'>0  W !,VFDTABN,?5,VFDLIST(VFDTABN)
 K DIR S DIR(0)="YO",DIR("A")="OK to delete above from list" D ^DIR
 Q:Y'=1
DEL ;
 F I=1:1 S VFDTABN=$P(VFDTDEL,",",I) Q:VFDTABN'>0  W !,VFDTABN,?5,VFDLIST(VFDTABN),?30,"Deleting" D
 .S VFDTABNM=VFDLIST(VFDTABN),VFDTABDA=$O(VFDTABS("B",VFDTABNM,0))
 .K VFDTABS(VFDTABDA),VFDTABS("B",VFDTABNM),VFDLIST(VFDTABN)
 Q
 ;
TABDISP ;display tabs & returns VFDLIST(I)=TabName
 W !!,"   List of tables"
 S VFDTABNM=""
 K VFDLIST
 F I=1:1 S VFDTABNM=$O(VFDTABS("B",VFDTABNM)) Q:VFDTABNM=""  D
 .S VFDLIST(I)=VFDTABNM
 S VFDLAST=$O(VFDLIST("A"),-1)
 Q:'VFDLAST
 F I=1:1:VFDLAST W !,I,?5,VFDLIST(I)
 Q
SEGADD ; COLLECT SEGS TO PUSH OUT
 F  S VFDSEGDA=$$SELSEG^VFDHHLOE(VFDSYSDA) Q:VFDSEGDA'>0  D
 . N VFDSEGIS S VFDSEGIS=VFDSEGDA_","_VFDSYSDA_","
 . S VFDSEGNM=$$GET1^DIQ(21625.0101,VFDSEGIS,.01)
 . S VFDSEGS(VFDSEGDA)=VFDSEGNM
 . S VFDSEGS("B",VFDSEGNM,VFDSEGDA)=""
 . D SEGDISP
QSEG ;
 D SEGDISP
 W ! K DIR S DIR(0)="S^A:Add;D:Delete;Q:Quit;C:Continue" D ^DIR
 I Y="A" G SEGADD
 I Y="D" D SEGSDEL G QSEG
 I Y="Q" S VFDSTOP=1 K VFDSEGS Q
 I Y="C" Q
 Q
SEGSDEL ;
 N NM,VFDTDEL,VFDSEGN,VFDLAST
 D SEGDISP ;creates VFDLIST
 S VFDLAST=$O(VFDLIST("A"),-1)
 S DIR(0)="LO^1:"_VFDLAST,DIR("A")="Delete " D ^DIR
 Q:'+Y
 S VFDTDEL=Y
 F I=1:1 S VFDSEGN=$P(VFDTDEL,",",I) Q:VFDSEGN'>0  W !,VFDSEGN,?5,VFDLIST(VFDSEGN)
 K DIR S DIR(0)="YO",DIR("A")="OK to delete above from list" D ^DIR
 Q:Y'=1
DELSEG ;
 F I=1:1 S VFDSEGN=$P(VFDTDEL,",",I) Q:VFDSEGN'>0  W !,VFDSEGN,?5,VFDLIST(VFDSEGN),?30,"Deleting" D
 .S VFDSEGNM=VFDLIST(VFDSEGN),VFDSEGDA=$O(VFDSEGS("B",VFDSEGNM,0))
 .K VFDSEGS(VFDSEGDA),VFDSEGS("B",VFDSEGNM),VFDLIST(VFDSEGN)
 Q
 ;
SEGDISP ;display SEGs & returns VFDLIST(I)=SEGName
 W !!,"   List of SEGs"
 N VFDLAST
 N VFDSEGNM
 K VFDLIST
 S VFDSEGNM=""
 F I=1:1 S VFDSEGNM=$O(VFDSEGS("B",VFDSEGNM)) Q:VFDSEGNM=""  D
 .S VFDLIST(I)=VFDSEGNM
 S VFDLAST=$O(VFDLIST("A"),-1)
 Q:'VFDLAST
 F I=1:1:VFDLAST W !,I,?5,VFDLIST(I)
 Q
DEVICE ;
 N VFDEXLOC,VFDEXDT
 N Y D GETENV^%ZOSV S VFDEXLOC=$P(Y,U,3)_"_"_$P(Y,U,1)
 D NOW^%DTC
 S VFDEXDT=$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3)_"."_$P(%,".",2)
 S X="HL7X_"_VFDSYSNM_"_TABLES_"_VFDEXLOC_"_"_VFDEXDT
 S VFDEXNM=X
 W !,"Export Name: ",VFDEXNM
 D ^%ZIS
 Q
OUT ;
 ;write out structured system, table values, row values
 ;generate data rows
 ;<|SYSNM|>SYSNM</|SYSNM>
 ;<|TABFLDS|>table flds</|TABFLD|>
 ;<|TABVALS|>.01,.02,.03 . . .</|TABDEF|
 ;<|ROWFLDS|>row fields</|ROWFLDS|>
 ;<|ROWVALS|>row values</|ROWVALS|>
 ;<|SEGFLDS|>seg fields</|SEGFLDS|> ;only one field
 ;<|SEGVALS|>seg values</|SEGVALS|>
 ;<|ELMFLDS|>elm fields</|ELMFLDS|>
 ;<|ELMVALS|>elm values</|ELMVALS|>
 ;<|MAPFLDS|>map fields</|MAPFLDS|> ;only one field
 ;<|MAPVALS|>map values</|MAPVALS|>
 K VFDLN ;line counter of ^TMP("VFDHHLIO",$J,"OUT",VFDLN,0)
 K ^TMP("VFDHHLIO",$J)
 S X=VFDEXNM
 D STASH(X)
 S X="<|SYSNM|>"_VFDSYSNM_"</|SYSNM|>"
 W !,X
 D STASH(X)
 D TABLES
 D SEGMENTS
 ; output information
 U IO
 S VFDGL=$NA(^TMP("VFDHHLIO",$J,"OUT"))
 S VFDLN=0
 F  S VFDLN=$O(@VFDGL@(VFDLN)) Q:VFDLN'>0  U IO W @VFDGL@(VFDLN,0),!
 D ^%ZISC
 Q
TABLES ; obtain table information
 N VFDTABNM,VFDTABDA
 S VFDTABNM=""
 F  S VFDTABNM=$O(VFDTABS("B",VFDTABNM)) Q:VFDTABNM=""  D
 .S VFDTABDA=$O(VFDTABS("B",VFDTABNM,0))
 .D TABLEONE(VFDTABDA)
 Q
TABLEONE(VFDTABDA) ;
 N VFDGL
 N VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG
 S (VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)=""
 ;Set needed variables
 S VFDFILE=21625.0105,VFDIENS=","_VFDSYSDA_","
 S VFDFLDS="@;.01;.02;.03;.04;.05;.06;.07",VFDFLGS="P"
 S VFDSCR="I VFDTABDA=+Y"
 S VFDTAR="^TMP(""VFDHHLIO"",$J,""TAB"")" K @VFDTAR
 S VFDMSG="VFDMSG",VFDFLGS="P"
 D LIST^DIC(VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)
 S VFDGL=$NA(^TMP("VFDHHLIO",$J,"TAB","DILIST"))
 S X="<|TABFLDS|>"_@VFDGL@(0,"MAP")_"</|TABFLDS|>" D STASH(X)
 S X="<|TABVALS|>"_@VFDGL@(1,0)_"</|TABVALS|>" D STASH(X)
 W !,"TABLE:",?10,$P(X,U,2),?30,$P(X,U,3)
 D ROWS
 Q
ROWS ; obtain row(s) information
 N VFDGL,VFDNN
 N VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG
 S (VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)=""
 ;Set needed variables
 S VFDFILE=21625.0106,VFDIENS=","_VFDTABDA_","_VFDSYSDA_","
 S VFDFLDS="@;.01;.02;.03;.04;.05",VFDFLGS="P"
 S VFDTAR="^TMP(""VFDHHLIO"",$J,""ROWS"")" K @VFDTAR
 S VFDMSG="VFDMSG",VFDFLGS="P"
 D LIST^DIC(VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)
 S VFDGL=$NA(^TMP("VFDHHLIO",$J,"ROWS","DILIST"))
 S X="<|ROWFLDS|>"_@VFDGL@(0,"MAP")_"</|ROWFLDS|>" D STASH(X)
 W "."
 S VFDNN=0 F  S VFDNN=$O(@VFDGL@(VFDNN)) Q:VFDNN'>0  S X="<|ROWVALS|>"_@VFDGL@(VFDNN,0)_"</|ROWVALS|>" D STASH(X)
 Q
SEGMENTS ; obtain SEG information
 N VFDSEGDA,VFDSEGNM
 S VFDSEGNM=""
 F  S VFDSEGNM=$O(VFDSEGS("B",VFDSEGNM)) Q:VFDSEGNM=""  D
 .S VFDSEGDA=$O(VFDSEGS("B",VFDSEGNM,0))
 .D SEGONE(VFDSEGDA)
 Q
SEGONE(VFDSEGDA) ;
 N VFDGL
 N VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG
 S (VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)=""
 ;Set needed variables
 S VFDFILE=21625.0101,VFDIENS=","_VFDSYSDA_","
 S VFDFLDS="@;.01",VFDFLGS="P"
 S VFDSCR="I VFDSEGDA=+Y"
 S VFDTAR="^TMP(""VFDHHLIO"",$J,""SEG"")" K @VFDTAR
 S VFDMSG="VFDMSG",VFDFLGS="P"
 D LIST^DIC(VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)
 S VFDGL=$NA(^TMP("VFDHHLIO",$J,"SEG","DILIST"))
 S X="<|SEGFLDS|>"_@VFDGL@(0,"MAP")_"</|SEGFLDS|>" D STASH(X)
 S X="<|SEGVALS|>"_@VFDGL@(1,0)_"</|SEGVALS|>" D STASH(X)
 S X=$P(X,"^",2),X=$P(X,"<")
 W !,"SEG:",?10,X
 D ELMS
 Q
ELMS ; obtain element(s) information
 N VFDGL,VFDTAR,VFDMSG,VFDGL,VFDNN
 N VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG
 S (VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)=""
 ;Set needed variables
 S VFDFILE=21625.0102,VFDIENS=","_VFDSEGDA_","_VFDSYSDA_","
 S VFDFLDS="@;.01;.02;.03;.04;.05;.06;.07;.08;.09;1.01",VFDFLGS="P"
 S VFDTAR="^TMP(""VFDHHLIO"",$J,""ELMS"")" K @VFDTAR
 S VFDMSG="VFDMSG",VFDFLGS="P"
 D LIST^DIC(VFDFILE,VFDIENS,VFDFLDS,VFDFLGS,VFDNUM,VFDFR,VFDPART,VFDNDX,VFDSCR,VFDIDENT,VFDTAR,VFDMSG)
 S VFDGL=$NA(^TMP("VFDHHLIO",$J,"ELMS","DILIST"))
 S X="<|ELMFLDS|>"_@VFDGL@(0,"MAP")_"</|ELMFLDS|>" D STASH(X)
 W "."
 S VFDNN=0 F  S VFDNN=$O(@VFDGL@(VFDNN)) Q:VFDNN'>0  D
 .;check if brief output, needed segments only Type[* or Variable stated
 .N XX,YY S XX=$P(@VFDGL@(VFDNN,0),U,5),YY=$P(@VFDGL@(VFDNN,0),U,9)
 .I $G(VFDBRIEF),XX'["*",$L(YY)'>2 Q
 .S X="<|ELMVALS|>"_@VFDGL@(VFDNN,0)_"</|ELMVALS|>" D STASH(X)
 Q
STASH(X) S VFDLN=$G(VFDLN)+1 S ^TMP("VFDHHLIO",$J,"OUT",VFDLN,0)=X
 ;W !,VFDLN,?5,X
 Q
IMPORT ; Bring In Tables & Segments
 ;
 ;<|SYSNM|>SYSNM</|SYSNM>
 ;<|TABFLDS|>table flds.01,.02,.03</|TABFLD|>
 ;<|TABVALS|>values:.01,.02,.03 . . .</|TABDEF|
 ;<|ROWFLDS|>row fields.01,.02,.03</|ROWFLDS|>
 ;<|ROWVALS|>row values.01,.02,.03</|ROWVALS|>
 ;<|SEGFLDS|>seg fields</|SEGFLDS|> ;only one field
 ;<|SEGVALS|>seg values</|SEGVALS|>
 ;<|ELMFLDS|>elm fields</|ELMFLDS|>
 ;<|ELMVALS|>elm values</|ELMVALS|>
 ;<|MAPFLDS|>map fields</|MAPFLDS|> ;only one field
 ;<|MAPVALS|>map values</|MAPVALS|>
 N NSEQ,FSEQ,VLIST,GLIST,VFDPATH,VFDFLNM,VFDTABDA,VFDSYSDA
 N VLIST,VFDPATH,VFDSYSDA,VFDSYSNM,VFDX
HFSQ1 ;
 K DIR S DIR(0)="FO",DIR("A")="Enter HFS Path "
 S:$D(^TMP($J,"HFSPATH")) DIR("B")=^TMP($J,"HFSPATH")
 D ^DIR I X="^" Q
 I $L(Y) S VFDPATH=Y,^TMP($J,"HFSPATH")=Y
 Q:$L(Y)=0
HFSQ2 ;
 W !!,"PATH is ",VFDPATH,!
 S GLIST("*.*")=""
 K VLIST S Y=$$LIST^%ZISH(VFDPATH,"GLIST","VLIST")
 K DIR S DIR(0)="FO",DIR("A")="ENTER FILE: "
 S:$D(^TMP($J,"HFSFILE")) DIR("B")=^TMP($J,"HFSFILE")
 D ^DIR
 I X="^" K VLIST,^TMP($J,"HFSFILE") G HFSQ1
 I '$D(VLIST(Y)) W !,?7,Y,!,"Not FOUND IN ",VFDPATH G HFSQ2
 I $L(Y)>2 S VFDFLNM=Y,^TMP($J,"HFSFILE")=VFDFLNM
 D HFSLOAD(.VFDGMSG,VFDPATH,VFDFLNM)
 I $G(VFDSTOP) Q
PREVIEW ;
 N GL,VFDEXNM,VFDLL
 N VFDTAG,VFDDATA,VFDSYDA,VFDSYNM
 S GL=$NA(^TMP("VFDHHLIO",$J))
 S VFDEXNM=@GL@(1)
 S VFDLL=$O(@GL@("A"),-1)
 W !!,?5,"Tables were generated at: ",!!,?5,VFDEXNM,!
 F I=1:1:VFDLL S VFDX=@GL@(I) D
 .D TAGDATA(.VFDTAG,.VFDDATA,VFDX)
 .I VFDTAG="SYSNM" W !,?10,"Interface:",?23,VFDDATA,!!
 .I VFDTAG="TABVALS" W !,?10,"Table:",?23,$P(VFDDATA,U,2),?40,$P(VFDDATA,U,3)
 .I VFDTAG="SEGVALS" W !,?10,"Segment:",?23,$P(VFDDATA,U,2),?40,$P(VFDDATA,U,3)
 W !!,"The listed tables/segments will be archived and then imported.",!
 W !,?5,"The archive table names abc will be VX_Z_abc_.DTM"
 W !!,?5,"The archive segment names abc will be VZ_abc_.DTM",!
 K DIR S DIR(0)="Y",DIR("A")="Do you wish to continue?",DIR("B")="N"
 D ^DIR
 I Y'=1 K @GL Q
 S VFDSYSDA=$$SELTRAN^VFDHHLOE
 S VFDSYSNM=$$GET1^DIQ(21625.01,VFDSYSDA,.01)
 W !!,"Tables/Segments are to be loaded into:  ",?20,VFDSYSNM,!
 K DIR S DIR(0)="Y",DIR("A")="Continue?",DIR("B")="Y"
 D ^DIR I Y'=1 Q
 D FILETABS
 Q
FILETABS ;move global into TABLES
 N VFDTAG,VFDTAG,VFDDATA,VFDFLDS,VFDTABDA,VFDSEGDA
 F VFDI=1:1:VFDLL S VFDX=@GL@(VFDI) D  I $G(VFDSTOP) K VFDSTOP Q
 .D TAGDATA(.VFDTAG,.VFDDATA,VFDX) ;from line dx pull tag and data
 .I VFDTAG="SYSNM" D SYSNM(.VFDSYSDA,VFDDATA) Q  ;return system IEN
 .I VFDTAG="TABFLDS" D VFDFLDS(.VFDFLDS,VFDDATA) Q  ;return table edit fields
 .I VFDTAG="TABVALS"  D TABVALS(.VFDTABDA,VFDDATA,.VFDFLDS) Q
 .I VFDTAG="ROWFLDS" W "." D VFDFLDS(.VFDFLDS,VFDDATA) Q
 .I VFDTAG="ROWVALS" D ROWVALS(VFDTABDA,VFDDATA,.VFDFLDS) Q
 .I VFDTAG="SEGFLDS" D VFDFLDS(.VFDFLDS,VFDDATA) Q  ;return table edit fields
 .I VFDTAG="SEGVALS"  D SEGVALS(.VFDSEGDA,VFDDATA,.VFDFLDS) Q
 .I VFDTAG="ELMFLDS" W "." D VFDFLDS(.VFDFLDS,VFDDATA) Q
 .I VFDTAG="ELMVALS" D ELMVALS(VFDSEGDA,VFDDATA,.VFDFLDS) Q
 Q
SYSNM(VFDSYSDA,VFDDATA) ; sets VFDSYSDA
 ;"<|SYSNM|>UBHC-ICSHL7</|SYSNM|>"
 W !!,?10,"Interface:",?23,VFDDATA,!
 Q
 N VFDFILE,VFDIENS,VFDFLGS,VFDVAL,VFDINDX,VFDSCR,VFDMSG
 ;set variables as needed
 ;S VFDFILE=21625.01,(VFDVAL,VFDSYSNM)=VFDDATA
 ;S VFDSYSDA=$$FIND1^DIC(VFDFILE,VFDIENS,VFDFLGS,.VFDVAL,.VFDINDX,.VFDSCR,VFDMSG)
 Q
VFDFLDS(VFDFLDS,VFDDATA) ;pull out fields to be edited tabs & rows
 ;"<|t/rFLDS|>IEN^.01^.02^.03^.04^.05^.06^.07</|t/rFLDS|>"
 K VFDFLDS
 ;W !,"VFDFLDS",?15,VFDDATA
 F I=1:1 S X=$P(VFDDATA,U,I) Q:X=""  S VFDFLDS(I)=X
 Q
TABVALS(VFDTABDA,VFDDATA,VFDFLDS) ;find table and file fields
 ; assemble Z
 ;"<|TABFLDS|>IEN^.01^.02^.03^.04^.05^.06^.07</|TABFLDS|>"
 ;"<|TABVALS|>301^VX-FILE44^HL7 PV1.3.1 TO FILE 44 IEN^^^POINT OF CARE^^</|TABVALS|>"
 ;N Z,LL
 N VFDFILE,VFDIENS,VFDFLGS,VFDVAL,VFDINDX,VFDSCR,VFDMSG
 S (VFDFILE,VFDIENS,VFDFLGS,VFDVAL,VFDINDX,VFDSCR,VFDMSG)=""
 ;set variables as needed
 S VFDFILE=21625.0105,VFDVAL=$P(VFDDATA,U,2),VFDIENS=","_VFDSYSDA_","
 S VFDTABDA=$$FIND1^DIC(VFDFILE,VFDIENS,VFDFLGS,.VFDVAL,.VFDINDX,.VFDSCR,VFDMSG)
 ;if table found delete it
 ;W !,"TABVALS",?15,VFDDATA
TABARCH ;
 W !
 I VFDTABDA D
 .N %,VFDVALNM,DR,DIE D NOW^%DTC
 .S VFDVALNM=$E(VFDVAL,1,2)_"Z"_$E(VFDVAL,3,99)_"."_$E(%,1,12)
 .W !,"Table found: ",VFDVAL,?40,"Archived as: ",VFDVALNM
 .S DA=VFDTABDA,DA(1)=VFDSYSDA S VFDTABIS=$$IENS^DILF(.DA)
 .S DIE=$$ROOT^DILFD(21625.0105,VFDTABIS)
 .S DR=".01///^S X=VFDVALNM;.05///@"
 .D ^DIE
TABFILE ;
 ;VFDFLDS array created by TAG TABFLDS processing
 N VFDFDA,Z,VFDIENS,VFDMSG
 S LL=$O(VFDFLDS("A"),-1)
 ;load Z from VFDFLDS array and VFDDATA
 ;skip 1st piece pair IEN:516
 F I=2:1:LL S X=$P(VFDDATA,U,I),Z(VFDFLDS(I))=X
 W !,"TABLE: ",Z(.01)
 M VFDFDA(21625.0105,"?+1,"_VFDSYSDA_",")=Z
 D UPDATE^DIE(,"VFDFDA","VFDIENS","VFDMSG")
 S VFDTABDA=VFDIENS(1)
 I $D(VFDMSG) D Q(VFDMSDA) I $E(IOST)="C" D E
 Q
ROWVALS(VFDTABDA,VFDDATA,VFDFLDS) ;pull out row values and file the row
 ;VFDFLDS array built by tag ROWFLDS processing
 ;<|ROWFLDS|>IEN^.01^.02^.03^.04^.05</|ROWFLDS|>
 ;<|ROWVALS|>8^2089-1^LDL Cholesterol^901^72^1</|ROWVALS|>
 N VFDFDA,Z,VFDIENS,VFDMSG,I,LL,VFDMSG
 S LL=$O(VFDFLDS("A"),-1)
 ;load Z from VFDFLDS array and VFDDATA
 ;skip 1st piece pair IEN:516
 ;W !,?5,VFDDATA
 F I=2:1:LL S X=$P(VFDDATA,U,I),Z(VFDFLDS(I))=X
 M VFDFDA(21625.0106,"?+1,"_VFDTABDA_","_VFDSYSDA_",")=Z
 D UPDATE^DIE(,"VFDFDA","VFDIENS","VFDMSG")
 I $D(VFDMSG) D Q(VFDMSG) I $E(IOST)="C" D E
 W "."
 Q
SEGVALS(VFDSEGDA,VFDDATA,VFDFLDS) ;find SEG and file fields
 ; assemble Z
 ;"<|SEGFLDS|>IEN^.01</|SEGFLDS|>"
 ;"<|SEGVALS|>99^PID</|SEGVALS|>"
 ;N Z,LL
 N VFDFILE,VFDIENS,VFDFLGS,VFDVAL,VFDINDX,VFDSCR,VFDMSG
 S (VFDFILE,VFDIENS,VFDFLGS,VFDVAL,VFDINDX,VFDSCR,VFDMSG)=""
 ;set variables as needed
 S VFDFILE=21625.0101,VFDVAL=$P(VFDDATA,U,2),VFDIENS=","_VFDSYSDA_","
 S VFDSEGDA=$$FIND1^DIC(VFDFILE,VFDIENS,VFDFLGS,.VFDVAL,.VFDINDX,.VFDSCR,VFDMSG)
 ;if SEG found delete it
 ;W !,"SEGVALS",?15,VFDDATA
SEGARCH ;
 W !
 N %,VFDVALNM,DA,DIE,DR
 I VFDSEGDA D
 .D NOW^%DTC
 .S VFDVALNM="VZ"_VFDVAL_"."_$E(%,1,12)
 .W !,"SEG found: ",VFDVAL,?40,"Archived as: ",VFDVALNM
 .S DA=VFDSEGDA,DA(1)=VFDSYSDA S VFDSEGIS=$$IENS^DILF(.DA)
 .S DIE=$$ROOT^DILFD(21625.0101,VFDSEGIS)
 .S DR=".01///^S X=VFDVALNM"
 .D ^DIE
SEGFILE ;
 ;VFDFLDS array created by TAG SEGFLDS processing
 N VFDFDA,Z,VFDIENS,VFDMSG,LL,VFDMSG
 S LL=$O(VFDFLDS("A"),-1)
 ;load Z from VFDFLDS array and VFDDATA
 ;skip 1st piece pair IEN:516
 F I=2:1:LL S X=$P(VFDDATA,U,I),Z(VFDFLDS(I))=X
 W !,"SEG: ",Z(.01)
 M VFDFDA(21625.0101,"?+1,"_VFDSYSDA_",")=Z
 D UPDATE^DIE(,"VFDFDA","VFDIENS","VFDMSG")
 S VFDSEGDA=VFDIENS(1)
 I $D(VFDMSG) D Q(VFDMSG) I $E(IOST)="C" D E
 Q
ELMVALS(VFDSEGDA,VFDDATA,VFDFLDS) ;pull out ELM values and file the ELM
 ;VFDFLDS array built by tag ELMFLDS processing
 ;<|ELMFLDS|>IEN^.01^.02^.03^.04^.05^.06^.07^.08^.09</|ELMFLDS|>
 ;<|ELMVALS|>8^...</|ELMVALS|>
 N VFDFDA,Z,VFDIENS,VFDMSG,I,LL,VFDMSG
 S LL=$O(VFDFLDS("A"),-1)
 ;load Z from VFDFLDS array and VFDDATA
 ;skip 1st piece pair IEN:516
 ;W !,?5,VFDDATA
 F I=2:1:LL S X=$P(VFDDATA,U,I),Z(VFDFLDS(I))=X
 M VFDFDA(21625.0102,"?+1,"_VFDSEGDA_","_VFDSYSDA_",")=Z
 D UPDATE^DIE(,"VFDFDA","VFDIENS","VFDMSG")
 I $D(VFDMSG) D Q(VFDMSG) I $E(IOST)="C" D E
 W "."
 Q
HFSLOAD(VFDGMSG,VFDPATH,VFDFLNM) ;
 W !!,"Path: ",VFDPATH,!,"FILE: ",VFDFLNM,!
 N VFDGBL,VFDGMSG,VFDEXNM
 S VFDGBL=$NA(^TMP("VFDHHLIO",$J,1))
 S VFDGMSG=$NA(^TMP("VFDHHLIO",$J)) K @VFDGMSG
 K ^TMP("VFDHHLIO",$J)
 S YY=$$FTG^%ZISH(VFDPATH,VFDFLNM,VFDGBL,3)
 I 'YY,$E(IOST)="C",'$D(ZTQUEUED) U IO(0) W !,"ERROR File To Global ",VFDPATH,VFDFLNM D E Q
 Q
TAGDATA(VFDTAG,VFDDATA,X) ;
 S VFDTAG=$P(X,"|",2)
 S VFDDATA=$P(X,"</"),VFDDATA=$P(VFDDATA,"|>",2)
 Q
INIT ;
 K VFDSYSDA,VFDSYSNM,VFDLIST,VFDLAST,VFDTABNM,VFDTABDA
 K VFDEXPNM,VFDEXDT,VFDEXLOC,VFDLN,VFDNN,VFDGL
 K VFDSEG,VFDSEGNM,VFDSEGDA,VFDSTOP,VFDSEGIS
 K VFDTAGDA,VFDTABIS,VFDTABN,VFDTABS,VFDTABNM
 K VFDTAG,VFDTAR,VFDTDEL,VFDVAL,VFDVALNM
 K VLIST,VFDLIST,VFDINDX,VFDLL,VFDLN
 K VFDFLDS
 S VFDSYSDA=$$SELTRAN^VFDHHLOE
 Q 
E ;returns VFDSTOP=1 if "^" entered
 I $E(IOST)="C",'$D(ZTQUEUED) K DIR,STOP
 S DIR(0)="E",DIR("A")="<CR> - Continue """"^"""" - STOP" W ! D ^DIR K DIR
 S:Y=0 VFDSTOP=1
 Q
MANUALIN ;manually load tables and segments (brief)
 D CHUILOAD^VFDHHL01 ;load into ^TMP("VFDHCHUI",$J)
 S X=$O(^TMP("VFDHCHUI",$J,"A"),-1)
 W !!,"Rows in import are: ",X
 K ^TMP("VFDHHLIO",$J)
 F I=1:1:X S ^TMP("VFDHHLIO",$J,I)=^TMP("VFDHCHUI",$J,I,0)
 G PREVIEW
 ;
Q(VAL) ; DISPLAY VAR WITH $Q
 N X,X1 S (X,X1)=VAL
 Q:'$D(@VAL)
 I $E(X,$L(X))=")" S X1=$E(X,1,$L(X)-1)
 I $D(@X)#10 W !,X,"=",@X
 F  S X=$Q(@X) Q:X'[X1  W !,X,"=",@X
 Q
HISTORY ; field 1.01 pointer to field map removed to be added later
