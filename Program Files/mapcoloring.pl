% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space
:- use_module(library(clpfd)).
:- style_check(-discontiguous).
:- style_check(-singleton).

% Your program goes here
colouring(Country) :-
    Country= [A,B,C,D,E,F,G,H,I],
    Country ins 1..4,
    A#\=B, A#\=C, A#\=D, A#\=E, A#\=F, A#\=G, A#\=H, A#\=I,
    B#\=C, B#\=D, 
    C#\=E, C#\=D,
    D#\=E, D#\=H,
    E#\=F, E#\=G, E#\=H, E#\=I,
    F#\=G,
    G#\=I,
    H#\=I,
    label(Country).

    
/** <examples> Your example queries go here, e.g.
?- member(X, [cat, mouse]).

*/
