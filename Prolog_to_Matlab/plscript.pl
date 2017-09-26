#!/usr/bin/env swipl                                                    
                                                                        
:- initialization main.                                          
                                                                        
main:- current_prolog_flag(argv,Argv),
		nth0(0, Argv, A), % get first argument
		nth0(1, Argv, B), % get second argument
		nth0(2, Argv, C), % get first argument
		nth0(3, Argv, D), % get second argument
		format("~w ~w ~w ~w \n",[A,B,C,D]),
        consult('example1Prolog'),
		atom_number(A,E),
		atom_number(B,F),
		atom_number(C,G),
		atom_number(D,H),
		control(X,Y,E,F,G,H),
		format("X= ~w Y= ~w \n",[X,Y]),	
		halt.
	

