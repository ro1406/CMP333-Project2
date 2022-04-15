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

magicTriangle(Sum,[A,B,C,D,E,F]) :-
    Vars=[A,B,C,D,E,F],
    Vars ins 1..6, 
    all_different(Vars),
    A+B+C #= Sum,
    C+D+E #= Sum,
    E+F+A #= Sum,
	label(Vars).

% Your example queries go here
% ?- magicTriangle(9,Circles).
?- magicTriangle(10,Circles).
% ?- magicTriangle(11,Circles),
% ?- magicTriangle(12,Circles).