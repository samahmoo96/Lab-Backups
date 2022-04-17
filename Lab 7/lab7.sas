data tmp;
infile "lab7.txt";
input prepop usgnp mincov t;
lprepop = log(prepop);
lmincov = log(mincov);
lusgnp = log(usgnp/1000);
trend = 1949 + t;
run;

proc gplot;
plot lprepop * trend = '*'
lmincov * trend = '-'
lusgnp * trend = '+' /overlay;
run;

proc reg;
model lprepop = lmincov lusgnp;
run;

proc reg;
model lprepop = lmincov lusgnp t;
run;

proc reg;
model lprepop = lmincov lusgnp trend;
run;

proc reg noprint;
model lprepop lmincov lusgnp = t;
output out=temp r = y x1 x2;
run;

proc reg;
model y = x1 x2;
run;
