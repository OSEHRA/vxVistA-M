SCRPW57 ;RENO/KEITH - Most Frequent 50 ICD Diagnosis Codes (OP7) or (IP7) ;5/6/03 1:18pm
 ;;5.3;Scheduling;**144,295,466,593**;AUG 13, 1993;Build 13
 S SDSTA=$G(SDSTA,2)
 D RQUE^SCRPW50("START^SCRPW57","Most Frequent 50 ICD Diagnosis Codes "_$S(SDSTA=2:"(OP7)",1:"(IP7)"),1) Q
 ;
START ;Print report
 K ^TMP("SCRPW",$J) S (SDSTOP,SDOUT)=0,SDT=SD("FYD")
 F  S SDT=$O(^SCE("B",SDT)) Q:'SDT!SDOUT!(SDT>SD("EDT"))  S SDOE=0 F  S SDOE=$O(^SCE("B",SDT,SDOE)) Q:'SDOE!SDOUT  S SDOE0=$$GETOE^SDOE(SDOE),SDIV=$P(SDOE0,U,11) I $$VALID() D SET(SDIV) D:SDMD SET(0)
 G:SDOUT EXIT S (SDVCT,SDIV)=""
 F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:SDIV=""  D STOP,DLIST Q:SDOUT  D
 .S DFN=0 F  S DFN=$O(^TMP("SCRPW",$J,SDIV,0,"LIST",DFN)) Q:'DFN  D
 ..S SDDX=0 F  S SDDX=$O(^TMP("SCRPW",$J,SDIV,0,"LIST",DFN,SDDX)) Q:'SDDX  S SDPT="" F  S SDPT=$O(^TMP("SCRPW",$J,SDIV,0,"LIST",DFN,SDDX,SDPT)) Q:SDPT=""  D
 ...S $P(^TMP("SCRPW",$J,SDIV,0,SDDX,SDPT),U,2)=$P($G(^TMP("SCRPW",$J,SDIV,0,SDDX,SDPT)),U,2)+1
 ...S:$D(^TMP("SCRPW",$J,SDIV,0,"LIST",DFN,SDDX,SDPT,"P")) $P(^TMP("SCRPW",$J,SDIV,0,SDDX,SDPT),U)=$P($G(^TMP("SCRPW",$J,SDIV,0,SDDX,SDPT)),U)+1
 ...Q
 ..Q
 .S SDDX=0 F  S SDDX=$O(^TMP("SCRPW",$J,SDIV,0,SDDX)) Q:'SDDX  S SDI=^TMP("SCRPW",$J,SDIV,0,SDDX),^TMP("SCRPW",$J,SDIV,1,SDI,SDDX)=""
 .Q
 G:SDOUT EXIT S SDLINE="",$P(SDLINE,"-",(IOM+1))="" D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDTIT(1)="<*>  MOST FREQUENT 50 ICD DIAGNOSIS CODES "_$S(SDSTA=2:"(OP7)",1:"(IP7)")_"  <*>",SDPG=0 D:$E(IOST)="C" DISP0^SCRPW23
 I '$D(^TMP("SCRPW",$J)) S SDPAGE=1,SDX="No activity found within report parameters." D HDR G:SDOUT EXIT W !!?(IOM-$L(SDX)\2),SDX G EXIT
 G:SDOUT EXIT S SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""!SDOUT  D DPRT(SDIV(SDIVN))
 G:SDOUT EXIT D:SDVCT>1 DPRT(0)
EXIT I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
 K ^TMP("SCRPW",$J),%,%H,%I,DIR,DFN,SD,SDDX,SDDXP,SDDIV,SDFL,SDI,SDII,SDIII,SDIV,SDIVN,SDLINE,SDMD,SDOE,SDOE0,SDOUT,SDPAGE,SDPG,SDPNOW,SDDIAG,SDPRTY,SDPT,SDPTN,SDPTV,SDSTOP,SDT,SDTIT,SDV,SDVCT,SDX,X,Y,SDSTA Q
 ;
DPRT(SDV) ;Print division
 ;Required input: SDV=division ifn or '0' for combined divisions
 I SDV S SDTIT(2)="For "_$S(SDDIV["DIVISIONS":"division",1:"facility")_": "_SDIVN
 I 'SDV S SDTIT(2)="Report for: "_$P(SDDIV,U,2) D
 .S SDI=2,SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""  S SDI=SDI+1,SDTIT(SDI)=$J("Division: ",$L(SDIVN))_SDIVN
 .Q
 S SDPAGE=1 D HDR Q:SDOUT  S (SDI,SDII)="" F  S SDI=$O(^TMP("SCRPW",$J,SDV,1,SDI),-1) Q:SDI=""!SDOUT!(SDII>49)  S SDDX="" F  S SDDX=$O(^TMP("SCRPW",$J,SDV,1,SDI,SDDX)) Q:SDDX=""!SDOUT!(SDII>49)  D PLINE
 Q
 ;
PLINE ;Print output line
 N DIWL,DIWF,SDL2 S DIWL=1 S DIWF="C38|"
 D:$Y>(IOSL-8) HDR Q:SDOUT  D HD1
 S SDDIAG=$$ICDDX^SCRPWICD(SDDX),SDDIAG=$P(SDDIAG,U,2)_"  "_$P(SDDIAG,U,4),SDII=SDII+1
 K ^UTILITY($J,"W") S X=SDDIAG D ^DIWP
 F SDL2=1:1:^UTILITY($J,"W",DIWL) D
 .I SDL2=1 W !,$J(SDII,3),?6,$E(^UTILITY($J,"W",DIWL,SDL2,0),1,38) I 1
 .E  W !,?6,$E(^UTILITY($J,"W",DIWL,SDL2,0),1,38)
 D  W !
 .S (SDFL,SDPT)="" F  S SDPT=$O(^TMP("SCRPW",$J,SDV,0,SDDX,SDPT)) Q:SDPT=""!SDOUT  D
 ..I $Y>(IOSL-3) D HDR,HD1 Q:SDOUT  S SDFL=1
 ..S SDPTV=^TMP("SCRPW",$J,SDV,0,SDDX,SDPT)
 ..S SDPTN=$$CODE2TXT^XUA4A72(SDPT),SDPTN=$P(SDPT,"V",2)_"  "_$P(SDPTN,U,2)
 ..W:SDFL ! W ?46,$E(SDPTN,1,38) D  S SDFL=SDFL+1
 ...F SDIII=1:1:4 W ?(86+(12*(SDIII-1))),$J($P(SDPTV,U,SDIII),10,0)
 ..Q
 .Q
 Q
 ;
HDR ;Print header
 I $E(IOST)="C",SDPG N DIR S DIR(0)="E" W ! D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP Q:SDOUT  W:SDPG!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0)
 N SDI S SDI=0 W SDLINE F  S SDI=$O(SDTIT(SDI)) Q:'SDI  W !?(IOM-$L(SDTIT(SDI))\2),SDTIT(SDI)
 W !,SDLINE,!,"For Fiscal Year activity through ",SD("PEDT"),!,"Date printed: ",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1,SDPG=1 Q
 ;
HD1 ;Print subheader
 Q:SDOUT  W !?87,"Prim. Dx.",?103,"Total",?111,"Prim. Dx.",?127,"Total",!,"Rank  ICD Diagnosis code",?48,"Provider Type",?89,"Uniques",?101,"Uniques",?110,"Encounters",?122,"Encounters"
 N SDI W !,"----",?6,$E(SDLINE,1,38),?46,$E(SDLINE,1,38) F SDI=0:1:3 W ?(86+(12*SDI)),$E(SDLINE,1,10)
 Q
 ;
DLIST ;Create alphabetic list of divisions found
 Q:'SDIV  S SDX=$P($G(^DG(40.8,SDIV,0)),U) S:'$L(SDX) SDX="*** UNKNOWN ***" S SDIV(SDX)=SDIV,SDVCT=SDVCT+1 Q
 ;
VALID() ;Check encounter record
 Q 1
 I $P(SDOE0,U,4),$P($G(^SC($P(SDOE0,U,4),0)),U,17)="Y" Q 0
 I SDIV,$$DIV(),$P(SDOE0,U,2),'$P(SDOE0,U,6),$P(SDOE0,U,7),$P(SDOE0,U,12)=SDSTA Q 1
 Q 0
 ;
DIV() ;Check division
 Q:'SDDIV 1  Q $D(SDDIV(SDIV))
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
SET(SDIV) ;Set division lists
 ;Required input: SDIV=division ifn or '0' for summary
 S SDSTOP=SDSTOP+1 I SDSTOP#2000=0 D STOP^SCRPW40 Q:SDOUT
 N SDDIAG,SDPRTY,SDI,SDII,SDIII,SDX S DFN=$P(SDOE0,U,2)
 D GETDX^SDOE(SDOE,"SDDIAG"),PROV^SCRPW50(SDOE,.SDPRTY)
 S SDI=0 F  S SDI=$O(SDDIAG(SDI)) Q:'SDI  S SDDX=$P(SDDIAG(SDI),U),SDDXP=$S($P(SDDIAG(SDI),U,12)="P":"P",1:"S") I SDDX D
 .S ^TMP("SCRPW",$J,SDIV,0,SDDX)=$G(^TMP("SCRPW",$J,SDIV,0,SDDX))+1
 .S SDII=0 F  S SDII=$O(SDPRTY(SDII)) Q:'SDII  S SDX=SDPRTY(SDII) I $L(SDX) D
 ..S $P(^TMP("SCRPW",$J,SDIV,0,SDDX,SDX),U,4)=$P($G(^TMP("SCRPW",$J,SDIV,0,SDDX,SDX)),U,4)+1 D
 ...S:SDDXP="P" $P(^TMP("SCRPW",$J,SDIV,0,SDDX,SDX),U,3)=$P($G(^TMP("SCRPW",$J,SDIV,0,SDDX,SDX)),U,3)+1
 ...S ^TMP("SCRPW",$J,SDIV,0,"LIST",DFN,SDDX,SDX,SDDXP)=""
 ...Q
 ..Q
 .Q
 Q
 ;
