data vote;
infile 'vote.txt';
input voteA expendA expendB prtystrA;
lexpendA = log(expendA);
lexpendB = log(expendB);
run;

proc means;
run;

proc corr;
var voteA lexpendA lexpendB prtystrA;
run;

proc reg;
model voteA = expendA expendB prtystrA;
run;

proc reg;
model voteA = lexpendA lexpendB prtystrA;
run;
