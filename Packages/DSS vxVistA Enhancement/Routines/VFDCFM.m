VFDCFM ;DSS/SGM - DRIVER PGM FOR VFDCFM* ; 02/13/2014 13:20
 ;;2013.0;DSS,INC VXVISTA OPEN SOURCE;;28 Jan 2013;Build 2
 ;Copyright 1995-2014,Document Storage Systems Inc. All Rights Reserved
 ;
 ; FUN deprecated in favor of $QUIT on 8/6/2012
 ;
OUT Q:$Q VFDC Q
 ;
 ;--------------------  VFDCFM01  --------------------
DATE(VFDXSD,VFDXED,FUN) ; start/end date prompter
 ; FUN - deprecated 8/6/2012
 N X,VFDC S VFDC=$$DATE^VFDCFM01(.VFDXSD,.VFDXED)
 G OUT
 ;
MSG(FLGS,VFDC,WIDTH,LEFT,INPUT) ; process message arrays
 D INIT("FLGS^WIDTH^LEFT") I $Q,FLGS'["V" S FLGS=FLGS_"V"
 D MSG^VFDCFM01(FLGS,.VFDC,WIDTH,LEFT,.INPUT)
 G OUT
 ;
 ;--------------------  VFDCFM05  --------------------
FIND(VFDC,INPUT) ; RPC: VFDC FM FIND
 D FIND^VFDCFM05(.VFDC,.INPUT) Q
 ;
LIST(VFDC,INPUT) ; RPC: VFDC FM LIST
 D LIST^VFDCFM05(.VFDC,.INPUT) Q
 ;
 ;--------------------  VFDCFM06  --------------------
EXTERNAL(VFDC,FILE,FIELD,VALUE,FUN) ; rpc: VFDC FM EXTERNAL
 D INIT("FILE^FIELD^VALUE")
 D EXTERNAL^VFDCFM06(.VFDC,FILE,FIELD,VALUE)
 G OUT
 ;
FIELD(VFDC,FILE,FIELD,FLAG,ATT,TYPE) ; rpc: VFDC FM GET FIELD ATTRIB
 D INIT("FILE^FIELD^FLAG^TYPE")
 D FIELD^VFDCFM06(.VFDC,FILE,FIELD,FLAG,.ATT,TYPE)
 Q
 ;
FIELDLST(VFDC,INPUT) ;
 D FIELDLST^VFDCFM06(.VFDC,.INPUT) Q
 ;
ROOT(VFDC,FILE,IENS,FLAG,FUN) ;
 D INIT("FILE^IENS^FLAG")
 D ROOT^VFDCFM06(.VFDC,$G(FILE),$G(IENS),$G(FLAG))
 G OUT
 ;
VFILE(VFDC,FILE,FUN) ; rpc: VFDC FM VERIFY FILE
 D INIT("FILE"),VFILE^VFDCFM06(.VFDC,FILE) G OUT
 ;
VFIELD(VFDC,FILE,FIELD,FUN) ; rpc: VFDC FM VERIFY FIELD
 D INIT("FILE^FIELD")
 D VFIELD^VFDCFM06(.VFDC,FILE,FIELD)
 G OUT
 ;
VIENS(VFDC,IENS,FUN) ;
 D INIT("IENS"),VIENS^VFDCFM06(.VFDC,IENS)
 G OUT
 ;
 ;---------------  subroutines  --------------------
INIT(STR) ; list of variable names to initialize
 N I,X
 F I=1:1:$L(STR,U) S X=$P(STR,U,I) S:X'="" @(X_"=$G(@X)")
 Q
