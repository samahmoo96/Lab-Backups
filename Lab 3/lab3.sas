data cal;
infile 'lab_3.txt';
input year;

data lab2;
infile 'lab_2.txt';
input c pi;

data tmp;
set cal lab2;

proc print data=tmp;
title2 'Set command';
run;

data tmp2;
merge cal lab2;

proc print data=tmp2;
title2 'Merge command';
run;

data tmp3;
input year;
datalines;
1996
1997
1998
1999
2000
2001
2002
;

data tmp4;
set cal tmp3;

proc print data=tmp4;
title2 'All years';
run;

data final;
merge tmp4 lab2;

proc print data=final;
title2 'Complete table merge';
run;
