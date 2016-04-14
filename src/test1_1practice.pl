f(a).
f(b).

g(a).
g(b).

h(b).

% Following the way Prolog attempts to match, and therefore
% prove this rule, by using the 'trace.' predicate should shed
% some light into the innerworks of the inference machine.
k(X) :- f(X), g(X), h(X).

house_elf(dobby).
wizard('McGonagall').
witch(hermoine).
witch(rita_skeeter).

magic(X) :- house_elf(X).
magic(X) :- wizard(X).
magic(X) :- witch(X).

% what will magic(Hermoine) yield?

isDigesting(X, Y) :- justAte(X, Y).
isDigesting(X, Y) :-
	justAte(X, Z),
	isDigesting(Z, Y).

justAte(mosquito, blood(john)).
justAte(frog, mosquito).
justAte(stork, frog).

descendant(X, Y) :- child(X, Y).
descendant(X, Y) :- child(X, Z), descendant(Z, Y).

child(caroline, sarah).
child(sarah, maria).
child(maria, mike).

numeral(0).
numeral(succ(X)) :- numeral(X).

%building terms by recursion.
add(0, Y, Y).
add(succ(X), Y, succ(R)) :-
	add(X, Y, R).

%lists
isPresent(E, [E | _]).
isPresent(E, [_ | T]) :-
	isPresent(E, T).

removeFromList(E, [E | T], T).
removeFromList(E, [H | T], R) :-
	R = [H | Rp],
	removeFromList(E, T, Rp).

a2b([], []).
a2b([a | Ta], [b | Tb]) :- a2b(Ta, Tb).

%99 problems but a bitch ain't one
%1
lastEl(E, [E | []]) :- !.
lastEl(E, [_ | T]) :- lastEl(E, T).

%2
lastBeforeLast([], []) :- !.
lastBeforeLast(E, [E | T]) :- T = [_ | []].
lastBeforeLast(E, [_ | T]) :- lastBeforeLast(E, T), !.

%3
kThElement(E, 0, [E | _]).
kThElement(E, K, [_ | T]) :- kThElement(E, Kp, T), K is Kp + 1, !.

%4
countElements([], 0).
countElements([_ | T], R) :- countElements(T, Rp), R is Rp + 1.

%5
revList([], _).
revList([H | T], R) :- revList(T, [H | R]).

%russian dolls
directlyIn(irina, natasha).
directlyIn(natasha, olga).
directlyIn(olga, katarina).

in(X, Y) :- directlyIn(X, Y).
in(X, Y) :- directlyIn(X, Z), in(Z, Y).

directTrain(saarbruecken, dudweiler).
directTrain(forbach, saarbruecken).
directTrain(freynming, forbach).
directTrain(stAvold, freyming).
directTrain(fahlquemont, stAvold).
directTrain(metz, fahlquemont).
directTrain(nancy, metz).

travelFromTo(X, Y) :- directTrain(X, Y).
travelFromTo(X, Y) :- directTrain(X, Z), travelFromTo(Z, Y).

greaterThan(succ(_), 0).
greaterThan(succ(X), succ(Y)) :-
	greaterThan(X, Y),
	!.

%trees
swap(nil, nil).
swap(t(X, Y, Z), t(X, Z, Y)) :-
	atomic(Y), atomic(Z).
swap(t(R, LST, RST), t(R, SRST, SLST)) :-
	swap(LST, SLST),
	swap(RST, SRST),
	!.
%maze
connected(1, 2).
connected(3, 4).
connected(5, 6).
connected(7, 8).
connected(9, 10).
connected(12, 13).
connected(13, 14).
connected(15, 16).
connected(17, 18).
connected(19, 20).
connected(4, 1).
connected(6, 3).
connected(4, 7).
connected(6, 11).
connected(14, 9).
connected(11, 15).
connected(16, 12).
connected(14, 17).
connected(16, 19).

canReach(X, Y) :- connected(X, Y).
canReach(X, Y) :- connected(X, Z), canReach(Z, Y), !.

%travel
byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(singapore,auckland).
byPlane(losAngeles,auckland).

travel(X, Y) :- byCar(X, Y); byTrain(X, Y); byPlane(X, Y).
travel(X, Y) :- (byCar(X, Z); byTrain(X, Z); byPlane(X,Z)),
		travel(Z, Y), !.

travel(X, Y, Z) :- byCar(X, Y), Z = goByCar(X, Y);
                   byTrain(X, Y), Z = goByTrain(X, Y);
		   byPlane(X, Y), Z = goByPlane(X, Y).
travel(X, Y, Z) :-
	byCar(X, T), Z = goByCar(X, T, Zp), travel(T, Y, Zp);
	byTrain(X, T), Z = goByTrain(X, T, Zp), travel(T, Y, Zp);
	byPlane(X, T), Z = goByPlane(X, T, Zp), travel(T, Y, Zp).


%factorial

% the cut operator does not allow the recursion to go into the
% dangerous zone of negative values for N (e.g. when getting a
% result, and asking Prolog to search further, which would
% inevitably lead to a stack overflow.
factorial(0, 1) :-
	!.
factorial(N, K) :-
	Np is N - 1,
	factorial(Np, Kp),
	K is Kp * N.

a.
b.
c.

% The goal predicate will always fail, even though there should
% be at least one case where it would match (i.e. the second
% clause for goal, but since the cut operator is present in the
% first one, it will not allow bypassing this rule, as any
% goal. evaluation will match the first rule, yielding a false
% result.
goal :- a, b, !, 0 > 1.
goal :- c.

% Again, the cut operator will disallow further matches once
% the first rule will match. This is sensible, as there can
% only be one maximum between two numbers, therefore the rules,
% as the ones presented above, are mutually exclusive (i.e.
% only one should be true at a given time).
maximum(X, Y, X) :- X >= Y, !.
maximum(_, Y, Y).

minimum(X, Y, X) :- X =< Y, !.
minimum(_, Y, Y).

abs(X, Y) :- X =< 0, Y is -X, !.
abs(X, X).

fibonacci(0, 0) :- !.
fibonacci(1, 1) :- !.
fibonacci(N, F) :-
	Np is N - 1,
	fibonacci(Np, Fp),
	F is Fp + N.

% divisor(A, B, R) means the largest common divisor between
% A, and B is R.
divisor(A, 0, A) :- !.
divisor(A, B, D) :-
	Ap is B,
	Bp is A mod B,
	divisor(Ap, Bp, D).

% This predicate will evaluate an arbitrarily large expression,
% which may contain the operands +, and -. 
% e.g.: evaluating(1+2-3, X). -> X = 0.
evaluating(X, X) :- integer(X), !.
evaluating(RestExpr+Term, Result) :-
	integer(Term),
	evaluating(RestExpr, RestResult),
	plus(Term, RestResult, Result).
evaluating(RestExpr-Term, Result) :-
	integer(Term),
	evaluating(RestExpr, RestResult),
	plus(Result, Term, RestResult).
