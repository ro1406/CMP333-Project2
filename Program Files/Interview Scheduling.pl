% Constraint Logic Programming
:- use_module(library(dif)).	% Sound inequality
:- use_module(library(clpfd)).	% Finite domain constraints
:- use_module(library(clpb)).	% Boolean constraints
:- use_module(library(chr)).	% Constraint Handling Rules
:- use_module(library(when)).	% Coroutining
:-style_check(-discontiguous).
:-style_check(-singleton).
%:- use_module(library(clpq)).  % Constraints over rational numbers

% Your program goes here

scheduleInterviews([A,B,C,D,E]) :-
    People = [A,B,C,D,E],
    People ins 1..5, all_different(People),
    A #>= 2, A #< 4, 			%Ali is busy before 2 and after 4
    B #\= 1,B #\= 3,B #\= 5,	%Ben does not like odd hours
    C #\= 2,C #\= 4,			%Cam has similar appointments at 2 and 4
    D #< 3,						%Don is free before 3
    E #>= 3,					%Eva only after 3
    label(People).             
	
scheduleInterviews2([A,B,C,D,E]) :- %Additional Constraint : Don Follows right after Cam
    People = [A,B,C,D,E],
    People ins 1..5, all_different(People),
    A #>= 2, A #< 4, 			%Ali is busy before 2 and after 4
    B #\= 1,B #\= 3,B #\= 5,	%Ben does not like odd hours
    C #\= 2,C #\= 4,			%Cam has similar appointments at 2 and 4
    D #< 3,						%Don is free before 3
    E #>= 3,					%Eva only after 3
    D #= C+1,					%Don follows right after Cam
    label(People).


% Your example queries go here
?- scheduleInterviews2(People).