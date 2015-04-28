letters([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]).
vowels([a,e,i,o,u,y]).

letter(X) :- letters(Ls),member(X,Ls).
vowel(X) :- vowels(Ls),member(X,Ls).

firstv([H|_]) :- vowel(H).
firstc1([C,V|_]) :- \+vowel(C),vowel(V).
firstc2([A,B|_]) :- \+vowel(A),\+vowel(B).

inv1([H|T]) --> T,[H].
inv2([A,B|T]) --> T,[A,B].

pigw(X) --> {maplist(letter,X),firstv(X)},X,[w,a,y].
pigw(X) --> {maplist(letter,X),firstc1(X)},inv1(X),[a,y].
pigw(X) --> {maplist(letter,X),firstc2(X)},inv2(X),[a,y].

pigp([]) --> [].
pigp([H|T]) --> {pigw(H,X,[])},[X],pigp(T).

split([]) --> [].
split(X) --> {\+member(' ',X)},[X].
split(X) --> {append(A,[' '|B],X),\+member(' ',A)},[A],split(B).

join([]) --> {fail}.
join([X]) --> X.
join([H|T]) --> H,[' '],join(T).

piglatin(X,Y) :- atom_chars(X,C),split(C,Ca,[]),pigp(Ca,Pa,[]),join(Pa,P,[]),atom_chars(Y,P).
