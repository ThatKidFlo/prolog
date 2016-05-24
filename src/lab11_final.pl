% In a game, a state represents a position.
% The findall predicate is useful when we're required to find
% all the solutions to a problem.
%
% for breadth-first, we will call findall(successor),
% whereas for depth-first, we only need one successor.


solveDepth :-
	StartingState = [1,3,3,0,0],
    depth_first_search([],StartingState,Solution),
	write(Solution),
	nl.

depth_first_search(CurrentPath,CurrentState,Solution) :-
    CurrentState=[-1,0,0,3,3],
    Solution=[CurrentState|CurrentPath].
depth_first_search(CurrentPath,CurrentState,Solution) :-
    %successor(CurrentState,NewState),
    successor1(CurrentState,NewState),
    not(member(NewState,CurrentPath)),
    depth_first_search([CurrentState|CurrentPath],NewState,Solution).

% one missionary crosses the river
successor([Side,LM,LC,RM,RC],[NewSide,NewLM,LC,NewRM,RC]) :-
	NewLM is LM-1*Side,
	NewRM is RM+1*Side,
	NewSide is (-1)*Side,
	test(NewLM,LC,NewRM,RC).
% two missionaries crosses the river
successor([Side,LM,LC,RM,RC],[NewSide,NewLM,LC,NewRM,RC]) :-
	NewLM is LM-2*Side,
	NewRM is RM+2*Side,
	NewSide is (-1)*Side,
    test(NewLM,LC,NewRM,RC).
% one cannibal crosses the river
successor([Side,LM,LC,RM,RC],[NewSide,LM,NewLC,RM,NewRC]) :-
	NewLC is LC-1*Side,
	NewRC is RC+1*Side,
	NewSide is (-1)*Side,
    test(LM,NewLC,RM,NewRC).
% two cannibals cross the river
successor([Side,LM,LC,RM,RC],[NewSide,LM,NewLC,RM,NewRC]) :-
	NewLC is LC-2*Side,
	NewRC is RC+2*Side,
	NewSide is (-1)*Side,
    test(LM,NewLC,RM,NewRC).
% one missionary and one cannibal corss the river
successor([Side,LM,LC,RM,RC],[NewSide,NewLM,NewLC,NewRM,NewRC]) :-
	NewLM is LM-1*Side,
	NewRM is RM+1*Side,
	NewLC is LC-1*Side,
	NewRC is RC+1*Side,
	NewSide is (-1)*Side,
    test(NewLM,LC,NewRM,RC).

test(LeftMissionaries,LeftCannibals,RightMissionaries,RightCannibals) :-
    LeftMissionaries>=0,
    LeftCannibals>=0,
	RightMissionaries>=0,
    RightCannibals>=0,
    LeftMissionaries>=LeftCannibals,
    RightMissionaries>=RightCannibals.
test(LeftMissionaries,LeftCannibals,RightMissionaries,RightCannibals) :-
    LeftMissionaries>=0,
    LeftCannibals>=0,
    RightMissionaries>=0,
    RightCannibals>=0,
    LeftMissionaries>=LeftCannibals,
    RightMissionaries=0.
test(LeftMissionaries,LeftCannibals,RightMissionaries,RightCannibals) :-
    LeftMissionaries>=0,
    LeftCannibals>=0,
    RightMissionaries>=0,
    RightCannibals>=0,
	LeftMissionaries=0,
    RightMissionaries>=RightCannibals.


solveBreadth :-
    breadth_first_search([[[1,3,3,0,0]]],[-1,0,0,3,3],Solution),
	write(Solution),
	nl.

breadth_first_search([[Node|Path]|_],TargetNode,[Node|Path]) :-
	Node=TargetNode.
breadth_first_search([[Node|Path]|RestPaths],TargetNode,Solution) :-
    findall([NewNode,Node|Path],(successor(Node,NewNode),not(member(NewNode,Path))),NewPaths),
    append(RestPaths,NewPaths,CurrentPaths),
    breadth_first_search(CurrentPaths,TargetNode,Solution).

%1.1
getNumber(M,C) :-
		member(M,[0,1,2]),
		member(C,[0,1,2]),
		2>=M+C,
		0<M+C.

successor1([Side,LM,LC,RM,RC],[NewSide,NewLM,NewLC,NewRM,NewRC]) :-
	getNumber(M,C),
	NewLM is LM-M*Side,
	NewRM is RM+M*Side,
	NewLC is LC-C*Side,
	NewRC is RC+C*Side,
	NewSide is (-1)*Side,
    test(NewLM,LC,NewRM,RC).

