% assert/1, and retract/1, retractall/1 can add, or remove facts from
% the knowledge database dynamically (i.e. w/o recompiling the db)
%
% In order to use predicates dynamically, we need to declare them
% dynamic, as follows:
%   :-dynamic(edge/2).
%   :-dynamic(vertex/1).
%
%  findall(X, member(X, [a,b,c]), L).
% need to declare a variable that will be used in the second expression,
% and as output, the list L will contain all the possible solutions.
%
% e.g.:
% for finding all edges as [edge(a,b), edge(b,c)...] we would use:
%   findall(edge(X, Y), edge(X, Y), L).
% finding all edges as [[a,b], [b,c], ...] implies:
%   findall([X, Y], edge(X, Y), L).
:-dynamic(edge/3).
:-dynamic(node/1).

node(a).
node(b).
node(c).

edge(a, b, 8).
edge(b, c, 5).

insertNode :-
	writef('%s', ["Node: "]),
	read(N),
	(
	    node(N);
	    assert(node(N))
	).

insertEdge :-
	writef('%s', ["From node: "]),
	read(N1),
	(
	    node(N1);
	    assert(node(N1))
	),

	writef('%s', ["To node: "]),
	read(N2),
	(
	    node(N2);
	    assert(node(N2))
	),
	writef('%s', ["Weight: "]),
	read(W),
	(
	    edge(N1, N2, W);
	    assert(edge(N1, N2, W))
	).

removeNode :-
	writef('%s', ["Node: "]),
	read(N),
	node(N),
	retract(node(N)).

removeEdge :-
	writef('%s', ["From node: "]),
	read(N1),
	node(N1),

	writef('%s', ["To node: "]),
	read(N2),
	node(N2),

	writef('%s', ["Weight: "]),
	read(W),
	edge(N1, N2, W),

	retract(edge(N1, N2, W)).

writeAllEdges([Edge | Rest]) :-
	writef('%w -> %w (w=%w)',Edge), nl,
	not(Rest = []),
	writeAllEdges(Rest).


showGraph :-
	writef('%s', ["Nodes: "]),
	findall(X, node(X), Nodes),
	write(Nodes), nl,
	writef('%s', ["Edges: "]), nl,
	findall([F, T, W], edge(F, T, W), Edges),
	writeAllEdges(Edges).
