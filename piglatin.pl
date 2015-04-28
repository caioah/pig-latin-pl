vowels("AEIOUaeiou").
except1("Qq").
except2("Uu").

except([C,V]) :- except1(L1),except2(L2),member(C,L1),member(V,L2).

vowel(X) :- vowels(Ls),member(X,Ls).

firstv([H|_]) :- vowel(H).

firstc1([C,E|_]) :- except([C,E]),!,fail.
firstc1([C,V|_]) :- \+vowel(C),vowel(V).

firstc2([C,E|_]) :- except([C,E]).
firstc2([A,B|_]) :- \+vowel(A),\+vowel(B).

inv1([H|T]) --> T,[H].
inv2([A,B|T]) --> T,[A,B].

pigw(X) --> {firstv(X)},X,"way".
pigw(X) --> {firstc1(X)},inv1(X),"ay".
pigw(X) --> {firstc2(X)},inv2(X),"ay".

pigp([]) --> [].
pigp([H|T]) --> {pigw(H,X,[])},[X],pigp(T),!.

split([]) --> [].
split(X) --> {\+member(32,X)},[X].
split(X) --> {append(A,[32|B],X),\+member(32,A)},[A],split(B).

join([]) --> {fail}.
join([X]) --> X.
join([H|T]) --> H,[32],join(T).

piglatin(X,Y) :- split(X,Ca,[]),pigp(Ca,Pa,[]),join(Pa,P,[]),name(Y,P).
