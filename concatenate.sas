/*Using the SET Statement: The Simplest Case*/
data sales;
   input EmployeeID $ 1-9 Name $ 11-29 @30 HireDate date9.
         Salary HomePhone $;
   format HireDate date9.;
   datalines;
429685482 Martin, Virginia   09aug1990 34800 493-0824
244967839 Singleton, MaryAnn 24apr1995 27900 929-2623
996740216 Leighton, Maurice  16dec1993 32600 933-6908
675443925 Freuler, Carl      15feb1998 29900 493-3993
845729308 Cage, Merce        19oct1992 39800 286-0519
;

proc print data=sales;
   title 'Sales Department Employees';
run;

data customer_support;
   input EmployeeID $ 1-9 Name $ 11-29 @30 HireDate date9.
         Salary HomePhone $;
   format HireDate date9.;
   datalines;
324987451 Sayre, Jay         15nov1994 44800 933-2998
596771321 Tolson, Andrew     18mar1998 41200 929-4800
477562122 Jensen, Helga      01feb1991 47400 286-2816
894724859 Kulenic, Marie     24jun1993 41400 493-1472
988427431 Zweerink, Anna     07jul1995 43700 929-3885
;

proc print data=customer_support;
   title 'Customer Support Department Employees';
run;

data one;
   set sales customer_support;
run;

proc print data=one;
   title 'Employees in Sales and Customer Support Departments';
run;

/*Using the SET Statement When Data Sets Contain Different Variables*/
data security;
   input EmployeeID $ 1-9 Name $ 11-29 Gender $ 30
         @32 HireDate date9. Salary;
   format HireDate date9.;
   datalines;
744289612 Saparilas, Theresa F 09may1998 33400
824904032 Brosnihan, Dylan   M 04jan1992 38200
242779184 Chao, Daeyong      M 28sep1995 37500
544382887 Slifkin, Leah      F 24jul1994 45000
933476520 Perry, Marguerite  F 19apr1992 39900
;
run;

data two;
   set sales customer_support security;
run;

proc print data=two;
   title 'Employees in Sales, Customer Support,';
   title2 'and Security Departments';
run;

/*Using the SET Statement When Variables Have Different Types*/
data accounting;
   input EmployeeID 1-9 Name $ 11-29 Gender $ 30
         @32 HireDate date9. Salary;
   format HireDate date9.;
   datalines;
634875680 Gardinski, Barbara F 29may1998 49800
824576630 Robertson, Hannah  F 14mar1995 52700
744826703 Gresham, Jean      F 28apr1992 54000
824447605 Kruize, Ronald     M 23may1994 49200
988674342 Linzer, Fritz      M 23jul1992 50400
;
run;

/*Change the type of the variable*/
data new_accounting (rename=(TempVar=EmployeeID)drop=EmployeeID);  
   set accounting; 
   TempVar=put(EmployeeID, 9.);  /*put statment converts numeric variable to character variable*/
run;

data three;
   set sales customer_support security new_accounting;
run;

proc print data=three;
   title 'Employees in Sales, Customer Support, Security,';
   title2 'and Accounting Departments';
run;

/*Using the SET Statement When Variables Have Different Formats, Informats, or Labels*/
data shipping;
   input employeeID $ 1-9 Name $ 11-29 Gender $ 30
         @32 HireDate date9.
         @42 Salary;
   format HireDate date7.
          Salary comma6.;
   datalines;
688774609 Carlton, Susan     F 28jan1995 29200
922448328 Hoffmann, Gerald   M 12oct1997 27600
544909752 DePuis, David      M 23aug1994 32900
745609821 Hahn, Kenneth      M 23aug1994 33300
634774295 Landau, Jennifer   F 30apr1996 32900
;
run;

data four;
   set shipping new_accounting security customer_support sales;
run;
proc print data=four;
   title 'Employees in Shipping, Accounting, Security,'; /*SAS uses the format that is defined in the first data set that is named in the SET statement*/
   title2 'Customer Support, and Sales Departments';  
run;


