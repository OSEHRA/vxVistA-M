FHSELA2 ;Hines OIFO/RTK - Map GMR Allergy file to Food Prefs ;3/07/2007
 ;;5.5;DIETETICS;**8,13,23,25,28,35,37**;Jan 28, 2005;Build 2
 ;
 ;10/9/2009 SLC/GDU FH*5.5*23
 ;  Remedy 317642 FGH - patient food allergy not mapping to N&FS food preferences
 ;  Adding the following food allergies:
 ;  Arugula, Capers, Curry, Gooseberries, Meat Tenderizer, Olestra, Orange Dye
 ;  Pomegranates, Pudding, Saffron, Stevia, Water Chestnuts
 ;
 ;6/22/2011 SLC/GDU FH*5.5*28
 ;  Remedy 490577 - Need N&FS patch to add OCTOPUS, KIDNEY BEANS as food allergies
 ;  Adding the following food allergies: Kidney Beans, Octopus
 ;3/5/2013 SLC/GDU FH*5.5*35
 ;  Remedy 742739 - FGH - SAGE FOOD ALLERGY
 ;  Adding the following food allergy: Sage
 ;9/13/2013 SLC/GDU FH*5.5*37
 ;  Remedy 905481 - PSPO 1380 changes needed due to NTRT
 ;  Adding the following food allergies: 
 ;  Margarine, Raw Onions, Raw Vegetables, Turmeric, Canola Oil, Erythritol,
 ;  Kale, Agave, Hemp Milk, Taro Root
TMPGL ; Create ^TMP Global
 K ^TMP($J,"FHALG") S FHK=0
 F  S FHK=FHK+1,FHFPS=$T(FPS+FHK),FHZ1=$P(FHFPS,";",3) Q:FHZ1=""  D
 .S ^TMP($J,"FHALG",FHZ1)=$P(FHFPS,";",3,99)
EXIT K FHK,FHFPS,FHZ1
 Q
FPS ;;
 ;;ALCOHOL;ALCOHOL
 ;;ALCOHOL, BEER;HOPS
 ;;ALCOHOL, GIN;GIN
 ;;ALCOHOL, RUM;RUM
 ;;ALCOHOL, SCOTCH;SCOTCH
 ;;ALCOHOL, TEQUILA;TEQUILA
 ;;ALCOHOL, VODKA;VODKA
 ;;ALCOHOL, WINE;WINE
 ;;ALCOHOL, WINE, WHITE;WHITE WINE
 ;;ALFALFA SPROUTS;ALFALFA SPROUTS
 ;;ALMONDS;ALMONDS
 ;;ANISE OIL;ANISE OIL
 ;;APPLES;APPLE JUICE;APPLES
 ;;APRICOTS;APRICOTS
 ;;ARTICHOKES;ARTICHOKES
 ;;ARTIFICIAL COLORS;ARTIFICIAL COLORS;BLACK DYES;BLUE DYES;FD&C BLUE DYE #2;FD&C GREEN DYE #6;GREEN DYES;PINK DYES;PURPLE DYES
 ;;ASPARAGUS;ASPARAGUS
 ;;AVOCADOS;AVOCADOS
 ;;BACON;BACON
 ;;BANANAS;BANANAS
 ;;BARBEQUE SAUCE;BARBEQUE SAUCE;BARBECUE SAUCE
 ;;BARLEY;BARLEY;MALT BARLEY
 ;;BASIL;BASIL
 ;;BEANS;BEANS;LEGUMES
 ;;BEANS, BAKED;BAKED BEANS
 ;;BEANS, FAVA;FAVA BEANS (BROAD BEANS)
 ;;BEANS, GREEN;GREEN BEANS
 ;;BEANS, LENTILS;LENTILS
 ;;BEANS, LIMA;LIMA BEANS
 ;;BEANS, PINTO;PINTO BEANS
 ;;BEANS, SOY;SOYBEANS
 ;;BEANS, STRING;STRING BEANS
 ;;BEANS, WHITE;WHITE BEANS
 ;;BEEF;BEEF;BEEF PRODUCTS
 ;;BEEF, CORNED;CORNED BEEF
 ;;BEETS;BEETS
 ;;BEETS, PICKLES;PICKLED BEETS
 ;;BERRIES;BERRIES
 ;;BLACKBERRIES;BLACKBERRIES
 ;;BLUEBERRIES;BLUEBERRIES
 ;;BROCCOLI;BROCCOLI
 ;;BRUSSELS SPROUTS;BRUSSELS SPROUTS
 ;;BUCKWHEAT;BUCKWHEAT
 ;;BUTTER;BUTTER
 ;;CABBAGE;CABBAGE
 ;;CAFFEINE;CAFFEINE;COFFEE;COFFEE BEANS
 ;;CAFFEINE, COLAS;COLA DRINKS
 ;;CANTALOUPE;CANTALOUPE
 ;;CARBONATED BEVERAGES;CARBONATED BEVERAGES;SOFT DRINKS
 ;;CARROTS;CARROTS
 ;;CATSUP;CATSUP
 ;;CAULIFLOWER;CAULIFLOWER
 ;;CAVIAR;CAVIAR
 ;;CELERY;CELERY
 ;;CEREAL;CEREALS
 ;;CEREAL, CORNFLAKES;CORNFLAKES
 ;;CEREAL, CRM OF WHEAT;CREAM OF WHEAT
 ;;CEREAL, GRITS;GRITS
 ;;CEREAL, OATMEAL;OATMEAL
 ;;CHEESE;CHEESE
 ;;CHEESE, BLUE;BLUE CHEESE
 ;;CHEESE, CHEDDAR;CHEDDAR CHEESE
 ;;CHEESE, COTTAGE;COTTAGE CHEESE
 ;;CHEESE, FETA;FETA CHEESE
 ;;CHEESE, GOAT;GOAT CHEESE
 ;;CHEESE, PARMESAN;PARMESAN CHEESE
 ;;CHEESE, RICOTTA;RICOTTA CHEESE
 ;;CHEESE, SWISS;SWISS CHEESE
 ;;CHERRIES;CHERRIES;CHERRY JUICE
 ;;CHICKEN;CHICKEN
 ;;CHICKPEAS;CHICKPEAS
 ;;CHICORY;CHICORY
 ;;CHILI;CHILI
 ;;CHIVES;CHIVES
 ;;CHOCOLATE;CHOCOLATE;COCOA
 ;;CILANTRO;CILANTRO;CUMIN
 ;;CINNAMON;CINNAMON;CINNAMON OIL
 ;;CITRUS;CITRUS;CITRUS FRUIT;CITRUS JUICE
 ;;CLOVES;CLOVES
 ;;COCONUT;COCONUTS
 ;;COLA;COLA DRINKS
 ;;CORN;CORN
 ;;CRACKERS;CRACKERS
 ;;CRACKERS, GRAHAM;GRAHAM CRACKERS
 ;;CRANBERRIES;CRANBERRIES
 ;;CREAM, SOUR;SOUR CREAM
 ;;CREAMER, NON-DAIRY;NON-DAIRY CREAMER
 ;;CREAMER, POWDER;POWDERED CREAMER
 ;;CUCUMBERS;CUCUMBERS
 ;;DAIRY PRODUCTS;DAIRY PRODUCTS
 ;;DATES;DATES
 ;;DILL;DILL
 ;;DUCK;DUCK;WATERFOWL
 ;;DYES, VEGETABLES;VEGETABLE DYES
 ;;EGGNOG;EGGNOG
 ;;EGGPLANT;EGGPLANT
 ;;EGGS;EGGS;EGG PRODUCTS;EGG WHITES;EGG YOLKS
 ;;EGGS, SUBSTITUTES;EGG, SUBSTITUTES;EGG SUBSTITUTES
 ;;FAT EMULSIONS;FAT EMULSIONS
 ;;FIGS;FIGS
 ;;FISH;FISH
 ;;FISH, ABALONE;ABALONE
 ;;FISH, ANCHOVIES;ANCHOVIES
 ;;FISH, CATFISH;CATFISH
 ;;FISH, COD;CODFISH
 ;;FISH, FLOUNDER;FLOUNDER
 ;;FISH, HERRING;HERRING
 ;;FISH, MACKEREL;MACKEREL
 ;;FISH, PERCH;PERCH
 ;;FISH, RED SNAPPER;RED SNAPPER
 ;;FISH, SALMON;SALMON
 ;;FISH, SARDINES;SARDINES
 ;;FISH, SHARK;SHARK
 ;;FISH, SWORDFISH;SWORDFISH
 ;;FISH, TROUT;TROUT
 ;;FISH, TUNA;TUNA
 ;;FISH, WHITE;WHITE FISH
 ;;FLAVORING, HICKORY;HICKORY
 ;;FLAVORING, LICORICE;LICORICE
 ;;FLAVORING, VANILLA;VANILLA
 ;;FOOD PRESERVATIVES;FOOD PRESERVATIVES
 ;;FRUIT, FRESH;FRESH FRUIT
 ;;FROG;FROG LEGS;FROGS
 ;;FRUIT;FRUIT
 ;;FRUIT JUICE;FRUIT JUICE
 ;;FRUITCAKES;FRUITCAKES
 ;;GARLIC;GARLIC
 ;;GELATIN;GELATIN
 ;;GINGER;GINGER
 ;;GLUTEN;GLUTENS
 ;;GRAINS;GRAINS
 ;;GRAPEFRUIT;GRAPEFRUIT
 ;;GRAPES;GRAPES
 ;;GRAVY;GRAVY
 ;;GREENS, COLLARD;COLLARD GREENS
 ;;GREENS, MUSTARD;MUSTARD GREENS
 ;;GREENS, TURNIP;TURNIP GREENS
 ;;GREEN LEAFY VEG;GREEN LEAFY VEGETABLES
 ;;GUAVA;GUAVA
 ;;HOMINY;HOMINY
 ;;HONEY;HONEY
 ;;HONEYDEW;HONEYDEW
 ;;HORSERADISH;HORSERADISH
 ;;IODINE;IODIZED SALT
 ;;JUICE;JUICE
 ;;KIWI;KIWI FRUIT
 ;;LACTOSE;LACTOSE
 ;;LEEKS;LEEKS
 ;;LEMON;LEMON JUICE;LEMONS
 ;;LETTUCE;LETTUCE
 ;;LIMES;LIMES
 ;;LYCHEE NUTS;LYCHEES
 ;;MALTOSE;MALTOSE
 ;;MANGOS;MANGOS
 ;;MARSHMALLOWS;MARSHMALLOWS
 ;;MAYONNAISE;MAYONNAISE
 ;;MEAT;MEAT
 ;;MEAT, LAMB;LAMB
 ;;MEAT, LIVER;LIVER
 ;;MEAT, PROCESSED;PROCESSED MEATS
 ;;MEAT, RED;RED MEAT
 ;;MEAT, VENISON;VENISON
 ;;MELONS;MELONS
 ;;MELONS, MUSK;MUSK MELONS
 ;;MELONS, WATER;WATERMELONS
 ;;MILK;MILK;DAIRY PRODUCTS
 ;;MILK, BUTTER;BUTTERMILK
 ;;MILK, GOAT;GOAT MILK
 ;;MILK, YOGURT;YOGURT
 ;;MINT;MINT
 ;;MODIFIED FOOD STARCH;MODIFIED FOOD STARCH;FOOD STARCH, MODIFIED
 ;;MSG;MONOSODIUM GLUTAMATE
 ;;MUSHROOMS;MUSHROOMS
 ;;MUSTARD;MUSTARD
 ;;MUTTON/LAMB;MUTTON
 ;;NECTARINES;NECTARINES
 ;;NITRITES;NITRITES
 ;;NON-FOOD RELATED;EGGSHELLS
 ;;NUTMEG;NUTMEG
 ;;NUTS;BRAZIL NUTS;CASHEWS;CHESTNUTS;HAZELNUTS;MACADAMIA NUTS;NUTS;PECANS
 ;;NUTS, PEANUT;PEANUT BUTTER;PEANUT OIL;PEANUTS
 ;;NUTS, PINE;PINE NUTS
 ;;NUTS, PISTACHIOS;PISTACHIOS
 ;;NUTS, TREE;PECANS;TREE NUTS
 ;;NUTS, WALNUT;WALNUTS
 ;;OATS;OATS
 ;;OIL, COCONUT;COCONUT OIL
 ;;OIL, COTTONSEED;COTTONSEED OIL
 ;;OIL, PALM;PALM OIL
 ;;OIL, SAFFLOWER;SAFFLOWER OIL
 ;;OIL, SOY;SOYBEAN OIL
 ;;OIL, SUNFLOWER;SUNFLOWER OIL
 ;;OKRA;OKRA
 ;;OLIVES;BLACK OLIVES;OLIVES
 ;;ONIONS;ONIONS
 ;;ONIONS, RED;RED ONIONS
 ;;ORANGE;ORANGE;ORANGES;ORANGE JUICE;ORANGE OIL
 ;;OREGANO;OREGANO
 ;;OYSTERS;OYSTERS
 ;;PAPAYAS;PAPAYAS
 ;;PAPRIKA;PAPRIKA
 ;;PARSLEY;PARSLEY
 ;;PARSNIP;PARSNIP
 ;;PASSION FRUIT;PASSION FRUIT
 ;;PEACHES;PEACHES
 ;;PEARS;PEARS
 ;;PEAS;PEAS
 ;;PEAS, BLACK-EYED;BLACK-EYED PEAS
 ;;PEAS, ENGLISH;ENGLISH PEAS
 ;;PEAS, SNOW;SNOW PEAS
 ;;PEPPER;PEPPER;WHITE PEPPER
 ;;PEPPER, BLACK;BLACK PEPPER;PEPPER
 ;;PEPPERMINT;PEPPERMINT
 ;;PEPPERONI;PEPPERONI
 ;;PEPPERS;BELL PEPPERS;PEPPERS
 ;;PEPPERS, CHILI;CHILI PEPPER;CHILI PEPPERS
 ;;PEPPERS, GREEN;GREEN BELL PEPPERS;PEPPERS
 ;;PEPPERS, HOT;CAPSAICIN;CAYENNE PEPPER;HOT PEPPER;HOT PEPPERS;JALAPENO PEPPERS
 ;;PEPPERS, RED;RED BELL PEPPERS
 ;;PERSIMMONS;PERSIMMONS
 ;;PHEASANT;PHEASANT
 ;;PICKLES;PICKLES
 ;;PIMENTOS;PIMENTOS
 ;;PINEAPPLE;PINEAPPLES
 ;;PIZZA;PIZZA
 ;;PLUMS;PLUMS
 ;;POPCORN;POPCORN
 ;;POPPY SEEDS;POPPY SEEDS
 ;;PORK;PORK;PORK PRODUCTS;HAM
 ;;PORK, HAM;HAM
 ;;POTATOES;POTATOES
 ;;POTATOES, SALAD;POTATO SALAD
 ;;POTATOES, SWEET/YAMS;SWEET POTATOES;YAMS
 ;;POULTRY;FOWL;POULTRY
 ;;PRUNES;PRUNES
 ;;PUDDING, TAPIOCA;TAPIOCA PUDDING
 ;;PUMPKIN;PUMPKINS
 ;;RABBIT;RABBIT
 ;;RADISH;RADISHES
 ;;RAISINS;RAISINS
 ;;RASPBERRIES;RASPBERRIES
 ;;RED DYES;FD&C RED DYE #1;FD&C RED DYE #2;FD&C RED DYE #3;FD&C RED DYE #40;FD&C RED DYE #40 LAKE;FD&C RED DYE #5;RED DYES
 ;;RHUBARB;RHUBARB
 ;;RICE;RICE;WHITE RICE
 ;;ROSEMARY;ROSEMARY
 ;;RUTABAGAS;RUTABAGAS
 ;;RYE;RYE
 ;;SALAD DRESSING, ITAL;ITALIAN DRESSING
 ;;SALT;NON-IODIZED SALT;SALT
 ;;SALT, SUBSTITUTES;SALT SUBSTITUTES
 ;;SAUERKRAUT;SAUERKRAUT
 ;;SAUSAGES;SAUSAGES
 ;;SEAFOOD;SEAFOOD
 ;;SEEDS;SEEDS
 ;;SEEDS, SUNFLOWER;SUNFLOWER SEEDS
 ;;SESAME;SESAME;SESAME OIL;SESAME SEEDS
 ;;SHELLFISH;CLAMS;CRAB;CRAWFISH;CRUSTACEANS;LOBSTER;MUSSELS;SCALLOPS;SHELL FISH;SHELLFISH
 ;;SHERBET;SHERBET
 ;;SHRIMP;SHRIMP
 ;;SNAILS;SNAILS
 ;;SOUR CREAM;SOUR CREAM
 ;;SOY;SOY;SOY MILK;SOY PRODUCTS;SOY SAUCE;SOYBEANS;TOFU
 ;;SOY SAUCE;SOY SAUCE
 ;;SPAGHETTI;SPAGHETTI
 ;;SPAM;SPAM
 ;;SPICES;CONDIMENTS;SPICES
 ;;SPINACH;SPINACH
 ;;SQUASH;SQUASH
 ;;SQUID;SQUID
 ;;STARCHY FOODS;STARCHES
 ;;STRAWBERRIES;STRAWBERRIES;STRAWBERRIES PLUS
 ;;SUCRALOSE;SUCRALOSE
 ;;SUGAR;SUGAR;SUGAR BEETS;WHITE SUGAR
 ;;SUGAR SUB;ARTIFICIAL SWEETENERS
 ;;SUGAR SUB, ASPARTAME;ASPARTAME
 ;;SUGAR SUB, SACCHARIN;SACCHARIN;SWEET'N LOW
 ;;SUGAR, BROWN;BROWN SUGAR
 ;;SULFITES;SULFITES
 ;;SYRUP, MAPLE;MAPLE SYRUP
 ;;TANGERINES;TANGERINES
 ;;TARRAGON;TARRAGON
 ;;TEA;TEA
 ;;TOFFEE;TOFFEE
 ;;TOMATO;TOMATO;TOMATO JUICE;TOMATO PRODUCTS;TOMATO SAUCE;TOMATOES
 ;;TOMATOES, FRESH;FRESH TOMATOES
 ;;TUMERIC;TUMERIC
 ;;TURKEY;TURKEY
 ;;TURNIPS;TURNIPS
 ;;VEAL;VEAL
 ;;VEGETABLES;VEGETABLES
 ;;VEGETABLES, GREEN;GREEN VEGETABLES
 ;;VINEGAR;VINEGAR
 ;;WATERFOWL;WATERFOWL
 ;;WHEAT;FLOUR;WHEAT
 ;;WHEY;WHEY
 ;;WINE, RED;RED WINE
 ;;YEAST;YEAST
 ;;YELLOW DYES;FD&C YELLOW DYE #10;FD&C YELLOW DYE #2;FD&C YELLOW DYE #5;FD&C YELLOW DYE #6;FD&C YELLOW DYE #6 LAKE;TARTRAZINE;YELLOW DYES
 ;;ZUCCHINI;ZUCCHINI
 ;;ARUGULA;ARUGULA
 ;;CAPERS;CAPERS
 ;;CURRY;CURRY
 ;;GOOSEBERRIES;GOOSEBERRIES;GOOSE BERRIES;GOOSE BERRY;GOOSEBERRY
 ;;MEAT TENDERIZER;MEAT TENDERIZER
 ;;OLESTRA;OLESTRA;OLEAN
 ;;ORANGE DYE;ORANGE DYE
 ;;POMEGRANATES;POMEGRANATES
 ;;PUDDING;PUDDING
 ;;SAFFRON;SAFFRON
 ;;STEVIA;STEVIA
 ;;WATER CHESTNUTS;WATER CHESTNUTS
 ;;BEANS, KIDNEY;KIDNEY BEANS
 ;;OCTOPUS;OCTOPUS
 ;;SAGE;SAGE
 ;;MARGARINE;MARGARINE
 ;;ONIONS, RAW;RAW ONIONS
 ;;VEGETABLES, RAW;RAW VEGETABLES
 ;;TURMERIC;TURMERIC
 ;;OIL, CANOLA;CANOLA OIL
 ;;ERYTHRITOL;ERYTHRITOL
 ;;KALE;KALE
 ;;AGAVE;AGAVE
 ;;MILK, HEMP;HEMP MILK
 ;;ROOT, TARO;TARO ROOT
