% Tree definitions:
% t(2, nil, nil).
% t(3, t(2, nil, nil), t(4, nil, nil)).
% t(t, t(t, nil, nil), t(t, nil, nil)). <- valid,
% since it will match; and having a t as a term is no problem
% Once something fails in the expression, the whole expression
% will fail.
% An example: t(t, t, t).
% Tree analysis: p(..) :- predicate(LT, ...). predicate(RT, ...).

present(Key, tree(Key, _, _)).
present(Key, tree(_, LT, RT)) :-
	present(Key, LT), !;
	present(Key, RT).

%present(Key, tree(_, LT, _)) :-
%	present(Key, LT).
%present(Key, tree(_, _, RT)) :-
%	present(Key, RT).

%inserting(key, T, Result).
inserting(Key, nil, tree(Key, nil, nil)).
inserting(Key, tree(Root, LT, RT), tree(Root, NLT, RT)) :-
	  Key < Root,
	  inserting(Key, LT, NLT).
inserting(Key, tree(Root, LT, RT), tree(Root, LT, NRT)) :-
	Key >= Root,
	inserting(Key, RT, NRT).

%HOMEWORK 1
%height(T, Result).
maximum(X, Y, X) :- X >= Y.
maximum(X, Y, Y) :- X < Y.

height(nil, 0).
height(K, 1) :- atomic(K).
height(tree(_, LT, RT), Height) :-
	height(LT, LH),
	height(RT, RH),
	maximum(LH, RH, Max),
	Height is Max + 1.

%HOMEWORK 2
% oneChildOnly(Tree, Count).
% count is the number of nodes in the bi-nary
% tree that have only one child.
oneChildOnly(nil, 0).
oneChildOnly(tree(_, L, nil), LC) :-
	dif(L, nil),
	oneChildOnly(L, LSC),
	LC is LSC + 1.
oneChildOnly(tree(_, nil, R), RC) :-
	dif(R, nil),
	oneChildOnly(R, RSC),
	RC is RSC + 1.
oneChildOnly(tree(_, LT, RT), Count) :-
	oneChildOnly(LT, LC),
	oneChildOnly(RT, RC),
	Count is LC + RC.

%HOMEWORK 3
decide(X, Y, Result) :-
	dif(X, Y),
	Result = yes, !.
decide(_, _, no).


testAVL(nil, yes, 0).
testAVL(tree(_, L, nil), yes, 0) :-
	dif(L, nil),
	atomic(L).
testAVL(tree(_, LT, RT), Result, Nodes) :-
	height(LT, LTH),
	height(RT, RTH),
	abs(LTH - RTH) =< 1,
	testAVL(LT, LTR, LTN),
	testAVL(RT, RTR, RTN),
	decide(LTR, RTR, Result),
	Nodes is LTN + RTN.

