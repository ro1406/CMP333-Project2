% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space
:- use_module(library(clpfd)).
:- style_check(-discontiguous).
:- style_check(-singleton).

% Your program goes here
sculptures(Animals):-
    Animals=[S,L,P],
    all_different(Animals),
    Animals ins 1..3,
    S#\=1, L#\=S+1, L#\=S-1,
    label(Animals).