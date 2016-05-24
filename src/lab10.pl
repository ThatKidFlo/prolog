% solve(S) :- generate(S), test(S).
% However, how much knowledge is placed in the generate clause, and how
% much is put into the test clause, depends heavily on the problem
% itself.

%TODO:: five houses problem
generateFive(S) :- S = [_, _, _, _, _].
testFive(S) :-
	S = [First, Second, Third, Fourth, Fifth],
	member(R, S),
	R = [red, english, _, _, _],
	member(G, S),
	G = [_, _, coffee, _, _],
	member(I, S),
	I = [_, italian, tea, _, _],
	member(Y, S),
	Y = [yellow, _, _, kent, _],
	Third = [_, _, milk, _, _],
	First = [russian, _, _, _, _].

generateCities(Road) :-
	Road = [_, _, _, _],
	member(a, Road),
	member(b, Road),
	member(c, Road),
        member(d, Road),
	firstConstraint(Road),
	secondConstraint(Road).

distance(C1, C2, L, R) :-
	nth0(P1, L, C1),
	nth0(P2, L, C2),
	Rp is P1 - P2,
	abs(Rp, R).

firstConstraint(Road) :-
	distance(a, c, Road, AC),
	distance(c, d, Road, CD),
	AC > CD.
secondConstraint(Road) :-
	distance(b, c, Road, BC),
	distance(b, d, Road, BD),
	BC < BD.
