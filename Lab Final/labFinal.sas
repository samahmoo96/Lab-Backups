data tmp;
infile "lab11.txt";
input favwin spread favhome fav25 und25;
if spread < 3 then delete;
run;

proc means data=tmp;
run;

data tmp2;
infile "lab11.txt";
input favwin spread favhome fav25 und25;
if spread >= 3 then delete;
run;

proc means data=tmp2;
run;

data tmp3;
infile "lab11.txt";
input favwin spread favhome fav25 und25;
if fav25 = 0 then delete;
if favhome = 0 then delete;
run;

proc means data=tmp3;
run;

data tmp4;
infile "lab11.txt";
input favwin spread favhome fav25 und25;
if fav25 = 0 then delete;
if und25 = 0 then delete;
run;

proc means data=tmp4;
run;

data tmp5;
infile "lab11.txt";
input favwin spread favhome fav25 und25;
run;

proc reg data=tmp5;
model spread = favhome fav25 und25;
test favhome = fav25 = und25 = 0;
run;

proc reg data=tmp5 outest = sample (keep = intercept spread rename= (intercept = b0 spread = b1));
model spread = favhome fav25 und25;
test intercept = 0;
test favhome = fav25 = und25 = 0;
run;

data tmp6;
  set sample;
  rename intercept = b0 spread = b1;
  pre = b0 + b1*10;
  file print;
  put 'Predicted probability of winning by LPM is' /
      pre;
run;

proc logistic descending data = tmp5
outest = sample (keep = intercept spread
rename= (intercept = b0 spread = b1));
model spread = favwin fav25 und25 / link=normit;
test intercept = 0;
test spread = 10;
run;
