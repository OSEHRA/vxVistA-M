ICDTBL3E ;ALB/JDG - GROUPER UTILITY FUNCTIONS;08/09/2010
 ;;18.0;DRG Grouper;**65,69,71,74**;Oct 20, 2000;Build 2
DRG300 ;
DRG301 S ICDRG=$S(ICDMCC=2:299,ICDMCC=1:300,1:301) Q
DRG302 ;
DRG303 S ICDRG=$S(ICDMCC=2:302,1:303) Q
DRG304 ;
DRG305 S ICDRG=$S(ICDMCC=2:304,1:305) Q
DRG306 ;
DRG307 S ICDRG=$S(ICDMCC=2:306,1:307) Q
DRG308 ;
DRG309 ;
DRG310 ;I (ICDDX(1)=2559!$D(ICDDXT("427.41"))),'ICDEXP S ICDMCC=2
 I (ICDDX(1)=2557&$D(ICDDXT("425.4"))) S ICDMCC=$S($D(ICDDXT("428.23")):2,($D(ICDDXT("276.2"))!$D(ICDDXT("584.9"))):1,1:0)
 I (ICDDX(1)=2558&$D(ICDDXT("425.4"))) S ICDMCC=$S($D(ICDDXT("428.23")):2,($D(ICDDXT("276.2"))!$D(ICDDXT("584.9"))):1,1:0)
 ;I ICDSD["V" S ICDMCC="0"
 S ICDRG=$S(ICDMCC=2:308,ICDMCC=1:309,1:310) Q
DRG311 S ICDRG=311 Q
DRG312 S ICDRG=312 Q
DRG313 S ICDRG=313 Q
DRG314 ;
DRG315 ;
DRG316 S ICDRG=$S(ICDMCC=2:314,ICDMCC=1:315,1:316) Q
DRG326 ;
DRG327 ;
DRG328 S ICDRG=$S(ICDMCC=2:326,ICDMCC=1:327,1:328) Q
DRG329 ;
DRG330 ;
DRG331 I ICDDX(1)=11611,$D(ICDDXT("427.5")),ICDMCC=2,ICDEXP=1 S ICDMCC=1
 S ICDRG=$S(ICDMCC=2:329,ICDMCC=1:330,1:331) Q
DRG332 ;
DRG333 ;
DRG334 S ICDRG=$S(ICDMCC=2:332,ICDMCC=1:333,1:334) Q
DRG335 ;
DRG336 ;
DRG337 S ICDRG=$S(ICDMCC=2:335,ICDMCC=1:336,1:337) Q
DRG338 ;
DRG339 ;
DRG340 I " 246 9197 2954 "'[ICDDX(1) W !,"DRG340" D DRG343 Q
       S ICDRG=$S(ICDMCC=2:338,ICDMCC=1:339,1:340) Q
DRG341 ;
DRG342 ;
DRG343 I ICDOR="" D DRG374 Q
       I " 246 9197 2954 "[ICDDX(1) W !,"DRG343",ICDDX(1) D DRG340 Q
       I ICDOR["a" D DRG727^ICDTBL7E Q
       S ICDRG=$S(ICDMCC=2:341,ICDMCC=1:342,1:343) Q
DRG344 ;
DRG345 ;
DRG346 S ICDRG=$S(ICDMCC=2:344,ICDMCC=1:345,1:346) Q
DRG347 ;
DRG348 ;
DRG349 S ICDRG=$S(ICDMCC=2:347,ICDMCC=1:348,1:349) Q
DRG350 ;
DRG351 ;
DRG352 I ICDOR["J" S ICDRG=$S(ICDMCC=2:350,ICDMCC=1:351,1:352) Q
DRG353 ;
DRG354 ;
DRG355 S ICDRG=$S(ICDMCC=2:353,ICDMCC=1:354,1:355) Q
DRG356 ;
DRG357 ;
DRG358 S ICDRG=$S(ICDMCC=2:356,ICDMCC=1:357,1:358) Q
DRG368 ;
DRG369 ;
DRG370 S ICDRG=$S(ICDMCC=2:368,ICDMCC=1:369,1:370) Q
DRG371 ;
DRG372 ;
DRG373 I ICDDX(1)=12671,$D(ICDDXT("785.59")),ICDEXP=1,ICDMCC=2 S ICDMCC=1
 S ICDRG=$S(ICDMCC=2:371,ICDMCC=1:372,1:373) Q
DRG374 ;
DRG375 ;
DRG376 S ICDRG=$S(ICDMCC=2:374,ICDMCC=1:375,1:376) Q
DRG377 ;
DRG378 ;
DRG379 S ICDRG=$S(ICDMCC=2:377,ICDMCC=1:378,1:379) Q
DRG380 ;
DRG381 ;
DRG382 S ICDRG=$S(ICDMCC=2:380,ICDMCC=1:381,1:382) Q
DRG383 ;
DRG384 S ICDRG=$S(ICDMCC=2:383,1:384) Q
DRG385 ;
DRG386 ;
DRG387 S ICDRG=$S(ICDMCC=2:385,ICDMCC=1:386,1:387) Q
DRG388 ;
DRG389 ;
DRG390 S ICDRG=$S(ICDMCC=2:388,ICDMCC=1:389,1:390) Q
DRG391 ;
DRG392 I $D(ICDDXT("799.1")),ICDEXP=1,ICDMCC=2 S ICDRG=392 Q
 S ICDRG=$S(ICDMCC=2:391,1:392) Q
DRG393 ;
DRG394 ;
DRG395 I ICDOR["J" D DRG350 Q
    S ICDRG=$S(ICDMCC=2:393,ICDMCC=1:394,1:395) Q
 Q
