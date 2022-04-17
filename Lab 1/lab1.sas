*Task 1;
data tmp;
input year x;
cards;
1996 2.54
1997 3.15
1998 4.23
1999 5.56
2000 6.24
2001 7.89
2002 9.21
run;
proc print;
title 'Data File Printout';
footnote 'SAS program by Syed Mahmood';
run;
proc gplot;
plot x * year;
run;

*Task 2;
data CLASS;
	input F_Name$ ID Gender$ GPA Height Weight;
cards;
Hector 123 M 3.5 59 155
Nancy 328 F 3.7 52 99
Edward 747 M 2.4 62 205
Michele 778 F 3.5 54 115
run;
proc print;
title 'CLASS Dataset';
footnote 'SAS program by Syed Mahmood';
run;
