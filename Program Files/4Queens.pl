% Constraint Logic Programming
:- use_module(library(dif)).	% Sound inequality
:- use_module(library(clpfd)).	% Finite domain constraints
:- use_module(library(clpb)).	% Boolean constraints
:- use_module(library(chr)).	% Constraint Handling Rules
:- use_module(library(when)).	% Coroutining
%:- use_module(library(clpq)).  % Constraints over rational numbers

% 4-Queens Puzzle
% Author: Prem Rajendran

% Solving function
queens4(Q):-
    Q = [X1,X2,X3,X4],
    Q ins 1..4,
    all_different(Q),
    abs(X1-X2) #\= 1, abs(X1-X3) #\= 2, abs(X1-X4) #\= 3,
    abs(X2-X3) #\= 1, abs(X2-X4) #\= 2,
    abs(X3-X4) #\= 1,
    labeling([], Q).