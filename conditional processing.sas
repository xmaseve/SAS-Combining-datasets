data southamerican;
   title "South American World Cup Finalists from 1954 to 1998";
   input  Year $  Country $ 9-23 Score $ 25-28 Result $ 32-36;
   datalines;
1998    Brazil          0-3    lost
1994    Brazil          3-2    won
1990    Argentina       0-1    lost
1986    Argentina       3-2    won
1978    Argentina       3-1    won 
1970    Brazil          4-1    won
1962    Brazil          3-1    won
1958    Brazil          5-2    won
;

data european;
   title "European World Cup Finalists From 1954 to 1998";
   input  Year $  Country $ 9-23 Score $ 25-28 Result $ 32-36;
   datalines;
1998    France          3-0    won
1994    Italy           2-3    lost
1990    West Germany    1-0    won
1986    West Germany    2-3    lost
1982    Italy           3-1    won
1982    West Germany    1-3    lost
1978    Holland         1-2    lost
1974    West Germany    2-1    won
1974    Holland         1-2    lost
1970    Italy           1-4    lost
1966    England         4-2    won
1966    West Germany    2-4    lost
1962    Czechoslovakia  1-3    lost
1958    Sweden          2-5    lost
1954    West Germany    3-2    won
1954    Hungary         2-3    lost
;

proc sort data=southamerican;
   by year; 
run;

proc print data=southamerican;
   title 'World Cup Finalists:';
   title2 'South American Countries';
   title3 'from 1954 to 1998';
run;

proc sort data=european; 
   by year;
run;

proc print data=european;
   title 'World Cup Finalists:';
   title2 'European Countries';
   title3 'from 1954 to 1998';
run;

data finalists;
   set southamerican (in=S) european;
   by Year;
   if S then Continent='South America';
   else Continent='Europe';
run;

proc print data=finalists;
   title 'World Cup Finalists';
   title2 'from 1954 to 1998';
run;

data timespan (keep=YearsSouthAmerican keep=YearsEuropean); 
   set southamerican (in=S) european  end=LastYear;
   by Year;
   if result='won' then     
      do;
         if S then SouthAmericanWins+1;
         else EuropeanWins+1;
      end;
   if lastyear then
      do;
         YearsSouthAmerican=SouthAmericanWins*4;
         YearsEuropean=EuropeanWins*4;
         output;
      end;

proc print data=timespan;
   title 'Total Years as Reigning World Cup Champions';
   title2 'from 1954 to 1998';
run;


