;; Name: Alex Meddin 
;; Time spent on assignment: 
;; Collaborators: 

[clause].

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; standard number predicates

between(Low,High,Low) :- Low =< High.
between(Low,High,N) :- Low =< High, LowPlusOne is Low+1, between(LowPlusOne,High,N).

max(A,B,A) :- A >= B.
max(A,B,B) :- A < B.

min(A,B,A) :- A =< B.
min(A,B,B) :- A > B.

; standard list predicates

list(nil).
list(cons(H,T)) :- list(T).

null([]).
notnull([_|_]).

head([H|T], H).
tail([H|T], T).

last([X], X).
last([H|T], X) :- last(T, X).

length([], 0).
length([H|T], N) :- length(T, M), N is M + 1.

append([], YS, YS).
append([X|XS], YS, [X|ZS]) :- append(XS, YS, ZS).

member_rec(X, [X|T]).
member_rec(X, [H|T]) :- member_rec(X, T).

member_via_append(X,L) :- append(_, [X|_], L).

member(X, L) :- member_rec(X, L).

snoc([], X, [X]).
snoc([H|T], X, [H|T_X]) :- snoc(T, X, T_X).

reverseA([], []).
reverseA([H|T], TR_H) :- reverseA(T, TR), snoc(TR, H, TR_H).

reverseB([], []).
reverseB([H|T], LR) :- reverseB(T,TR), append(TR,[H],LR).

revappendC([], L, L).
revappendC([H|T], L2, L3) :- revappendC(T, [H|L2], L3).
reverseC(L, LR) :- revappendC(L, [], LR).

reverse(L, LR) :- reverseA(L, LR).

palindrome(L) :- reverse(L, L).

zip([], YS, []).
zip(XS, [], []).
zip([X|XS], [Y|YS], [pair(X,Y)|ZS]) :- zip(XS, YS, ZS).

permutation([], []).
permutation(L, [H|T]) :- append(XS, [H|YS], L), append (XS, YS, ZS), permutation(ZS, T).

ordered([]).
ordered([A]).
ordered([A,B|L]) :- A =< B, ordered([B|L]).

naive_sort(L,SL) :- permutation(L,SL), ordered(SL).

partition(Pivot, [A|XS], [A|YS], ZS) :- A =< Pivot, partition(Pivot, XS, YS, ZS).
partition(Pivot, [A|XS], YS, [A|ZS]) :- Pivot < A,  partition(Pivot, XS, YS, ZS).
partition(Pivot, [], [], []).

quicksorted([], []).
quicksorted([X|XS], SL) :-
  partition(X, XS, Lows, Highs),
  quicksort(Lows, SLows), quicksorted(Highs, SHighs),
  appended(SLows, [X|SHighs], SL).

ofLength(0, []).
ofLength(N, [H|T]) :- N >= 1, M is N - 1, ofLength(M, T).

; predicates useful for puzzles

eqInList(X, X, L) :- member(X, L).
neqInList(X, Y, L) :- append(L1, [X|L2], L), member(Y, L1).
neqInList(X, Y, L) :- append(L1, [X|L2], L), member(Y, L2).
adjInList(X, Y, L) :- append(L1, [X,Y|L2], L).
adjInList(X, Y, L) :- append(L1, [Y,X|L2], L).
nadjInList(X, Y, L) :- append(L1, [Z,X|L2], L), member(Y, L1).
nadjInList(X, Y, L) :- append(L1, [X,Z|L2], L), member(Y, L2).
ltInList(X, Y, L) :- append(L1, [X|L2], L), member(Y, L2).
gtInList(X, Y, L) :- append(L1, [X|L2], L), member(Y, L1).

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part A (sum)

;; DEFINE sum HERE
sum([],0).
sum([H|T],N) :- sum(T,M), N is M + H.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part B (prod)

;; DEFINE prod HERE
prod([],1).
prod([H|T],N) :- prod(T,M), N is M * H.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part C (avg)

;; DEFINE avg HERE
avg(L,N) :- sum(L,M),length(L,P),P > 0,N is M / P.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part D (swizzle)

;; DEFINE swizzle HERE
swizzle([],[],[]).
swizzle([],L2,L2).
swizzle(L1,[],L1).
swizzle([H1|T1],[H2|T2],[H1,H2|L3]) :- swizzle(T1,T2,L3).

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part E (partition)

;; DEFINE partition HERE
partition([],[]).
partition([Hl|Tl],[[Hl]|Tp]) :- partition(Tl,Tp).
partition([Hl|Tl],[[Hl|Bp]|Tp]) :- partition(Tl,[Bp|Tp]).

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part F (balanced_partition) !bonus!

;; DEFINE balanced_partition HERE
bal([],L).
bal([H|T],L) :- length(H,L), Low is L - 1, High is L + 1, bal(T,N), between(Low,High,N).
balanced_partition(L,P) :- partition(L,P), bal(P,N). 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part G (msort)

;; DEFINE msort HERE
halve(L,H,T) :- append(H,T,L), length(H,N), length(T,M), M is N + 1.
halve(L,H,T) :- append(H,T,L), length(H,N), length(T,N). 
merge([],L,L).
merge(L,[],L).
merge([H1|T1],[H2|T2],[H1|T]):- H1 =< H2, merge(T1,[H2|T2],T).
merge([H1|T1],[H2|T2],[H2|T]):- H1 > H2, merge([H1|T1],T2,T).
msort([],[]).
msort([X],[X]).
msort(L,S):- length(L,Len), Len > 1, halve(L,L1,L2), msort(L1,S1), msort(L2,S2), merge(S1,S2,S).     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part H (btreeHeight)

;; DEFINE btreeHeight HERE
leaf([]).
node(BTL,X,BTR).
btreeHeight(leaf,0).
btreeHeight(node(BTL,X,BTR),H) :- btreeHeight(BTL,H1), btreeHeight(BTR,H2), H1 >= H2, H is H1 + 1.
btreeHeight(node(BTL,X,BTR),H) :- btreeHeight(BTL,H1), btreeHeight(BTR,H2), H1 < H2, H is H2 + 1.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part I (btreeHighest)

;; DEFINE btreeHighest HERE
btreeHighest(node(leaf,X,leaf),X).
btreeHighest(node(BTL,X,BTR),Y) :- btreeHighest(BTL,Y), btreeHeight(BTL,L), btreeHeight(BTR,R), L > R.
btreeHighest(node(BTL,X,BTR),Y) :- btreeHighest(BTR,Y), btreeHeight(BTL,L), btreeHeight(BTR,R), L < R.
btreeHighest(node(BTL,X,BTR),Y) :- btreeHighest(BTR,Y), btreeHeight(BTL,L), btreeHeight(BTR,R), L is R.
btreeHighest(node(BTL,X,BTR),Y) :- btreeHighest(BTL,Y), btreeHeight(BTL,L), btreeHeight(BTR,R), L is R.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part J (btreeInternal) !bonus!

;; DEFINE btreeInternal HERE
btreeInternal(node(BTL,X,BTR),Y) :- btreeInternal(BTL,Y).
btreeInternal(X,X).
btreeInternal(node(BTL,X,BTR),Y) :- btreeInternal(BTR,Y).

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part K (puzzle_soln)

;; DEFINE puzzle_soln HERE

; Alex, Bret, Chris, Derek, Eddie, Fred, Greg, Harold, and John are
; nine students who live in a three storey building, with three rooms
; on each floor. A room in the West wing, one in the centre, and one
; in the East wing. If you look directly at the building, the left
; side is West and the right side is East. Each student is assigned
; exactly one room.
;
; 1. Harold does not live on the bottom floor.
; 2. Fred lives directly above John and directly next to Bret (who lives in the West wing).
; 3. Eddie lives in the East wing and one floor higher than Fred.
; 4. Derek lives directly above Fred.
; 5. Greg lives directly above Chris.
;
; Can you find where each of their rooms is?

lives(S,R,F,B) :- studentLivesInRoomOnFloorOfBldg(S,R,F,B).
studentLivesInRoomOnFloorOfBldg(S,R,bottom,building(F,_,_)) :- studentLivesInRoomOnFloor(S,R,F).
studentLivesInRoomOnFloorOfBldg(S,R,middle,building(_,F,_)) :- studentLivesInRoomOnFloor(S,R,F).
studentLivesInRoomOnFloorOfBldg(S,R,top,building(_,_,F)) :- studentLivesInRoomOnFloor(S,R,F).
studentLivesInRoomOnFloor(S,west,floor(S,_,_)).
studentLivesInRoomOnFloor(S,center,floor(_,S,_)).
studentLivesInRoomOnFloor(S,east,floor(_,_,S)).

rooms([west,center,east]).
floors([bottom,middle,top]).

floor(SW,SC,SE). 
building(floor(FB),floor(FM),floor(FT)). 

spaces([[west,bottom],[center,bottom],[east,bottom],
    [west,middle],[center,middle],[east,middle],
    [west,top],[center,top],[east,top]]).

puzzle_soln(BLDG) :- rooms(R), floors(F), spaces(S),
    ltInList(bottom,H2,F),
    ltInList(J2,F2,F),adjInList(J2,F2,F),eqInList(F1,J1,R),adjInList(F1,B1,R),eqInList(F2,B2,F),
    eqInList(B1,west,R), 
    eqInList(E1,east,R),ltInList(F2,E2,F),adjInList(F2,E2,F),
    eqInList(D1,F1,R),ltInList(F2,D2,F),adjInList(F2,D2,F),
    eqInList(G1,C1,R),ltInList(C2,G2,F),adjInList(C2,G2,F), 
    member([H1,H2],S),member([F1,F2],S),member([J1,J2],S),member([B1,B2],S),member([E1,E2],S),member([D1,D2],S),member([G1,G2],S),member([C1,C2],S),member([A1,A2],S),
    lives(harold,H1,H2,BLDG),
    lives(fred,F1,F2,BLDG),
    lives(john,J1,J2,BLDG),
    lives(bret,B1,B2,BLDG),
    lives(eddie,E1,E2,BLDG),
    lives(derek,D1,D2,BLDG),
    lives(greg,G1,G2,BLDG),
    lives(chris,C1,C2,BLDG),
    lives(alex,A1,A2,BLDG),
    unique([[H1,H2],[F1,F2],[J1,J2],[B1,B2],[E1,E2],[D1,D2],[G1,G2],[C1,C2],[A1,A2]]).

unique([H|T]) :- noq(H,T), unique(T).
unique([]).
noq(X,[H|T]) :- spaces(S), neqInList(X,H,S), noq(H,T).
noq(X,[]).
     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part L (re_match)

;; DEFINE re_match HERE
re_match(epsilon, []).
re_match(char(X),[X]).
re_match(seq(RE1,RE2),L) :- re_match(RE1,R1), re_match(RE2,R2), append(R1,R2,L). 
re_match(alt(RE1,RE2),L) :- re_match(RE1,L).
re_match(alt(RE1,RE2),L) :- re_match(RE2,L).
re_match(star(RE),[]).
re_match(star(RE),L) :- between(1,10,N), ofLength(N,L), append([H1|H],T,L), re_match(RE,[H1|H]), re_match(star(RE),T).

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Part M (re_reverse) !bonus!

;; DEFINE re_reverse HERE


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Example binary trees, for tests.
btreeEx01(leaf).
btreeEx02(node(leaf,99,leaf)).
btreeEx03(node(node(leaf,9,leaf),99,node(leaf,999,leaf))).
btreeEx04(node(node(node(leaf,9,leaf),20,leaf),30,node(node(leaf,99,leaf),33,node(leaf,1000,leaf)))).
btreeEx05(node(node(node(leaf,9,leaf),99,node(leaf,999,leaf)),9999,node(node(leaf,9,leaf),99,node(leaf,999,leaf)))).
btreeEx06(node(leaf,5,node(leaf,4,node(leaf,3,node(leaf,2,node(leaf,1,node(leaf,0,leaf))))))).
btreeEx07(node(leaf,567,node(leaf,208,node(node(leaf,509,leaf),-442,leaf)))).
btreeEx08(node(leaf,525,node(leaf,609,leaf))).
btreeEx09(node(leaf,468,node(node(node(leaf,873,node(leaf,315,node(leaf,825,node(leaf,54,node(leaf,885,leaf))))),-34,node(leaf,248,leaf)),-66,node(leaf,456,leaf)))).
btreeEx10(node(node(leaf,-696,leaf),-930,node(leaf,208,node(leaf,-364,node(node(leaf,484,leaf),-1003,node(node(node(leaf,189,node(node(node(leaf,-75,leaf),214,leaf),872,leaf)),0,node(leaf,-450,leaf)),937,leaf)))))).
btreeEx11(node(node(node(leaf,3,leaf),3,node(leaf,3,leaf)),3,node(node(leaf,3,leaf),3,node(leaf,3,leaf)))).

[query].
