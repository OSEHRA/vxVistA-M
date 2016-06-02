ORMTIM01 ; SLC-ISC/RJS - PROCESS TIME BASED EVENT ;2/01/00  10:30 [8/3/05 7:19am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**31,40,190,232**;Dec 17, 1997;Build 164
 ;
SCAN ;
 S OCXORMTR="ORMTIME: scan"
 N OCXNOW,OCXDATE,OCXTMT,OCXORD S OCXNOW=$$IDATE("NOW"),OCXTMT=$$IDATE("N+1H")
 ;
 ;  Expire orders
 ;
 S OCXORMTR="ORMTIME: scan expiring orders"
 S OCXDATE=0 F  S OCXDATE=$O(^OR(100,"AE",OCXDATE)) Q:'OCXDATE  I '((+OCXDATE)>OCXNOW) D
 .;DSS/Con- BEGIN MODS - Check whether order is exempt from expiring
 .S OCXORD=0 F  S OCXORD=$O(^OR(100,"AE",OCXDATE,OCXORD)) Q:'OCXORD  Q:$$VFD  D
 ..;DSS/Con - END MODS
 ..D EXP^OCXOTIME(OCXDATE,OCXORD)
 ..I $G(^OR(100,"AE",OCXDATE,OCXORD)),(^OR(100,"AE",OCXDATE,OCXORD)>OCXNOW) Q
 ..S ^OR(100,"AE",OCXDATE,OCXORD)=OCXTMT
 ..N OCXORMTR S OCXORMTR=" Executing: D EXP^ORMEVNT("_OCXORD_","_OCXDATE_")"
 ..D EXP^ORB3F1(OCXDATE,OCXORD)
 ..D EXP^ORMEVNT(OCXORD,OCXDATE)
 ..S:$D(^OR(100,"AE",OCXDATE,OCXORD)) ^OR(100,"AE",OCXDATE,OCXORD)=""
 D DELEXP^ORB3F1  ;delete old expired orders from ^XTMP("ORAE"
 ;
 ;  Activate orders
 ;
 S OCXORMTR="ORMTIME: scan activating orders"
 S OCXDATE=0 F  S OCXDATE=$O(^OR(100,"AD",OCXDATE)) Q:'OCXDATE  I '((+OCXDATE)>OCXNOW) D
 .S OCXORD=0 F  S OCXORD=$O(^OR(100,"AD",OCXDATE,OCXORD)) Q:'OCXORD  D
 ..D ACT^OCXOTIME(OCXDATE,OCXORD)
 ..I $G(^OR(100,"AD",OCXDATE,OCXORD)),(^OR(100,"AD",OCXDATE,OCXORD)>OCXNOW) Q
 ..S ^OR(100,"AD",OCXDATE,OCXORD)=OCXTMT
 ..N OCXORMTR S OCXORMTR=" Executing: D ACTIVE^ORMEVNT("_OCXORD_","_OCXDATE_")"
 ..D ACTIVE^ORMEVNT(OCXORD,OCXDATE)
 ..S:$D(^OR(100,"AD",OCXDATE,OCXORD)) ^OR(100,"AD",OCXDATE,OCXORD)=""
 ;
 ; Trigger Task/Time-driven Notifications
 ;
 S OCXORMTR=" Executing: D TNOTIFS^ORB3TIM1"
 D TNOTIFS^ORB3TIM1
 ;
 ;   Run Order Check Purges
 ;
 I $L($T(^OCXOPURG)) D
 .S OCXORMTR="ORMTIME: Run purge for order checking"
 .D EN^OCXOPURG
 ;
 ;   ^ORYX("ORERR" CPRS Errors Purge
 ;
 I $O(^ORYX("ORERR",0)) D
 .N %DT,ORD0,ORDATE,ORKILL,ORLIMIT,ORNODE,X,Y
 .;
 .S ORLIMIT=$$GET^XPAR("ALL","ORPF ERROR DAYS") S:(ORLIMIT<1) ORLIMIT=2
 .S X="TODAY-"_ORLIMIT,%DT="" D ^%DT S ORLIMIT=Y
 .;
 .I '$O(^ORYX("ORERR","B",0)) S ORD0=0 F  S ORD0=$O(^ORYX("ORERR",ORD0)) Q:'ORD0  D
 ..S ^ORYX("ORERR","B",+$G(^ORYX("ORERR",ORD0,0)),ORD0)=""
 .;
 .S ORDATE="" F  S ORDATE=$O(^ORYX("ORERR","B",ORDATE)) Q:'$L(ORDATE)  D
 ..S ORD0=0 F  S ORD0=$O(^ORYX("ORERR","B",ORDATE,ORD0)) Q:'ORD0  D
 ...S ORNODE=$G(^ORYX("ORERR",ORD0,0))
 ...I (+ORNODE<ORLIMIT) K ^ORYX("ORERR",ORD0) S ORKILL=1
 ..I (ORDATE<ORLIMIT) K ^ORYX("ORERR","B",ORDATE) S ORKILL=1
 .;
 .S ORLIMIT=10000 ; **NOTE**  This limit is on the number of entries in the CPRS error log
 .;
 .I $G(ORKILL)!($P(^ORYX("ORERR",0),U,4)>ORLIMIT) D
 ..N ORD0,ORD1,ORPREV,ORCNT
 ..S ORD0=0 F ORCNT=0:1 S ORPREV=ORD0,ORD0=$O(^ORYX("ORERR",ORD0)) Q:'ORD0
 ..S $P(^ORYX("ORERR",0),U,3,4)=ORPREV_U_ORCNT
 ..;
 ..S ORD0=0 F ORD1=ORLIMIT:1:ORCNT S ORPREV=ORD0,ORD0=$O(^ORYX("ORERR",ORD0)) Q:'ORD0  D
 ...S ORNODE=$G(^ORYX("ORERR",ORD0,0))
 ...K ^ORYX("ORERR",ORD0),^ORYX("ORERR","B",+ORNODE)
 ..S $P(^ORYX("ORERR",0),U,3,4)=ORPREV_U_ORLIMIT
 ;
 ;  Time Based Events for Order Checking
 ;
 I $L($T(^OCXOTIME)) D
 .S OCXORMTR="ORMTIME: scan time based events for order checking"
 .D EN^OCXOTIME
 ;
 S OCXORMTR="Finish Job #: "_$J_"  at: "_$$EDATE($$IDATE("N"))
 ;
 ;  Clean up cache of Remote Order Checking Data
 ;
 D CLEANUP^ORRDI2
 ;
 Q
 ;
EDATE(Y) X ^DD("DD") S:(Y["@") Y=$P(Y,"@",1)_" at "_$P(Y,"@",2) Q Y
 ;
IDATE(X) N %DT,Y S %DT="TF" D ^%DT Q Y
 ;
TIME(X) N M,H S M=$E(100+(X#60),2,3),H=$E(100+(X\60),2,3) Q H_M
 ;
VFD() ;DSS/Con - Is ORDER exempt from expiring?
 ; Context variable OCXORD  = ORDER IEN to check
 ; Context variable OCXDATE = STOP DATE
 ;
 ; Returns 1 (TRUE) if and only if this order is exempt
 ; Resets "AE" index value to the empty string
 ;
 N VFD S VFD=$P($G(^OR(100,OCXORD,0)),U,14) Q:'VFD 0  ;No PACKAGE
 I '$$GET^XPAR("SYS","VFD ORDERS DO NOT EXPIRE",VFD,"I") Q 0
 ; let inactive orders continue through ORMTIME unabated
 S VFD=+$$STATUS^ORQOR2(OCXORD) S:VFD="" VFD=99
 I "^1^2^7^11^12^13^14^15^"[(U_VFD_U) Q 0
 ;
 S ^OR(100,"AE",OCXDATE,OCXORD)=""
 Q 1
