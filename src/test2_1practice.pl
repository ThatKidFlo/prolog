:-op(500, fx, concatenating).
:-op(300, yfx, and).
:-op(400, xfx, gives).

concatenating X and Y gives R :-
	X = Xl and Xr,
	concatenating Xl and Xr gives Xp,
	append(Xp, Y, R), !.
concatenating X and Y gives R :-
	append(X, Y, R).

%DONALD + GERALD = RICHARD bijective function
test(X, L, L) :-
	nonvar(X).
test(X, Li, Lo) :-
	var(X),
	member(X, Li),
	delete(Li, X, Lo).

digitSum(X, Y, Z, Ci, Di, Co, Do) :-
	test(X, Di, L1),
	test(Y, L1, L2),
	test(Z, L2, Do),
	Sum is X + Y + Ci,
	Z =:= Sum mod 10,
	Co is Sum // 10.

sumDigits([X | Rx], [Y | Ry], [Z | Rz], Ci, Di, Co, Do) :-
	sumDigits(Rx, Ry, Rz, Ci, Di, C1, D1),
	digitSum(X, Y, Z, C1, D1, Co, Do).
sumDigits(_,_,_,_, Di, 0, Di).

sum(X, Y, Z) :-
	sumDigits(X, Y, Z, 0, [0,1,2,3,4,5,6,7,8,9], 0, []).

