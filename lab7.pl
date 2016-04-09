% Cannot have nested calling in Prolog, so a complex term inside
% is not a call, it's just a functor. (not a predicate).
%
% However, if we switch to the infix notation, and write:
%   t(a(b,c)) present null a present [b,c] (i.e. infix notation)
% for such a notation, it's very difficult to tell which is the
% predicate.
%
% In infix notation, the problem of precedence arises, so we must
% define our own precedence rules (for our operators)
%
% In order to define something as an operator, we must add:
%   :- op(Precedence, Type, Name) (much like a degenerate rule)
%
% Name - operator name.
% Type - binary, or unary operator. (xf, yf, ...)
% Precedence - integer value, determining the precedence.
% A lower precedence value means an operation will be evaluated
% first. Precedence determines how are prefix notation expr.
% built from infix notation ones.
%
%   xfx - u + w | having an X won't allow us to have an operator
% that has the same precedence as ours, only lower. X is
% very restrictive.
%  xfy - 2 + 3 + 4
%  this type of rule will not allow evaluation like:
%  (2 + 3) + 4, it only accounts for having the same precedence
%  to the right (i.e. the y).
%
present(E, [E | _]).
present(E, [_ | T]) :- present(E, T).

:-op(1000, xfx, present).
:-op(200, xfy, and).
:-op(300, xfx, plays).
% plays(jimmy, and(football, and(basketball, tennis))).
jimmy plays football and basketball and tennis.

:-op(300, xfx, was).
:-op(250, xfx, of).
:-op(200, fx, the).
% was(john, of(the(secretary), the(department))).
john was the secretary of the department.


% deleting(gives(from(1,lst), result)). <- this solution
% gives(from(deleting(1), lst), result).
:-op(300, fx, deleting).
:-op(200, xfx, from).
:-op(250, xfx, gives).

deleting _ from [] gives [].
deleting E from [E | T] gives R :-
	deleting E from T gives R, !.
deleting E from [H | T] gives R :-
	R=[H | Re],
	deleting E from T gives Re.

%deleting E from LST gives Result :-
%	delete(LST, E, Result).


%concatenating
% concatenating lst and lst1 gives result
% concatenating(gives(and(lst, lst1), result)).
:-op(200, xfx, and).
:-op(300, fx, concatenating).

%concatenating Lst and Lst1 gives Result :-
%	append(Lst, Lst1, Result).

