data tmp;
infile "mlb1.txt";
input salary years gamesyr bavg hrunsyr runsyr fldperc allstar frstbase scndbase thrdbase shrtstop outfield catcher;
lsalary = log(salary);
run;

proc print data=tmp;
var frstbase scndbase thrdbase shrtstop outfield catcher;
option obs=15;
run;

proc reg;
model lsalary = years gamesyr bavg hrunsyr runsyr fldperc allstar frstbase scndbase thrdbase shrtstop outfield catcher;
run;

proc reg;
model lsalary = years gamesyr bavg hrunsyr runsyr fldperc allstar;
run;

proc reg;
model lsalary = years gamesyr bavg hrunsyr runsyr fldperc allstar outfield catcher;
test outfield = catcher;
run;



data tmp2;
infile "mlb2.txt";
input salary years gamesyr bavg hrunsyr runsyr fldperc allstar black hispan percblck perchisp;
bpercblck = black*percblck;
hperchisp = hispan*perchisp;
lsalary = log(salary);
run;

proc reg;
model lsalary = years gamesyr bavg hrunsyr runsyr fldperc allstar black hispan bpercblck hperchisp;
run;
