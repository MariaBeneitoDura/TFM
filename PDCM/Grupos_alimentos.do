import spss using "S:\LAB_RFJ\LAB\María\TFM_STATA\DATOS\DIETA ALIMENTO V1.sav", clear
sort DR1QFOOD

gen Seleccion=1 if DR1CODREC==DR1QFOOD
replace Seleccion=2 if DR1CODREC==0
drop if Seleccion==.
drop Seleccion

tab DR1QFOOD if inrange(DR1QFOOD, 1701001, 1701004)
drop if inrange(DR1QFOOD, 1701002, 1701004)

* Grupo 1 (Productos lácteos y yogures azucarados):
tab DR1QFOOD if inrange(DR1QFOOD, 0201001, 0201003) | DR1QFOOD==0202001 | DR1QFOOD==0202003 | DR1QFOOD==0202005 | DR1QFOOD==0202006 | inrange(DR1QFOOD, 0202008, 0202010) | inrange(DR1QFOOD, 0202012, 0202015) | DR1QFOOD==0204001 | DR1QFOOD==0204002 | DR1QFOOD==1799004
gen FoodGroupV1=1 if inrange(DR1QFOOD, 0201001, 0201003) | DR1QFOOD==0202001 | DR1QFOOD==0202003 | DR1QFOOD==0202005 | DR1QFOOD==0202006 | inrange(DR1QFOOD, 0202008, 0202010) | inrange(DR1QFOOD, 0202012, 0202015) | DR1QFOOD==0204001 | DR1QFOOD==0204002 | DR1QFOOD==1799004

tab DR1QFOOD if DR1QFOOD==0903005 | inrange(DR1QFOOD, 0202017, 0202019) | inrange(DR1QFOOD, 1501223, 1501225) | DR1QFOOD==1501243
replace FoodGroupV1=1 if DR1QFOOD==0903005 | inrange(DR1QFOOD, 0202017, 0202019) | inrange(DR1QFOOD, 1501223, 1501225) | DR1QFOOD==1501243

* Grupo 2 (Productos lácteos y yogures sin azúcar):
tab DR1QFOOD if DR1QFOOD==0200000 | inrange(DR1QFOOD, 0201004, 0201013) | DR1QFOOD==0201015 | DR1QFOOD==0202002 | DR1QFOOD==0202004 | DR1QFOOD==0202007 | DR1QFOOD==0202011 | DR1QFOOD==0202016 | DR1QFOOD==0203003 | DR1QFOOD==0299001 | DR1QFOOD==0903004 | DR1QFOOD==1799006
replace FoodGroupV1=2 if DR1QFOOD==0200000 | inrange(DR1QFOOD, 0201004, 0201013) | DR1QFOOD==0201015 | DR1QFOOD==0202002 | DR1QFOOD==0202004 | DR1QFOOD==0202007 | DR1QFOOD==0202011 | DR1QFOOD==0202016 | DR1QFOOD==0203003 | DR1QFOOD==0299001 | DR1QFOOD==0903004 | DR1QFOOD==1799006

tab DR1QFOOD if inrange(DR1QFOOD, 0201017, 0201025) | DR1QFOOD==0
replace FoodGroupV1=2 if inrange(DR1QFOOD, 0201017, 0201025) | DR1QFOOD==0

* Grupo 3 (Queso bajo en grasa):
tab DR1QFOOD if DR1QFOOD==0204000 | inrange(DR1QFOOD, 0204003, 0204009) | DR1QFOOD==0299002
replace FoodGroupV1=3 if DR1QFOOD==0204000 | inrange(DR1QFOOD, 0204003, 0204009) | DR1QFOOD==0299002

* Grupo 4 (Queso rico en grasa):
tab DR1QFOOD if inrange(DR1QFOOD, 0205000, 0205049) | DR1QFOOD==0206009
codebook DR1QFOOD if inrange(DR1QFOOD, 0205000, 0205049) | DR1QFOOD==0206009, compact
replace FoodGroupV1=4 if inrange(DR1QFOOD, 0205000, 0205049) | DR1QFOOD==0206009

tab DR1QFOOD if DR1QFOOD==1501216
replace FoodGroupV1=4 if DR1QFOOD==1501216

* Grupo 5 (Mantequilla y grasas animales):
tab DR1QFOOD if DR1QFOOD==0702001 | DR1QFOOD==0702002
replace FoodGroupV1=5 if DR1QFOOD==0702001 | DR1QFOOD==0702002

* Grupo 6 (Aceites vegetales):
tab DR1QFOOD if DR1QFOOD==0700000 | DR1QFOOD==0700001 | inrange(DR1QFOOD, 0701001, 0701004) | DR1QFOOD==0701007 | inrange(DR1QFOOD, 0702003, 0702006) | DR1QFOOD==0701005 | DR1QFOOD==0701006
replace FoodGroupV1=6 if DR1QFOOD==0700000 | DR1QFOOD==0700001 | inrange(DR1QFOOD, 0701001, 0701004) | DR1QFOOD==0701007 | inrange(DR1QFOOD, 0702003, 0702006) | DR1QFOOD==0701005 | DR1QFOOD==0701006

* Grupo 7 (Huevos y platos basados en huevo):
tab DR1QFOOD if inrange(DR1QFOOD, 0401001, 0401011)
replace FoodGroupV1=7 if inrange(DR1QFOOD, 0401001, 0401011)

tab DR1QFOOD if inrange(DR1QFOOD, 1501090, 1501092) | inrange(DR1QFOOD, 1501145, 1501150) | inrange(DR1QFOOD, 1501166, 1501179) | DR1QFOOD==1501187
codebook DR1QFOOD if inrange(DR1QFOOD, 1501090, 1501092) | inrange(DR1QFOOD, 1501145, 1501150) | inrange(DR1QFOOD, 1501166, 1501179) | DR1QFOOD==1501187, compact
replace FoodGroupV1=7 if inrange(DR1QFOOD, 1501090, 1501092) | inrange(DR1QFOOD, 1501145, 1501150) | inrange(DR1QFOOD, 1501166, 1501179) | DR1QFOOD==1501187

* Grupo 8 (Pan blanco y harinas refinadas):
tab DR1QFOOD if inrange(DR1QFOOD, 0101003, 0101006) | DR1QFOOD==0101009 | DR1QFOOD==0101011 | DR1QFOOD==0103000 | DR1QFOOD==0103001 | inrange(DR1QFOOD, 0103003, 0103013) | inrange(DR1QFOOD, 0103016, 0103018)
replace FoodGroupV1=8 if inrange(DR1QFOOD, 0101003, 0101006) | DR1QFOOD==0101009 | DR1QFOOD==0101011 | DR1QFOOD==0103000 | DR1QFOOD==0103001 | inrange(DR1QFOOD, 0103003, 0103013) | inrange(DR1QFOOD, 0103016, 0103018)

* Grupo 9 (Pan y harinas integrales):
tab DR1QFOOD if DR1QFOOD==0101007 | DR1QFOOD==0103002 | DR1QFOOD==0103014 | DR1QFOOD==0103015
replace FoodGroupV1=9 if DR1QFOOD==0101007 | DR1QFOOD==0103002 | DR1QFOOD==0103014 | DR1QFOOD==0103015

* Grupo 10 (Cereales de desayuno refinados):
tab DR1QFOOD if DR1QFOOD==0106000 | DR1QFOOD==0106001 | inrange(DR1QFOOD, 0106004, 0106006) | DR1QFOOD==0106008
replace FoodGroupV1=10 if DR1QFOOD==0106000 | DR1QFOOD==0106001 | inrange(DR1QFOOD, 0106004, 0106006) | DR1QFOOD==0106008

tab DR1QFOOD if DR1QFOOD==0106010 | DR1QFOOD==0106011
replace FoodGroupV1=10 if DR1QFOOD==0106010 | DR1QFOOD==0106011

* Grupo 11 (Cereales de desayuno integrales):
tab DR1QFOOD if DR1QFOOD==0106002 | DR1QFOOD==0106003 | DR1QFOOD==0106007 | DR1QFOOD==0106009
replace FoodGroupV1=11 if DR1QFOOD==0106002 | DR1QFOOD==0106003 | DR1QFOOD==0106007 | DR1QFOOD==0106009

* Grupo 12 (Arroz, pasta y otros cereales):
tab DR1QFOOD if DR1QFOOD==0101001 | DR1QFOOD==0101002 | DR1QFOOD==0101008 | DR1QFOOD==0101010 | DR1QFOOD==0102001 | DR1QFOOD==0102002 | DR1QFOOD==1002002 | DR1QFOOD==1900001
replace FoodGroupV1=12 if DR1QFOOD==0101001 | DR1QFOOD==0101002 | DR1QFOOD==0101008 | DR1QFOOD==0101010 | DR1QFOOD==0102001 | DR1QFOOD==0102002 | DR1QFOOD==1002002 | DR1QFOOD==1900001

tab DR1QFOOD if DR1QFOOD==0102005 | inrange(DR1QFOOD, 1501005, 1501007) | DR1QFOOD==1501009 | DR1QFOOD==1501045 | DR1QFOOD==1501067 | DR1QFOOD==1501071 | DR1QFOOD==1501082 | inrange(DR1QFOOD, 1501107, 1501111) | inrange(DR1QFOOD, 1501113, 1501116) | DR1QFOOD==1501227
codebook DR1QFOOD if DR1QFOOD==0102005 | inrange(DR1QFOOD, 1501005, 1501007) | DR1QFOOD==1501009 | DR1QFOOD==1501045 | DR1QFOOD==1501067 | DR1QFOOD==1501071 | DR1QFOOD==1501082 | inrange(DR1QFOOD, 1501107, 1501111) | inrange(DR1QFOOD, 1501113, 1501116) | DR1QFOOD==1501227, compact
replace FoodGroupV1=12 if DR1QFOOD==0102005 | inrange(DR1QFOOD, 1501005, 1501007) | DR1QFOOD==1501009 | DR1QFOOD==1501045 | DR1QFOOD==1501067 | DR1QFOOD==1501071 | DR1QFOOD==1501082 | inrange(DR1QFOOD, 1501107, 1501111) | inrange(DR1QFOOD, 1501113, 1501116) | DR1QFOOD==1501227

* Grupo 13 [Comida rápida (pizza, kebab, hamburguesa, etc.)]:
tab DR1QFOOD if DR1QFOOD==0399010 | DR1QFOOD==1001003 | inrange(DR1QFOOD, 1505001, 1505003)
replace FoodGroupV1=13 if DR1QFOOD==0399010 | DR1QFOOD==1001003 | inrange(DR1QFOOD, 1505001, 1505003)

tab DR1QFOOD if inrange(DR1QFOOD, 1501128, 1501133) | DR1QFOOD==1501153 | DR1QFOOD==1501154 | inrange(DR1QFOOD, 1501188, 1501206) | DR1QFOOD==1501213 | DR1QFOOD==1501215 | DR1QFOOD==1501220 | DR1QFOOD==1501250 | DR1QFOOD==1501251
codebook DR1QFOOD if inrange(DR1QFOOD, 1501128, 1501133) | DR1QFOOD==1501153 | DR1QFOOD==1501154 | inrange(DR1QFOOD, 1501188, 1501206) | DR1QFOOD==1501213 | DR1QFOOD==1501215 | DR1QFOOD==1501220 | DR1QFOOD==1501250 | DR1QFOOD==1501251, compact
replace FoodGroupV1=13 if inrange(DR1QFOOD, 1501128, 1501133) | DR1QFOOD==1501153 | DR1QFOOD==1501154 | inrange(DR1QFOOD, 1501188, 1501206) | DR1QFOOD==1501213 | DR1QFOOD==1501215 | DR1QFOOD==1501220 | DR1QFOOD==1501250 | DR1QFOOD==1501251

* Grupo 14 (Pasteles y galletas):
tab DR1QFOOD if inrange(DR1QFOOD, 0104000, 0104007) | inrange(DR1QFOOD, 0105000, 0105036) | inrange(DR1QFOOD, 0105038, 0105048)
codebook DR1QFOOD if inrange(DR1QFOOD, 0104000, 0104007) | inrange(DR1QFOOD, 0105000, 0105036) | inrange(DR1QFOOD, 0105038, 0105048), compact
replace FoodGroupV1=14 if inrange(DR1QFOOD, 0104000, 0104007) | inrange(DR1QFOOD, 0105000, 0105036) | inrange(DR1QFOOD, 0105038, 0105048)

tab DR1QFOOD if inrange(DR1QFOOD, 0104008, 0104012) | DR1QFOOD==0199001 | DR1QFOOD==0199002 | DR1QFOOD==1900007 | DR1QFOOD==1900008
replace FoodGroupV1=14 if inrange(DR1QFOOD, 0104008, 0104012) | DR1QFOOD==0199001 | DR1QFOOD==0199002 | DR1QFOOD==1900007 | DR1QFOOD==1900008

* Grupo 15 (Postres lácteos):
tab DR1QFOOD if DR1QFOOD==0105037 | DR1QFOOD==0201016 | DR1QFOOD==0203001 | DR1QFOOD==0203002 | inrange(DR1QFOOD, 0203004, 0203014)
replace FoodGroupV1=15 if DR1QFOOD==0105037 | DR1QFOOD==0201016 | DR1QFOOD==0203001 | DR1QFOOD==0203002 | inrange(DR1QFOOD, 0203004, 0203014)

tab DR1QFOOD if DR1QFOOD==1501008 | DR1QFOOD==1501059
replace FoodGroupV1=15 if DR1QFOOD==1501008 | DR1QFOOD==1501059

* Grupo 16 (Chocolate y confitería):
tab DR1QFOOD if inrange(DR1QFOOD, 1303001, 1303006) | inrange(DR1QFOOD, 1304001, 1304005) | inrange(DR1QFOOD, 1304007, 1304014) | inrange(DR1QFOOD, 1305001, 1305004) | DR1QFOOD==1399003 | DR1QFOOD==1900005
codebook DR1QFOOD if inrange(DR1QFOOD, 1303001, 1303006) | inrange(DR1QFOOD, 1304001, 1304005) | inrange(DR1QFOOD, 1304007, 1304014) | inrange(DR1QFOOD, 1305001, 1305004) | DR1QFOOD==1399003 | DR1QFOOD==1900005, compact
replace FoodGroupV1=16 if inrange(DR1QFOOD, 1303001, 1303006) | inrange(DR1QFOOD, 1304001, 1304005) | inrange(DR1QFOOD, 1304007, 1304014) | inrange(DR1QFOOD, 1305001, 1305004) | DR1QFOOD==1399003 | DR1QFOOD==1900005

* Grupo 17 (Carne roja):
tab DR1QFOOD if DR1QFOOD==0300000 | DR1QFOOD==0300001 | inrange(DR1QFOOD, 0301001, 0301011) | inrange(DR1QFOOD, 0302000, 0302010) | inrange(DR1QFOOD, 0303001, 0303008) | inrange(DR1QFOOD, 0304000, 0304004) | inrange(DR1QFOOD, 0306000, 0306017) | inrange(DR1QFOOD, 0399001, 0399004) | DR1QFOOD==0399011
codebook DR1QFOOD if DR1QFOOD==0300000 | DR1QFOOD==0300001 | inrange(DR1QFOOD, 0301001, 0301011) | inrange(DR1QFOOD, 0302000, 0302010) | inrange(DR1QFOOD, 0303001, 0303008) | inrange(DR1QFOOD, 0304000, 0304004) | inrange(DR1QFOOD, 0306000, 0306017) | inrange(DR1QFOOD, 0399001, 0399004) | DR1QFOOD==0399011, compact
replace FoodGroupV1=17 if DR1QFOOD==0300000 | DR1QFOOD==0300001 | inrange(DR1QFOOD, 0301001, 0301011) | inrange(DR1QFOOD, 0302000, 0302010) | inrange(DR1QFOOD, 0303001, 0303008) | inrange(DR1QFOOD, 0304000, 0304004) | inrange(DR1QFOOD, 0306000, 0306017) | inrange(DR1QFOOD, 0399001, 0399004) | DR1QFOOD==0399011

tab DR1QFOOD if inrange(DR1QFOOD, 1501042, 1501044) | DR1QFOOD==1501057 | DR1QFOOD==1501096 | DR1QFOOD==1501099 | DR1QFOOD==1501102 | DR1QFOOD==1501144 | DR1QFOOD==1501164 | DR1QFOOD==1501165
replace FoodGroupV1=17 if inrange(DR1QFOOD, 1501042, 1501044) | DR1QFOOD==1501057 | DR1QFOOD==1501096 | DR1QFOOD==1501099 | DR1QFOOD==1501102 | DR1QFOOD==1501144 | DR1QFOOD==1501164 | DR1QFOOD==1501165

* Grupo 18 (Carne procesada):
tab DR1QFOOD if inrange(DR1QFOOD, 0307000, 0307014) | inrange(DR1QFOOD, 0308000, 0308020) | DR1QFOOD==0399005 | inrange(DR1QFOOD, 0399007, 0399009) | inrange(DR1QFOOD, 0399013, 0399015) | DR1QFOOD==1600007
codebook DR1QFOOD if inrange(DR1QFOOD, 0307000, 0307014) | inrange(DR1QFOOD, 0308000, 0308020) | DR1QFOOD==0399005 | inrange(DR1QFOOD, 0399007, 0399009) | inrange(DR1QFOOD, 0399013, 0399015) | DR1QFOOD==1600007, compact
replace FoodGroupV1=18 if inrange(DR1QFOOD, 0307000, 0307014) | inrange(DR1QFOOD, 0308000, 0308020) | DR1QFOOD==0399005 | inrange(DR1QFOOD, 0399007, 0399009) | inrange(DR1QFOOD, 0399013, 0399015) | DR1QFOOD==1600007

tab DR1QFOOD if DR1QFOOD==1501210
replace FoodGroupV1=18 if DR1QFOOD==1501210

* Grupo 19 [Carne blanca (aves de corral y conejo)]:
tab DR1QFOOD if inrange(DR1QFOOD, 0305000, 0305019) | DR1QFOOD==0399006 | DR1QFOOD==0399012
codebook DR1QFOOD if inrange(DR1QFOOD, 0305000, 0305019) | DR1QFOOD==0399006 | DR1QFOOD==0399012, compact
replace FoodGroupV1=19 if inrange(DR1QFOOD, 0305000, 0305019) | DR1QFOOD==0399006 | DR1QFOOD==0399012

tab DR1QFOOD if DR1QFOOD==1501056 | inrange(DR1QFOOD, 1501134, 1501137)
replace FoodGroupV1=19 if DR1QFOOD==1501056 | inrange(DR1QFOOD, 1501134, 1501137)

* Grupo 20 (Sustitutos de la carne):
tab DR1QFOOD if DR1QFOOD==0903003
replace FoodGroupV1=20 if DR1QFOOD==0903003

* Grupo 21 (Pescado azul):
tab DR1QFOOD if inrange(DR1QFOOD, 0502002, 0502006) | DR1QFOOD==0502000 | inrange(DR1QFOOD, 0502002, 0502006) | DR1QFOOD==0502011 | inrange(DR1QFOOD, 0502015, 0502017) | inrange(DR1QFOOD, 0502019, 0502027) | DR1QFOOD==0502029 | DR1QFOOD==0502030 | DR1QFOOD==0502032 | DR1QFOOD==0503001 | DR1QFOOD==0503004 | DR1QFOOD==0503005
codebook DR1QFOOD if DR1QFOOD==0502000 | inrange(DR1QFOOD, 0502002, 0502006) | DR1QFOOD==0502011 | inrange(DR1QFOOD, 0502015, 0502017) | inrange(DR1QFOOD, 0502019, 0502027) | DR1QFOOD==0502029 | DR1QFOOD==0502030 | DR1QFOOD==0502032 | DR1QFOOD==0503001 | DR1QFOOD==0503004 | DR1QFOOD==0503005, compact
replace FoodGroupV1=21 if inrange(DR1QFOOD, 0502002, 0502006) | DR1QFOOD==0502000 | inrange(DR1QFOOD, 0502002, 0502006) | DR1QFOOD==0502011 | inrange(DR1QFOOD, 0502015, 0502017) | inrange(DR1QFOOD, 0502019, 0502027) | DR1QFOOD==0502029 | DR1QFOOD==0502030 | DR1QFOOD==0502032 | DR1QFOOD==0503001 | DR1QFOOD==0503004 | DR1QFOOD==0503005

tab DR1QFOOD if DR1QFOOD==1501015 | DR1QFOOD==1501101 | DR1QFOOD==1501222
replace FoodGroupV1=21 if DR1QFOOD==1501015 | DR1QFOOD==1501101 | DR1QFOOD==1501222

* Grupo 22 (Pescado blanco):
tab DR1QFOOD if DR1QFOOD==0500000 | inrange(DR1QFOOD, 0501000, 0501034) | inrange(DR1QFOOD, 0503002, 0503003)
codebook DR1QFOOD if DR1QFOOD==0500000 | inrange(DR1QFOOD, 0501000, 0501034) | inrange(DR1QFOOD, 0503002, 0503003), compact
replace FoodGroupV1=22 if DR1QFOOD==0500000 | inrange(DR1QFOOD, 0501000, 0501034) | inrange(DR1QFOOD, 0503002, 0503003)

tab DR1QFOOD if inrange(DR1QFOOD, 1501011, 1501014) | DR1QFOOD==1501074 | DR1QFOOD==1501083 | inrange(DR1QFOOD, 1501104, 1501106) | DR1QFOOD==1501125 | DR1QFOOD==1501126 | DR1QFOOD==1501180 | DR1QFOOD==1501184
codebook DR1QFOOD if inrange(DR1QFOOD, 1501011, 1501014) | DR1QFOOD==1501074 | DR1QFOOD==1501083 | inrange(DR1QFOOD, 1501104, 1501106) | DR1QFOOD==1501125 | DR1QFOOD==1501126 | DR1QFOOD==1501180 | DR1QFOOD==1501184, compact
replace FoodGroupV1=22 if inrange(DR1QFOOD, 1501011, 1501014) | DR1QFOOD==1501074 | DR1QFOOD==1501083 | inrange(DR1QFOOD, 1501104, 1501106) | DR1QFOOD==1501125 | DR1QFOOD==1501126 | DR1QFOOD==1501180 | DR1QFOOD==1501184

* Grupo 23 (Pescado enlatado):
tab DR1QFOOD if DR1QFOOD==0500001 | DR1QFOOD==0500002 | DR1QFOOD==0502001 | inrange(DR1QFOOD, 0502007, 0502010) | inrange(DR1QFOOD, 0502012, 0502014) | DR1QFOOD==0502018 | DR1QFOOD==0502028 | DR1QFOOD==0502031 | inrange(DR1QFOOD, 0599001, 0599005) | DR1QFOOD==0602003 | DR1QFOOD==0602010 | DR1QFOOD==1504001
codebook DR1QFOOD if DR1QFOOD==0500001 | DR1QFOOD==0500002 | DR1QFOOD==0502001 | inrange(DR1QFOOD, 0502007, 0502010) | inrange(DR1QFOOD, 0502012, 0502014) | DR1QFOOD==0502018 | DR1QFOOD==0502028 | DR1QFOOD==0502031 | inrange(DR1QFOOD, 0599001, 0599005) | DR1QFOOD==0602003 | DR1QFOOD==0602010 | DR1QFOOD==1504001, compact
replace FoodGroupV1=23 if DR1QFOOD==0500001 | DR1QFOOD==0500002 | DR1QFOOD==0502001 | inrange(DR1QFOOD, 0502007, 0502010) | inrange(DR1QFOOD, 0502012, 0502014) | DR1QFOOD==0502018 | DR1QFOOD==0502028 | DR1QFOOD==0502031 | inrange(DR1QFOOD, 0599001, 0599005) | DR1QFOOD==0602003 | DR1QFOOD==0602010 | DR1QFOOD==1504001

tab DR1QFOOD if DR1QFOOD==1501047
replace FoodGroupV1=23 if DR1QFOOD==1501047

* Grupo 24 (Patatas):
tab DR1QFOOD if DR1QFOOD==1001001 | DR1QFOOD==1001002 | inrange(DR1QFOOD, 1001004, 1001006) | DR1QFOOD==1002001 | DR1QFOOD==1002003
replace FoodGroupV1=24 if DR1QFOOD==1001001 | DR1QFOOD==1001002 | inrange(DR1QFOOD, 1001004, 1001006) | DR1QFOOD==1002001 | DR1QFOOD==1002003

tab DR1QFOOD if DR1QFOOD==1501065 | DR1QFOOD==1501072 | DR1QFOOD==1501075 | DR1QFOOD==1501079 | inrange(DR1QFOOD, 1501119, 1501124)
replace FoodGroupV1=24 if DR1QFOOD==1501065 | DR1QFOOD==1501072 | DR1QFOOD==1501075 | DR1QFOOD==1501079 | inrange(DR1QFOOD, 1501119, 1501124)

* Grupo 25 (Verduras):
tab DR1QFOOD if DR1QFOOD==0800000 | inrange(DR1QFOOD, 0801001, 0801023) | inrange(DR1QFOOD, 0802001, 0802011) | inrange(DR1QFOOD, 0803001, 0803004) | inrange(DR1QFOOD, 0804001, 0804021) | inrange(DR1QFOOD, 0899001, 0899005) | DR1QFOOD==1599015 | DR1QFOOD==1600001 | DR1QFOOD==1600002 | DR1QFOOD==1600005 | DR1QFOOD==1600006 | DR1QFOOD==1600008
replace FoodGroupV1=25 if DR1QFOOD==0800000 | inrange(DR1QFOOD, 0801001, 0801023) | inrange(DR1QFOOD, 0802001, 0802011) | inrange(DR1QFOOD, 0803001, 0803004) | inrange(DR1QFOOD, 0804001, 0804021) | inrange(DR1QFOOD, 0899001, 0899005) | DR1QFOOD==1599015 | DR1QFOOD==1600001 | DR1QFOOD==1600002 | DR1QFOOD==1600005 | DR1QFOOD==1600006 | DR1QFOOD==1600008

tab DR1QFOOD if DR1QFOOD==1599021 | DR1QFOOD==1501001 | DR1QFOOD==1501016 | DR1QFOOD==1501046 | inrange(DR1QFOOD, 1501052, 1501055) | DR1QFOOD==1501058 | DR1QFOOD==1501069 | DR1QFOOD==1501073 | inrange(DR1QFOOD, 1501076, 1501078) | inrange(DR1QFOOD, 1501093, 1501095) | DR1QFOOD==1501103 | DR1QFOOD==1501112 | DR1QFOOD==1501127 | DR1QFOOD==1501142 | DR1QFOOD==1501151 | DR1QFOOD==1501181 | DR1QFOOD==1501183 | DR1QFOOD==1501186 | DR1QFOOD==1501207 | DR1QFOOD==1501211 | DR1QFOOD==1501221
codebook DR1QFOOD if DR1QFOOD==1599021 | DR1QFOOD==1501001 | DR1QFOOD==1501016 | DR1QFOOD==1501046 | inrange(DR1QFOOD, 1501052, 1501055) | DR1QFOOD==1501058 | DR1QFOOD==1501069 | DR1QFOOD==1501073 | inrange(DR1QFOOD, 1501076, 1501078) | inrange(DR1QFOOD, 1501093, 1501095) | DR1QFOOD==1501103 | DR1QFOOD==1501112 | DR1QFOOD==1501127 | DR1QFOOD==1501142 | DR1QFOOD==1501151 | DR1QFOOD==1501181 | DR1QFOOD==1501183 | DR1QFOOD==1501186 | DR1QFOOD==1501207 | DR1QFOOD==1501211 | DR1QFOOD==1501221, compact
replace FoodGroupV1=25 if DR1QFOOD==1599021 | DR1QFOOD==1501001 | DR1QFOOD==1501016 | DR1QFOOD==1501046 | inrange(DR1QFOOD, 1501052, 1501055) | DR1QFOOD==1501058 | DR1QFOOD==1501069 | DR1QFOOD==1501073 | inrange(DR1QFOOD, 1501076, 1501078) | inrange(DR1QFOOD, 1501093, 1501095) | DR1QFOOD==1501103 | DR1QFOOD==1501112 | DR1QFOOD==1501127 | DR1QFOOD==1501142 | DR1QFOOD==1501151 | DR1QFOOD==1501181 | DR1QFOOD==1501183 | DR1QFOOD==1501186 | DR1QFOOD==1501207 | DR1QFOOD==1501211 | DR1QFOOD==1501221

* Grupo 26 (Fruta fresca):
tab DR1QFOOD if inrange(DR1QFOOD, 1100000, 1101022) | inrange(DR1QFOOD, 1101025, 1101035) | inrange(DR1QFOOD, 1101037, 1101049) | DR1QFOOD==1104004
codebook DR1QFOOD if inrange(DR1QFOOD, 1100000, 1101022) | inrange(DR1QFOOD, 1101025, 1101035) | inrange(DR1QFOOD, 1101037, 1101049) | DR1QFOOD==1104004, compact
replace FoodGroupV1=26 if inrange(DR1QFOOD, 1100000, 1101022) | inrange(DR1QFOOD, 1101025, 1101035) | inrange(DR1QFOOD, 1101037, 1101049) | DR1QFOOD==1104004

tab DR1QFOOD if DR1QFOOD==1501100
replace FoodGroupV1=26 if DR1QFOOD==1501100

* Grupo 27 (Otras frutas):
tab DR1QFOOD if DR1QFOOD==1101023 | DR1QFOOD==1101024 | inrange(DR1QFOOD, 1102000, 1102006) | inrange(DR1QFOOD, 1103001, 1103006) | DR1QFOOD==1302001 | DR1QFOOD==1302002 | DR1QFOOD==1399001 | DR1QFOOD==1399002
codebook DR1QFOOD if DR1QFOOD==1101023 | DR1QFOOD==1101024 | inrange(DR1QFOOD, 1102000, 1102006) | inrange(DR1QFOOD, 1103001, 1103006) | DR1QFOOD==1302001 | DR1QFOOD==1302002 | DR1QFOOD==1399001 | DR1QFOOD==1399002, compact
replace FoodGroupV1=27 if DR1QFOOD==1101023 | DR1QFOOD==1101024 | inrange(DR1QFOOD, 1102000, 1102006) | inrange(DR1QFOOD, 1103001, 1103006) | DR1QFOOD==1302001 | DR1QFOOD==1302002 | DR1QFOOD==1399001 | DR1QFOOD==1399002

* Grupo 28 (Frutos secos y semillas):
tab DR1QFOOD if inrange(DR1QFOOD, 1104001, 1104003) | inrange(DR1QFOOD, 1200000, 1201020)
replace FoodGroupV1=28 if inrange(DR1QFOOD, 1104001, 1104003) | inrange(DR1QFOOD, 1200000, 1201020)

* Grupo 29 (Legumbres sin carne):
tab DR1QFOOD if DR1QFOOD==0900000 | inrange(DR1QFOOD, 0901001, 0901004) | inrange(DR1QFOOD, 0902001, 0902011) | DR1QFOOD==0903002 | DR1QFOOD==1600011
replace FoodGroupV1=29 if DR1QFOOD==0900000 | inrange(DR1QFOOD, 0901001, 0901004) | inrange(DR1QFOOD, 0902001, 0902011) | DR1QFOOD==0903002 | DR1QFOOD==1600011

tab DR1QFOOD if DR1QFOOD==1501066 | DR1QFOOD==1501004 | DR1QFOOD==1501068 | DR1QFOOD==1501070 | DR1QFOOD==1501081 | inrange(DR1QFOOD, 1501139, 1501140) | DR1QFOOD==1501143 | DR1QFOOD==1501098
replace FoodGroupV1=29 if DR1QFOOD==1501066 | DR1QFOOD==1501004 | DR1QFOOD==1501068 | DR1QFOOD==1501070 | DR1QFOOD==1501081 | inrange(DR1QFOOD, 1501139, 1501140) | DR1QFOOD==1501143 | DR1QFOOD==1501098

* Grupo 30 (Legumbres con carne):
tab DR1QFOOD if DR1QFOOD==1501003 | inrange(DR1QFOOD, 1501048, 1501050) | DR1QFOOD==1501080 | DR1QFOOD==1501097 | DR1QFOOD==1501141
replace FoodGroupV1=30 if DR1QFOOD==1501003 | inrange(DR1QFOOD, 1501048, 1501050) | DR1QFOOD==1501080 | DR1QFOOD==1501097 | DR1QFOOD==1501141
	
* Grupo 31 (Patatas fritas y snacks salados):
tab DR1QFOOD if DR1QFOOD==1600003 | DR1QFOOD==1600004 | DR1QFOOD==1600009 | DR1QFOOD==1600010 | inrange(DR1QFOOD, 1600012, 1600018)
replace FoodGroupV1=31 if DR1QFOOD==1600003 | DR1QFOOD==1600004 | DR1QFOOD==1600009 | DR1QFOOD==1600010 | inrange(DR1QFOOD, 1600012, 1600018)

* Grupo 32 (Platos precocinados y combinados con carne):
tab DR1QFOOD if DR1QFOOD==0102003 | DR1QFOOD==0102004 | DR1QFOOD==0399016 | inrange(DR1QFOOD, 1502001, 1502008) | inrange(DR1QFOOD, 1503001, 1503003) | DR1QFOOD==1504002 | DR1QFOOD==1504003 | DR1QFOOD==1504005 | inrange(DR1QFOOD, 1599001, 1599003) | DR1QFOOD==1599007 | inrange(DR1QFOOD, 1599009, 1599014) | DR1QFOOD==1599016
codebook DR1QFOOD if DR1QFOOD==0102003 | DR1QFOOD==0102004 | DR1QFOOD==0399016 | inrange(DR1QFOOD, 1502001, 1502008) | inrange(DR1QFOOD, 1503001, 1503003) | DR1QFOOD==1504002 | DR1QFOOD==1504003 | DR1QFOOD==1504005 | inrange(DR1QFOOD, 1599001, 1599003) | DR1QFOOD==1599007 | inrange(DR1QFOOD, 1599009, 1599014) | DR1QFOOD==1599016, compact
replace FoodGroupV1=32 if DR1QFOOD==0102003 | DR1QFOOD==0102004 | DR1QFOOD==0399016 | inrange(DR1QFOOD, 1502001, 1502008) | inrange(DR1QFOOD, 1503001, 1503003) | DR1QFOOD==1504002 | DR1QFOOD==1504003 | DR1QFOOD==1504005 | inrange(DR1QFOOD, 1599001, 1599003) | DR1QFOOD==1599007 | inrange(DR1QFOOD, 1599009, 1599014) | DR1QFOOD==1599016

tab DR1QFOOD if DR1QFOOD==1502009 | DR1QFOOD==1501010 | DR1QFOOD==1501063 | DR1QFOOD==1501064 | inrange(DR1QFOOD, 1501085, 1501089) | DR1QFOOD==1501117 | DR1QFOOD==1501118 | DR1QFOOD==1501152 | DR1QFOOD==1501212 | DR1QFOOD==1501214 | DR1QFOOD==1501217 | DR1QFOOD==1501218
codebook DR1QFOOD if DR1QFOOD==1502009 | DR1QFOOD==1501010 | DR1QFOOD==1501063 | DR1QFOOD==1501064 | inrange(DR1QFOOD, 1501085, 1501089) | DR1QFOOD==1501117 | DR1QFOOD==1501118 | DR1QFOOD==1501152 | DR1QFOOD==1501212 | DR1QFOOD==1501214 | DR1QFOOD==1501217 | DR1QFOOD==1501218, compact
replace FoodGroupV1=32 if DR1QFOOD==1502009 | DR1QFOOD==1501010 | DR1QFOOD==1501063 | DR1QFOOD==1501064 | inrange(DR1QFOOD, 1501085, 1501089) | DR1QFOOD==1501117 | DR1QFOOD==1501118 | DR1QFOOD==1501152 | DR1QFOOD==1501212 | DR1QFOOD==1501214 | DR1QFOOD==1501217 | DR1QFOOD==1501218

* Grupo 33 (Sopas):
tab DR1QFOOD if inrange(DR1QFOOD, 1599004, 1599006) | DR1QFOOD==1599008 | inrange(DR1QFOOD, 1599017, 1599020) | DR1QFOOD==1504006
replace FoodGroupV1=33 if inrange(DR1QFOOD, 1599004, 1599006) | DR1QFOOD==1599008 | inrange(DR1QFOOD, 1599017, 1599020) | DR1QFOOD==1504006

tab DR1QFOOD if DR1QFOOD==1501002 | inrange(DR1QFOOD, 1501060, 1501062) | DR1QFOOD==1501084 | DR1QFOOD==1501138 | inrange(DR1QFOOD, 1501155, 1501163) | DR1QFOOD==1501182 | DR1QFOOD==1501208 | DR1QFOOD==1501209
codebook DR1QFOOD if DR1QFOOD==1501002 | inrange(DR1QFOOD, 1501060, 1501062) | DR1QFOOD==1501084 | DR1QFOOD==1501138 | inrange(DR1QFOOD, 1501155, 1501163) | DR1QFOOD==1501182 | DR1QFOOD==1501208 | DR1QFOOD==1501209, compact
replace FoodGroupV1=33 if DR1QFOOD==1501002 | inrange(DR1QFOOD, 1501060, 1501062) | DR1QFOOD==1501084 | DR1QFOOD==1501138 | inrange(DR1QFOOD, 1501155, 1501163) | DR1QFOOD==1501182 | DR1QFOOD==1501208 | DR1QFOOD==1501209

* Grupo 34 (Salsas y aderezos):
tab DR1QFOOD if DR1QFOOD==0201014 | inrange(DR1QFOOD, 1401001, 1401027) | DR1QFOOD==1499007
replace FoodGroupV1=34 if DR1QFOOD==0201014 | inrange(DR1QFOOD, 1401001, 1401027) | DR1QFOOD==1499007

tab DR1QFOOD if DR1QFOOD==1501219
replace FoodGroupV1=34 if DR1QFOOD==1501219

* Grupo 35 (Condimentos):
tab DR1QFOOD if inrange(DR1QFOOD, 1499001, 1499006)
replace FoodGroupV1=35 if inrange(DR1QFOOD, 1499001, 1499006)

tab DR1QFOOD if DR1QFOOD==1499008
replace FoodGroupV1=35 if DR1QFOOD==1499008

* Grupo 36 (Azúcar añadido):
tab DR1QFOOD if inrange(DR1QFOOD, 1301001, 1301004) | DR1QFOOD==1702001 | DR1QFOOD==1900004
replace FoodGroupV1=36 if inrange(DR1QFOOD, 1301001, 1301004) | DR1QFOOD==1702001 | DR1QFOOD==1900004

* Grupo 37 (Bebidas de alto valor energético):
tab DR1QFOOD if DR1QFOOD==0903001 | DR1QFOOD==1304006 | inrange(DR1QFOOD, 1703000, 1703003) | inrange(DR1QFOOD, 1703005, 1703010) | inrange(DR1QFOOD, 1704001, 1704016) | inrange(DR1QFOOD, 1799001, 1799003) | DR1QFOOD==1799005 | DR1QFOOD==1799007 | DR1QFOOD==1799008 | DR1QFOOD==1799010
codebook DR1QFOOD if DR1QFOOD==0903001 | DR1QFOOD==1304006 | inrange(DR1QFOOD, 1703000, 1703003) | inrange(DR1QFOOD, 1703005, 1703010) | inrange(DR1QFOOD, 1704001, 1704016) | inrange(DR1QFOOD, 1799001, 1799003) | DR1QFOOD==1799005 | DR1QFOOD==1799007 | DR1QFOOD==1799008 | DR1QFOOD==1799010, compact
replace FoodGroupV1=37 if DR1QFOOD==0903001 | DR1QFOOD==1304006 | inrange(DR1QFOOD, 1703000, 1703003) | inrange(DR1QFOOD, 1703005, 1703010) | inrange(DR1QFOOD, 1704001, 1704016) | inrange(DR1QFOOD, 1799001, 1799003) | DR1QFOOD==1799005 | DR1QFOOD==1799007 | DR1QFOOD==1799008 | DR1QFOOD==1799010

tab DR1QFOOD if DR1QFOOD==1704017 | DR1QFOOD==1900006 | inrange(DR1QFOOD, 1501228, 1501242) | DR1QFOOD==1501244
codebook DR1QFOOD if DR1QFOOD==1704017 | DR1QFOOD==1900006 | inrange(DR1QFOOD, 1501228, 1501242) | DR1QFOOD==1501244, compact
replace FoodGroupV1=37 if DR1QFOOD==1704017 | DR1QFOOD==1900006 | inrange(DR1QFOOD, 1501228, 1501242) | DR1QFOOD==1501244

* Grupo 38 (Bebidas de bajo valor energético):
tab DR1QFOOD if DR1QFOOD==1703004 | DR1QFOOD==1701001
replace FoodGroupV1=38 if DR1QFOOD==1703004 | DR1QFOOD==1701001

* Grupo 39 (Zumos de fruta naturales):
tab DR1QFOOD if DR1QFOOD==1101036 | DR1QFOOD==1799009
replace FoodGroupV1=39 if DR1QFOOD==1101036 | DR1QFOOD==1799009

* Grupo 40 (Café y té):
tab DR1QFOOD if inrange(DR1QFOOD, 1702002, 1702013)
replace FoodGroupV1=40 if inrange(DR1QFOOD, 1702002, 1702013)

tab DR1QFOOD if inrange(DR1QFOOD, 1501017, 1501025) | inrange(DR1QFOOD, 1501029, 1501037) | DR1QFOOD==1501041 | DR1QFOOD==1501185 | DR1QFOOD==1501226
codebook DR1QFOOD if inrange(DR1QFOOD, 1501017, 1501025) | inrange(DR1QFOOD, 1501029, 1501037) | DR1QFOOD==1501041 | DR1QFOOD==1501185 | DR1QFOOD==1501226, compact
replace FoodGroupV1=40 if inrange(DR1QFOOD, 1501017, 1501025) | inrange(DR1QFOOD, 1501029, 1501037) | DR1QFOOD==1501041 | DR1QFOOD==1501185 | DR1QFOOD==1501226

tab DR1QFOOD if inrange(DR1QFOOD, 1501246, 1501249)
replace FoodGroupV1=40 if inrange(DR1QFOOD, 1501246, 1501249)

* Grupo 41 (Vino):
tab DR1QFOOD if inrange(DR1QFOOD, 1802001, 1802012)
codebook DR1QFOOD if inrange(DR1QFOOD, 1802001, 1802012), compact
replace FoodGroupV1=41 if inrange(DR1QFOOD, 1802001, 1802012)

* Grupo 42 (Cerveza y sidra):
tab DR1QFOOD if inrange(DR1QFOOD, 1801001, 1801006)
replace FoodGroupV1=42 if inrange(DR1QFOOD, 1801001, 1801006)

tab DR1QFOOD if DR1QFOOD==1501245
replace FoodGroupV1=42 if DR1QFOOD==1501245

* Grupo 43 (Bebidas destiladas):
tab DR1QFOOD if inrange(DR1QFOOD, 1803001, 1803005) | inrange(DR1QFOOD, 1804001, 1804010)
codebook DR1QFOOD if inrange(DR1QFOOD, 1803001, 1803005) | inrange(DR1QFOOD, 1804001, 1804010), compact
replace FoodGroupV1=43 if inrange(DR1QFOOD, 1803001, 1803005) | inrange(DR1QFOOD, 1804001, 1804010)

* Grupo 44 (Marisco):
tab DR1QFOOD if inrange(DR1QFOOD, 0601001, 0601014) | DR1QFOOD==0602001 | DR1QFOOD==0602002 | inrange(DR1QFOOD, 0602004, 0602009) | inrange(DR1QFOOD, 0602011, 0602015)
codebook DR1QFOOD if inrange(DR1QFOOD, 0601001, 0601014) | DR1QFOOD==0602001 | DR1QFOOD==0602002 | inrange(DR1QFOOD, 0602004, 0602009) | inrange(DR1QFOOD, 0602011, 0602015), compact
replace FoodGroupV1=44 if inrange(DR1QFOOD, 0601001, 0601014) | DR1QFOOD==0602001 | DR1QFOOD==0602002 | inrange(DR1QFOOD, 0602004, 0602009) | inrange(DR1QFOOD, 0602011, 0602015)

tab DR1QFOOD if DR1QFOOD==1501051
replace FoodGroupV1=45 if DR1QFOOD==1501051

* Grupo 45 (Queso procesados):
tab DR1QFOOD if inrange(DR1QFOOD, 0206001, 0206008)
replace FoodGroupV1=45 if inrange(DR1QFOOD, 0206001, 0206008)

drop if DR1QFOOD==1500000 | DR1QFOOD==1900002

forvalues y=1/45{
codebook SEQN if FoodGroupV1==`y', compact
}

keep SEQN DR1NEWFOOD FoodGroupV1
order SEQN DR1NEWFOOD FoodGroupV1
sort SEQN

collapse (sum) DR1NEWFOOD, by(SEQN FoodGroupV1)
tab FoodGroupV1
codebook SEQN FoodGroupV1 DR1NEWFOOD, compact

reshape wide DR1NEWFOOD, i(SEQN) j (FoodGroupV1)

codebook DR1NEWFOOD1-DR1NEWFOOD45, compact

recode DR1NEWFOOD1-DR1NEWFOOD45 (.=0)
codebook DR1NEWFOOD1-DR1NEWFOOD45, compact

save "S:\LAB_RFJ\LAB\María\TFM_STATA\DATOS\2024.11.14.Consumo por grupo de alimentos_Infl_legoils_V1.dta", replace