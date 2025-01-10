use "S:\LAB_RFJ\LAB\María\TFM_STATA\DATOS\2024.11.14.MasterDataBase.dta", clear
keep if visit==1
rename seqn SEQN

merge 1:1 SEQN using "S:\LAB_RFJ\LAB\María\TFM_STATA\DATOS\2024.11.14.Consumo por grupo de alimentos_Infl_legoils_V1.dta"
drop if _merge!=3
drop _merge

* Regresión de rango reducido (RRR) para derivar un patrón dietético
rrr bpxsym bpxdim lbxglu lbxtr bmxwaist lbxhdd, x(DR1NEWFOOD1-DR1NEWFOOD45) rank(6) savevar loadings

* Cálculo de la mediana de la adherencia al patrón dietético cardiometabólico (PDCM)
xtile MedianPatternDCMf1=f1, nq(2)

* Covariables de los modelos
gen Current_smoker=cond(psqto000==., ., cond(psqto000==0 | psqto000==2, 0, 1))
label define Current_smoker 0 "Non-smoker" 1 "Smoker"
label val Current_smoker Current_smoker

gen University=cond(psqeduca==., ., cond(psqeduca==0 | psqeduca==1 | psqeduca==2 | psqeduca==3, 0, 1))
label define Univeristy 0 "No" 1 "Yes"
label val University University

gen BMI=bmxwt/((bmxht/100)*(bmxht/100))
gen Obesity=cond(BMI==., ., cond(BMI<30, 0, 1))
label val University Obesity

gen Dyslipidemia=0
replace Dyslipidemia=1 if lbxtc>=240 | lbdldl>=160 | lbxhdd<40
replace Dyslipidemia=. if lbxtc==. | lbdldl==. | lbxhdd==.
label val University Dyslipidemia

gen Sleep_hours=apaq62/60

gen CO_USA=0
replace CO_USA=1 if dr1tsex==1 & bmxwaist>=102
replace CO_USA=1 if dr1tsex==2 & bmxwaist>=88
replace CO_USA=. if bmxwaist==.

gen CO_Europe=0
replace CO_Europe=1 if dr1tsex==1 & bmxwaist>=94
replace CO_Europe=1 if dr1tsex==2 & bmxwaist>=80
replace CO_Europe=. if bmxwaist==.

gen SobOb=cond(BMI==., ., cond(BMI<25, 0, 1))

* Variables de aterosclerosis
xtile CACS_cat=tacsctot if tacsctot!=0 & tacsctot!=., nq(3)
replace CACS_cat=0 if tacsctot==0

xtile E3Dburden_cat=e3dburdenc if e3dburdenc!=0 & e3dburdenc!=. & e3dfcalidi!=3 & e3dfcalidd!=3 & e3dccalidi!=3 & e3dccalidd!=3, nq(3)
replace E3Dburden_cat=0 if e3dburdenc==0 & e3dfcalidi!=3 & e3dfcalidd!=3 & e3dccalidi!=3 & e3dccalidd!=3

xtile E3Dburden_car_cat=e3dcrawcsum if e3dcrawcsum!=0 & e3dcrawcsum!=. & e3dccalidi!=3 & e3dccalidd!=3, nq(3)
replace E3Dburden_car_cat=0 if e3dcrawcsum==0 & e3dccalidi!=3 & e3dccalidd!=3

xtile E3Dburden_fem_cat=e3dfrawcsum if e3dfrawcsum!=0 & e3dfrawcsum!=. & e3dfcalidi!=3 & e3dfcalidd!=3, nq(3)
replace E3Dburden_fem_cat=0 if e3dfrawcsum==0 & e3dfcalidi!=3 & e3dfcalidd!=3

* Modelos logísticos ordinales entre las variables de aterosclerosis y la adherencia al PDCM
ologit CACS_cat i.MedianPatternDCMf1 psqage i.dr1tsex i.Current_smoker i.Dyslipidemia i.peqmh110 i.peqmh090 i.Obesity i.peqmh140 i.University Sleep_hours i.psqmarit totalmvpa
ologit, or
tab MedianPatternDCMf1 if e(sample)

ologit E3Dburden_cat i.MedianPatternDCMf1 psqage i.dr1tsex i.Current_smoker i.Dyslipidemia i.peqmh110 i.peqmh090 i.Obesity i.peqmh140 i.University Sleep_hours i.psqmarit totalmvpa
ologit, or
tab MedianPatternDCMf1 if e(sample)

ologit E3Dburden_car_cat i.MedianPatternDCMf1 psqage i.dr1tsex i.Current_smoker i.Dyslipidemia i.peqmh110 i.peqmh090 i.Obesity i.peqmh140 i.University Sleep_hours i.psqmarit totalmvpa
ologit, or
tab MedianPatternDCMf1 if e(sample)

ologit E3Dburden_fem_cat i.MedianPatternDCMf1 psqage i.dr1tsex i.Current_smoker i.Dyslipidemia i.peqmh110 i.peqmh090 i.Obesity i.peqmh140 i.University Sleep_hours i.psqmarit totalmvpa
ologit, or
tab MedianPatternDCMf1 if e(sample)