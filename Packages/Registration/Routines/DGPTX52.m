DGPTX52 ; ;01/08/16
 S X=DE(62),DIC=DIE
 K ^DGPT(DA(1),"M","AC",$E(X,1,30),DA)
 S X=DE(62),DIC=DIE
 X "N X S X=""DGRUDD01"" X ^%ZOSF(""TEST"") Q:'$T  N DG1 S DG1=+$P(^DGPT(DA(1),0),""^"",1) D:(DG1>0) ADGRU^DGRUDD01(DG1)"
