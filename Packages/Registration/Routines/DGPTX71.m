DGPTX71 ; ;01/08/16
 S X=DE(56),DIC=DIE
 X "N DG1 S DG1=$P(^DGPT(DA,0),""^"",1) N X S X=""DGRUDD01"" X ^%ZOSF(""TEST"") Q:'$T  D:(+DG1>0) ADGRU^DGRUDD01(DG1)"
