DIQQQ ;SFISC/GFT,XAK-MORE HELP ;21FEB2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**144,999**
 ;
DICATT W !,"IF YOU WANT THE SAME ANSWER ALLOWED FOR ",F,!,"AS FOR " Q
 ;
DICATT1 W !,"ENTER GLOBAL SUBSCRIPT NAME AT WHICH ",F," WILL BE STORED"
 W !,"   ALREADY ASSIGNED: " S Y="",T=0 F  S Y=$O(^DD(A,"GL",Y)) Q:Y=""  W $J(Y,9) W:$X>66 !
 S Y=-1 G SUB^DICATT1
 ;
DIS ;
 D  W !! Q  ;**CCO/NI (next 8 lines) HELP FOR SEARCHING
 .N DIP
 .S DIP(1)=O(DC),DIP(2)=$P("NOT ",U,DN]"")_$P("^CONTAIN^MATCH^BE LESS THAN^EQUAL^EXCEED^FOLLOW",U,+DQ),DIP(3)=$C(DC+64)
 .D BLD^DIALOG(9079,.DIP),MSG^DIALOG("WH")
 .W:+DQ=3 !?8,"(I.E., ENTER WHAT WOULD FOLLOW THE MUMPS '?' OPERATOR)",!
 .I E["S" W !! D EN^DIQQ1(DK,DU,"?")
 ;
DISC ;
 D BLD^DIALOG(9075),MSG^DIALOG("WH") G C^DIS
 ;
DIP1 ;
 W $C(7) D BLD^DIALOG(8145),MSG^DIALOG("WE") G Q^DIP ;**CCO/NI 'YOU'VE ASKED FOR THE SAME SORT FIELD TWICE!'
 ;
DIP3 W !,$$EZBLD^DIALOG(9086) G ^DIP3
 ;
DIA ;
 W ! D BLD^DIALOG(9131),MSG^DIALOG("WH") ;**CCO/NI HELP FOR 'EDIT WHICH FIELD:'
 G 2^DIA
 ;
DIA3 ;
 W ! D BLD^DIALOG(8147),MSG^DIALOG("WE") W ! G 2^DIA ;**CCO/NI 'CAPTIONS CANNOT CONTAIN...'
 ;
DIP21 ;
 D BLD^DIALOG(9083),MSG^DIALOG("WH") ;**CCO/NI HELP FOR THE 'SUPPRESS SUBHEADERS?' QUERY
 G SUB^DIP21
 ;
DICOMPW W ! D BLD^DIALOG(9121,Y),MSG^DIALOG("WH") Q  ;**CCO/NI HELP FOR RELATIONAL-JUMP QUERY IN CREATING A COMPUTED EXPRESSION
 ;
XPDIP21 ;from XPUT^DIP21
 W !!,$C(7),"You must choose a template to store the fields selected for export."
 W !,"If you do not want to save the selections, use the '^'.",! Q
