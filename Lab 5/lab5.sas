data vote;
infile "vote.txt";
input voteA expendA expendB prtystrA;
lexpendA = log(expendA);
lexpendB = log(expendB);
eA = expendA * 1000;
eB = expendB * 1000;
leA = log(eA);
leB = log(eB);
diff = leB - leA;
run;

proc means;
run;

proc reg;
model voteA = eA eB prtystrA;
output out=tmp1;
run;

proc print data=tmp1;
run;

proc reg;
model voteA = leA leB prtystrA;
output out=tmp2;
test leA = -leB;
run;

proc print data=tmp2;
run;

proc reg;
model voteA = leA diff prtystrA;
run;
