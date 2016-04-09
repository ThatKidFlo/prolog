loves(vincent, mia).
loves(marsellus, mia).
loves(pumpkin, honeyBunny).
loves(honeyBunny, pumpkin).

jealous(X, Y) :- loves(X, Z), loves(Y, Z), X \= Y.

% X is different from Y could be written as:
% \+ X = Y (i.e. NOT X = Y)
% X \= Y   (i.e. X DIFFERENT FROM Y)
% not(X = Y)

joe('John Doe').

%1.4 ------------------------------------------------------------
killer(butch).
married(mia, marsellus).
dead(zed).
kills(marsellus, X) :- givesFootMassage(X, mia), X \= marsellus.
loves(mia, X) :- isAGoodDancer(X).
eats(jules, X) :- isNutritious(X); isTasty(X).


vertical(line(point(X, _), point(X, _))).
horizontal(line(point(_, Y), point(_, Y))).
