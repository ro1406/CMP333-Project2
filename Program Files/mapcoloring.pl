% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space
:- use_module(library(clpfd)).
:- style_check(-discontiguous).
:- style_check(-singleton).

% Your program goes here
colouring(Country) :-
    Country= [Germany,Poland,CzechRepublic,Slovakia,Austria,Hungary,Switzerland,Italy,Slovenia],
    Country ins 1..4,
    Germany#\=Poland, Germany#\=CzechRepublic, Germany#\=Austria, Germany#\=Switzerland,
    Poland#\=CzechRepublic, Poland#\=Slovakia,
    CzechRepublic#\=Austria, CzechRepublic#\=Slovakia,
    Slovakia#\=Austria, Slovakia#\=Hungary,
    Hungary#\=Austria, Hungary#\=Slovenia,
    Austria#\=Slovenia, Austria#\=Italy, Austria#\=Switzerland,
    Switzerland#\=Italy,
    Slovenia#\=Italy,
    label(Country).