% SUDOKU.pl
% Advanced Constraint Satisfaction Programming example
% Copyright © 2004-2022 Michel Pasquier
%
% orig from CSP Manual @ http://www.swi-prolog.org/man/clpfd.html
%

% Load the CSP module:
:- use_module(library(clpfd)).
%
% (suppress some warning messages)
:-style_check(-discontiguous).
:-style_check(-singleton).

% CSP solver:
%
sudoku(Rows) :- length(Rows, 9), maplist(length_(9), Rows),
                append(Rows, Vs), Vs ins 1..9,
                maplist(all_distinct, Rows),
                transpose(Rows, Columns),
                maplist(all_distinct, Columns),
                Rows = [A,B,C,D,E,F,G,H,I],
                blocks(A, B, C), blocks(D, E, F), blocks(G, H, I).

length_(L, Ls) :- length(Ls, L).

blocks([], [], []).
blocks([A,B,C|Bs1], [D,E,F|Bs2], [G,H,I|Bs3]) :-
                all_distinct([A,B,C,D,E,F,G,H,I]),
                blocks(Bs1, Bs2, Bs3).

% Sudoku problem no. 1:
%
problem(1, [[_,_,_,_,_,_,_,_,_],    % [9, 8, 7, 6, 5, 4, 3, 2, 1]
            [_,_,_,_,_,3,_,8,5],    % [2, 4, 6, 1, 7, 3, 9, 8, 5]
            [_,_,1,_,2,_,_,_,_],    % [3, 5, 1, 9, 2, 8, 7, 4, 6]
            [_,_,_,5,_,7,_,_,_],    % [1, 2, 8, 5, 3, 7, 6, 9, 4]
            [_,_,4,_,_,_,1,_,_],    % [6, 3, 4, 8, 9, 2, 1, 5, 7]
            [_,9,_,_,_,_,_,_,_],    % [7, 9, 5, 4, 6, 1, 8, 3, 2]
            [5,_,_,_,_,_,_,7,3],    % [5, 1, 9, 2, 8, 6, 4, 7, 3]
            [_,_,2,_,1,_,_,_,_],    % [4, 7, 2, 3, 1, 9, 5, 6, 8]
            [_,_,_,_,4,_,_,_,9]]).  % [8, 6, 3, 7, 4, 5, 2, 1, 9]

% Solution query:
%?- problem(1, Rows), sudoku(Rows), maplist(writeln, Rows).
%
% Make it a predicate
solve(N) :- problem(N, Rows), sudoku(Rows), maplist(writeln, Rows).

%?- solve(1).

% Hard puzzles from http://www.sudoku.ws/hard.htm :

problem(2, [[3,_,_,_,_,8,_,_,_],    % [3, 1, 9, 4, 5, 8, 7, 6, 2]
            [7,_,8,3,2,_,_,_,5],    % [7, 6, 8, 3, 2, 1, 9, 4, 5]
            [_,_,_,9,_,_,_,1,_],    % [5, 4, 2, 9, 7, 6, 3, 1, 8]
            [9,_,_,_,_,4,_,2,_],    % [9, 8, 5, 7, 3, 4, 6, 2, 1]
            [_,_,_,_,1,_,_,_,_],    % [6, 3, 4, 2, 1, 9, 8, 5, 7]
            [_,7,_,8,_,_,_,_,9],    % [2, 7, 1, 8, 6, 5, 4, 3, 9]
            [_,5,_,_,_,3,_,_,_],    % [1, 5, 7, 6, 9, 3, 2, 8, 4]
            [8,_,_,_,4,7,5,_,3],    % [8, 2, 6, 1, 4, 7, 5, 9, 3]
            [_,_,_,5,_,_,_,_,6]]).  % [4, 9, 3, 5, 8, 2, 1, 7, 6]

problem(3, [[_,_,_,1,_,_,4,6,_],    % [9, 3, 2, 1, 8, 7, 4, 6, 5]
            [1,_,_,_,_,5,_,_,_],    % [1, 8, 4, 3, 6, 5, 2, 9, 7]
            [7,_,5,_,9,2,8,3,_],    % [7, 6, 5, 4, 9, 2, 8, 3, 1]
            [8,7,_,_,_,_,_,_,_],    % [8, 7, 6, 2, 5, 4, 3, 1, 9]
            [_,_,3,8,1,6,7,_,_],    % [5, 9, 3, 8, 1, 6, 7, 2, 4]
            [_,_,_,_,_,_,_,5,8],    % [2, 4, 1, 9, 7, 3, 6, 5, 8]
            [_,1,9,7,3,_,5,_,2],    % [6, 1, 9, 7, 3, 8, 5, 4, 2]
            [_,_,_,6,_,_,_,_,3],    % [4, 5, 8, 6, 2, 1, 9, 7, 3]
            [_,2,7,_,_,9,_,_,_]]).  % [3, 2, 7, 5, 4, 9, 1, 8, 6]

% EOF