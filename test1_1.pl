f(a).
f(b).

g(a).
g(b).

h(b).

k(X) :- f(X), g(X), h(X).

house_elf(dobby).
wizard('McGonagall').
witch(hermoine).
witch(rita_skeeter).

magic(X) :- house_elf(X).
magic(X) :- wizard(X).
magic(X) :- witch(X).


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


add(0, Y, Y).
add(succ(X), Y, succ(R)) :-
	add(X, Y, R).

isPresent(E, [E | _]).
isPresent(E, [_ | T]) :-
	isPresent(E, T).

removeFromList(E, [E | T], T).
removeFromList(E, [H | T], R) :-
	R = [H | Rp],
	removeFromList(E, T, Rp).

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
