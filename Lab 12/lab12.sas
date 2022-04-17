data stock;
infile 'sp500.txt';
input sp500;
date = intnx('month', '31dec1946'd, _n_);
format date monyy.;
run;

proc gplot data=stock;
plot sp500*date;
run;

data stock1;
set stock;
if date > '30jun91'd then delete;
run;

data stock2;
set stock;
if date < '30jun91'd then delete;
run;

proc arima data=stock;
identify var=sp500(1) nlags=24 esacf p=(1:12) q = (0:12);
run;

proc arima data=stock1;
identify var=sp500(1);
estimate q=2 method = ml;
forecast out=tmp lead=24 id=date interval=month;
run;

data tmp;
set tmp;
if date < '30jun91'd then delete;
run;

data final;
merge tmp stock2;
run;

proc print data=final;
run;

proc gplot data=final;
plot sp500*date = '+' FORECAST*date = '-'/overlay;
run;
