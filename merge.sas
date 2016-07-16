/*Performing a Simple One-to-One Merge*/
data class;
   input Name $ 1-25 Year $ 26-34 Major $ 36-50;
   datalines;
Abbott, Jennifer         first
Carter, Tom              third     Theater
Kirby, Elissa            fourth    Mathematics
Tucker, Rachel           first
Uhl, Roland              second
Wacenske, Maurice        third     Theater
;
proc print data=class;
   title 'Acting Class Roster';
run;

data time_slot;
   input Date date9.  @12 Time $ @19 Room $;
   format date date9.;
   datalines;
14sep2000  10:00  103
14sep2000  10:30  103
14sep2000  11:00  207
15sep2000  10:00  105
15sep2000  10:30  105
17sep2000  11:00  207
;
proc print data=time_slot;
   title 'Dates, Times, and Locations of Conferences';
run;

data schedule;
   merge class time_slot;
run;

proc print data=schedule;
   title 'Student Conference Assignments';
run;

/*Performing a One-to-One Merge on Data Sets with the Same Variables*/
data class2;
   input Name $ 1-25 Year $ 26-34 Major $ 36-50;
   datalines;
Hitchcock-Tyler, Erin    second
Keil, Deborah            third     Theater
Nacewicz, Chester        third     Theater
Norgaard, Rolf           second
Prism, Lindsay           fourth    Anthropology
Singh, Rajiv             second
Wittich, Stefan          third     Physics
;
proc print data=class2;
   title 'Acting Class Roster';
   title2 '(second section)';
run;

data exercise;
   merge class (drop=Year Major)
         class2 (drop=Year Major rename=(Name=Name2))
         time_slot;
run;

proc print data=exercise;
   title 'Acting Class Exercise Schedule';
run;

/*Match-Merging Data Sets with Multiple Observations in a BY Group*/
data finance;
   input IdNumber $ 1-11 Name $ 13-40 Salary;
   datalines;
074-53-9892 Vincent, Martina             35000
776-84-5391 Phillipon, Marie-Odile       29750
929-75-0218 Gunter, Thomas               27500
446-93-2122 Harbinger, Nicholas          33900
228-88-9649 Benito, Gisela               28000
029-46-9261 Rudelich, Herbert            35000
442-21-8075 Sirignano, Emily             5000
;
proc sort data=finance;
   by IdNumber;
run;

data repertory;
   input Play $ 1-23 Role $ 25-48 IdNumber $ 50-60;
   datalines;
No Exit                 Estelle                  074-53-9892
No Exit                 Inez                     776-84-5391
No Exit                 Valet                    929-75-0218
No Exit                 Garcin                   446-93-2122
Happy Days              Winnie                   074-53-9892
Happy Days              Willie                   446-93-2122
The Glass Menagerie     Amanda Wingfield         228-88-9649
The Glass Menagerie     Laura Wingfield          776-84-5391
The Glass Menagerie     Tom Wingfield            929-75-0218
The Glass Menagerie     Jim O'Connor             029-46-9261
The Dear Departed       Mrs. Slater              228-88-9649
The Dear Departed       Mrs. Jordan              074-53-9892
The Dear Departed       Henry Slater             029-46-9261
The Dear Departed       Ben Jordan               446-93-2122
The Dear Departed       Victoria Slater          442-21-8075
The Dear Departed       Abel Merryweather        929-75-0218
;
proc sort data=repertory;
   by IdNumber;
run;

data repertory_name;
   merge finance repertory;
   by IdNumber;
run;

proc print data=repertory_name;
   title 'Little Theater Season Casting Assignments';
   title2 'with employee financial information';
run;

/*Using sql to do the same thing*/
proc sql;
select f.idnumber, f.name, r.play, r.role
from finance f, repertory r
where f.idnumber = r.idnumber;
quit;
