ORD22 ; COMPILED XREF FOR FILE #100.001 ; 01/26/16
 ; 
 S DA(1)=DA S DA=0
A1 ;
 I $D(DIKILL) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^OR(100,DA(1),.1,DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^OR(100,DA(1),.1,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^OR(100,DA(1),.1,"B",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D OI2^ORDD100A(DA(1))
 G:'$D(DIKLM) A Q:$D(DIKILL)
END G ^ORD23
