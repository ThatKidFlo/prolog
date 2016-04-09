% list: [2, 3, 'c', tree(2...), [...]]
% [2, 3, 4] => [X | Y] => X = 2, Y = [3, 4]
% The |	operator yields the rest of the list, after removing
% a specific number of elements. Extraction can only be done
% from the beginning of the list.
% [2, 3, 4] = [X, Y, Z | LST] will match, as LST = [].

% pres(X, LIST) means X is present in the list LIST
pres(E, [E | _]).
pres(E, [_ | Tail]) :-
	pres(E, Tail).

concatenating([], Lst, Lst).
concatenating([Head | Tail], List, [Head | ResultList]) :-
	concatenating(Tail, List, ResultList).

inserting(Item, List, [Item | List]).
inserting(Item, [Head | Tail], Result) :-
	append([Head], NewList, Result),
	inserting(Item, Tail, NewList).

