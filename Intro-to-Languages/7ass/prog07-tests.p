; test-A-sum.P
[query].

check_solutions(sum([], N), [[N = 0]]).
check_solutions(sum([1], N), [[N = 1]]).
check_solutions(sum([1,2], N), [[N = 3]]).
check_solutions(sum([1,2,3], N), [[N = 6]]).
check_solutions(sum([1,2,3,4], N), [[N = 10]]).
check_solutions(sum([1,2,3,4,5], N), [[N = 15]]).
check_solutions(sum([0,3,7,0,10,2,-3,-10,9,3], N), [[N = 21]]).
check_solutions(sum([-1,-1,-6,-3,6,6,1,3,3,-5], N), [[N = 3]]).
check_solutions(sum([-10,-3,-7,-6,-6,-4,5,10,3,2,1,-9,-1,-8,-2], N), [[N = -35]]).
check_solutions(sum([3,-9,8,7,-4,-9,-6,4,-6,-7,-6,-1,-4,-5,-5,6,-4,7,8,-3], N), [[N = -26]]).

; test-B-prod.P
[query].

check_solutions(prod([], N), [[N = 1]]).
check_solutions(prod([1], N), [[N = 1]]).
check_solutions(prod([1,2], N), [[N = 2]]).
check_solutions(prod([1,2,3], N), [[N = 6]]).
check_solutions(prod([1,2,3,4], N), [[N = 24]]).
check_solutions(prod([1,2,3,4,5], N), [[N = 120]]).
check_solutions(prod([0,3,7,0,10,2,-3,-10,9,3], N), [[N = 0]]).
check_solutions(prod([-1,-1,-6,-3,6,6,1,3,3,-5], N), [[N = -29160]]).
check_solutions(prod([-10,-3,-7,-6,-6,-4,5,10,3,2,1,-9,-1,-8,-2], N), [[N = 1306368000]]).

; test-C-avg.P
[query].

check_solutions(avg([], N), []).
check_solutions(avg([1], N), [[N = 1]]).
check_solutions(avg([1,2], N), [[N = 1]]).
check_solutions(avg([1,2,3], N), [[N = 2]]).
check_solutions(avg([1,2,3,4], N), [[N = 2]]).
check_solutions(avg([1,2,3,4,5], N), [[N = 3]]).
check_solutions(avg([0,3,7,0,10,2,-3,-10,9,3], N), [[N = 2]]).
check_solutions(avg([-1,-1,-6,-3,6,6,1,3,3,-5], N), [[N = 0]]).
check_solutions(avg([-10,-3,-7,-6,-6,-4,5,10,3,2,1,-9,-1,-8,-2], N), [[N = -3]]).
check_solutions(avg([3,-9,8,7,-4,-9,-6,4,-6,-7,-6,-1,-4,-5,-5,6,-4,7,8,-3], N), [[N = -2]]).

; test-D-swizzle.P
[query].

check_solutions(swizzle([], [], L3), [[L3 = []]]).
check_solutions(swizzle([a], [], L3), [[L3 = [a]]]).
check_solutions(swizzle([], [b], L3), [[L3 = [b]]]).
check_solutions(swizzle([a], [b], L3), [[L3 = [a, b]]]).
check_solutions(swizzle([a,b,c], [d,e,f], L3), [[L3 = [a,d,b,e,c,f]]]).
check_solutions(swizzle([a,b], [c,d,e,f], L3), [[L3 = [a,c,b,d,e,f]]]).
check_solutions(swizzle([a,b,c,d], [e,f], L3), [[L3 = [a,e,b,f,c,d]]]).

check_solutions(swizzle(L1, L2, []),
                [[L1 = [], L2 = []]]).
check_solutions(swizzle(L1, L2, [a]),
                [[L1 = [], L2 = [a]],
                 [L1 = [a], L2 = []]]).
check_solutions(swizzle(L1, L2, [a,b,c,d,e,f]),
                [[L1 = [], L2 = [a,b,c,d,e,f]],
                 [L1 = [a,b,c,d,e,f], L2 = []],
                 [L1 = [a], L2 = [b,c,d,e,f]],
                 [L1 = [a,c,d,e,f], L2 = [b]],
                 [L1 = [a,c], L2 = [b,d,e,f]],
                 [L1 = [a,c,e,f], L2 = [b,d]],
                 [L1 = [a,c,e], L2 = [b,d,f]]]).

; test-E-partition.P
[query].

check_solutions(partition([],P),
                [[P = []]]).
check_solutions(partition([a],P),
                [[P = [[a]]]]).
check_solutions(partition([a,b],P),
                [[P = [[a],[b]]],
                 [P = [[a,b]]]]).
check_solutions(partition([a,b,c,d],P),
                [[P = [[a],[b],[c],[d]]],
                 [P = [[a],[b],[c,d]]],
                 [P = [[a],[b,c],[d]]],
                 [P = [[a],[b,c,d]]],
                 [P = [[a,b],[c],[d]]],
                 [P = [[a,b],[c,d]]],
                 [P = [[a,b,c],[d]]],
                 [P = [[a,b,c,d]]]]).
check_solutions(partition([1,2,3,4],P),
                [[P = [[1],[2],[3],[4]]],
                 [P = [[1],[2],[3,4]]],
                 [P = [[1],[2,3],[4]]],
                 [P = [[1],[2,3,4]]],
                 [P = [[1,2],[3],[4]]],
                 [P = [[1,2],[3,4]]],
                 [P = [[1,2,3],[4]]],
                 [P = [[1,2,3,4]]]]).
check_solutions(partition([a,b,c,a],P),
                [[P = [[a],[b],[c],[a]]],
                 [P = [[a],[b],[c,a]]],
                 [P = [[a],[b,c],[a]]],
                 [P = [[a],[b,c,a]]],
                 [P = [[a,b],[c],[a]]],
                 [P = [[a,b],[c,a]]],
                 [P = [[a,b,c],[a]]],
                 [P = [[a,b,c,a]]]]).

check_solutions(partition(L,[]), [[L = []]]).
check_solutions(partition(L,[[a]]), [[L = [a]]]).
check_solutions(partition(L,[[a],[b],[c],[d]]), [[L = [a,b,c,d]]]).
check_solutions(partition(L,[[a,b],[c,d],[e]]), [[L = [a,b,c,d,e]]]).
check_solutions(partition(L,[[1],[2],[3,4,5]]), [[L = [1,2,3,4,5]]]).

; test-F-balanced_partition.P
[query].

check_solutions(balanced_partition([],P),
                [[P = []]]).
check_solutions(balanced_partition([a],P),
                [[P = [[a]]]]).
check_solutions(balanced_partition([a,b],P),
                [[P = [[a],[b]]],
                 [P = [[a,b]]]]).
check_solutions(balanced_partition([a,b,c,d],P),
                [[P = [[a],[b],[c],[d]]],
                 [P = [[a],[b],[c,d]]],
                 [P = [[a],[b,c],[d]]],
                 [P = [[a,b],[c],[d]]],
                 [P = [[a,b],[c,d]]],
                 [P = [[a,b,c,d]]]]).
check_solutions(balanced_partition([1,2,3,4,5],P),
                [[P = [[1],[2],[3],[4],[5]]],
                 [P = [[1],[2],[3],[4,5]]],
                 [P = [[1],[2],[3,4],[5]]],
                 [P = [[1],[2,3],[4],[5]]],
                 [P = [[1],[2,3],[4,5]]],
                 [P = [[1,2],[3],[4],[5]]],
                 [P = [[1,2],[3],[4,5]]],
                 [P = [[1,2],[3,4],[5]]],
                 [P = [[1,2],[3,4,5]]],
                 [P = [[1,2,3],[4,5]]],
                 [P = [[1,2,3,4,5]]]]).

check_solutions(balanced_partition(L,[]), [[L = []]]).
check_solutions(balanced_partition(L,[[a]]), [[L = [a]]]).
check_solutions(balanced_partition(L,[[a],[b],[c],[d,e]]), [[L = [a,b,c,d,e]]]).
check_solutions(balanced_partition(L,[[a,b],[c],[d],[e]]), [[L = [a,b,c,d,e]]]).
check_solutions(balanced_partition(L,[[a],[b,c],[d,e],[f]]), [[L = [a,b,c,d,e,f]]]).

check_solutions(balanced_partition(L, [[a],[b,c,d]]), []).

check_solutions(balanced_partition([1,2,3,4,5,6,7],P),
                [[P = [[1], [2], [3], [4], [5], [6], [7]]],
                 [P = [[1], [2], [3], [4], [5], [6, 7]]],
                 [P = [[1], [2], [3], [4], [5, 6], [7]]],
                 [P = [[1], [2], [3], [4, 5], [6], [7]]],
                 [P = [[1], [2], [3], [4, 5], [6, 7]]],
                 [P = [[1], [2], [3, 4], [5], [6], [7]]],
                 [P = [[1], [2], [3, 4], [5], [6, 7]]],
                 [P = [[1], [2], [3, 4], [5, 6], [7]]],
                 [P = [[1], [2, 3], [4], [5], [6], [7]]],
                 [P = [[1], [2, 3], [4], [5], [6, 7]]],
                 [P = [[1], [2, 3], [4], [5, 6], [7]]],
                 [P = [[1], [2, 3], [4, 5], [6], [7]]],
                 [P = [[1], [2, 3], [4, 5], [6, 7]]],
                 [P = [[1, 2], [3], [4], [5], [6], [7]]],
                 [P = [[1, 2], [3], [4], [5], [6, 7]]],
                 [P = [[1, 2], [3], [4], [5, 6], [7]]],
                 [P = [[1, 2], [3], [4, 5], [6], [7]]],
                 [P = [[1, 2], [3], [4, 5], [6, 7]]],
                 [P = [[1, 2], [3, 4], [5], [6], [7]]],
                 [P = [[1, 2], [3, 4], [5], [6, 7]]],
                 [P = [[1, 2], [3, 4], [5, 6], [7]]],
                 [P = [[1, 2], [3, 4], [5, 6, 7]]],
                 [P = [[1, 2], [3, 4, 5], [6, 7]]],
                 [P = [[1, 2, 3], [4, 5], [6, 7]]],
                 [P = [[1, 2, 3], [4, 5, 6, 7]]],
                 [P = [[1, 2, 3, 4], [5, 6, 7]]],
                 [P = [[1, 2, 3, 4, 5, 6, 7]]]]).

; test-G-msort.P
[query].

check_solutions(msort([],S), [[S = []]]).
check_solutions(msort([1],S), [[S = [1]]]).
check_solutions(msort([5,4,3,2,1],S), [[S = [1,2,3,4,5]]]).
check_solutions(msort([-45,-7,-26,7,-18,-35,-45,31,2,-24,-31,-14,-47,-39,-12,25,-33],S), [[S = [-47,-45,-45,-39,-35,-33,-31,-26,-24,-18,-14,-12,-7,2,7,25,31]]]).
check_solutions(msort([4,3,2,1,2,3,4],S), [[S = [1,2,2,3,3,4,4]]]).
check_solutions(msort([-15,0,-48,-31,37,4,-10,22,-42,34,-6,-28,23,-45,-20,-4,-10,33,47,41,-10,-48,-27,-41,-42,36,-42,25,17,-29,-18,-4,-31,-44,-46,1,-1,18,18,18,-36,21,33,-20,49,-10,22,25,-32,-17,35,2,48,9,9,44,-17,-15,31,17,-38,3,-5,-25,4,45,12,-38,-34,-35,44,22,48,-36,-24,0,17,28,-24,-20,12,-2,-12,41,35,27,-16,-39,46,39,-5,-7,33,-18,9,-22,-9,-46,-14,12,-4,37,13,35,4,46,-29,26,41,-49,-9,-9,-1,48,38,-18,-37,12,34,7,-23,42,45,22,-22,3,-9,-41,-12,-5,41,40,42,-49,28,-1,47,-33,33,12,-23,-35,-3,-31,-22,1,24,27,-35,25,-1,-44,-14,-41,-28,8,14,-22,4,-16,-33,-14,43,-22,17,5,1,-47,10,28,-40,41,41,20,-9,31,-26,-19,5,-26,-12,-41,25,-6,-38,-25,8,44,-30,19,14,48,29,-39,-43,20,-31,44,41,33],S), [[S = [-49,-49,-48,-48,-47,-46,-46,-45,-44,-44,-43,-42,-42,-42,-41,-41,-41,-41,-40,-39,-39,-38,-38,-38,-37,-36,-36,-35,-35,-35,-34,-33,-33,-32,-31,-31,-31,-31,-30,-29,-29,-28,-28,-27,-26,-26,-25,-25,-24,-24,-23,-23,-22,-22,-22,-22,-22,-20,-20,-20,-19,-18,-18,-18,-17,-17,-16,-16,-15,-15,-14,-14,-14,-12,-12,-12,-10,-10,-10,-10,-9,-9,-9,-9,-9,-7,-6,-6,-5,-5,-5,-4,-4,-4,-3,-2,-1,-1,-1,-1,0,0,1,1,1,2,3,3,4,4,4,4,5,5,7,8,8,9,9,9,10,12,12,12,12,12,13,14,14,17,17,17,17,18,18,18,19,20,20,21,22,22,22,22,23,24,25,25,25,25,26,27,27,28,28,28,29,31,31,33,33,33,33,33,34,34,35,35,35,36,37,37,38,39,40,41,41,41,41,41,41,41,42,42,43,44,44,44,44,45,45,46,46,47,47,48,48,48,48,49]]]).

; test-H-btreeHeight.P
[clause].

btreeHeight_test01(N) :- btreeEx01(BT), btreeHeight(BT, N).
btreeHeight_test02(N) :- btreeEx02(BT), btreeHeight(BT, N).
btreeHeight_test03(N) :- btreeEx03(BT), btreeHeight(BT, N).
btreeHeight_test04(N) :- btreeEx04(BT), btreeHeight(BT, N).
btreeHeight_test05(N) :- btreeEx05(BT), btreeHeight(BT, N).
btreeHeight_test06(N) :- btreeEx06(BT), btreeHeight(BT, N).
btreeHeight_test07(N) :- btreeEx07(BT), btreeHeight(BT, N).
btreeHeight_test08(N) :- btreeEx08(BT), btreeHeight(BT, N).
btreeHeight_test09(N) :- btreeEx09(BT), btreeHeight(BT, N).
btreeHeight_test10(N) :- btreeEx10(BT), btreeHeight(BT, N).

[query].

check_solutions(btreeHeight_test01(N), [[N = 0]]).
check_solutions(btreeHeight_test02(N), [[N = 1]]).
check_solutions(btreeHeight_test03(N), [[N = 2]]).
check_solutions(btreeHeight_test04(N), [[N = 3]]).
check_solutions(btreeHeight_test05(N), [[N = 3]]).
check_solutions(btreeHeight_test06(N), [[N = 6]]).
check_solutions(btreeHeight_test07(N), [[N = 4]]).
check_solutions(btreeHeight_test08(N), [[N = 2]]).
check_solutions(btreeHeight_test09(N), [[N = 8]]).
check_solutions(btreeHeight_test10(N), [[N = 10]]).

; test-I-btreeHighest.P
[clause].

btreeHighest_test01(X) :- btreeEx01(BT), btreeHighest(BT,X).
btreeHighest_test02(X) :- btreeEx02(BT), btreeHighest(BT,X).
btreeHighest_test03(X) :- btreeEx03(BT), btreeHighest(BT,X).
btreeHighest_test04(X) :- btreeEx04(BT), btreeHighest(BT,X).
btreeHighest_test05(X) :- btreeEx05(BT), btreeHighest(BT,X).
btreeHighest_test06(X) :- btreeEx06(BT), btreeHighest(BT,X).
btreeHighest_test07(X) :- btreeEx07(BT), btreeHighest(BT,X).
btreeHighest_test08(X) :- btreeEx08(BT), btreeHighest(BT,X).
btreeHighest_test09(X) :- btreeEx09(BT), btreeHighest(BT,X).
btreeHighest_test10(X) :- btreeEx10(BT), btreeHighest(BT,X).

[query].

check_solutions(btreeHighest_test01(X), []).
check_solutions(btreeHighest_test02(X), [[X = 99]]).
check_solutions(btreeHighest_test03(X), [[X = 9],[X = 999]]).
check_solutions(btreeHighest_test04(X), [[X = 9],[X = 99],[X = 1000]]).
check_solutions(btreeHighest_test05(X), [[X = 9],[X = 999],[X = 9],[X = 999]]).
check_solutions(btreeHighest_test06(X), [[X = 0]]).
check_solutions(btreeHighest_test07(X), [[X = 509]]).
check_solutions(btreeHighest_test08(X), [[X = 609]]).
check_solutions(btreeHighest_test09(X), [[X = 885]]).
check_solutions(btreeHighest_test10(X), [[X = -75]]).

; test-J-btreeInternal.P
[clause].

btreeInternal_test01(IBT) :- btreeEx01(BT), btreeInternal(BT,IBT).
btreeInternal_test02(IBT) :- btreeEx02(BT), btreeInternal(BT,IBT).
btreeInternal_test03(IBT) :- btreeEx03(BT), btreeInternal(BT,IBT).
btreeInternal_test04(IBT) :- btreeEx04(BT), btreeInternal(BT,IBT).
btreeInternal_test05(IBT) :- btreeEx05(BT), btreeInternal(BT,IBT).
btreeInternal_test06(IBT) :- btreeEx06(BT), btreeInternal(BT,IBT).
btreeInternal_test07(IBT) :- btreeEx07(BT), btreeInternal(BT,IBT).
btreeInternal_test08(IBT) :- btreeEx08(BT), btreeInternal(BT,IBT).
btreeInternal_test09(IBT) :- btreeEx09(BT), btreeInternal(BT,IBT).

[query].

check_solutions(btreeInternal_test01(IBT), [
                    [IBT = leaf]
                ]).
check_solutions(btreeInternal_test02(IBT), [
                    [IBT = leaf],
                    [IBT = node(leaf, 99, leaf)]
                ]).
check_solutions(btreeInternal_test03(IBT), [
                    [IBT = leaf],
                    [IBT = node(leaf, 9, leaf)],
                    [IBT = node(leaf, 99, leaf)],
                    [IBT = node(leaf, 99, node(leaf, 999, leaf))],
                    [IBT = node(leaf, 999, leaf)],
                    [IBT = node(node(leaf, 9, leaf), 99, leaf)],
                    [IBT = node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf))]
               ]).
check_solutions(btreeInternal_test04(IBT), [
                    [IBT = leaf],
                    [IBT = node(leaf, 9, leaf)],
                    [IBT = node(leaf, 20, leaf)],
                    [IBT = node(leaf, 30, leaf)],
                    [IBT = node(leaf, 30, node(leaf, 33, leaf))],
                    [IBT = node(leaf, 30, node(leaf, 33, node(leaf, 1000, leaf)))],
                    [IBT = node(leaf, 30, node(node(leaf, 99, leaf), 33, leaf))],
                    [IBT = node(leaf, 30, node(node(leaf, 99, leaf), 33, node(leaf, 1000, leaf)))],
                    [IBT = node(leaf, 33, leaf)],
                    [IBT = node(leaf, 33, node(leaf, 1000, leaf))],
                    [IBT = node(leaf, 99, leaf)],
                    [IBT = node(leaf, 1000, leaf)],
                    [IBT = node(node(leaf, 9, leaf), 20, leaf)],
                    [IBT = node(node(leaf, 20, leaf), 30, leaf)],
                    [IBT = node(node(leaf, 20, leaf), 30, node(leaf, 33, leaf))],
                    [IBT = node(node(leaf, 20, leaf), 30, node(leaf, 33, node(leaf, 1000, leaf)))],
                    [IBT = node(node(leaf, 20, leaf), 30, node(node(leaf, 99, leaf), 33, leaf))],
                    [IBT = node(node(leaf, 20, leaf), 30, node(node(leaf, 99, leaf), 33, node(leaf, 1000, leaf)))],
                    [IBT = node(node(leaf, 99, leaf), 33, leaf)],
                    [IBT = node(node(leaf, 99, leaf), 33, node(leaf, 1000, leaf))],
                    [IBT = node(node(node(leaf, 9, leaf), 20, leaf), 30, leaf)],
                    [IBT = node(node(node(leaf, 9, leaf), 20, leaf), 30, node(leaf, 33, leaf))],
                    [IBT = node(node(node(leaf, 9, leaf), 20, leaf), 30, node(leaf, 33, node(leaf, 1000, leaf)))],
                    [IBT = node(node(node(leaf, 9, leaf), 20, leaf), 30, node(node(leaf, 99, leaf), 33, leaf))],
                    [IBT = node(node(node(leaf, 9, leaf), 20, leaf), 30, node(node(leaf, 99, leaf), 33, node(leaf, 1000, leaf)))]
                ]).
check_solutions(btreeInternal_test05(IBT), [
                    [IBT = leaf],
                    [IBT = node(leaf, 9, leaf)],
                    [IBT = node(leaf, 99, leaf)],
                    [IBT = node(leaf, 99, node(leaf, 999, leaf))],
                    [IBT = node(leaf, 999, leaf)],
                    [IBT = node(leaf, 9999, leaf)],
                    [IBT = node(leaf, 9999, node(leaf, 99, leaf))],
                    [IBT = node(leaf, 9999, node(leaf, 99, node(leaf, 999, leaf)))],
                    [IBT = node(leaf, 9999, node(node(leaf, 9, leaf), 99, leaf))],
                    [IBT = node(leaf, 9999, node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf)))],
                    [IBT = node(node(leaf, 9, leaf), 99, leaf)],
                    [IBT = node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf))],
                    [IBT = node(node(leaf, 99, leaf), 9999, leaf)],
                    [IBT = node(node(leaf, 99, leaf), 9999, node(leaf, 99, leaf))],
                    [IBT = node(node(leaf, 99, leaf), 9999, node(leaf, 99, node(leaf, 999, leaf)))],
                    [IBT = node(node(leaf, 99, leaf), 9999, node(node(leaf, 9, leaf), 99, leaf))],
                    [IBT = node(node(leaf, 99, leaf), 9999, node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf)))],
                    [IBT = node(node(leaf, 99, node(leaf, 999, leaf)), 9999, leaf)],
                    [IBT = node(node(leaf, 99, node(leaf, 999, leaf)), 9999, node(leaf, 99, leaf))],
                    [IBT = node(node(leaf, 99, node(leaf, 999, leaf)), 9999, node(leaf, 99, node(leaf, 999, leaf)))],
                    [IBT = node(node(leaf, 99, node(leaf, 999, leaf)), 9999, node(node(leaf, 9, leaf), 99, leaf))],
                    [IBT = node(node(leaf, 99, node(leaf, 999, leaf)), 9999, node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf)))],
                    [IBT = node(node(node(leaf, 9, leaf), 99, leaf), 9999, leaf)],
                    [IBT = node(node(node(leaf, 9, leaf), 99, leaf), 9999, node(leaf, 99, leaf))],
                    [IBT = node(node(node(leaf, 9, leaf), 99, leaf), 9999, node(leaf, 99, node(leaf, 999, leaf)))],
                    [IBT = node(node(node(leaf, 9, leaf), 99, leaf), 9999, node(node(leaf, 9, leaf), 99, leaf))],
                    [IBT = node(node(node(leaf, 9, leaf), 99, leaf), 9999, node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf)))],
                    [IBT = node(node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf)), 9999, leaf)],
                    [IBT = node(node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf)), 9999, node(leaf, 99, leaf))],
                    [IBT = node(node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf)), 9999, node(leaf, 99, node(leaf, 999, leaf)))],
                    [IBT = node(node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf)), 9999, node(node(leaf, 9, leaf), 99, leaf))],
                    [IBT = node(node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf)), 9999, node(node(leaf, 9, leaf), 99, node(leaf, 999, leaf)))]
                ]).
check_solutions(btreeInternal_test06(IBT), [
                    [IBT = leaf],
                    [IBT = node(leaf, 0, leaf)],
                    [IBT = node(leaf, 1, leaf)],
                    [IBT = node(leaf, 1, node(leaf, 0, leaf))],
                    [IBT = node(leaf, 2, leaf)],
                    [IBT = node(leaf, 2, node(leaf, 1, leaf))],
                    [IBT = node(leaf, 2, node(leaf, 1, node(leaf, 0, leaf)))],
                    [IBT = node(leaf, 3, leaf)],
                    [IBT = node(leaf, 3, node(leaf, 2, leaf))],
                    [IBT = node(leaf, 3, node(leaf, 2, node(leaf, 1, leaf)))],
                    [IBT = node(leaf, 3, node(leaf, 2, node(leaf, 1, node(leaf, 0, leaf))))],
                    [IBT = node(leaf, 4, leaf)],
                    [IBT = node(leaf, 4, node(leaf, 3, leaf))],
                    [IBT = node(leaf, 4, node(leaf, 3, node(leaf, 2, leaf)))],
                    [IBT = node(leaf, 4, node(leaf, 3, node(leaf, 2, node(leaf, 1, leaf))))],
                    [IBT = node(leaf, 4, node(leaf, 3, node(leaf, 2, node(leaf, 1, node(leaf, 0, leaf)))))],
                    [IBT = node(leaf, 5, leaf)],
                    [IBT = node(leaf, 5, node(leaf, 4, leaf))],
                    [IBT = node(leaf, 5, node(leaf, 4, node(leaf, 3, leaf)))],
                    [IBT = node(leaf, 5, node(leaf, 4, node(leaf, 3, node(leaf, 2, leaf))))],
                    [IBT = node(leaf, 5, node(leaf, 4, node(leaf, 3, node(leaf, 2, node(leaf, 1, leaf)))))],
                    [IBT = node(leaf, 5, node(leaf, 4, node(leaf, 3, node(leaf, 2, node(leaf, 1, node(leaf, 0, leaf))))))]
                ]).
check_solutions(btreeInternal_test07(IBT), [
                    [IBT = leaf],
                    [IBT = node(leaf, -442, leaf)],
                    [IBT = node(leaf, 208, leaf)],
                    [IBT = node(leaf, 208, node(leaf, -442, leaf))],
                    [IBT = node(leaf, 208, node(node(leaf, 509, leaf), -442, leaf))],
                    [IBT = node(leaf, 509, leaf)],
                    [IBT = node(leaf, 567, leaf)],
                    [IBT = node(leaf, 567, node(leaf, 208, leaf))],
                    [IBT = node(leaf, 567, node(leaf, 208, node(leaf, -442, leaf)))],
                    [IBT = node(leaf, 567, node(leaf, 208, node(node(leaf, 509, leaf), -442, leaf)))],
                    [IBT = node(node(leaf, 509, leaf), -442, leaf)]
                ]).
check_solutions(btreeInternal_test08(IBT), [
                    [IBT = leaf],
                    [IBT = node(leaf, 525, leaf)],
                    [IBT = node(leaf, 525, node(leaf, 609, leaf))],
                    [IBT = node(leaf, 609, leaf)]
                ]).
check_solutions(btreeInternal_test09(IBT), [
                    [IBT = leaf],
                    [IBT = node(leaf, -66, leaf)],
                    [IBT = node(leaf, -66, node(leaf, 456, leaf))],
                    [IBT = node(leaf, -34, leaf)],
                    [IBT = node(leaf, -34, node(leaf, 248, leaf))],
                    [IBT = node(leaf, 54, leaf)],
                    [IBT = node(leaf, 54, node(leaf, 885, leaf))],
                    [IBT = node(leaf, 248, leaf)],
                    [IBT = node(leaf, 315, leaf)],
                    [IBT = node(leaf, 315, node(leaf, 825, leaf))],
                    [IBT = node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))],
                    [IBT = node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))],
                    [IBT = node(leaf, 456, leaf)],
                    [IBT = node(leaf, 468, leaf)],
                    [IBT = node(leaf, 468, node(leaf, -66, leaf))],
                    [IBT = node(leaf, 468, node(leaf, -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(leaf, -34, leaf), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(leaf, -34, leaf), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(leaf, -34, node(leaf, 248, leaf)), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(leaf, -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, leaf), -34, leaf), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, leaf), -34, leaf), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, leaf), -34, node(leaf, 248, leaf)), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, leaf), -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, leaf)), -34, leaf), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, leaf)), -34, leaf), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, leaf)), -34, node(leaf, 248, leaf)), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, leaf)), -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf))), -34, leaf), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf))), -34, leaf), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf))), -34, node(leaf, 248, leaf)), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf))), -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))), -34, leaf), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))), -34, leaf), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))), -34, node(leaf, 248, leaf)), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))), -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))), -34, leaf), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))), -34, leaf), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))), -34, node(leaf, 248, leaf)), -66, leaf))],
                    [IBT = node(leaf, 468, node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))), -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf)))],
                    [IBT = node(leaf, 825, leaf)],
                    [IBT = node(leaf, 825, node(leaf, 54, leaf))],
                    [IBT = node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf)))],
                    [IBT = node(leaf, 873, leaf)],
                    [IBT = node(leaf, 873, node(leaf, 315, leaf))],
                    [IBT = node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf)))],
                    [IBT = node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf))))],
                    [IBT = node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf)))))],
                    [IBT = node(leaf, 885, leaf)],
                    [IBT = node(node(leaf, -34, leaf), -66, leaf)],
                    [IBT = node(node(leaf, -34, leaf), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(leaf, -34, node(leaf, 248, leaf)), -66, leaf)],
                    [IBT = node(node(leaf, -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(leaf, 873, leaf), -34, leaf)],
                    [IBT = node(node(leaf, 873, leaf), -34, node(leaf, 248, leaf))],
                    [IBT = node(node(leaf, 873, node(leaf, 315, leaf)), -34, leaf)],
                    [IBT = node(node(leaf, 873, node(leaf, 315, leaf)), -34, node(leaf, 248, leaf))],
                    [IBT = node(node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf))), -34, leaf)],
                    [IBT = node(node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf))), -34, node(leaf, 248, leaf))],
                    [IBT = node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))), -34, leaf)],
                    [IBT = node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))), -34, node(leaf, 248, leaf))],
                    [IBT = node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))), -34, leaf)],
                    [IBT = node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))), -34, node(leaf, 248, leaf))],
                    [IBT = node(node(node(leaf, 873, leaf), -34, leaf), -66, leaf)],
                    [IBT = node(node(node(leaf, 873, leaf), -34, leaf), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(node(leaf, 873, leaf), -34, node(leaf, 248, leaf)), -66, leaf)],
                    [IBT = node(node(node(leaf, 873, leaf), -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, leaf)), -34, leaf), -66, leaf)],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, leaf)), -34, leaf), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, leaf)), -34, node(leaf, 248, leaf)), -66, leaf)],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, leaf)), -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf))), -34, leaf), -66, leaf)],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf))), -34, leaf), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf))), -34, node(leaf, 248, leaf)), -66, leaf)],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, leaf))), -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))), -34, leaf), -66, leaf)],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))), -34, leaf), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))), -34, node(leaf, 248, leaf)), -66, leaf)],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, leaf)))), -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))), -34, leaf), -66, leaf)],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))), -34, leaf), -66, node(leaf, 456, leaf))],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))), -34, node(leaf, 248, leaf)), -66, leaf)],
                    [IBT = node(node(node(leaf, 873, node(leaf, 315, node(leaf, 825, node(leaf, 54, node(leaf, 885, leaf))))), -34, node(leaf, 248, leaf)), -66, node(leaf, 456, leaf))]
                ]).

; test-K-puzzle_soln.P
; no puzzle_soln tests

; test-La-re_match_simple.P
[query].

check_satisfiable(re_match(alt(char(a),star(char(b))),[])).
check_satisfiable(re_match(alt(char(a),star(char(b))),[a])).
check_unsatisfiable(re_match(alt(char(a),star(char(b))),[a,b])).
check_unsatisfiable(re_match(alt(char(a),star(char(b))),[a,b,b])).
check_satisfiable(re_match(alt(char(a),star(char(b))),[b])).
check_satisfiable(re_match(alt(char(a),star(char(b))),[b,b])).
check_unsatisfiable(re_match(seq(char(a),seq(star(char(b)),alt(char(c),epsilon))),[])).
check_satisfiable(re_match(seq(char(a),seq(star(char(b)),alt(char(c),epsilon))),[a])).
check_unsatisfiable(re_match(seq(char(a),seq(star(char(b)),alt(char(c),epsilon))),[b])).
check_satisfiable(re_match(seq(char(a),seq(star(char(b)),alt(char(c),epsilon))),[a,b])).
check_satisfiable(re_match(seq(char(a),seq(star(char(b)),alt(char(c),epsilon))),[a,b,b])).
check_satisfiable(re_match(seq(char(a),seq(star(char(b)),alt(char(c),epsilon))),[a,b,b,c])).
check_unsatisfiable(re_match(seq(char(a),seq(star(char(b)),alt(char(c),epsilon))),[a,b,b,c,c])).
check_satisfiable(re_match(seq(char(a),char(b)),[a,b])).
check_satisfiable(re_match(star(char(b)),[b,b,b,b])).

; test-Lb-re_match_advanced1.P
[query].

check_satisfiable(re_match(star(star(char(a))),[])).
check_satisfiable(re_match(star(star(char(a))),[a])).
check_satisfiable(re_match(star(star(char(a))),[a,a])).
check_unsatisfiable(re_match(star(star(char(a))),[a,b,b])).
check_satisfiable(re_match(star(seq(char(a),char(b))),[a,b,a,b])).
check_satisfiable(re_match(star(seq(char(a),star(char(b)))),[a,a,b,a,b,b,a,b,b,b])).

; test-Lc-re_match_advanced2.P
[clause].

re_match_advanced2_test01(L) :- between(0,7,N), ofLength(N,L), re_match(alt(char(a),star(char(b))),L).
re_match_advanced2_test02(L) :- between(0,7,N), ofLength(N,L), re_match(seq(char(a),seq(star(char(b)),alt(char(c),epsilon))),L).
re_match_advanced2_test03(L) :- between(0,4,N), ofLength(N,L), re_match(star(alt(char(a),char(b))),L).
re_match_advanced2_test04(L) :- between(0,4,N), ofLength(N,L), re_match(seq(star(char(a)),star(char(b))),L).
re_match_advanced2_test05(L) :- between(0,8,N), ofLength(N,L), re_match(star(seq(char(a),char(b))),L).

[query].

check_solutions(re_match_advanced2_test01(L),
                [
                    [L = [a]],
                    [L = [b, b, b, b, b, b, b]],
                    [L = [b, b, b, b, b, b]],
                    [L = [b, b, b, b, b]],
                    [L = [b, b, b, b]],
                    [L = [b, b, b]],
                    [L = [b, b]],
                    [L = [b]],
                    [L = []]
                ]).
check_solutions(re_match_advanced2_test02(L), [
                    [L = [a, b, b, b, b, b, b]],
                    [L = [a, b, b, b, b, b, c]],
                    [L = [a, b, b, b, b, b]],
                    [L = [a, b, b, b, b, c]],
                    [L = [a, b, b, b, b]],
                    [L = [a, b, b, b, c]],
                    [L = [a, b, b, b]],
                    [L = [a, b, b, c]],
                    [L = [a, b, b]],
                    [L = [a, b, c]],
                    [L = [a, b]],
                    [L = [a, c]],
                    [L = [a]]
                ]).
check_solutions(re_match_advanced2_test03(L), [
                    [L = [a, a, a, a]],
                    [L = [a, a, a, b]],
                    [L = [a, a, a]],
                    [L = [a, a, b, a]],
                    [L = [a, a, b, b]],
                    [L = [a, a, b]],
                    [L = [a, a]],
                    [L = [a, b, a, a]],
                    [L = [a, b, a, b]],
                    [L = [a, b, a]],
                    [L = [a, b, b, a]],
                    [L = [a, b, b, b]],
                    [L = [a, b, b]],
                    [L = [a, b]],
                    [L = [a]],
                    [L = [b, a, a, a]],
                    [L = [b, a, a, b]],
                    [L = [b, a, a]],
                    [L = [b, a, b, a]],
                    [L = [b, a, b, b]],
                    [L = [b, a, b]],
                    [L = [b, a]],
                    [L = [b, b, a, a]],
                    [L = [b, b, a, b]],
                    [L = [b, b, a]],
                    [L = [b, b, b, a]],
                    [L = [b, b, b, b]],
                    [L = [b, b, b]],
                    [L = [b, b]],
                    [L = [b]],
                    [L = []]
                ]).
check_solutions(re_match_advanced2_test04(L), [
                    [L = [a, a, a, a]],
                    [L = [a, a, a, b]],
                    [L = [a, a, a]],
                    [L = [a, a, b, b]],
                    [L = [a, a, b]],
                    [L = [a, a]],
                    [L = [a, b, b, b]],
                    [L = [a, b, b]],
                    [L = [a, b]],
                    [L = [a]],
                    [L = [b, b, b, b]],
                    [L = [b, b, b]],
                    [L = [b, b]],
                    [L = [b]],
                    [L = []]
                ]).
check_solutions(re_match_advanced2_test05(L), [
                    [L = [a, b, a, b, a, b, a, b]],
                    [L = [a, b, a, b, a, b]],
                    [L = [a, b, a, b]],
                    [L = [a, b]],
                    [L = []]
                ]).

; test-M-re_reverse.P
; no re_reverse tests

