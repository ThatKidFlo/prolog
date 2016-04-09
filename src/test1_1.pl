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







