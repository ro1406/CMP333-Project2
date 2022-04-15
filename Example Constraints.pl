% CONSTRAINTS-EXAMPLES.pl
% Constraint Satisfaction Programming (CSP) examples
% Copyright © 2004-2022 Michel Pasquier
%

% CSP is useful for optimizing search problems by reducing search spaces, and
% for solving a wide variety of "find values for these variables" problems:
%
% Scheduling problems e.g.: When should we do which task to make these products?
% Optimization problems e.g.: Which products should we make to maximize profits?
% Satisfying problems e.g.: Which arrangement of rooms in a hospital will meet
%     many criteria incl. having the operating theater near the recovery rooms?
%     or: Which vacation plan will the whole family agree on?
% Sequencing problems e.g.: Which travel itinerary gets us to our destination?
% Labeling problems e.g.: Sudoku or Cryptarithm puzzles
% Problems of belief and intention e.g.: Detective puzzles and NPC’s in games
% Allocation problems e.g.: Which assignment of flight crews to aircraft will
%     meet union requirements for maximum time away from home?
% Finding acceptable solutions to linked sets of variables e.g.: Who will go to
%     the party when X will only go if Y goes, but Y won’t go if Z goes, etc.
% Creating lists of acceptable alternatives for multiple interacting variables
%     e.g., which banquet menu will meet criteria of cost, scheduling cooks and
%     waiters, ovens, and so on, then which to select?
% Geometric constraints for computer vision and graphics e.g.: Some CAD system
%     where 2 lines must be perpendicular, 2 others parallel within 2 cm, etc.
%

% References
%
% http://en.wikibooks.org/wiki/Prolog/Constraint_Logic_Programming
% CSP Manual @ http://www.swi-prolog.org/man/clpfd.html
% Tutorials  @ http://www.pathwayslms.com/swipltuts/clpfd/clpfd.html
%      also  @ https://github.com/Anniepoo/swiplclpfd/blob/master/clpfd.adoc
%

% Load the CSP module:
:- use_module(library(clpfd)).
%
% (suppress some warning messages)
:-style_check(-discontiguous).
:-style_check(-singleton).


% Sample query: Find X and Y such that X>Y, and X in [1,5], and Y=2 ?

% Native Prolog may not work depending on the order of the statements (error:
% "X not sufficiently instantiated") e.g.:
%?- X > Y, member(X,[1,2,3,4,5]), Y = 2.
%
% Native Prolog will then work fine if reordering the conjuncts properly:
%?- member(X,[1,2,3,4,5]), Y = 2, X > Y.
%
% Then, solutions are provided one at a time; one must explicitly ask for the
% others (either manually or by forcing repetition programmatically):
% X = 3, Y = 2 ;
% X = 4, Y = 2 ;
% X = 5, Y = 2

% Using CSP, the order does not matter e.g., constraints followed by domains:
?- X #> Y, X in 1..5, Y=2.
%
% or, specifying variables and domains first, followed by their constraints:
?- X in 1..5, Y = 2, X #> Y.
%
% Solutions are by default provided in a concise format e.g., using sets:
% Y = 2, X in 3..5.
%
% Using CSP, one can mimic Prolog's behavior, forcing repetition (backtracking)
% and showing all solutions by using labels:
?- X in 1..5, Y = 2, X #> Y, label([X,Y]).
% X = 3, Y = 2 ;
% X = 4, Y = 2 ;
% X = 5, Y = 2


% Another query: Find X and Y such that X>2*Y and X in [2,5] and Y in [1,3] ?

% Using CSP:
?- X in 2..5, Y in 1..3, X #> 2*Y, label([X,Y]).
% X = 3, Y = 1 ;
% X = 4, Y = 1 ;
% X = 5, Y = 1 ;
% X = 5, Y = 2


% CLP(FD) works with integers; there are other modules that handle real numbers
% (i.e. real-valued variables and constraints) etc. Basic CLP(FD) operators:
% #>=, #=<, #=, #\=, #>, #<, +, -, *, /, min, max, ^ (exp), abs, mod, rem.


% Predicates and sample queries:

% To define and reuse a query many times, one can make it a predicate e.g.:
sol(X,Y) :- X in 2..5, Y in 1..3, X #> 2*Y.

% Such predicates can be used in all directions i.e., to test an answer, to 
% find an answer, or any combination thereof. Examples:
?- sol(3,1).
% true
%?- sol(1,1)
% false.
?- sol(X,1).
% X in 3..5
?- sol(3,Y).
% Y = 1

?- sol(X,Y).
% X in 3..5, 2*Y+1#=<X, Y in 1..2.
?- sol(X,Y), label([X,Y]).
% X = 3, Y = 1 ;   X = 4, Y = 1 ;   X = 5, Y = 1 ;   X = 5, Y = 2.


% Solving (in)equations:

?- X #> 3.
% X in 4..sup
?- X #\= 20.
% X in inf..19\/21..sup
%
?- 2*X #= 10.
% X = 5
?- X*X #= 25.
% X in -5\/5
?- X*X #= 25, X#>0.
% X = 5

% The \/ operator denotes the union of domains e.g. -5\/5 means either -5 or 5.
% For example a Boolean variable can be defined as: boolvar in 0\/1
% The in operator constrains a single variable, ins constrains many variables;
% so for instance X in 1..5, Y in 1..5 is the same as [X,Y] ins 1..5


% Solving a linear system:

?- 4*X + 2*Y #= 24, X + Y #= 9, [X,Y] ins 0..sup.
% X = 3, Y = 6

% Same but listing domain first then the constraints:
%
?- [X,Y] ins 0..sup,
   4*X + 2*Y #= 24,
   X + Y #= 9.
% X = 3, Y = 6

% It is the same for any CSP! Define variables, their domain, the constraints,
% then let the CSP search algorithm automatically solve the problem. That's it!


% Using predicates again:
%
sys(X,Y,K) :- 4*X + 2*Y #= K, X + Y #= 9, [X,Y] ins 0..sup.

% Same as above:
sys(X,Y,24).
% X = 3, Y = 6
% But also:
sys(X,Y,36).
% X = 9, Y = 0


% Higher-order functions are also available (declarative programming is also
% functional programming). E.g.
?- Vs = [A,B,C,D], Vs ins 1..4, all_different(Vs),
   A #< B, C #< D, A #< C,                       % to remove symmetric answers
   findall( pair(A,B)-pair(C,D), label(Vs), Ms). % repeat to find all solutions


% EOF