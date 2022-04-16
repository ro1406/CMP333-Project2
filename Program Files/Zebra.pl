% Constraint Logic Programming
:- use_module(library(dif)).	% Sound inequality
:- use_module(library(clpfd)).	% Finite domain constraints
:- use_module(library(clpb)).	% Boolean constraints
:- use_module(library(chr)).	% Constraint Handling Rules
:- use_module(library(when)).	% Coroutining
%:- use_module(library(clpq)).  % Constraints over rational numbers

% Your program goes here

zebra([Zebra,Water]):-
	Color=[Red,Green,Blue,White,Yellow],
    Nationality=[English,Spaniard,Italian,Norwegian,Japanese],
    Drink=[Tea,Coffee,Milk,Fruit_Juice,Water],
    Pets = [Dog,Snail,Fox,Zebra,Horse],
    Profession = [Painter,Diplomat,Doctor,Violinist,Sculptor],
    
    Color ins 1..5,
    Nationality ins 1..5,
    Drink ins 1..5,
    Pets ins 1..5,
    Profession ins 1..5,
    
    all_different(Color),
    all_different(Nationality),
    all_different(Drink),
    all_different(Pets),
    all_different(Profession),
    
    English#=Red,
    Spaniard#=Dog,
    Japanese#=Painter,
    Italian#=Tea,
    Norwegian#=1,
    Green#=Coffee,
    Green#=White+1,
    Sculptor#=Snail,
    Diplomat#=Yellow,
    Milk#=3,
    (Norwegian#=Blue+1#\/Norwegian#=Blue-1),
    Violinist#=Fruit_Juice,
    (Fox#=Doctor+1#\/Fox#=Doctor-1),
    (Horse#=Diplomat+1#\/Horse#=Diplomat-1),
    
    %flatten([Nationality, Color, Profession, Pets, Drink], List),
    label([Zebra,Water]).
    
    

/*
 * Five men live in five different colored houses in a street. 
 * They all have different nationalities, professions, drink preferences, and pets. 
You must find out who has a zebra and who drinks water, given the following information: 
The Englishman lives in the red house. 
The Spaniard has a dog. The Japanese is a painter. 
The Italian drinks tea. 
The Norwegian lives in the first house on the left. 
The owner of the green house drinks coffee.
The green house is on the right of the white house. 
The sculptor breeds snails. 
The diplomat lives in the yellow house. 
They drink milk in the middle house. 
The Norwegian lives next door to the blue house. 
The violinist drinks fruit juice. 
The fox is in the house next to the doctor’s. 
The horse is in the house next to the diplomat’s.
 * 
*/
?- zebra(Ans).