data tmp;
infile "lab9.txt";
input unem inf;
run;

proc reg;
model inf = unem;
run;

proc reg;
model inf = unem /dw;
run;

proc autoreg;
model inf = unem /dwprob;
run;

proc reg;
model inf = unem;
output out = sample residual = e;
run;

data sample;
set sample;
le = lag(e);
run;

proc reg data=sample
outest = beta (keep = le rename=(le=rho));
model e = le;
run;

data sample;
set sample;
if _n_ = 1 then set beta;
run;

data sample;
set sample;
dinf = inf - rho*lag(inf);
dunem = unem - rho*lag(unem);
drop e le;
run;

proc reg data=sample;
model dinf = dunem;
title3 "Cochrane-Orcutt method: round 1";
run;

proc autoreg;
model inf = unem / nlag=1 method = ml;
title3 'MLE of AR(1)';
run;
