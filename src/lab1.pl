child(dan).
child(bob).
child(mike).
child(andrew).

parent(mike, john).
parent(andrew, bob).
parent(joshua, mike).

happy(X) :- child(X).
child(X, Y) :- parent(Y, X).
brother(X, Y) :- parent(Z, X), parent(Z, Y).
nephew(X, Y) :- brother(Y, Z), parent(Z, X).
grandchild(X, Y) :- parent(Z, X), parent(Z, Y).
predecessor(X, Y) :- parent(X, Y); predecessor(X, Z), parent(Z, Y).

% Homework 2
class('Vehicle').
class('EnginePoweredVehicle').
class('HumanPoweredVehicle').
class('Car').
class('Bus').
class('Bicycle').

inherits('EnginePoweredVehicle','Vehicle').
inherits('HumanPoweredVehicle','Vehicle').
inherits('Car','EnginePoweredVehicle').
inherits('Bus','EnginePoweredVehicle').
inherits('Bicycle','HumanPoweredVehicle').

memberVariable('numberOfSeats',protected,int,'Vehicle').
memberVariable('engineCapacity',public,int,'EnginePoweredVehicle').
memberVariable('fuelConsumption',protected,float,'EnginePoweredVehicle').
memberVariable('nameOfOwner',private,'java.lang.String','Car').
memberVariable('nameOfOwnerCompany',private,'java.lang.String','Bus').
memberVariable('numberOfGears',public,int,'Bicycle').

brotherClass(X, Y) :- not(X == Y), inherits(X, Z), inherits(Y, Z).
