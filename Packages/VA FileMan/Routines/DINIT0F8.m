DINIT0F8 ;SFISC/MKO-DATA FOR FORM AND BLOCK FILES ;18AUG2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8,42,76,1003,1043**
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT0F9 S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.404,.00109,40,24,3)
 ;;=!M
 ;;^DIST(.404,.00109,40,24,3.1)
 ;;=D Y^DICATTD3(12,2)
 ;;^DIST(.404,.00109,40,24,20)
 ;;=F^^1:70
 ;;^DIST(.404,.00109,40,24,22)
 ;;=D C^DICATTD3
 ;;^DIST(.404,.00109,40,25,0)
 ;;=59^CODE^2^^CODE13
 ;;^DIST(.404,.00109,40,25,2)
 ;;=14,8^4^14,2
 ;;^DIST(.404,.00109,40,25,3)
 ;;=!M
 ;;^DIST(.404,.00109,40,25,3.1)
 ;;=D Y^DICATTD3(13,1)
 ;;^DIST(.404,.00109,40,25,20)
 ;;=F^^1:20
 ;;^DIST(.404,.00109,40,25,22)
 ;;=D C^DICATTD3
 ;;^DIST(.404,.00109,40,26,0)
 ;;=60^WILL STAND FOR^2^^MEANS13
 ;;^DIST(.404,.00109,40,26,2)
 ;;=14,30^30^14,14
 ;;^DIST(.404,.00109,40,26,3)
 ;;=!M
 ;;^DIST(.404,.00109,40,26,3.1)
 ;;=D Y^DICATTD3(13,2)
 ;;^DIST(.404,.00109,40,26,20)
 ;;=F^^1:70
 ;;^DIST(.404,.00109,40,26,22)
 ;;=D C^DICATTD3
 ;;^DIST(.404,.0011,0)
 ;;=DICATTW1^1
 ;;^DIST(.404,.0011,40,0)
 ;;=^.4044I^1^1
 ;;^DIST(.404,.0011,40,1,0)
 ;;=1^ ^2
 ;;^DIST(.404,.0011,40,1,2)
 ;;=1,4^1^1,1^1
 ;;^DIST(.404,.0011,40,1,11)
 ;;=S DDACT="CL"
 ;;^DIST(.404,.0011,40,1,20)
 ;;=F
 ;;^DIST(.404,.00111,0)
 ;;=DICATTW2^1
 ;;^DIST(.404,.00111,11)
 ;;=D WORD^DICATTD0(23)
 ;;^DIST(.404,.00111,40,0)
 ;;=^.4044I^1^1
 ;;^DIST(.404,.00111,40,1,0)
 ;;=1^ ^1
 ;;^DIST(.404,.00111,40,1,2)
 ;;=1,4^1^1,1^1
 ;;^DIST(.404,.00111,40,1,11)
 ;;=S DDACT="CL"
 ;;^DIST(.404,.00111,40,1,20)
 ;;=F
 ;;^DIST(.404,.00112,0)
 ;;=DICATTM^1
 ;;^DIST(.404,.00112,40,0)
 ;;=^.4044I^3^2
 ;;^DIST(.404,.00112,40,2,0)
 ;;=16^SUBSCRIPT^2^^SUBSCRIPT
 ;;^DIST(.404,.00112,40,2,2)
 ;;=1,18^33^1,7
 ;;^DIST(.404,.00112,40,2,3)
 ;;=!M
 ;;^DIST(.404,.00112,40,2,3.1)
 ;;=D SUBDEF^DICATTDM
 ;;^DIST(.404,.00112,40,2,4)
 ;;=1
 ;;^DIST(.404,.00112,40,2,11)
 ;;=D SUBHELP^DICATTDM
 ;;^DIST(.404,.00112,40,2,20)
 ;;=F^^1:33
 ;;^DIST(.404,.00112,40,2,22)
 ;;=K:X?1P.E!(X[" ")!(X[",")!(X[":")!(X[";")!(X["""")!(X["=")&(+X'=X) X I $D(X) N % S %=$$CHKSUB^DICATTDM(X) I '% K X D HLP^DDSUTL(%)
 ;;^DIST(.404,.00112,40,3,0)
 ;;=17^PIECE-POSITION^2^^PIECE
 ;;^DIST(.404,.00112,40,3,2)
 ;;=2,18^8^2,2
 ;;^DIST(.404,.00112,40,3,3)
 ;;=!M
 ;;^DIST(.404,.00112,40,3,3.1)
 ;;=D PIECDEF^DICATTDM
 ;;^DIST(.404,.00112,40,3,4)
 ;;=1
 ;;^DIST(.404,.00112,40,3,11)
 ;;=D PIECHELP^DICATTDM
 ;;^DIST(.404,.00112,40,3,20)
 ;;=F^^1:8
 ;;^DIST(.404,.00112,40,3,22)
 ;;=N % S %=$$CHKPIEC^DICATTDM(X) I '% K X D HLP^DDSUTL(%)
 ;;^DIST(.404,.00113,0)
 ;;=DICATT9^1
 ;;^DIST(.404,.00113,40,0)
 ;;=^.4044I^3^3
 ;;^DIST(.404,.00113,40,1,0)
 ;;=99^ARE YOU SURE YOU WANT TO DELETE THE ENTIRE FIELD^2^^DELETING
 ;;^DIST(.404,.00113,40,1,2)
 ;;=3,53^3^3,3
 ;;^DIST(.404,.00113,40,1,3)
 ;;=!M
 ;;^DIST(.404,.00113,40,1,3.1)
 ;;=S Y="N"
 ;;^DIST(.404,.00113,40,1,12)
 ;;=D POST9^DICATTDK
 ;;^DIST(.404,.00113,40,1,20)
 ;;=Y
 ;;^DIST(.404,.00113,40,2,0)
 ;;=99.1^*****************************************************^1
 ;;^DIST(.404,.00113,40,2,2)
 ;;=^^2,3
 ;;^DIST(.404,.00113,40,3,0)
 ;;=99.2^*****************************************************^1
 ;;^DIST(.404,.00113,40,3,2)
 ;;=^^4,3
 ;;^DIST(.404,.00114,0)
 ;;=DICATTS^1
 ;;^DIST(.404,.00114,40,0)
 ;;=^.4044I^2^2
 ;;^DIST(.404,.00114,40,1,0)
 ;;=76^SUBSCRIPT^2^^MUL SUBSCRIPT
 ;;^DIST(.404,.00114,40,1,2)
 ;;=2,26^33^2,15
 ;;^DIST(.404,.00114,40,1,3)
 ;;=!M
 ;;^DIST(.404,.00114,40,1,3.1)
 ;;=S Y="" I DICATT4="" F Y=+$O(^DD(DICATTA,"GL","A"),-1):1 Q:'$D(^(Y))
 ;;^DIST(.404,.00114,40,1,4)
 ;;=1
 ;;^DIST(.404,.00114,40,1,11)
 ;;=D SUBHELP^DICATTDM
 ;;^DIST(.404,.00114,40,1,20)
 ;;=F^^1:33
 ;;^DIST(.404,.00114,40,1,22)
 ;;=K:X?1P.E!(X[",")!(X[":")!(X["""")!(X["=")&(+X'=X) X I $D(X) N % S %=$$CHKSUB^DICATTDM(X) I '% K X D HLP^DDSUTL(%)
 ;;^DIST(.404,.00114,40,1,24)
 ;;=D SUBHELP^DICATTDM
 ;;^DIST(.404,.00114,40,2,0)
 ;;=76.1^SUB-DICTIONARY NUMBER^2
 ;;^DIST(.404,.00114,40,2,2)
 ;;=3,26^22^3,3
 ;;^DIST(.404,.00114,40,2,3)
 ;;=!M
 ;;^DIST(.404,.00114,40,2,3.1)
 ;;=S Y="" I DICATT4=Y D SUBDIC^DICATTD5
 ;;^DIST(.404,.00114,40,2,4)
 ;;=1
 ;;^DIST(.404,.00114,40,2,11)
 ;;=D HLP^DDSUTL("^DD number must be between "_DICATTA_" and "_(DICATTA\1+1)_" and not already used")
 ;;^DIST(.404,.00114,40,2,20)
 ;;=N^^0:9999999999999:9
 ;;^DIST(.404,.00114,40,2,22)
 ;;=D CHKDIC^DICATTD5
 ;;^DIST(.404,.00115,0)
 ;;=DICATTVP^1
 ;;^DIST(.404,.00115,40,0)
 ;;=^.4044I^6^6
 ;;^DIST(.404,.00115,40,1,0)
 ;;=1^MESSAGE^2
 ;;^DIST(.404,.00115,40,1,2)
 ;;=2,10^28^2,1
 ;;^DIST(.404,.00115,40,1,4)
 ;;=0
 ;;^DIST(.404,.00115,40,1,20)
 ;;=F^^1:30
 ;;^DIST(.404,.00115,40,2,0)
 ;;=4^SCREEN^2
 ;;^DIST(.404,.00115,40,2,2)
 ;;=5,9^60^5,1
 ;;^DIST(.404,.00115,40,2,10)
 ;;=D UNED^DDSUTL(5,,,X="","")
 ;;^DIST(.404,.00115,40,2,20)
 ;;=DD^^.12,1
 ;;^DIST(.404,.00115,40,2,21,0)
 ;;=^^3^3^2981127
 ;;^DIST(.404,.00115,40,2,21,1,0)
 ;;=Enter (optionally) a MUMPS statement which begins with 'S DIC("S")=' and
 ;;^DIST(.404,.00115,40,2,21,2,0)
 ;;=contains code which sets $T to "1" for selectable Entries.  Entry numbers
 ;;^DIST(.404,.00115,40,2,21,3,0)
 ;;=will be in the variable 'Y' when evaluation by DIC("S") takes place.
 ;;^DIST(.404,.00115,40,3,0)
 ;;=3^SHOULD USER BE ALLOWED TO ADD A NEW ENTRY^2
 ;;^DIST(.404,.00115,40,3,2)
 ;;=4,44^3^4,1
 ;;^DIST(.404,.00115,40,3,20)
 ;;=S^^y:YES;n:NO
 ;;^DIST(.404,.00115,40,4,0)
 ;;=5^EXPLANATION OF SCREEN^2
 ;;^DIST(.404,.00115,40,4,2)
 ;;=6,24^45^6,1
 ;;^DIST(.404,.00115,40,4,20)
 ;;=F^^1:240
 ;;^DIST(.404,.00115,40,5,0)
 ;;=2^PREFIX^2
 ;;^DIST(.404,.00115,40,5,2)
 ;;=3,9^10^3,1
 ;;^DIST(.404,.00115,40,5,4)
 ;;=0
 ;;^DIST(.404,.00115,40,5,20)
 ;;=F^^1:10
 ;;^DIST(.404,.00115,40,5,22)
 ;;=I X["." K X
 ;;^DIST(.404,.00115,40,6,0)
 ;;=.5^^4
 ;;^DIST(.404,.00115,40,6,2)
 ;;=1,20^30
 ;;^DIST(.404,.00115,40,6,30)
 ;;=S Y="VARIABLE-POINTER #"_$G(DICATTVP)
 ;;^DIST(.404,.00116,0)
 ;;=DICATT MUL^1
 ;;^DIST(.404,.00116,40,0)
 ;;=^.4044I^7^7
 ;;^DIST(.404,.00116,40,1,0)
 ;;=1^MULTIPLE-FIELD LABEL^2^^MULTIPLE LABEL
 ;;^DIST(.404,.00116,40,1,2)
 ;;=3,23^30^3,1
 ;;^DIST(.404,.00116,40,1,3)
 ;;=!M
 ;;^DIST(.404,.00116,40,1,3.1)
 ;;=S Y=$P($G(^DD(DICATTA,DICATTF,0)),U)
 ;;^DIST(.404,.00116,40,1,10)
 ;;=I X="" S DDSSTACK=9
 ;;^DIST(.404,.00116,40,1,20)
 ;;=DD^^0,.01
 ;;^DIST(.404,.00116,40,2,0)
 ;;=5^READ ACCESS^2^^MULTIPLE READ ACCESS
 ;;^DIST(.404,.00116,40,2,2)
 ;;=4,23^13^4,10
 ;;^DIST(.404,.00116,40,2,3)
 ;;=!M
 ;;^DIST(.404,.00116,40,2,3.1)
 ;;=S Y=$G(^DD(DICATTA,DICATTF,8))
 ;;^DIST(.404,.00116,40,2,11)
 ;;=I $G(DICATTDK) S DDACT="EX"
 ;;^DIST(.404,.00116,40,2,20)
 ;;=DD^^0,8
 ;;^DIST(.404,.00116,40,3,0)
 ;;=7^WRITE ACCESS^2^^MULTIPLE WRITE ACCESS
 ;;^DIST(.404,.00116,40,3,2)
 ;;=5,23^13^5,9
 ;;^DIST(.404,.00116,40,3,3)
 ;;=!M
 ;;^DIST(.404,.00116,40,3,3.1)
 ;;=S Y=$G(^DD(DICATTA,DICATTF,9))
 ;;^DIST(.404,.00116,40,3,20)
 ;;=DD^^0,9
 ;;^DIST(.404,.00116,40,4,0)
 ;;=8^SOURCE^2^^MULTIPLE SOURCE
 ;;^DIST(.404,.00116,40,6,0)
 ;;=11^DESCRIPTION...^2
 ;;^DIST(.404,.00116,40,6,2)
 ;;=7,17^1^7,2^1
 ;;^DIST(.404,.00116,40,6,10)
 ;;=S DDSSTACK=1.1
 ;;^DIST(.404,.00116,40,6,20)
 ;;=F^^1:1
 ;;^DIST(.404,.00116,40,7,0)
 ;;=12^TECHNICAL DESCRIPTION...^2
 ;;^DIST(.404,.00116,40,7,2)
 ;;=7,49^1^7,24^1
 ;;^DIST(.404,.00116,40,7,10)
 ;;=S DDSSTACK=1.2
 ;;^DIST(.404,.00116,40,7,20)
 ;;=F^^1:1
