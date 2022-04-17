data tmp;
infile "rental.txt";
input rent pop avginc pctstu city year;
lpop = log(pop);
lrent = log(rent);
lavginc = log(avginc);
if year = 90 then y90 = 1;
else y90 = 0;
run;

proc print;
run;

proc reg;
model lrent = lpop lavginc pctstu y90;
run;

proc tscsreg fixone;
fixed: model lrent = y90 lpop lavginc pctstu;
id city year;
run;

proc tscsreg fixtwo;
fixed: model lrent = y90 lpop lavginc pctstu;
id city year;
run;

proc tscsreg ranone;
fixed: model lrent = y90 lpop lavginc pctstu;
id city year;
run;
