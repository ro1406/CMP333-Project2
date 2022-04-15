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

sendmoney_puzzle([S,E,N,D] + [M,O,R,E] = [M,O,N,E,Y]) :-
    Vars = [S,E,N,D,M,O,R,Y],
    C1 in 0..1, C2 in 0..1, C3 in 0..1,
    Vars ins 0..9, S #\= 0, M #\= 0, all_different(Vars),
    D+E#=Y+10*C1,
    N+R+C1#=E+10*C2,
    E+O+C2#=N+10*C3,
    S+M+C3#=O+10*M,
	label(Vars).

% Your example queries go here
?- sendmoney_puzzle(As+Bs=Cs).