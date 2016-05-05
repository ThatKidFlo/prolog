check(X, Lin, Lin) :- nonvar(X), !.
check(X, Lin, Lout) :- var(X), member(X, Lin), delete(Lin, X, Lout).

checkDigitSum(X, Y, Z, Cin, Cout, Lin, Lout) :-
	check(X, Lin, L1),
	check(Y, L1, L2),
	check(Z, L2, Lout),
	(
	    (Z is X + Y + Cin, Cout = 0);
	    (Z is X + Y + Cin - 10, Cout = 1)
	).

sumrev([], [], [], 0, []) :- !.
sumrev([X | Tx], [Y | Ty], [Z | Tz], Cin, Lin) :-
	checkDigitSum(X, Y, Z, Cin, Cout, Lin, Lout),
	sumrev(Tx, Ty, Tz, Cout, Lout).

sum(Term1, Term2, Result) :-
	reverse(Term1, Rev1),
	reverse(Term2, Rev2),
	reverse(Result, RevR),
	sumrev(Rev1, Rev2, RevR, 0, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).
