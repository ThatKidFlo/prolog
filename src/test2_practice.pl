:-arithmetic_function(addedTo/2).
:-op(500, yfx, addedTo).

%usage: X is n1 addedWith n2 [addedWith ...]
addedTo(X, Y, Z) :-
	Z is X + Y.

testAddedTo(X) :-
	X is 3 addedTo 4 addedTo 5.

:-op(300, xfx, plays).
:-op(200, xfy, and).

jimmy plays football and basketball and tennis.
mark plays videoGames.
joshua plays tennis and cricket.

:-op(300, xfx, in).

Item in [Item | _].
Item in [_ | Tail] :-
	Item in Tail.

%was(john, the(secretary), of(the(department)))
:-op(400, xfx, was).
:-op(200, fy, the).
:-op(300, xfx, of).

john was the secretary of the department.

%deleting X from List gives Result.

writeList([]).
writeList([H | T]) :-
	writef("%d ", [H]),
	writeList(T).

:-op(300, fx, deleting).
:-op(250, xfx, from).
:-op(200, xfx, yields).

deleting E from L yields R :- delete(L, E, R).
