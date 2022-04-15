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

magicTriangle(sum) :-
    [A,B,C,D,E,F] ins 1..6, 
    all_different(nums),
    A+B+C #= sum,
    C+D+E #= sum,
    E+F+A #= sum,
	label(sum).

% Your example queries go here
% ?- magicTriangle(9).
?- magicTriangle(10).
% ?- magicTriangle(11),
% ?- magicTriangle(12).