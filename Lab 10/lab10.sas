data tmp;
infile "lab10.txt";
input salary sales roe ros;
lsalary = log(salary);
lsales = log(sales);
if ros < 0 then rosneg = 1;
if ros > 0 then rosneg = 0;
if ros = 0 then rosneg = 0;
run;

proc reg;
model lsalary = lsales roe rosneg;
output out = sample predicted = y;
run;

data tmp;
set sample;
py2 = y ** 2;
py3 = y ** 3;
run;

proc reg;
model lsalary = lsales roe rosneg py2 py3;
run;

proc autoreg;
model lsalary = lsales roe rosneg / RESET NORMAL;
run;


data tmp2;
infile "hprice.txt";
input price dist inst area land rooms baths age;
lprice = log(price);
ldist = log(dist);
linst = log(inst);
larea = log(area);
lland = log(land);
linst2 = linst ** 2;
ldist2 = ldist ** 2;
run;

proc reg;
model lprice = ldist;
run;

proc reg;
model lprice = ldist linst larea lland rooms baths age;
run;

proc reg;
model lprice = ldist linst linst2 larea lland rooms baths age;
run;

proc reg;
model lprice = ldist ldist2 linst linst2 larea lland rooms baths age;
run;
