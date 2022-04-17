data tmp;
infile "lab11.txt";
input favwin spread favhome fav25 und25;
run;

proc means;
run;

proc reg;
model favwin = spread;
test intercept = .5;
test spread = 10;
run;

proc reg outest = sample (keep = intercept spread rename= (intercept = b0 spread = b1));
model favwin = spread favhome fav25 und25;
test spread = favhome = fav25 = und25;
run;

data tmp;
  set sample;
  rename intercept = b0 spread = b1;
  pre = b0 + b1*10;
  file print;
  put 'Predicted probability of winning by LPM is' /
      pre;
run;

proc logistic descending data = tmp
outest = sample (keep = intercept spread
rename= (intercept = b0 spread = b1));
model favwin = spread / link=normit;
test intercept = 0;
test spread = 10;
run;

proc logistic descending data = tmp
outest = sample (keep = intercept spread
rename= (intercept = b0 spread = b1));
model favwin = spread favhome fav25 und25 / link=normit;
test spread = favhome = fav25 = und25;
run;

data tmp;
set sample;
pre = b0 + b1*10;
pre = probnorm(pre);
file print;
put 'Predicted probability of winning by the probit model is' /
pre;
run;
