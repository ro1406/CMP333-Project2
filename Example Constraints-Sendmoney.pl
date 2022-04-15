% CRYPTARITHMETIC.pl
% Constraint Satisfaction Programming examples
% Copyright © 2004-2022 Michel Pasquier
%
% orig from CSP Manual @ http://www.swi-prolog.org/man/clpfd.html

% Load the CSP module:
:- use_module(library(clpfd)).
%
% (suppress some warning messages)
:-style_check(-discontiguous).
:-style_check(-singleton).


% Define the classic cryptarithmetic puzzle below (the "hello world" of CSP :),
% where different letters denote distinct integers between 0 and 9.
%
% Puzzle:       S E N D        Solution:      9 5 6 7
%          +    M O R E                   +   1 0 8 5
%          ------------                   -----------
%          =  M O N E Y                   = 1 0 6 5 2
%

sendmoney_puzzle(Digits) :-
    Digits = [S,E,N,D,M,O,R,Y],            % variables used and domains:
    Digits ins 0..9,                       % all in the same range 0..9
    S #\= 0, M #\= 0,                      % except S and M cannot be 0
    all_different(Digits),                 % constraints: all must be different
                 S*1000 + E*100 + N*10 + D %              and the sum must work
    +            M*1000 + O*100 + R*10 + E
    #= M*10000 + O*1000 + N*100 + E*10 + Y.

% Query showing how constraint solver can deduce more stringent bounds for all
% variables (the model being kept separate from the search):
%?- sendmoney_puzzle(Digits).

% Query showing how labeling can then be used to search for solutions:
?- sendmoney_puzzle(Digits), label(Digits).
%
% Solution found:
% Digits = [9, 5, 6, 7, 1, 0, 8, 2]

% (This is the only solution; but there are several if we allow leading 0s.)


% Variant with more fanciful format and labelling included:
sendmoney_puzzle2([S,E,N,D] + [M,O,R,E] = [M,O,N,E,Y]) :-
    Vars = [S,E,N,D,M,O,R,Y],
    Vars ins 0..9, S #\= 0, M #\= 0, all_different(Vars),
                 S*1000 + E*100 + N*10 + D
    +            M*1000 + O*100 + R*10 + E
    #= M*10000 + O*1000 + N*100 + E*10 + Y,
	label(Vars).

% Query to solve the puzzle:
?- sendmoney_puzzle2(As + Bs = Cs).
%
% As = [9, 5, 6, 7],
% Bs = [1, 0, 8, 5],
% Cs = [1, 0, 6, 5, 2]


% Using a predicate and custom formatting:
sendmoney_puzzle3 :- sendmoney_puzzle2(SEND + MORE = MONEY), 
                     writeln(SEND), write(' + '), writeln(MORE),
					 write(' = '), writeln(MONEY).
%
?- sendmoney_puzzle3.
% [9, 5, 6, 7] + [1, 0, 8, 5] = [1, 0, 6, 5, 2]


% EOF