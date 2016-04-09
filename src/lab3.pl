sine(X, Y) :- Y is sin(X).

%Example #3
%factorial(N, F) means "F is the factorial of N"

factorial(0, 1).
factorial(N, F) :-
	is(N_Prime, N-1),
	factorial(N_Prime, F_Prime),
	is(F, *(F_Prime, N)).


%fib(N, V) means "V is the N-th term in the fibonacci sequence
fib(0, 0).
fib(1, 1).
fib(N, V) :-
	N > 1,
	is(N_Prime, N-1),
	fib(N_Prime, V_Prime),
	is(N_Second, N-2),
	fib(N_Second, V_Second),
	is(V, +(V_Prime, V_Second)).

%Example #4
factorial_4(0, 1).
factorial_4(N, F) :-
	N > 0,
        N_Prime is N - 1,
	factorial_4(N_Prime, F_Prime),
	F is F_Prime * N.

%Example 5
factorial_5(0, 1) :-
	!.
factorial_5(N, F) :-
	N_Prime is N-1,
	factorial_5(N_Prime, F_Prime),
	F is F_Prime * N.

%Example 6
a.
b.
c.
goal :-
	a,b,!,0>1.
goal :- c.

% Example #8
% maximum(X, Y, Z) means "Z is the maximum between X and Y"
maximum(X,Y,X) :-
	X>=Y.
maximum(X,Y,Y) :-
	X<Y.

%minimum(X,Y,Z) means "Z is the minimum between X and Y"
minimum(X, Y, X) :-
	X=<Y,
	!.
%due to the prev. cut symbol, X is guaranteed to be
%greater than Y, and therefore, this works perfectly.
minimum(_, Y, Y).

%Homework abs.
abs(X, Y) :-
	X =< 0,
	Y is - X.
abs(X, X).

abs_1(X, X) :-
	X >= 0,
	!.
abs_1(X, Y) :-
	Y is -X,
	!.

%Homework divisor.
divisor(X, 0, X).
divisor(X, Y, D) :-
	Y>0,
	B_Prime is X mod Y,
	divisor(Y, B_Prime, D).

%Homework evaluating.
%The cut operator enforces the result it found,
%basically it goes back recursively, up to the root
%and it will delete all other possible branches.
%-----LEFT AT EVALUATING-------
evaluating(X+Y, R) :- plus(X, Y, R).
evaluating(X-Y, R) :- evaluating(X + Z, R), -Y =:= Z.


