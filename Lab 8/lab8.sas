data tmp;
infile "smoke.txt";
input cigs income cigpric educ age restauran;
lincome = log(income);
lcigpric = log(cigpric);
age2 = age**2;
run;

proc reg;
model cigs = lincome lcigpric educ age age2 restauran / acov spec;
run;

proc reg data=tmp;
model cigs = lincome lcigpric educ age age2 restauran / acov spec;
output out = sample r = uhat;
run;

data sample;
set sample;
uhat2 = uhat**2;
luhat2 = log(uhat2);
run;

proc reg;
model luhat2 = lincome lcigpric educ age age2 restauran;
output out = sample p = ghat;
run;

data sample;
set sample;
hhat = 1/exp(ghat);
run;

proc reg;
model cigs = lincome lcigpric educ age age2 restauran / spec;
weight hhat;
title3 'Weighted Regression';
run;
