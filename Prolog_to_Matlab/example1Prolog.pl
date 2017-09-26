:- dynamic upOn/0, upOff/0.

upOff.

getOn(sensor,Value)  :- Value > 0.5.
getOff(sensor,Value) :- Value < 0.5.

setOn(valve,Value)  :- Value is 1.0.
setOff(valve,Value) :- Value is 0.0.

control(V_in,V_out,S0,S1,S2,SW)  :- getOff(sensor,SW),getOff(sensor,S0),getOff(sensor,S1),getOff(sensor,S2),upOff,setOff(valve,V_in),setOff(valve,V_out).

control(V_in,V_out,S0,S1,S2,SW)  :- getOn(sensor,SW),getOff(sensor,S0),getOff(sensor,S1),getOff(sensor,S2),upOff,setOn(valve,V_in),setOff(valve,V_out),retract(upOff),asserta(upOn).

control(V_in,V_out,S0,S1,S2,SW)  :- getOn(sensor,SW),getOn(sensor,S0),getOff(sensor,S1),getOff(sensor,S2),upOn,setOn(valve,V_in),setOff(valve,V_out).

control(V_in,V_out,S0,S1,S2,SW)  :- getOn(sensor,SW),getOn(sensor,S0),getOn(sensor,S1),getOff(sensor,S2),upOn,setOn(valve,V_in),setOff(valve,V_out).

control(V_in,V_out,S0,S1,S2,SW)  :- getOn(sensor,SW),getOn(sensor,S0),getOn(sensor,S1),getOn(sensor,S2),upOn,setOff(valve,V_in),setOn(valve,V_out),retract(upOn),asserta(upOff).

control(V_in,V_out,S0,S1,S2,SW)  :- getOn(sensor,SW),getOn(sensor,S0),getOn(sensor,S1),getOn(sensor,S2),upOff,setOff(valve,V_in),setOn(valve,V_out).

control(V_in,V_out,S0,S1,S2,SW)  :- getOn(sensor,SW),getOn(sensor,S0),getOn(sensor,S1),getOff(sensor,S2),upOff,setOff(valve,V_in),setOn(valve,V_out).

control(V_in,V_out,S0,S1,S2,SW)  :- getOn(sensor,SW),getOn(sensor,S0),getOff(sensor,S1),getOff(sensor,S2),upOff,setOn(valve,V_in),setOff(valve,V_out),retract(upOff),asserta(upOn).

control(V_in,V_out,S0,S1,S2,SW)  :- getOff(sensor,SW),getOn(sensor,S0),getOn(sensor,S1),getOn(sensor,S2),setOff(valve,V_in),setOn(valve,V_out).

control(V_in,V_out,S0,S1,S2,SW)  :- getOff(sensor,SW),getOn(sensor,S0),getOn(sensor,S1),getOff(sensor,S2),upOff,setOff(valve,V_in),setOn(valve,V_out).

control(V_in,V_out,S0,S1,S2,SW)  :- getOff(sensor,SW),getOn(sensor,S0),getOn(sensor,S1),getOff(sensor,S2),upOn,setOff(valve,V_in),setOn(valve,V_out),retract(upOn),asserta(upOff).

control(V_in,V_out,S0,S1,S2,SW)  :- getOff(sensor,SW),getOn(sensor,S0),getOff(sensor,S1),getOff(sensor,S2),upOff,setOff(valve,V_in),setOn(valve,V_out).

control(V_in,V_out,S0,S1,S2,SW)  :- getOff(sensor,SW),getOn(sensor,S0),getOff(sensor,S1),getOff(sensor,S2),upOn,setOff(valve,V_in),setOn(valve,V_out),retract(upOn),asserta(upOff).






