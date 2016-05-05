% L3
% abs
abs(X, X) :- X >= 0.
abs(X, Y) :- Y is -X.

% fib
fib(0, 0).
fib(1, 1).
fib(N, F) :-
	N > 1,
	Np is N - 1,
	Ns is N - 2,
	fib(Np, Fp),
	fib(Ns, Fs),
	F is Fp + Fs.

% div
div(X, 0, X).
div(X, Y, D) :-
	Y > 0,
	Yp is X mod Y,
	div(Y, Yp, D).

% eval
eval(X, X) :-
	integer(X).
eval(RestExpr+Term, Result) :-
	integer(Term),
	eval(RestExpr, RestResult),
	plus(Term, RestResult, Result).
eval(RestExpr-Term, Result) :-
	integer(Term),
	eval(RestExpr, RestResult),
	plus(Result, Term, RestResult).

% L4
% height
maximum(X, Y, Z) :-
	( X >= Y, Z = X  );
	( Y > X, Z = Y ).
height(nil, 0) :- !.
height(tree(_, Lt, Rt), H) :-
	height(Lt, HLt),
	height(Rt, HRt),
	maximum(HLt, HRt, MH),
	plus(1, MH, H).

%oneChild
oneChildOnly(nil, 0).
oneChildOnly(tree(_, nil, R), C) :-
	dif(R, nil),
	oneChildOnly(R, Cr),
	C is Cr + 1, !.
oneChildOnly(tree(_, L, nil), C) :-
	dif(L, nil),
	oneChildOnly(L, Cl),
	C is Cl + 1, !.
oneChildOnly(tree(_, L, R), C) :-
	oneChildOnly(L, Cl),
	oneChildOnly(R, Cr),
	C is Cl + Cr.

