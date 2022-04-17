data tmp;
infile "wine.txt";
input Q S Pw Pb A Y;
lQ = log(Q);
lS = log(S);
lPw = log(Pw);
lPb = log(Pb);
lA = log(A);
lY = log(Y);
run;

proc reg;
model lQ = lPw lPb lY lA;
title3 'Demand Function Using OLS';
run;

proc reg;
model lQ = lPw lS;
title3 'Supply Function Using OLS';
run;

proc syslin 2sls;
  endogenous lQ lPw;
  instruments lPb lY lA lS;
  demand: model lQ = lPw lPb lY lA;
  title3 'IV for demand';
run;

proc syslin 2sls;
  endogenous lQ lPw;
  instruments lS lPb;
  supply: model lQ = lPw lS;
  title3 'IV for supply: Use Pb';
run;

proc syslin 2sls;
  endogenous lQ lPw;
  instruments lS lA;
  supply: model lQ = lPw lS;
  title3 'IV for supply: Use lA';
run;

proc syslin 2sls;
  endogenous lQ lPw;
  instruments lS lY;
  supply: model lQ = lPw lS;
  title3 'IV for supply: use lY';
run;

proc syslin 2sls;
  endogenous lQ lPw;
  instruments lS lPb lA lY;
  supply: model lQ = lPw lS;
  title3 'IV for supply: Use All';
run;

proc syslin 2sls first;
  endogenous lQ lPw;
  instruments lS lPb lA lY;
  demand: model lQ = lPw lPb lA lY / overid;
  supply: model lQ = lPw lS / overid;
  title3 'Demand-Supply of Wine by 2sls';
run;
