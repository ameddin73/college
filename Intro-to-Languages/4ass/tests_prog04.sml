(* util.sml *)
fun run_test f check test =
   let
      val (test_name, test_input, test_output) = test
      val _ = print (concat ["Testing ", test_name, " ...\n"])
   in
      (if check (f test_input, test_output)
          then print (concat ["Test ", test_name, " PASSED.\n"])
          else print (concat ["Test ", test_name, " FAILED.\n"]))
      handle exn => print (concat ["Test ", test_name, " ERRORED. [", exnMessage exn, "]\n"])
   end 
fun run_tests f check tests = List.app (run_test f check) tests

fun intEq (i1: int, i2: int) = i1 = i2
fun boolEq (b1: bool, b2: bool) = b1 = b2
fun stringEq (s1: string, s2: string) = s1 = s2
fun pairEq (elem1Eq, elem2Eq) (p1, p2) =
   case (p1, p2) of
      ((x1, y1), (x2, y2)) => elem1Eq (x1, x2) andalso elem2Eq (y1, y2)
fun optionEq elemEq (opt1, opt2) =
   case (opt1, opt2) of
      (NONE, NONE) => true
    | (SOME x1, SOME x2) => elemEq (x1, x2)
    | _ => false
fun listEq elemEq (l1, l2) =
   case (l1, l2) of
      ([], []) => true
    | (h1::t1, h2::t2) => elemEq (h1, h2) andalso listEq elemEq (t1, t2)
    | _ => false
fun listSetEq elemEq (l1, l2) =
   (List.length l1) = (List.length l2)
   andalso
   List.all (fn x1 => List.exists (fn x2 => elemEq (x1, x2)) l2) l1
   andalso
   List.all (fn x2 => List.exists (fn x1 => elemEq (x1, x2)) l1) l2

fun uncurry2 f (x, y) = f x y
fun uncurry3 f (x, y, z) = f x y z

fun btreeEq elemEq (bt1, bt2) =
   case (bt1, bt2) of
      (Leaf, Leaf) => true
    | (Node (l1, x1, r1), Node (l2, x2, r2)) => btreeEq elemEq (l1, l2) andalso elemEq (x1, x2) andalso btreeEq elemEq (r1, r2)
    | _ => false
datatype 'a findRes = FR_Found of 'a | FR_NotFound of string
fun wrapFind find (name, rho) =
   (FR_Found (find (name, rho))) handle NotFound n => FR_NotFound n
fun findResEq elemEq (fr1, fr2) =
   case (fr1, fr2) of
      (FR_Found d1, FR_Found d2) => elemEq (d1, d2)
    | (FR_NotFound n1, FR_NotFound n2) => stringEq (n1, n2)
    | _ => false
val tenvEx01 = Leaf
val tenvEx02 = Node (Node (Node (Leaf, ("a", 107), Leaf), ("c", 417), Node (Leaf, ("e", ~151), Node (Leaf, ("o", ~499), Leaf))), ("s", 35), Node (Leaf, ("u", ~387), Node (Leaf, ("y", 263), Leaf)))
val tenvEx03 = Node (Node (Leaf, ("d", ~422), Node (Node (Node (Node (Leaf, ("f", ~464), Leaf), ("j", 158), Leaf), ("n", ~362), Leaf), ("t", 424), Leaf)), ("v", 354), Node (Leaf, ("z", ~224), Leaf))
val tenvEx04 = Node (Node (Node (Leaf, ("c", ~169), Leaf), ("g", 15), Node (Node (Leaf, ("i", 149), Node (Node (Leaf, ("m", ~313), Leaf), ("o", 115), Leaf)), ("q", ~159), Node (Leaf, ("s", 297), Leaf))), ("u", ~327), Node (Leaf, ("w", ~163), Leaf))
val tenvEx05 = Node (Leaf, ("b", 56), Node (Node (Leaf, ("d", 192), Leaf), ("f", ~404), Node (Node (Node (Node (Leaf, ("h", 258), Node (Leaf, ("j", ~486), Leaf)), ("l", 468), Node (Leaf, ("n", 76), Leaf)), ("p", 94), Node (Node (Leaf, ("r", 348), Leaf), ("t", ~424), Leaf)), ("v", 62), Node (Leaf, ("x", ~184), Node (Leaf, ("z", 360), Leaf)))))
val tenvEx06 = Node (Node (Node (Node (Leaf, ("a", 427), Leaf), ("c", ~257), Leaf), ("e", ~297), Node (Node (Node (Leaf, ("g", ~455), Leaf), ("i", 31), Node (Leaf, ("k", 21), Leaf)), ("m", ~401), Node (Node (Node (Leaf, ("o", ~441), Leaf), ("q", ~511), Leaf), ("s", ~113), Node (Leaf, ("u", 169), Leaf)))), ("w", 245), Node (Leaf, ("y", ~291), Leaf))
val tenvEx07 = Node (Node (Node (Leaf, ("b", 378), Leaf), ("d", ~72), Node (Leaf, ("f", 64), Node (Leaf, ("h", 82), Leaf))), ("j", 362), Node (Node (Leaf, ("l", ~58), Leaf), ("n", 340), Node (Node (Node (Node (Leaf, ("p", ~52), Leaf), ("r", 114), Leaf), ("t", 130), Leaf), ("x", ~66), Node (Leaf, ("z", ~312), Leaf))))
val tenvEx08 = Node (Node (Node (Node (Leaf, ("a", 341), Leaf), ("c", ~81), Node (Leaf, ("e", ~121), Leaf)), ("g", ~191), Node (Node (Leaf, ("i", 207), Leaf), ("k", 489), Leaf)), ("m", ~459), Node (Node (Node (Leaf, ("o", 379), Leaf), ("q", ~277), Leaf), ("s", 63), Node (Node (Leaf, ("u", 23), Leaf), ("w", ~135), Node (Leaf, ("y", 351), Leaf))))
val tenvEx09 = Node (Node (Leaf, ("b", 174), Node (Node (Leaf, ("d", ~100), Leaf), ("f", ~142), Leaf)), ("h", ~328), Node (Node (Leaf, ("j", ~192), Node (Leaf, ("l", ~88), Node (Leaf, ("n", 106), Node (Leaf, ("p", ~460), Leaf)))), ("r", ~354), Node (Node (Leaf, ("t", ~190), Node (Leaf, ("v", 90), Leaf)), ("x", 20), Leaf)))
val tenvEx10 = Node (Leaf, ("a", ~391), Node (Node (Node (Leaf, ("c", 95), Leaf), ("e", ~3), Node (Leaf, ("g", ~337), Leaf)), ("i", ~27), Node (Node (Node (Node (Leaf, ("k", ~447), Leaf), ("m", ~49), Node (Leaf, ("o", 85), Leaf)), ("q", 309), Node (Leaf, ("s", ~317), Node (Leaf, ("u", 491), Node (Leaf, ("w", ~223), Leaf)))), ("y", ~233), Leaf)))
val tenvEx11 = Node (Node (Node (Leaf, ("b", ~236), Node (Node (Node (Leaf, ("d", 396), Leaf), ("f", ~462), Leaf), ("h", ~182), Leaf)), ("l", ~146), Node (Leaf, ("n", 136), Node (Leaf, ("p", ~198), Leaf))), ("r", 376), Node (Leaf, ("t", ~104), Node (Node (Leaf, ("v", 382), Node (Leaf, ("x", ~214), Leaf)), ("z", 390), Leaf)))
val tenvEx12 = Node (Node (Leaf, ("a", 165), Leaf), ("c", ~255), Node (Node (Leaf, ("e", 143), Leaf), ("g", 277), Node (Node (Leaf, ("i", 501), Node (Node (Leaf, ("k", ~125), Leaf), ("m", 243), Leaf)), ("o", ~31), Node (Node (Node (Leaf, ("q", 425), Leaf), ("s", ~199), Leaf), ("u", 287), Node (Leaf, ("w", ~75), Node (Leaf, ("y", ~145), Leaf))))))
val tenvEx13 = Node (Leaf, ("b", ~470), Node (Node (Node (Leaf, ("d", ~394), Node (Node (Leaf, ("f", ~404), Leaf), ("h", 256), Node (Leaf, ("j", ~486), Node (Leaf, ("l", 468), Leaf)))), ("n", 76), Leaf), ("p", ~402), Node (Node (Node (Leaf, ("r", 260), Node (Leaf, ("t", 306), Node (Leaf, ("v", 120), Leaf))), ("x", ~184), Leaf), ("z", 360), Leaf)))
val tenvEx14 = Node (Node (Leaf, ("a", 311), Node (Leaf, ("c", 299), Node (Leaf, ("e", ~385), Leaf))), ("g", ~425), Node (Node (Node (Leaf, ("i", 441), Leaf), ("k", ~359), Leaf), ("m", ~107), Node (Node (Node (Node (Leaf, ("o", 495), Leaf), ("q", 455), Node (Leaf, ("s", ~141), Leaf)), ("u", ~241), Node (Leaf, ("w", 41), Leaf)), ("y", 117), Leaf)))
val tenvEx15 = Node (Node (Node (Leaf, ("b", 174), Node (Leaf, ("d", 456), Node (Node (Leaf, ("f", 122), Leaf), ("h", ~36), Leaf))), ("j", 216), Node (Node (Node (Leaf, ("l", 206), Leaf), ("n", 106), Leaf), ("p", ~314), Leaf)), ("r", 84), Node (Node (Leaf, ("t", ~308), Node (Leaf, ("v", 90), Leaf)), ("x", 138), Node (Leaf, ("z", 10), Leaf)))
val tenvEx16 = Node (Node (Node (Node (Leaf, ("a", ~127), Leaf), ("c", 329), Node (Leaf, ("e", 231), Leaf)), ("g", ~395), Node (Node (Node (Leaf, ("i", ~465), Node (Leaf, ("k", ~505), Leaf)), ("m", 69), Leaf), ("o", 291), Leaf)), ("q", 105), Node (Leaf, ("s", 181), Node (Leaf, ("u", 375), Node (Leaf, ("w", ~17), Node (Leaf, ("y", ~351), Leaf)))))


fun alistEq elemEq (l1, l2) =
   case (l1, l2) of
      (Nil, Nil) => true
    | (NonNil l1, NonNil l2) =>
         let
            fun alistNNEq (l1, l2) =
               case (l1, l2) of
                  (Sing x1, Sing x2) => elemEq (x1, x2)
                | (Append (ys1, zs1), Append (ys2, zs2)) => alistNNEq (ys1, ys2) andalso alistNNEq (zs1, zs2)
                | _ => false
         in
            alistNNEq (l1, l2)
         end
    | _ => false
val alistEx1 = Nil
val alistEx2 = NonNil (Sing 42)
val alistEx3 = NonNil (Append (Sing 23, Sing 24))
val alistEx4 = NonNil (Append (Append (Sing 17, Sing 18), Sing 19))
val alistEx5 = NonNil (Append (Sing 39, Append (Sing 38, Sing 37)))
val alistEx6 = NonNil (Append (Append (Append (Sing 27, Sing 28), Sing 29), Append (Sing 79, Append (Sing 78, Sing 77))))
val alistEx7 = NonNil (Append (Append (Sing 50, Sing 51), Append (Sing 61, Sing 60)))
val alistExs = [alistEx1, alistEx2, alistEx3, alistEx4, alistEx5, alistEx6, alistEx7]

val fmlaEx01 = F_And (F_Not (F_Not (F_Or (F_Or (F_Or (F_Not (F_And (F_And (F_Or (F_Or (F_Var "d", F_Var "h"), F_Not (F_Var "a")), F_Var "h"), F_And (F_Not (F_Var "e"), F_Var "b"))), F_Var "g"), F_And (F_Var "c", F_Var "b")), F_Or (F_And (F_Or (F_Var "h", F_Or (F_Or (F_Var "c", F_Var "a"), F_Var "d")), F_Var "h"), F_Or (F_And (F_And (F_Var "b", F_Var "c"), F_Var "f"), F_Var "a"))))), F_Var "b")
val fmlaEx02 = F_Or (F_And (F_Var "c", F_Or (F_And (F_Not (F_And (F_Var "g", F_And (F_Var "a", F_Or (F_Or (F_Or (F_Not (F_Var "a"), F_Or (F_Var "h", F_Var "b")), F_And (F_Var "d", F_Or (F_Var "a", F_Or (F_Var "c", F_Var "d")))), F_Not (F_Var "d"))))), F_Or (F_Var "a", F_Var "b")), F_Var "b")), F_Not (F_Var "b"))
val fmlaEx03 = F_And (F_Var "h", F_And (F_Or (F_Var "b", F_And (F_Or (F_Or (F_Or (F_Var "f", F_Not (F_Var "e")), F_Not (F_Not (F_And (F_Var "c", F_Not (F_Not (F_And (F_Var "f", F_Var "d"))))))), F_Var "e"), F_Not (F_Var "f"))), F_Var "b"))
val fmlaEx04 = F_Or (F_Var "a", F_Not (F_And (F_Var "f", F_Not (F_Or (F_Or (F_And (F_Or (F_Var "g", F_Var "g"), F_Var "a"), F_Or (F_Var "d", F_And (F_And (F_Not (F_Or (F_Var "g", F_And (F_Var "f", F_Not (F_Or (F_Or (F_Var "d", F_Not (F_Not (F_Var "b"))), F_And (F_Not (F_And (F_Var "b", F_And (F_Var "g", F_And (F_Not (F_Var "e"), F_Or (F_Or (F_Or (F_Var "d", F_Or (F_Var "a", F_And (F_And (F_Var "g", F_Var "f"), F_Var "b"))), F_Not (F_Var "c")), F_And (F_Or (F_And (F_And (F_Or (F_Not (F_Var "f"), F_Var "h"), F_Or (F_Var "f", F_And (F_And (F_Not (F_Or (F_And (F_Or (F_Not (F_Var "a"), F_Var "g"), F_Or (F_Not (F_And (F_And (F_And (F_Not (F_Or (F_And (F_Var "h", F_And (F_Var "b", F_Or (F_Not (F_Var "d"), F_Var "d"))), F_Var "a")), F_Not (F_Var "a")), F_Var "d"), F_Or (F_Var "a", F_Not (F_Var "d")))), F_And (F_Var "a", F_Var "f"))), F_Var "h")), F_And (F_Var "c", F_Var "d")), F_Or (F_Var "b", F_Or (F_Var "d", F_Var "f"))))), F_Not (F_Not (F_Var "b"))), F_Not (F_Var "h")), F_Var "d")))))), F_Or (F_Not (F_Var "e"), F_Not (F_Or (F_Var "f", F_Var "d"))))))))), F_Var "d"), F_Or (F_Var "g", F_And (F_Var "b", F_Var "e"))))), F_Var "f")))))
val fmlaEx05 = F_And (F_Var "a", F_And (F_Not (F_Or (F_Var "c", F_And (F_Var "f", F_Or (F_Var "e", F_And (F_And (F_And (F_Var "b", F_Not (F_And (F_Var "g", F_Var "e"))), F_Or (F_Or (F_Var "e", F_Var "f"), F_Or (F_Var "e", F_Var "f"))), F_Not (F_Var "f")))))), F_Not (F_Var "f")))
val fmlaEx06 = F_Not (F_And (F_Not (F_And (F_Var "d", F_Var "c")), F_And (F_Var "g", F_Not (F_Or (F_Var "d", F_Or (F_And (F_And (F_Var "d", F_And (F_Not (F_Not (F_Var "f")), F_Var "c")), F_Var "c"), F_Var "h"))))))
val fmlaEx07 = F_Not (F_Not (F_Not (F_Var "d")))
val fmlaEx08 = F_Or (F_Var "a", F_Or (F_Var "f", F_Not (F_Not (F_Not (F_Not (F_Or (F_Not (F_Var "f"), F_And (F_Var "c", F_Or (F_Not (F_Or (F_Var "d", F_Not (F_Not (F_Not (F_Or (F_And (F_Var "g", F_And (F_Or (F_Var "h", F_And (F_Not (F_Var "g"), F_And (F_Var "b", F_Not (F_Var "b")))), F_Var "d")), F_Var "b")))))), F_And (F_Var "b", F_Var "b"))))))))))
val fmlaEx09 = F_Or (F_Not (F_Var "f"), F_Not (F_Not (F_And (F_And (F_Not (F_Or (F_Or (F_Or (F_Or (F_Var "a", F_Not (F_Var "g")), F_Var "h"), F_Var "g"), F_And (F_Var "a", F_Var "f"))), F_Not (F_Var "g")), F_Var "a"))))
val fmlaEx10 = F_And (F_Not (F_And (F_Not (F_And (F_Var "d", F_And (F_Or (F_Var "c", F_Or (F_Not (F_And (F_Not (F_Var "a"), F_And (F_Var "a", F_Var "f"))), F_Var "b")), F_Var "a"))), F_Not (F_Or (F_And (F_Or (F_Var "c", F_And (F_Var "d", F_Not (F_Not (F_And (F_Or (F_And (F_Or (F_Or (F_Or (F_Var "a", F_And (F_Var "h", F_Var "e")), F_And (F_And (F_Var "g", F_Var "e"), F_Var "d")), F_And (F_Var "c", F_Var "c")), F_Var "a"), F_Var "h"), F_Not (F_Var "g")))))), F_Not (F_Var "f")), F_Not (F_Var "h"))))), F_Var "b")
val fmlaEx11 = F_Or (F_Or (F_Var "h", F_Var "e"), F_Or (F_Var "b", F_And (F_Var "c", F_Var "a")))
val fmlaEx12 = F_Not (F_And (F_And (F_Var "d", F_And (F_And (F_Var "e", F_Or (F_Not (F_Or (F_Var "g", F_Var "e")), F_Or (F_Var "d", F_Var "f"))), F_And (F_Var "c", F_And (F_Var "g", F_And (F_Var "c", F_Not (F_Var "d")))))), F_Var "c"))
val fmlaEx13 = F_Not (F_Not (F_Var "h"))
val fmlaEx14 = F_Or (F_Not (F_Var "d"), F_Not (F_Var "d"))
val fmlaEx15 = F_Not (F_And (F_Or (F_And (F_Not (F_Var "e"), F_Not (F_Or (F_Not (F_Var "f"), F_Or (F_Var "a", F_Or (F_Var "h", F_Var "d"))))), F_Var "g"), F_Var "g"))
val fmlaEx16 = F_Or (F_Var "h", F_Not (F_And (F_And (F_Not (F_Or (F_Var "g", F_And (F_Not (F_Var "c"), F_Not (F_Not (F_And (F_Or (F_And (F_Not (F_And (F_And (F_Var "g", F_Var "b"), F_Var "b")), F_Var "d"), F_Not (F_Or (F_And (F_Var "b", F_Or (F_And (F_Var "c", F_Var "b"), F_Not (F_And (F_Or (F_Var "c", F_Var "g"), F_Or (F_Or (F_And (F_Var "e", F_Or (F_Var "d", F_And (F_Var "b", F_Or (F_Not (F_Not (F_Not (F_Not (F_Var "b")))), F_And (F_Not (F_Not (F_Or (F_And (F_Not (F_And (F_Var "e", F_Var "b")), F_Not (F_Not (F_Var "h"))), F_Var "h"))), F_Var "g"))))), F_Var "e"), F_Or (F_And (F_Or (F_Not (F_Var "f"), F_And (F_Or (F_Var "c", F_Var "g"), F_Var "f")), F_Var "g"), F_And (F_Not (F_Var "d"), F_Var "d"))))))), F_Var "d"))), F_Var "h")))))), F_Var "f"), F_And (F_Not (F_Var "e"), F_Var "h"))))
val fmlaEx17 = F_Or (F_Not (F_Not (F_Not (F_Or (F_Or (F_And (F_Var "h", F_And (F_Not (F_Not (F_Var "d")), F_Var "b")), F_Or (F_Not (F_Var "b"), F_Var "f")), F_Or (F_Or (F_Var "h", F_Var "b"), F_And (F_Or (F_And (F_Not (F_Or (F_Var "a", F_Var "f")), F_Not (F_Or (F_Var "a", F_And (F_Var "h", F_Var "a")))), F_Var "d"), F_Not (F_Or (F_Not (F_Not (F_Or (F_And (F_And (F_And (F_Var "b", F_Or (F_And (F_Or (F_Var "c", F_Not (F_Var "f")), F_Or (F_And (F_Var "g", F_Not (F_Var "a")), F_Var "c")), F_Var "g")), F_Var "b"), F_Not (F_And (F_Var "h", F_Not (F_And (F_Var "c", F_Not (F_Not (F_And (F_Or (F_Var "d", F_Var "b"), F_Not (F_Not (F_Var "f")))))))))), F_Var "a"))), F_And (F_Not (F_Not (F_Var "h")), F_And (F_Var "b", F_Not (F_Var "d"))))))))))), F_Not (F_And (F_Var "e", F_Var "b")))
val fmlaEx18 = F_And (F_Or (F_Var "a", F_Or (F_Not (F_Or (F_And (F_Not (F_Not (F_Var "h")), F_And (F_Not (F_Var "d"), F_Or (F_And (F_Or (F_Or (F_Var "d", F_Not (F_Var "b")), F_Or (F_Not (F_Var "b"), F_And (F_And (F_Var "e", F_Var "e"), F_Or (F_Not (F_Var "d"), F_Var "c")))), F_Not (F_Or (F_And (F_Not (F_Var "d"), F_Not (F_Var "c")), F_Or (F_Var "g", F_And (F_Var "c", F_And (F_Var "f", F_Or (F_Var "a", F_Or (F_Or (F_Var "a", F_Not (F_Var "a")), F_Var "b")))))))), F_Var "e"))), F_Var "h")), F_And (F_Not (F_Var "h"), F_Var "e"))), F_Var "h")
val fmlaEx19 = F_Or (F_Not (F_Var "f"), F_Not (F_And (F_Var "g", F_Var "d")))
val fmlaEx20 = F_Or (F_Var "c", F_Or (F_Not (F_Var "a"), F_Var "a"))
val fmlaEx21 = F_Not (F_And (F_Not (F_Or (F_Var "d", F_And (F_Var "e", F_Or (F_Var "h", F_Var "e")))), F_Or (F_Var "a", F_And (F_Var "f", F_Var "b"))))
val fmlaEx22 = F_Not (F_And (F_Var "h", F_Or (F_Or (F_Var "b", F_Not (F_And (F_Not (F_And (F_Var "f", F_Not (F_Var "d"))), F_Or (F_Var "a", F_Not (F_Not (F_Not (F_And (F_Or (F_And (F_Or (F_Var "b", F_Var "h"), F_And (F_And (F_Not (F_Var "e"), F_And (F_Var "g", F_Var "h")), F_Or (F_Var "b", F_Or (F_Or (F_Var "b", F_Not (F_Var "h")), F_Var "b")))), F_Var "b"), F_And (F_Var "b", F_Var "b"))))))))), F_Var "b")))
val fmlaEx23 = F_Or (F_Not (F_Var "a"), F_And (F_Or (F_Not (F_Or (F_Or (F_Var "e", F_And (F_Var "h", F_Not (F_Var "g"))), F_Var "a")), F_Var "g"), F_Var "c"))
val fmlaEx24 = F_Or (F_Or (F_Or (F_Not (F_Var "d"), F_Not (F_Var "b")), F_And (F_Var "b", F_Var "e")), F_Var "d")
val fmlaEx25 = F_Or (F_Not (F_Or (F_And (F_Not (F_Not (F_Var "f")), F_Var "d"), F_Or (F_Or (F_Var "e", F_Not (F_Or (F_Or (F_And (F_Var "g", F_Var "g"), F_Not (F_And (F_Var "g", F_Not (F_Var "c")))), F_And (F_Var "c", F_Or (F_And (F_Not (F_Not (F_Not (F_Not (F_Not (F_Var "g"))))), F_Or (F_And (F_And (F_Or (F_And (F_Var "b", F_And (F_And (F_And (F_Var "h", F_Or (F_Var "g", F_Var "d")), F_Or (F_Var "c", F_Not (F_Var "e"))), F_Or (F_Var "g", F_Var "g"))), F_Var "a"), F_Not (F_And (F_Var "a", F_Var "e"))), F_Var "h"), F_Var "e")), F_Var "g"))))), F_Not (F_Or (F_Var "e", F_Not (F_Not (F_Var "h"))))))), F_Not (F_Var "e"))
val fmlaEx26 = F_Not (F_Var "d")
val fmlaEx27 = F_Or (F_Var "a", F_Not (F_Not (F_Not (F_And (F_Var "e", F_Var "h")))))
val fmlaEx28 = F_Or (F_Or (F_Not (F_Var "a"), F_Var "a"), F_Or (F_Or (F_Var "h", F_Not (F_And (F_Var "b", F_Or (F_And (F_And (F_And (F_And (F_Var "a", F_Not (F_Not (F_Or (F_Or (F_Var "b", F_Var "b"), F_Var "g")))), F_Var "e"), F_And (F_Or (F_Not (F_Not (F_And (F_Or (F_Var "d", F_Var "e"), F_Not (F_Var "e")))), F_Not (F_And (F_Var "e", F_Or (F_Or (F_Var "b", F_Var "a"), F_And (F_Var "f", F_Not (F_Or (F_Var "c", F_Var "e"))))))), F_Var "h")), F_Var "a"), F_And (F_Var "a", F_Var "f"))))), F_Or (F_Var "e", F_And (F_Or (F_And (F_Not (F_Var "g"), F_And (F_Var "g", F_Not (F_Or (F_Var "e", F_And (F_Or (F_Var "g", F_Var "c"), F_Var "g"))))), F_Var "f"), F_Var "a"))))
val fmlaEx29 = F_Or (F_Not (F_Or (F_Not (F_Not (F_Not (F_And (F_Var "b", F_Not (F_And (F_Not (F_Not (F_Var "b")), F_Or (F_Not (F_Or (F_Var "f", F_And (F_And (F_And (F_Not (F_Not (F_Var "g")), F_Var "g"), F_Not (F_Var "d")), F_Or (F_Or (F_Var "a", F_Or (F_Not (F_And (F_Var "h", F_Or (F_Var "b", F_Var "d"))), F_Var "e")), F_Not (F_Var "a"))))), F_Var "b"))))))), F_Not (F_Var "a"))), F_Var "e")
val fmlaEx30 = F_And (F_And (F_Var "f", F_Var "f"), F_Not (F_And (F_Not (F_Not (F_Var "a")), F_Var "h")))
val fmlaEx31 = F_Var "a"
val fmlaEx32 = F_Or (F_Or (F_Or (F_Var "a", F_Var "a"), F_Not (F_Not (F_Not (F_And (F_Or (F_Not (F_Not (F_Not (F_And (F_Not (F_Var "d"), F_Not (F_Var "d"))))), F_Var "c"), F_Not (F_Not (F_And (F_Not (F_Var "c"), F_And (F_Not (F_Var "c"), F_Not (F_Var "d")))))))))), F_Var "g")

val envEx01 = [("a", false), ("b", false), ("c", false), ("d", true), ("e", true), ("f", false), ("g", false), ("h", true)]
val envEx02 = [("a", false), ("b", true), ("c", false), ("d", false), ("e", false), ("f", true), ("g", false), ("h", false)]
val envEx03 = [("a", true), ("b", false), ("c", true), ("d", false), ("e", false), ("f", false), ("g", true), ("h", false)]
val envEx04 = [("a", true), ("b", true), ("c", true), ("d", true), ("e", true), ("f", true), ("g", false), ("h", false)]
;

(* test-Aa-unzip.sml *)
val _ : ('a * 'b) list -> 'a list * 'b list = unzip

fun run_unzip_test check test = run_test unzip check test

val _ = run_unzip_test (pairEq (listEq intEq, listEq stringEq)) ("unzip_test01", [], ([],[]))
val _ = run_unzip_test (pairEq (listEq intEq, listEq stringEq)) ("unzip_test02", [(1,"2"),(3,"4"),(5,"6")], ([1,3,5],["2","4","6"]))
val _ = run_unzip_test (pairEq (listEq intEq, listEq stringEq)) ("unzip_test03", [(1,"2"),(3,"4"),(5,"6"),(7,"8"),(9,"10")], ([1,3,5,7,9],["2","4","6","8","10"]))
;

(* test-Ab-zip.sml *)
val _ : 'a list * 'b list -> ('a * 'b) list = zip

fun run_zip_test check test = run_test zip check test

val _ = run_zip_test (listEq (pairEq (intEq, stringEq))) ("zip_test01", ([],[]), [])
val _ = run_zip_test (listEq (pairEq (intEq, stringEq))) ("zip_test02", ([1,3,5],[]), [])
val _ = run_zip_test (listEq (pairEq (intEq, stringEq))) ("zip_test03", ([],["2","4","6"]), [])
val _ = run_zip_test (listEq (pairEq (intEq, stringEq))) ("zip_test04", ([1,3,5],["2","4","6"]), [(1,"2"),(3,"4"),(5,"6")])
val _ = run_zip_test (listEq (pairEq (intEq, stringEq))) ("zip_test05", ([1,3,5,7,9],["2","4","6"]), [(1,"2"),(3,"4"),(5,"6")])
val _ = run_zip_test (listEq (pairEq (intEq, stringEq))) ("zip_test06", ([1,3,5],["2","4","6","8","10"]), [(1,"2"),(3,"4"),(5,"6")])
val _ = run_zip_test (listEq (pairEq (intEq, stringEq))) ("zip_test07", ([1,3,5,7,9],["2","4","6","8","10"]), [(1,"2"),(3,"4"),(5,"6"),(7,"8"),(9,"10")])
;

(* test-B-compound.sml *)
val _ : int -> ('a -> 'a) -> 'a -> 'a = compound

fun run_compound_test check test = run_test (fn (n,f,x) => compound n f x) check test

val _ = run_compound_test intEq ("compound_test01", (0, fn x => x + 1, 10), 10)
val _ = run_compound_test intEq ("compound_test02", (5, fn x => x + 1, 10), 15)
val _ = run_compound_test intEq ("compound_test03", (10, fn x => x + 1, 10), 20)
val _ = run_compound_test intEq ("compound_test04", (0, fn x => x + x, 2), 2)
val _ = run_compound_test intEq ("compound_test05", (4, fn x => x + x, 2), 32)
val _ = run_compound_test stringEq ("compound_test06", (0, fn x => x ^ x, "*"), "*")
val _ = run_compound_test stringEq ("compound_test06", (3, fn x => x ^ x, "*"), "********")
;

(* test-C-exp.sml *)
val _ : int -> int -> int = exp

fun run_exp_test test = run_test (fn (b,e) => exp b e) intEq test

val _ = run_exp_test ("exp_test01", (3, 0), 1)
val _ = run_exp_test ("exp_test02", (3, 1), 3)
val _ = run_exp_test ("exp_test03", (3, 2), 9)
val _ = run_exp_test ("exp_test04", (3, 3), 27)
val _ = run_exp_test ("exp_test05", (2, 0), 1)
val _ = run_exp_test ("exp_test06", (2, 1), 2)
val _ = run_exp_test ("exp_test07", (2, 2), 4)
val _ = run_exp_test ("exp_test08", (2, 3), 8)
val _ = run_exp_test ("exp_test09", (2, 4), 16)
val _ = run_exp_test ("exp_test10", (~3, 0), 1)
val _ = run_exp_test ("exp_test11", (~3, 1), ~3)
val _ = run_exp_test ("exp_test12", (~3, 2), 9)
val _ = run_exp_test ("exp_test13", (~3, 3), ~27)
val _ = run_exp_test ("exp_test14", (~2, 0), 1)
val _ = run_exp_test ("exp_test15", (~2, 1), ~2)
val _ = run_exp_test ("exp_test16", (~2, 2), 4)
val _ = run_exp_test ("exp_test17", (~2, 3), ~8)
val _ = run_exp_test ("exp_test18", (~2, 4), 16)
;

(* test-D-existsUnique.sml *)
val _ : ('a -> bool) -> 'a list -> bool = existsUnique

fun run_existsUnique_test test = run_test (uncurry2 existsUnique) boolEq test

val _ = run_existsUnique_test ("existsUnique_test01", (fn x => x mod 2 = 1, []), false)
val _ = run_existsUnique_test ("existsUnique_test02", (fn x => x mod 2 = 1, [1]), true)
val _ = run_existsUnique_test ("existsUnique_test03", (fn x => x mod 2 = 1, [1,2]), true)
val _ = run_existsUnique_test ("existsUnique_test04", (fn x => x mod 2 = 1, [1,2,3]), false)
val _ = run_existsUnique_test ("existsUnique_test05", (fn x => x mod 2 = 1, [1,2,3,4,5]), false)
val _ = run_existsUnique_test ("existsUnique_test06", (fn x => x mod 2 = 1, [2,4,5,6,8]), true)
val _ = run_existsUnique_test ("existsUnique_test07", (fn x => size x = 4, ["antelope","bat","cat","dear","elephant"]), true)
;

(* test-E-allAlt.sml *)
val _ : ('a -> bool) -> 'a list -> bool = allAlt

fun run_allAlt_test test = run_test (uncurry2 allAlt) boolEq test

val _ = run_allAlt_test ("allAlt_test01", (fn x => x mod 2 = 1, []), true)
val _ = run_allAlt_test ("allAlt_test02", (fn x => x mod 2 = 1, [1]), true)
val _ = run_allAlt_test ("allAlt_test03", (fn x => x mod 2 = 1, [1,2,3,4,5,6,7,8,9]), true)
val _ = run_allAlt_test ("allAlt_test04", (fn x => x mod 2 = 1, [1,2,3,4,6,7,8,9]), false)
val _ = run_allAlt_test ("allAlt_test05", (fn x => x < "monkey", ["ant","zebra","cat","yak"]), true)
val _ = run_allAlt_test ("allAlt_test06", (fn x => x < "monkey", ["ant","zebra","yak","cat"]), false)
;

(* test-Fa-tenvEmpty.sml *)
val _ : 'a tenv = tenvEmpty
;

(* test-Fb-tenvFind.sml *)
val _ : string * 'a tenv -> 'a = tenvFind

fun run_tenvFind_test test = run_test (wrapFind tenvFind) (findResEq intEq) test

val _ = run_tenvFind_test ("tenvFind_test001", ("f", tenvEx01), FR_NotFound "f")
val _ = run_tenvFind_test ("tenvFind_test002", ("l", tenvEx01), FR_NotFound "l")
val _ = run_tenvFind_test ("tenvFind_test003", ("z", tenvEx01), FR_NotFound "z")
val _ = run_tenvFind_test ("tenvFind_test004", ("d", tenvEx01), FR_NotFound "d")
val _ = run_tenvFind_test ("tenvFind_test005", ("r", tenvEx01), FR_NotFound "r")
val _ = run_tenvFind_test ("tenvFind_test006", ("h", tenvEx01), FR_NotFound "h")
val _ = run_tenvFind_test ("tenvFind_test007", ("p", tenvEx01), FR_NotFound "p")
val _ = run_tenvFind_test ("tenvFind_test008", ("t", tenvEx01), FR_NotFound "t")
val _ = run_tenvFind_test ("tenvFind_test009", ("f", tenvEx02), FR_NotFound "f")
val _ = run_tenvFind_test ("tenvFind_test010", ("l", tenvEx02), FR_NotFound "l")
val _ = run_tenvFind_test ("tenvFind_test011", ("z", tenvEx02), FR_NotFound "z")
val _ = run_tenvFind_test ("tenvFind_test012", ("d", tenvEx02), FR_NotFound "d")
val _ = run_tenvFind_test ("tenvFind_test013", ("r", tenvEx02), FR_NotFound "r")
val _ = run_tenvFind_test ("tenvFind_test014", ("h", tenvEx02), FR_NotFound "h")
val _ = run_tenvFind_test ("tenvFind_test015", ("p", tenvEx02), FR_NotFound "p")
val _ = run_tenvFind_test ("tenvFind_test016", ("t", tenvEx02), FR_NotFound "t")
val _ = run_tenvFind_test ("tenvFind_test017", ("f", tenvEx03), FR_Found ~464)
val _ = run_tenvFind_test ("tenvFind_test018", ("l", tenvEx03), FR_NotFound "l")
val _ = run_tenvFind_test ("tenvFind_test019", ("z", tenvEx03), FR_Found ~224)
val _ = run_tenvFind_test ("tenvFind_test020", ("d", tenvEx03), FR_Found ~422)
val _ = run_tenvFind_test ("tenvFind_test021", ("r", tenvEx03), FR_NotFound "r")
val _ = run_tenvFind_test ("tenvFind_test022", ("h", tenvEx03), FR_NotFound "h")
val _ = run_tenvFind_test ("tenvFind_test023", ("p", tenvEx03), FR_NotFound "p")
val _ = run_tenvFind_test ("tenvFind_test024", ("t", tenvEx03), FR_Found 424)
val _ = run_tenvFind_test ("tenvFind_test025", ("f", tenvEx04), FR_NotFound "f")
val _ = run_tenvFind_test ("tenvFind_test026", ("l", tenvEx04), FR_NotFound "l")
val _ = run_tenvFind_test ("tenvFind_test027", ("z", tenvEx04), FR_NotFound "z")
val _ = run_tenvFind_test ("tenvFind_test028", ("d", tenvEx04), FR_NotFound "d")
val _ = run_tenvFind_test ("tenvFind_test029", ("r", tenvEx04), FR_NotFound "r")
val _ = run_tenvFind_test ("tenvFind_test030", ("h", tenvEx04), FR_NotFound "h")
val _ = run_tenvFind_test ("tenvFind_test031", ("p", tenvEx04), FR_NotFound "p")
val _ = run_tenvFind_test ("tenvFind_test032", ("t", tenvEx04), FR_NotFound "t")
val _ = run_tenvFind_test ("tenvFind_test033", ("f", tenvEx05), FR_Found ~404)
val _ = run_tenvFind_test ("tenvFind_test034", ("l", tenvEx05), FR_Found 468)
val _ = run_tenvFind_test ("tenvFind_test035", ("z", tenvEx05), FR_Found 360)
val _ = run_tenvFind_test ("tenvFind_test036", ("d", tenvEx05), FR_Found 192)
val _ = run_tenvFind_test ("tenvFind_test037", ("r", tenvEx05), FR_Found 348)
val _ = run_tenvFind_test ("tenvFind_test038", ("h", tenvEx05), FR_Found 258)
val _ = run_tenvFind_test ("tenvFind_test039", ("p", tenvEx05), FR_Found 94)
val _ = run_tenvFind_test ("tenvFind_test040", ("t", tenvEx05), FR_Found ~424)
val _ = run_tenvFind_test ("tenvFind_test041", ("f", tenvEx06), FR_NotFound "f")
val _ = run_tenvFind_test ("tenvFind_test042", ("l", tenvEx06), FR_NotFound "l")
val _ = run_tenvFind_test ("tenvFind_test043", ("z", tenvEx06), FR_NotFound "z")
val _ = run_tenvFind_test ("tenvFind_test044", ("d", tenvEx06), FR_NotFound "d")
val _ = run_tenvFind_test ("tenvFind_test045", ("r", tenvEx06), FR_NotFound "r")
val _ = run_tenvFind_test ("tenvFind_test046", ("h", tenvEx06), FR_NotFound "h")
val _ = run_tenvFind_test ("tenvFind_test047", ("p", tenvEx06), FR_NotFound "p")
val _ = run_tenvFind_test ("tenvFind_test048", ("t", tenvEx06), FR_NotFound "t")
val _ = run_tenvFind_test ("tenvFind_test049", ("f", tenvEx07), FR_Found 64)
val _ = run_tenvFind_test ("tenvFind_test050", ("l", tenvEx07), FR_Found ~58)
val _ = run_tenvFind_test ("tenvFind_test051", ("z", tenvEx07), FR_Found ~312)
val _ = run_tenvFind_test ("tenvFind_test052", ("d", tenvEx07), FR_Found ~72)
val _ = run_tenvFind_test ("tenvFind_test053", ("r", tenvEx07), FR_Found 114)
val _ = run_tenvFind_test ("tenvFind_test054", ("h", tenvEx07), FR_Found 82)
val _ = run_tenvFind_test ("tenvFind_test055", ("p", tenvEx07), FR_Found ~52)
val _ = run_tenvFind_test ("tenvFind_test056", ("t", tenvEx07), FR_Found 130)
val _ = run_tenvFind_test ("tenvFind_test057", ("f", tenvEx08), FR_NotFound "f")
val _ = run_tenvFind_test ("tenvFind_test058", ("l", tenvEx08), FR_NotFound "l")
val _ = run_tenvFind_test ("tenvFind_test059", ("z", tenvEx08), FR_NotFound "z")
val _ = run_tenvFind_test ("tenvFind_test060", ("d", tenvEx08), FR_NotFound "d")
val _ = run_tenvFind_test ("tenvFind_test061", ("r", tenvEx08), FR_NotFound "r")
val _ = run_tenvFind_test ("tenvFind_test062", ("h", tenvEx08), FR_NotFound "h")
val _ = run_tenvFind_test ("tenvFind_test063", ("p", tenvEx08), FR_NotFound "p")
val _ = run_tenvFind_test ("tenvFind_test064", ("t", tenvEx08), FR_NotFound "t")
val _ = run_tenvFind_test ("tenvFind_test065", ("f", tenvEx09), FR_Found ~142)
val _ = run_tenvFind_test ("tenvFind_test066", ("l", tenvEx09), FR_Found ~88)
val _ = run_tenvFind_test ("tenvFind_test067", ("z", tenvEx09), FR_NotFound "z")
val _ = run_tenvFind_test ("tenvFind_test068", ("d", tenvEx09), FR_Found ~100)
val _ = run_tenvFind_test ("tenvFind_test069", ("r", tenvEx09), FR_Found ~354)
val _ = run_tenvFind_test ("tenvFind_test070", ("h", tenvEx09), FR_Found ~328)
val _ = run_tenvFind_test ("tenvFind_test071", ("p", tenvEx09), FR_Found ~460)
val _ = run_tenvFind_test ("tenvFind_test072", ("t", tenvEx09), FR_Found ~190)
val _ = run_tenvFind_test ("tenvFind_test073", ("f", tenvEx10), FR_NotFound "f")
val _ = run_tenvFind_test ("tenvFind_test074", ("l", tenvEx10), FR_NotFound "l")
val _ = run_tenvFind_test ("tenvFind_test075", ("z", tenvEx10), FR_NotFound "z")
val _ = run_tenvFind_test ("tenvFind_test076", ("d", tenvEx10), FR_NotFound "d")
val _ = run_tenvFind_test ("tenvFind_test077", ("r", tenvEx10), FR_NotFound "r")
val _ = run_tenvFind_test ("tenvFind_test078", ("h", tenvEx10), FR_NotFound "h")
val _ = run_tenvFind_test ("tenvFind_test079", ("p", tenvEx10), FR_NotFound "p")
val _ = run_tenvFind_test ("tenvFind_test080", ("t", tenvEx10), FR_NotFound "t")
val _ = run_tenvFind_test ("tenvFind_test081", ("f", tenvEx11), FR_Found ~462)
val _ = run_tenvFind_test ("tenvFind_test082", ("l", tenvEx11), FR_Found ~146)
val _ = run_tenvFind_test ("tenvFind_test083", ("z", tenvEx11), FR_Found 390)
val _ = run_tenvFind_test ("tenvFind_test084", ("d", tenvEx11), FR_Found 396)
val _ = run_tenvFind_test ("tenvFind_test085", ("r", tenvEx11), FR_Found 376)
val _ = run_tenvFind_test ("tenvFind_test086", ("h", tenvEx11), FR_Found ~182)
val _ = run_tenvFind_test ("tenvFind_test087", ("p", tenvEx11), FR_Found ~198)
val _ = run_tenvFind_test ("tenvFind_test088", ("t", tenvEx11), FR_Found ~104)
val _ = run_tenvFind_test ("tenvFind_test089", ("f", tenvEx12), FR_NotFound "f")
val _ = run_tenvFind_test ("tenvFind_test090", ("l", tenvEx12), FR_NotFound "l")
val _ = run_tenvFind_test ("tenvFind_test091", ("z", tenvEx12), FR_NotFound "z")
val _ = run_tenvFind_test ("tenvFind_test092", ("d", tenvEx12), FR_NotFound "d")
val _ = run_tenvFind_test ("tenvFind_test093", ("r", tenvEx12), FR_NotFound "r")
val _ = run_tenvFind_test ("tenvFind_test094", ("h", tenvEx12), FR_NotFound "h")
val _ = run_tenvFind_test ("tenvFind_test095", ("p", tenvEx12), FR_NotFound "p")
val _ = run_tenvFind_test ("tenvFind_test096", ("t", tenvEx12), FR_NotFound "t")
val _ = run_tenvFind_test ("tenvFind_test097", ("f", tenvEx13), FR_Found ~404)
val _ = run_tenvFind_test ("tenvFind_test098", ("l", tenvEx13), FR_Found 468)
val _ = run_tenvFind_test ("tenvFind_test099", ("z", tenvEx13), FR_Found 360)
val _ = run_tenvFind_test ("tenvFind_test100", ("d", tenvEx13), FR_Found ~394)
val _ = run_tenvFind_test ("tenvFind_test101", ("r", tenvEx13), FR_Found 260)
val _ = run_tenvFind_test ("tenvFind_test102", ("h", tenvEx13), FR_Found 256)
val _ = run_tenvFind_test ("tenvFind_test103", ("p", tenvEx13), FR_Found ~402)
val _ = run_tenvFind_test ("tenvFind_test104", ("t", tenvEx13), FR_Found 306)
val _ = run_tenvFind_test ("tenvFind_test105", ("f", tenvEx14), FR_NotFound "f")
val _ = run_tenvFind_test ("tenvFind_test106", ("l", tenvEx14), FR_NotFound "l")
val _ = run_tenvFind_test ("tenvFind_test107", ("z", tenvEx14), FR_NotFound "z")
val _ = run_tenvFind_test ("tenvFind_test108", ("d", tenvEx14), FR_NotFound "d")
val _ = run_tenvFind_test ("tenvFind_test109", ("r", tenvEx14), FR_NotFound "r")
val _ = run_tenvFind_test ("tenvFind_test110", ("h", tenvEx14), FR_NotFound "h")
val _ = run_tenvFind_test ("tenvFind_test111", ("p", tenvEx14), FR_NotFound "p")
val _ = run_tenvFind_test ("tenvFind_test112", ("t", tenvEx14), FR_NotFound "t")
val _ = run_tenvFind_test ("tenvFind_test113", ("f", tenvEx15), FR_Found 122)
val _ = run_tenvFind_test ("tenvFind_test114", ("l", tenvEx15), FR_Found 206)
val _ = run_tenvFind_test ("tenvFind_test115", ("z", tenvEx15), FR_Found 10)
val _ = run_tenvFind_test ("tenvFind_test116", ("d", tenvEx15), FR_Found 456)
val _ = run_tenvFind_test ("tenvFind_test117", ("r", tenvEx15), FR_Found 84)
val _ = run_tenvFind_test ("tenvFind_test118", ("h", tenvEx15), FR_Found ~36)
val _ = run_tenvFind_test ("tenvFind_test119", ("p", tenvEx15), FR_Found ~314)
val _ = run_tenvFind_test ("tenvFind_test120", ("t", tenvEx15), FR_Found ~308)
val _ = run_tenvFind_test ("tenvFind_test121", ("f", tenvEx16), FR_NotFound "f")
val _ = run_tenvFind_test ("tenvFind_test122", ("l", tenvEx16), FR_NotFound "l")
val _ = run_tenvFind_test ("tenvFind_test123", ("z", tenvEx16), FR_NotFound "z")
val _ = run_tenvFind_test ("tenvFind_test124", ("d", tenvEx16), FR_NotFound "d")
val _ = run_tenvFind_test ("tenvFind_test125", ("r", tenvEx16), FR_NotFound "r")
val _ = run_tenvFind_test ("tenvFind_test126", ("h", tenvEx16), FR_NotFound "h")
val _ = run_tenvFind_test ("tenvFind_test127", ("p", tenvEx16), FR_NotFound "p")
val _ = run_tenvFind_test ("tenvFind_test128", ("t", tenvEx16), FR_NotFound "t")
;

(* test-Fc-tenvBind.sml *)
val _ : string * 'a * 'a tenv -> 'a tenv = tenvBind

fun run_tenvBind_test test = run_test tenvBind (btreeEq (pairEq (stringEq, intEq))) test

val _ = run_tenvBind_test ("tenvBind_test001", ("f", ~492, tenvEx01), Node (Leaf, ("f", ~492), Leaf))
val _ = run_tenvBind_test ("tenvBind_test002", ("l", 322, tenvEx01), Node (Leaf, ("l", 322), Leaf))
val _ = run_tenvBind_test ("tenvBind_test003", ("z", 126, tenvEx01), Node (Leaf, ("z", 126), Leaf))
val _ = run_tenvBind_test ("tenvBind_test004", ("d", ~394, tenvEx01), Node (Leaf, ("d", ~394), Leaf))
val _ = run_tenvBind_test ("tenvBind_test005", ("r", 260, tenvEx01), Node (Leaf, ("r", 260), Leaf))
val _ = run_tenvBind_test ("tenvBind_test006", ("h", 256, tenvEx01), Node (Leaf, ("h", 256), Leaf))
val _ = run_tenvBind_test ("tenvBind_test007", ("p", ~402, tenvEx01), Node (Leaf, ("p", ~402), Leaf))
val _ = run_tenvBind_test ("tenvBind_test008", ("t", ~132, tenvEx01), Node (Leaf, ("t", ~132), Leaf))
val _ = run_tenvBind_test ("tenvBind_test009", ("f", ~492, tenvEx02), Node (Node (Node (Leaf, ("a", 107), Leaf), ("c", 417), Node (Leaf, ("e", ~151), Node (Node (Leaf, ("f", ~492), Leaf), ("o", ~499), Leaf))), ("s", 35), Node (Leaf, ("u", ~387), Node (Leaf, ("y", 263), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test010", ("l", 322, tenvEx02), Node (Node (Node (Leaf, ("a", 107), Leaf), ("c", 417), Node (Leaf, ("e", ~151), Node (Node (Leaf, ("l", 322), Leaf), ("o", ~499), Leaf))), ("s", 35), Node (Leaf, ("u", ~387), Node (Leaf, ("y", 263), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test011", ("z", 126, tenvEx02), Node (Node (Node (Leaf, ("a", 107), Leaf), ("c", 417), Node (Leaf, ("e", ~151), Node (Leaf, ("o", ~499), Leaf))), ("s", 35), Node (Leaf, ("u", ~387), Node (Leaf, ("y", 263), Node (Leaf, ("z", 126), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test012", ("d", ~394, tenvEx02), Node (Node (Node (Leaf, ("a", 107), Leaf), ("c", 417), Node (Node (Leaf, ("d", ~394), Leaf), ("e", ~151), Node (Leaf, ("o", ~499), Leaf))), ("s", 35), Node (Leaf, ("u", ~387), Node (Leaf, ("y", 263), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test013", ("r", 260, tenvEx02), Node (Node (Node (Leaf, ("a", 107), Leaf), ("c", 417), Node (Leaf, ("e", ~151), Node (Leaf, ("o", ~499), Node (Leaf, ("r", 260), Leaf)))), ("s", 35), Node (Leaf, ("u", ~387), Node (Leaf, ("y", 263), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test014", ("h", 256, tenvEx02), Node (Node (Node (Leaf, ("a", 107), Leaf), ("c", 417), Node (Leaf, ("e", ~151), Node (Node (Leaf, ("h", 256), Leaf), ("o", ~499), Leaf))), ("s", 35), Node (Leaf, ("u", ~387), Node (Leaf, ("y", 263), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test015", ("p", ~402, tenvEx02), Node (Node (Node (Leaf, ("a", 107), Leaf), ("c", 417), Node (Leaf, ("e", ~151), Node (Leaf, ("o", ~499), Node (Leaf, ("p", ~402), Leaf)))), ("s", 35), Node (Leaf, ("u", ~387), Node (Leaf, ("y", 263), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test016", ("t", ~132, tenvEx02), Node (Node (Node (Leaf, ("a", 107), Leaf), ("c", 417), Node (Leaf, ("e", ~151), Node (Leaf, ("o", ~499), Leaf))), ("s", 35), Node (Node (Leaf, ("t", ~132), Leaf), ("u", ~387), Node (Leaf, ("y", 263), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test017", ("f", ~492, tenvEx03), Node (Node (Leaf, ("d", ~422), Node (Node (Node (Node (Leaf, ("f", ~492), Leaf), ("j", 158), Leaf), ("n", ~362), Leaf), ("t", 424), Leaf)), ("v", 354), Node (Leaf, ("z", ~224), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test018", ("l", 322, tenvEx03), Node (Node (Leaf, ("d", ~422), Node (Node (Node (Node (Leaf, ("f", ~464), Leaf), ("j", 158), Node (Leaf, ("l", 322), Leaf)), ("n", ~362), Leaf), ("t", 424), Leaf)), ("v", 354), Node (Leaf, ("z", ~224), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test019", ("z", 126, tenvEx03), Node (Node (Leaf, ("d", ~422), Node (Node (Node (Node (Leaf, ("f", ~464), Leaf), ("j", 158), Leaf), ("n", ~362), Leaf), ("t", 424), Leaf)), ("v", 354), Node (Leaf, ("z", 126), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test020", ("d", ~394, tenvEx03), Node (Node (Leaf, ("d", ~394), Node (Node (Node (Node (Leaf, ("f", ~464), Leaf), ("j", 158), Leaf), ("n", ~362), Leaf), ("t", 424), Leaf)), ("v", 354), Node (Leaf, ("z", ~224), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test021", ("r", 260, tenvEx03), Node (Node (Leaf, ("d", ~422), Node (Node (Node (Node (Leaf, ("f", ~464), Leaf), ("j", 158), Leaf), ("n", ~362), Node (Leaf, ("r", 260), Leaf)), ("t", 424), Leaf)), ("v", 354), Node (Leaf, ("z", ~224), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test022", ("h", 256, tenvEx03), Node (Node (Leaf, ("d", ~422), Node (Node (Node (Node (Leaf, ("f", ~464), Node (Leaf, ("h", 256), Leaf)), ("j", 158), Leaf), ("n", ~362), Leaf), ("t", 424), Leaf)), ("v", 354), Node (Leaf, ("z", ~224), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test023", ("p", ~402, tenvEx03), Node (Node (Leaf, ("d", ~422), Node (Node (Node (Node (Leaf, ("f", ~464), Leaf), ("j", 158), Leaf), ("n", ~362), Node (Leaf, ("p", ~402), Leaf)), ("t", 424), Leaf)), ("v", 354), Node (Leaf, ("z", ~224), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test024", ("t", ~132, tenvEx03), Node (Node (Leaf, ("d", ~422), Node (Node (Node (Node (Leaf, ("f", ~464), Leaf), ("j", 158), Leaf), ("n", ~362), Leaf), ("t", ~132), Leaf)), ("v", 354), Node (Leaf, ("z", ~224), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test025", ("f", ~492, tenvEx04), Node (Node (Node (Leaf, ("c", ~169), Node (Leaf, ("f", ~492), Leaf)), ("g", 15), Node (Node (Leaf, ("i", 149), Node (Node (Leaf, ("m", ~313), Leaf), ("o", 115), Leaf)), ("q", ~159), Node (Leaf, ("s", 297), Leaf))), ("u", ~327), Node (Leaf, ("w", ~163), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test026", ("l", 322, tenvEx04), Node (Node (Node (Leaf, ("c", ~169), Leaf), ("g", 15), Node (Node (Leaf, ("i", 149), Node (Node (Node (Leaf, ("l", 322), Leaf), ("m", ~313), Leaf), ("o", 115), Leaf)), ("q", ~159), Node (Leaf, ("s", 297), Leaf))), ("u", ~327), Node (Leaf, ("w", ~163), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test027", ("z", 126, tenvEx04), Node (Node (Node (Leaf, ("c", ~169), Leaf), ("g", 15), Node (Node (Leaf, ("i", 149), Node (Node (Leaf, ("m", ~313), Leaf), ("o", 115), Leaf)), ("q", ~159), Node (Leaf, ("s", 297), Leaf))), ("u", ~327), Node (Leaf, ("w", ~163), Node (Leaf, ("z", 126), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test028", ("d", ~394, tenvEx04), Node (Node (Node (Leaf, ("c", ~169), Node (Leaf, ("d", ~394), Leaf)), ("g", 15), Node (Node (Leaf, ("i", 149), Node (Node (Leaf, ("m", ~313), Leaf), ("o", 115), Leaf)), ("q", ~159), Node (Leaf, ("s", 297), Leaf))), ("u", ~327), Node (Leaf, ("w", ~163), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test029", ("r", 260, tenvEx04), Node (Node (Node (Leaf, ("c", ~169), Leaf), ("g", 15), Node (Node (Leaf, ("i", 149), Node (Node (Leaf, ("m", ~313), Leaf), ("o", 115), Leaf)), ("q", ~159), Node (Node (Leaf, ("r", 260), Leaf), ("s", 297), Leaf))), ("u", ~327), Node (Leaf, ("w", ~163), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test030", ("h", 256, tenvEx04), Node (Node (Node (Leaf, ("c", ~169), Leaf), ("g", 15), Node (Node (Node (Leaf, ("h", 256), Leaf), ("i", 149), Node (Node (Leaf, ("m", ~313), Leaf), ("o", 115), Leaf)), ("q", ~159), Node (Leaf, ("s", 297), Leaf))), ("u", ~327), Node (Leaf, ("w", ~163), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test031", ("p", ~402, tenvEx04), Node (Node (Node (Leaf, ("c", ~169), Leaf), ("g", 15), Node (Node (Leaf, ("i", 149), Node (Node (Leaf, ("m", ~313), Leaf), ("o", 115), Node (Leaf, ("p", ~402), Leaf))), ("q", ~159), Node (Leaf, ("s", 297), Leaf))), ("u", ~327), Node (Leaf, ("w", ~163), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test032", ("t", ~132, tenvEx04), Node (Node (Node (Leaf, ("c", ~169), Leaf), ("g", 15), Node (Node (Leaf, ("i", 149), Node (Node (Leaf, ("m", ~313), Leaf), ("o", 115), Leaf)), ("q", ~159), Node (Leaf, ("s", 297), Node (Leaf, ("t", ~132), Leaf)))), ("u", ~327), Node (Leaf, ("w", ~163), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test033", ("f", ~492, tenvEx05), Node (Leaf, ("b", 56), Node (Node (Leaf, ("d", 192), Leaf), ("f", ~492), Node (Node (Node (Node (Leaf, ("h", 258), Node (Leaf, ("j", ~486), Leaf)), ("l", 468), Node (Leaf, ("n", 76), Leaf)), ("p", 94), Node (Node (Leaf, ("r", 348), Leaf), ("t", ~424), Leaf)), ("v", 62), Node (Leaf, ("x", ~184), Node (Leaf, ("z", 360), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test034", ("l", 322, tenvEx05), Node (Leaf, ("b", 56), Node (Node (Leaf, ("d", 192), Leaf), ("f", ~404), Node (Node (Node (Node (Leaf, ("h", 258), Node (Leaf, ("j", ~486), Leaf)), ("l", 322), Node (Leaf, ("n", 76), Leaf)), ("p", 94), Node (Node (Leaf, ("r", 348), Leaf), ("t", ~424), Leaf)), ("v", 62), Node (Leaf, ("x", ~184), Node (Leaf, ("z", 360), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test035", ("z", 126, tenvEx05), Node (Leaf, ("b", 56), Node (Node (Leaf, ("d", 192), Leaf), ("f", ~404), Node (Node (Node (Node (Leaf, ("h", 258), Node (Leaf, ("j", ~486), Leaf)), ("l", 468), Node (Leaf, ("n", 76), Leaf)), ("p", 94), Node (Node (Leaf, ("r", 348), Leaf), ("t", ~424), Leaf)), ("v", 62), Node (Leaf, ("x", ~184), Node (Leaf, ("z", 126), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test036", ("d", ~394, tenvEx05), Node (Leaf, ("b", 56), Node (Node (Leaf, ("d", ~394), Leaf), ("f", ~404), Node (Node (Node (Node (Leaf, ("h", 258), Node (Leaf, ("j", ~486), Leaf)), ("l", 468), Node (Leaf, ("n", 76), Leaf)), ("p", 94), Node (Node (Leaf, ("r", 348), Leaf), ("t", ~424), Leaf)), ("v", 62), Node (Leaf, ("x", ~184), Node (Leaf, ("z", 360), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test037", ("r", 260, tenvEx05), Node (Leaf, ("b", 56), Node (Node (Leaf, ("d", 192), Leaf), ("f", ~404), Node (Node (Node (Node (Leaf, ("h", 258), Node (Leaf, ("j", ~486), Leaf)), ("l", 468), Node (Leaf, ("n", 76), Leaf)), ("p", 94), Node (Node (Leaf, ("r", 260), Leaf), ("t", ~424), Leaf)), ("v", 62), Node (Leaf, ("x", ~184), Node (Leaf, ("z", 360), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test038", ("h", 256, tenvEx05), Node (Leaf, ("b", 56), Node (Node (Leaf, ("d", 192), Leaf), ("f", ~404), Node (Node (Node (Node (Leaf, ("h", 256), Node (Leaf, ("j", ~486), Leaf)), ("l", 468), Node (Leaf, ("n", 76), Leaf)), ("p", 94), Node (Node (Leaf, ("r", 348), Leaf), ("t", ~424), Leaf)), ("v", 62), Node (Leaf, ("x", ~184), Node (Leaf, ("z", 360), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test039", ("p", ~402, tenvEx05), Node (Leaf, ("b", 56), Node (Node (Leaf, ("d", 192), Leaf), ("f", ~404), Node (Node (Node (Node (Leaf, ("h", 258), Node (Leaf, ("j", ~486), Leaf)), ("l", 468), Node (Leaf, ("n", 76), Leaf)), ("p", ~402), Node (Node (Leaf, ("r", 348), Leaf), ("t", ~424), Leaf)), ("v", 62), Node (Leaf, ("x", ~184), Node (Leaf, ("z", 360), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test040", ("t", ~132, tenvEx05), Node (Leaf, ("b", 56), Node (Node (Leaf, ("d", 192), Leaf), ("f", ~404), Node (Node (Node (Node (Leaf, ("h", 258), Node (Leaf, ("j", ~486), Leaf)), ("l", 468), Node (Leaf, ("n", 76), Leaf)), ("p", 94), Node (Node (Leaf, ("r", 348), Leaf), ("t", ~132), Leaf)), ("v", 62), Node (Leaf, ("x", ~184), Node (Leaf, ("z", 360), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test041", ("f", ~492, tenvEx06), Node (Node (Node (Node (Leaf, ("a", 427), Leaf), ("c", ~257), Leaf), ("e", ~297), Node (Node (Node (Node (Leaf, ("f", ~492), Leaf), ("g", ~455), Leaf), ("i", 31), Node (Leaf, ("k", 21), Leaf)), ("m", ~401), Node (Node (Node (Leaf, ("o", ~441), Leaf), ("q", ~511), Leaf), ("s", ~113), Node (Leaf, ("u", 169), Leaf)))), ("w", 245), Node (Leaf, ("y", ~291), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test042", ("l", 322, tenvEx06), Node (Node (Node (Node (Leaf, ("a", 427), Leaf), ("c", ~257), Leaf), ("e", ~297), Node (Node (Node (Leaf, ("g", ~455), Leaf), ("i", 31), Node (Leaf, ("k", 21), Node (Leaf, ("l", 322), Leaf))), ("m", ~401), Node (Node (Node (Leaf, ("o", ~441), Leaf), ("q", ~511), Leaf), ("s", ~113), Node (Leaf, ("u", 169), Leaf)))), ("w", 245), Node (Leaf, ("y", ~291), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test043", ("z", 126, tenvEx06), Node (Node (Node (Node (Leaf, ("a", 427), Leaf), ("c", ~257), Leaf), ("e", ~297), Node (Node (Node (Leaf, ("g", ~455), Leaf), ("i", 31), Node (Leaf, ("k", 21), Leaf)), ("m", ~401), Node (Node (Node (Leaf, ("o", ~441), Leaf), ("q", ~511), Leaf), ("s", ~113), Node (Leaf, ("u", 169), Leaf)))), ("w", 245), Node (Leaf, ("y", ~291), Node (Leaf, ("z", 126), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test044", ("d", ~394, tenvEx06), Node (Node (Node (Node (Leaf, ("a", 427), Leaf), ("c", ~257), Node (Leaf, ("d", ~394), Leaf)), ("e", ~297), Node (Node (Node (Leaf, ("g", ~455), Leaf), ("i", 31), Node (Leaf, ("k", 21), Leaf)), ("m", ~401), Node (Node (Node (Leaf, ("o", ~441), Leaf), ("q", ~511), Leaf), ("s", ~113), Node (Leaf, ("u", 169), Leaf)))), ("w", 245), Node (Leaf, ("y", ~291), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test045", ("r", 260, tenvEx06), Node (Node (Node (Node (Leaf, ("a", 427), Leaf), ("c", ~257), Leaf), ("e", ~297), Node (Node (Node (Leaf, ("g", ~455), Leaf), ("i", 31), Node (Leaf, ("k", 21), Leaf)), ("m", ~401), Node (Node (Node (Leaf, ("o", ~441), Leaf), ("q", ~511), Node (Leaf, ("r", 260), Leaf)), ("s", ~113), Node (Leaf, ("u", 169), Leaf)))), ("w", 245), Node (Leaf, ("y", ~291), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test046", ("h", 256, tenvEx06), Node (Node (Node (Node (Leaf, ("a", 427), Leaf), ("c", ~257), Leaf), ("e", ~297), Node (Node (Node (Leaf, ("g", ~455), Node (Leaf, ("h", 256), Leaf)), ("i", 31), Node (Leaf, ("k", 21), Leaf)), ("m", ~401), Node (Node (Node (Leaf, ("o", ~441), Leaf), ("q", ~511), Leaf), ("s", ~113), Node (Leaf, ("u", 169), Leaf)))), ("w", 245), Node (Leaf, ("y", ~291), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test047", ("p", ~402, tenvEx06), Node (Node (Node (Node (Leaf, ("a", 427), Leaf), ("c", ~257), Leaf), ("e", ~297), Node (Node (Node (Leaf, ("g", ~455), Leaf), ("i", 31), Node (Leaf, ("k", 21), Leaf)), ("m", ~401), Node (Node (Node (Leaf, ("o", ~441), Node (Leaf, ("p", ~402), Leaf)), ("q", ~511), Leaf), ("s", ~113), Node (Leaf, ("u", 169), Leaf)))), ("w", 245), Node (Leaf, ("y", ~291), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test048", ("t", ~132, tenvEx06), Node (Node (Node (Node (Leaf, ("a", 427), Leaf), ("c", ~257), Leaf), ("e", ~297), Node (Node (Node (Leaf, ("g", ~455), Leaf), ("i", 31), Node (Leaf, ("k", 21), Leaf)), ("m", ~401), Node (Node (Node (Leaf, ("o", ~441), Leaf), ("q", ~511), Leaf), ("s", ~113), Node (Node (Leaf, ("t", ~132), Leaf), ("u", 169), Leaf)))), ("w", 245), Node (Leaf, ("y", ~291), Leaf)))
val _ = run_tenvBind_test ("tenvBind_test049", ("f", ~492, tenvEx07), Node (Node (Node (Leaf, ("b", 378), Leaf), ("d", ~72), Node (Leaf, ("f", ~492), Node (Leaf, ("h", 82), Leaf))), ("j", 362), Node (Node (Leaf, ("l", ~58), Leaf), ("n", 340), Node (Node (Node (Node (Leaf, ("p", ~52), Leaf), ("r", 114), Leaf), ("t", 130), Leaf), ("x", ~66), Node (Leaf, ("z", ~312), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test050", ("l", 322, tenvEx07), Node (Node (Node (Leaf, ("b", 378), Leaf), ("d", ~72), Node (Leaf, ("f", 64), Node (Leaf, ("h", 82), Leaf))), ("j", 362), Node (Node (Leaf, ("l", 322), Leaf), ("n", 340), Node (Node (Node (Node (Leaf, ("p", ~52), Leaf), ("r", 114), Leaf), ("t", 130), Leaf), ("x", ~66), Node (Leaf, ("z", ~312), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test051", ("z", 126, tenvEx07), Node (Node (Node (Leaf, ("b", 378), Leaf), ("d", ~72), Node (Leaf, ("f", 64), Node (Leaf, ("h", 82), Leaf))), ("j", 362), Node (Node (Leaf, ("l", ~58), Leaf), ("n", 340), Node (Node (Node (Node (Leaf, ("p", ~52), Leaf), ("r", 114), Leaf), ("t", 130), Leaf), ("x", ~66), Node (Leaf, ("z", 126), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test052", ("d", ~394, tenvEx07), Node (Node (Node (Leaf, ("b", 378), Leaf), ("d", ~394), Node (Leaf, ("f", 64), Node (Leaf, ("h", 82), Leaf))), ("j", 362), Node (Node (Leaf, ("l", ~58), Leaf), ("n", 340), Node (Node (Node (Node (Leaf, ("p", ~52), Leaf), ("r", 114), Leaf), ("t", 130), Leaf), ("x", ~66), Node (Leaf, ("z", ~312), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test053", ("r", 260, tenvEx07), Node (Node (Node (Leaf, ("b", 378), Leaf), ("d", ~72), Node (Leaf, ("f", 64), Node (Leaf, ("h", 82), Leaf))), ("j", 362), Node (Node (Leaf, ("l", ~58), Leaf), ("n", 340), Node (Node (Node (Node (Leaf, ("p", ~52), Leaf), ("r", 260), Leaf), ("t", 130), Leaf), ("x", ~66), Node (Leaf, ("z", ~312), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test054", ("h", 256, tenvEx07), Node (Node (Node (Leaf, ("b", 378), Leaf), ("d", ~72), Node (Leaf, ("f", 64), Node (Leaf, ("h", 256), Leaf))), ("j", 362), Node (Node (Leaf, ("l", ~58), Leaf), ("n", 340), Node (Node (Node (Node (Leaf, ("p", ~52), Leaf), ("r", 114), Leaf), ("t", 130), Leaf), ("x", ~66), Node (Leaf, ("z", ~312), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test055", ("p", ~402, tenvEx07), Node (Node (Node (Leaf, ("b", 378), Leaf), ("d", ~72), Node (Leaf, ("f", 64), Node (Leaf, ("h", 82), Leaf))), ("j", 362), Node (Node (Leaf, ("l", ~58), Leaf), ("n", 340), Node (Node (Node (Node (Leaf, ("p", ~402), Leaf), ("r", 114), Leaf), ("t", 130), Leaf), ("x", ~66), Node (Leaf, ("z", ~312), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test056", ("t", ~132, tenvEx07), Node (Node (Node (Leaf, ("b", 378), Leaf), ("d", ~72), Node (Leaf, ("f", 64), Node (Leaf, ("h", 82), Leaf))), ("j", 362), Node (Node (Leaf, ("l", ~58), Leaf), ("n", 340), Node (Node (Node (Node (Leaf, ("p", ~52), Leaf), ("r", 114), Leaf), ("t", ~132), Leaf), ("x", ~66), Node (Leaf, ("z", ~312), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test057", ("f", ~492, tenvEx08), Node (Node (Node (Node (Leaf, ("a", 341), Leaf), ("c", ~81), Node (Leaf, ("e", ~121), Node (Leaf, ("f", ~492), Leaf))), ("g", ~191), Node (Node (Leaf, ("i", 207), Leaf), ("k", 489), Leaf)), ("m", ~459), Node (Node (Node (Leaf, ("o", 379), Leaf), ("q", ~277), Leaf), ("s", 63), Node (Node (Leaf, ("u", 23), Leaf), ("w", ~135), Node (Leaf, ("y", 351), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test058", ("l", 322, tenvEx08), Node (Node (Node (Node (Leaf, ("a", 341), Leaf), ("c", ~81), Node (Leaf, ("e", ~121), Leaf)), ("g", ~191), Node (Node (Leaf, ("i", 207), Leaf), ("k", 489), Node (Leaf, ("l", 322), Leaf))), ("m", ~459), Node (Node (Node (Leaf, ("o", 379), Leaf), ("q", ~277), Leaf), ("s", 63), Node (Node (Leaf, ("u", 23), Leaf), ("w", ~135), Node (Leaf, ("y", 351), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test059", ("z", 126, tenvEx08), Node (Node (Node (Node (Leaf, ("a", 341), Leaf), ("c", ~81), Node (Leaf, ("e", ~121), Leaf)), ("g", ~191), Node (Node (Leaf, ("i", 207), Leaf), ("k", 489), Leaf)), ("m", ~459), Node (Node (Node (Leaf, ("o", 379), Leaf), ("q", ~277), Leaf), ("s", 63), Node (Node (Leaf, ("u", 23), Leaf), ("w", ~135), Node (Leaf, ("y", 351), Node (Leaf, ("z", 126), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test060", ("d", ~394, tenvEx08), Node (Node (Node (Node (Leaf, ("a", 341), Leaf), ("c", ~81), Node (Node (Leaf, ("d", ~394), Leaf), ("e", ~121), Leaf)), ("g", ~191), Node (Node (Leaf, ("i", 207), Leaf), ("k", 489), Leaf)), ("m", ~459), Node (Node (Node (Leaf, ("o", 379), Leaf), ("q", ~277), Leaf), ("s", 63), Node (Node (Leaf, ("u", 23), Leaf), ("w", ~135), Node (Leaf, ("y", 351), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test061", ("r", 260, tenvEx08), Node (Node (Node (Node (Leaf, ("a", 341), Leaf), ("c", ~81), Node (Leaf, ("e", ~121), Leaf)), ("g", ~191), Node (Node (Leaf, ("i", 207), Leaf), ("k", 489), Leaf)), ("m", ~459), Node (Node (Node (Leaf, ("o", 379), Leaf), ("q", ~277), Node (Leaf, ("r", 260), Leaf)), ("s", 63), Node (Node (Leaf, ("u", 23), Leaf), ("w", ~135), Node (Leaf, ("y", 351), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test062", ("h", 256, tenvEx08), Node (Node (Node (Node (Leaf, ("a", 341), Leaf), ("c", ~81), Node (Leaf, ("e", ~121), Leaf)), ("g", ~191), Node (Node (Node (Leaf, ("h", 256), Leaf), ("i", 207), Leaf), ("k", 489), Leaf)), ("m", ~459), Node (Node (Node (Leaf, ("o", 379), Leaf), ("q", ~277), Leaf), ("s", 63), Node (Node (Leaf, ("u", 23), Leaf), ("w", ~135), Node (Leaf, ("y", 351), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test063", ("p", ~402, tenvEx08), Node (Node (Node (Node (Leaf, ("a", 341), Leaf), ("c", ~81), Node (Leaf, ("e", ~121), Leaf)), ("g", ~191), Node (Node (Leaf, ("i", 207), Leaf), ("k", 489), Leaf)), ("m", ~459), Node (Node (Node (Leaf, ("o", 379), Node (Leaf, ("p", ~402), Leaf)), ("q", ~277), Leaf), ("s", 63), Node (Node (Leaf, ("u", 23), Leaf), ("w", ~135), Node (Leaf, ("y", 351), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test064", ("t", ~132, tenvEx08), Node (Node (Node (Node (Leaf, ("a", 341), Leaf), ("c", ~81), Node (Leaf, ("e", ~121), Leaf)), ("g", ~191), Node (Node (Leaf, ("i", 207), Leaf), ("k", 489), Leaf)), ("m", ~459), Node (Node (Node (Leaf, ("o", 379), Leaf), ("q", ~277), Leaf), ("s", 63), Node (Node (Node (Leaf, ("t", ~132), Leaf), ("u", 23), Leaf), ("w", ~135), Node (Leaf, ("y", 351), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test065", ("f", ~492, tenvEx09), Node (Node (Leaf, ("b", 174), Node (Node (Leaf, ("d", ~100), Leaf), ("f", ~492), Leaf)), ("h", ~328), Node (Node (Leaf, ("j", ~192), Node (Leaf, ("l", ~88), Node (Leaf, ("n", 106), Node (Leaf, ("p", ~460), Leaf)))), ("r", ~354), Node (Node (Leaf, ("t", ~190), Node (Leaf, ("v", 90), Leaf)), ("x", 20), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test066", ("l", 322, tenvEx09), Node (Node (Leaf, ("b", 174), Node (Node (Leaf, ("d", ~100), Leaf), ("f", ~142), Leaf)), ("h", ~328), Node (Node (Leaf, ("j", ~192), Node (Leaf, ("l", 322), Node (Leaf, ("n", 106), Node (Leaf, ("p", ~460), Leaf)))), ("r", ~354), Node (Node (Leaf, ("t", ~190), Node (Leaf, ("v", 90), Leaf)), ("x", 20), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test067", ("z", 126, tenvEx09), Node (Node (Leaf, ("b", 174), Node (Node (Leaf, ("d", ~100), Leaf), ("f", ~142), Leaf)), ("h", ~328), Node (Node (Leaf, ("j", ~192), Node (Leaf, ("l", ~88), Node (Leaf, ("n", 106), Node (Leaf, ("p", ~460), Leaf)))), ("r", ~354), Node (Node (Leaf, ("t", ~190), Node (Leaf, ("v", 90), Leaf)), ("x", 20), Node (Leaf, ("z", 126), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test068", ("d", ~394, tenvEx09), Node (Node (Leaf, ("b", 174), Node (Node (Leaf, ("d", ~394), Leaf), ("f", ~142), Leaf)), ("h", ~328), Node (Node (Leaf, ("j", ~192), Node (Leaf, ("l", ~88), Node (Leaf, ("n", 106), Node (Leaf, ("p", ~460), Leaf)))), ("r", ~354), Node (Node (Leaf, ("t", ~190), Node (Leaf, ("v", 90), Leaf)), ("x", 20), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test069", ("r", 260, tenvEx09), Node (Node (Leaf, ("b", 174), Node (Node (Leaf, ("d", ~100), Leaf), ("f", ~142), Leaf)), ("h", ~328), Node (Node (Leaf, ("j", ~192), Node (Leaf, ("l", ~88), Node (Leaf, ("n", 106), Node (Leaf, ("p", ~460), Leaf)))), ("r", 260), Node (Node (Leaf, ("t", ~190), Node (Leaf, ("v", 90), Leaf)), ("x", 20), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test070", ("h", 256, tenvEx09), Node (Node (Leaf, ("b", 174), Node (Node (Leaf, ("d", ~100), Leaf), ("f", ~142), Leaf)), ("h", 256), Node (Node (Leaf, ("j", ~192), Node (Leaf, ("l", ~88), Node (Leaf, ("n", 106), Node (Leaf, ("p", ~460), Leaf)))), ("r", ~354), Node (Node (Leaf, ("t", ~190), Node (Leaf, ("v", 90), Leaf)), ("x", 20), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test071", ("p", ~402, tenvEx09), Node (Node (Leaf, ("b", 174), Node (Node (Leaf, ("d", ~100), Leaf), ("f", ~142), Leaf)), ("h", ~328), Node (Node (Leaf, ("j", ~192), Node (Leaf, ("l", ~88), Node (Leaf, ("n", 106), Node (Leaf, ("p", ~402), Leaf)))), ("r", ~354), Node (Node (Leaf, ("t", ~190), Node (Leaf, ("v", 90), Leaf)), ("x", 20), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test072", ("t", ~132, tenvEx09), Node (Node (Leaf, ("b", 174), Node (Node (Leaf, ("d", ~100), Leaf), ("f", ~142), Leaf)), ("h", ~328), Node (Node (Leaf, ("j", ~192), Node (Leaf, ("l", ~88), Node (Leaf, ("n", 106), Node (Leaf, ("p", ~460), Leaf)))), ("r", ~354), Node (Node (Leaf, ("t", ~132), Node (Leaf, ("v", 90), Leaf)), ("x", 20), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test073", ("f", ~492, tenvEx10), Node (Leaf, ("a", ~391), Node (Node (Node (Leaf, ("c", 95), Leaf), ("e", ~3), Node (Node (Leaf, ("f", ~492), Leaf), ("g", ~337), Leaf)), ("i", ~27), Node (Node (Node (Node (Leaf, ("k", ~447), Leaf), ("m", ~49), Node (Leaf, ("o", 85), Leaf)), ("q", 309), Node (Leaf, ("s", ~317), Node (Leaf, ("u", 491), Node (Leaf, ("w", ~223), Leaf)))), ("y", ~233), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test074", ("l", 322, tenvEx10), Node (Leaf, ("a", ~391), Node (Node (Node (Leaf, ("c", 95), Leaf), ("e", ~3), Node (Leaf, ("g", ~337), Leaf)), ("i", ~27), Node (Node (Node (Node (Leaf, ("k", ~447), Node (Leaf, ("l", 322), Leaf)), ("m", ~49), Node (Leaf, ("o", 85), Leaf)), ("q", 309), Node (Leaf, ("s", ~317), Node (Leaf, ("u", 491), Node (Leaf, ("w", ~223), Leaf)))), ("y", ~233), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test075", ("z", 126, tenvEx10), Node (Leaf, ("a", ~391), Node (Node (Node (Leaf, ("c", 95), Leaf), ("e", ~3), Node (Leaf, ("g", ~337), Leaf)), ("i", ~27), Node (Node (Node (Node (Leaf, ("k", ~447), Leaf), ("m", ~49), Node (Leaf, ("o", 85), Leaf)), ("q", 309), Node (Leaf, ("s", ~317), Node (Leaf, ("u", 491), Node (Leaf, ("w", ~223), Leaf)))), ("y", ~233), Node (Leaf, ("z", 126), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test076", ("d", ~394, tenvEx10), Node (Leaf, ("a", ~391), Node (Node (Node (Leaf, ("c", 95), Node (Leaf, ("d", ~394), Leaf)), ("e", ~3), Node (Leaf, ("g", ~337), Leaf)), ("i", ~27), Node (Node (Node (Node (Leaf, ("k", ~447), Leaf), ("m", ~49), Node (Leaf, ("o", 85), Leaf)), ("q", 309), Node (Leaf, ("s", ~317), Node (Leaf, ("u", 491), Node (Leaf, ("w", ~223), Leaf)))), ("y", ~233), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test077", ("r", 260, tenvEx10), Node (Leaf, ("a", ~391), Node (Node (Node (Leaf, ("c", 95), Leaf), ("e", ~3), Node (Leaf, ("g", ~337), Leaf)), ("i", ~27), Node (Node (Node (Node (Leaf, ("k", ~447), Leaf), ("m", ~49), Node (Leaf, ("o", 85), Leaf)), ("q", 309), Node (Node (Leaf, ("r", 260), Leaf), ("s", ~317), Node (Leaf, ("u", 491), Node (Leaf, ("w", ~223), Leaf)))), ("y", ~233), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test078", ("h", 256, tenvEx10), Node (Leaf, ("a", ~391), Node (Node (Node (Leaf, ("c", 95), Leaf), ("e", ~3), Node (Leaf, ("g", ~337), Node (Leaf, ("h", 256), Leaf))), ("i", ~27), Node (Node (Node (Node (Leaf, ("k", ~447), Leaf), ("m", ~49), Node (Leaf, ("o", 85), Leaf)), ("q", 309), Node (Leaf, ("s", ~317), Node (Leaf, ("u", 491), Node (Leaf, ("w", ~223), Leaf)))), ("y", ~233), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test079", ("p", ~402, tenvEx10), Node (Leaf, ("a", ~391), Node (Node (Node (Leaf, ("c", 95), Leaf), ("e", ~3), Node (Leaf, ("g", ~337), Leaf)), ("i", ~27), Node (Node (Node (Node (Leaf, ("k", ~447), Leaf), ("m", ~49), Node (Leaf, ("o", 85), Node (Leaf, ("p", ~402), Leaf))), ("q", 309), Node (Leaf, ("s", ~317), Node (Leaf, ("u", 491), Node (Leaf, ("w", ~223), Leaf)))), ("y", ~233), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test080", ("t", ~132, tenvEx10), Node (Leaf, ("a", ~391), Node (Node (Node (Leaf, ("c", 95), Leaf), ("e", ~3), Node (Leaf, ("g", ~337), Leaf)), ("i", ~27), Node (Node (Node (Node (Leaf, ("k", ~447), Leaf), ("m", ~49), Node (Leaf, ("o", 85), Leaf)), ("q", 309), Node (Leaf, ("s", ~317), Node (Node (Leaf, ("t", ~132), Leaf), ("u", 491), Node (Leaf, ("w", ~223), Leaf)))), ("y", ~233), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test081", ("f", ~492, tenvEx11), Node (Node (Node (Leaf, ("b", ~236), Node (Node (Node (Leaf, ("d", 396), Leaf), ("f", ~492), Leaf), ("h", ~182), Leaf)), ("l", ~146), Node (Leaf, ("n", 136), Node (Leaf, ("p", ~198), Leaf))), ("r", 376), Node (Leaf, ("t", ~104), Node (Node (Leaf, ("v", 382), Node (Leaf, ("x", ~214), Leaf)), ("z", 390), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test082", ("l", 322, tenvEx11), Node (Node (Node (Leaf, ("b", ~236), Node (Node (Node (Leaf, ("d", 396), Leaf), ("f", ~462), Leaf), ("h", ~182), Leaf)), ("l", 322), Node (Leaf, ("n", 136), Node (Leaf, ("p", ~198), Leaf))), ("r", 376), Node (Leaf, ("t", ~104), Node (Node (Leaf, ("v", 382), Node (Leaf, ("x", ~214), Leaf)), ("z", 390), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test083", ("z", 126, tenvEx11), Node (Node (Node (Leaf, ("b", ~236), Node (Node (Node (Leaf, ("d", 396), Leaf), ("f", ~462), Leaf), ("h", ~182), Leaf)), ("l", ~146), Node (Leaf, ("n", 136), Node (Leaf, ("p", ~198), Leaf))), ("r", 376), Node (Leaf, ("t", ~104), Node (Node (Leaf, ("v", 382), Node (Leaf, ("x", ~214), Leaf)), ("z", 126), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test084", ("d", ~394, tenvEx11), Node (Node (Node (Leaf, ("b", ~236), Node (Node (Node (Leaf, ("d", ~394), Leaf), ("f", ~462), Leaf), ("h", ~182), Leaf)), ("l", ~146), Node (Leaf, ("n", 136), Node (Leaf, ("p", ~198), Leaf))), ("r", 376), Node (Leaf, ("t", ~104), Node (Node (Leaf, ("v", 382), Node (Leaf, ("x", ~214), Leaf)), ("z", 390), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test085", ("r", 260, tenvEx11), Node (Node (Node (Leaf, ("b", ~236), Node (Node (Node (Leaf, ("d", 396), Leaf), ("f", ~462), Leaf), ("h", ~182), Leaf)), ("l", ~146), Node (Leaf, ("n", 136), Node (Leaf, ("p", ~198), Leaf))), ("r", 260), Node (Leaf, ("t", ~104), Node (Node (Leaf, ("v", 382), Node (Leaf, ("x", ~214), Leaf)), ("z", 390), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test086", ("h", 256, tenvEx11), Node (Node (Node (Leaf, ("b", ~236), Node (Node (Node (Leaf, ("d", 396), Leaf), ("f", ~462), Leaf), ("h", 256), Leaf)), ("l", ~146), Node (Leaf, ("n", 136), Node (Leaf, ("p", ~198), Leaf))), ("r", 376), Node (Leaf, ("t", ~104), Node (Node (Leaf, ("v", 382), Node (Leaf, ("x", ~214), Leaf)), ("z", 390), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test087", ("p", ~402, tenvEx11), Node (Node (Node (Leaf, ("b", ~236), Node (Node (Node (Leaf, ("d", 396), Leaf), ("f", ~462), Leaf), ("h", ~182), Leaf)), ("l", ~146), Node (Leaf, ("n", 136), Node (Leaf, ("p", ~402), Leaf))), ("r", 376), Node (Leaf, ("t", ~104), Node (Node (Leaf, ("v", 382), Node (Leaf, ("x", ~214), Leaf)), ("z", 390), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test088", ("t", ~132, tenvEx11), Node (Node (Node (Leaf, ("b", ~236), Node (Node (Node (Leaf, ("d", 396), Leaf), ("f", ~462), Leaf), ("h", ~182), Leaf)), ("l", ~146), Node (Leaf, ("n", 136), Node (Leaf, ("p", ~198), Leaf))), ("r", 376), Node (Leaf, ("t", ~132), Node (Node (Leaf, ("v", 382), Node (Leaf, ("x", ~214), Leaf)), ("z", 390), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test089", ("f", ~492, tenvEx12), Node (Node (Leaf, ("a", 165), Leaf), ("c", ~255), Node (Node (Leaf, ("e", 143), Node (Leaf, ("f", ~492), Leaf)), ("g", 277), Node (Node (Leaf, ("i", 501), Node (Node (Leaf, ("k", ~125), Leaf), ("m", 243), Leaf)), ("o", ~31), Node (Node (Node (Leaf, ("q", 425), Leaf), ("s", ~199), Leaf), ("u", 287), Node (Leaf, ("w", ~75), Node (Leaf, ("y", ~145), Leaf)))))))
val _ = run_tenvBind_test ("tenvBind_test090", ("l", 322, tenvEx12), Node (Node (Leaf, ("a", 165), Leaf), ("c", ~255), Node (Node (Leaf, ("e", 143), Leaf), ("g", 277), Node (Node (Leaf, ("i", 501), Node (Node (Leaf, ("k", ~125), Node (Leaf, ("l", 322), Leaf)), ("m", 243), Leaf)), ("o", ~31), Node (Node (Node (Leaf, ("q", 425), Leaf), ("s", ~199), Leaf), ("u", 287), Node (Leaf, ("w", ~75), Node (Leaf, ("y", ~145), Leaf)))))))
val _ = run_tenvBind_test ("tenvBind_test091", ("z", 126, tenvEx12), Node (Node (Leaf, ("a", 165), Leaf), ("c", ~255), Node (Node (Leaf, ("e", 143), Leaf), ("g", 277), Node (Node (Leaf, ("i", 501), Node (Node (Leaf, ("k", ~125), Leaf), ("m", 243), Leaf)), ("o", ~31), Node (Node (Node (Leaf, ("q", 425), Leaf), ("s", ~199), Leaf), ("u", 287), Node (Leaf, ("w", ~75), Node (Leaf, ("y", ~145), Node (Leaf, ("z", 126), Leaf))))))))
val _ = run_tenvBind_test ("tenvBind_test092", ("d", ~394, tenvEx12), Node (Node (Leaf, ("a", 165), Leaf), ("c", ~255), Node (Node (Node (Leaf, ("d", ~394), Leaf), ("e", 143), Leaf), ("g", 277), Node (Node (Leaf, ("i", 501), Node (Node (Leaf, ("k", ~125), Leaf), ("m", 243), Leaf)), ("o", ~31), Node (Node (Node (Leaf, ("q", 425), Leaf), ("s", ~199), Leaf), ("u", 287), Node (Leaf, ("w", ~75), Node (Leaf, ("y", ~145), Leaf)))))))
val _ = run_tenvBind_test ("tenvBind_test093", ("r", 260, tenvEx12), Node (Node (Leaf, ("a", 165), Leaf), ("c", ~255), Node (Node (Leaf, ("e", 143), Leaf), ("g", 277), Node (Node (Leaf, ("i", 501), Node (Node (Leaf, ("k", ~125), Leaf), ("m", 243), Leaf)), ("o", ~31), Node (Node (Node (Leaf, ("q", 425), Node (Leaf, ("r", 260), Leaf)), ("s", ~199), Leaf), ("u", 287), Node (Leaf, ("w", ~75), Node (Leaf, ("y", ~145), Leaf)))))))
val _ = run_tenvBind_test ("tenvBind_test094", ("h", 256, tenvEx12), Node (Node (Leaf, ("a", 165), Leaf), ("c", ~255), Node (Node (Leaf, ("e", 143), Leaf), ("g", 277), Node (Node (Node (Leaf, ("h", 256), Leaf), ("i", 501), Node (Node (Leaf, ("k", ~125), Leaf), ("m", 243), Leaf)), ("o", ~31), Node (Node (Node (Leaf, ("q", 425), Leaf), ("s", ~199), Leaf), ("u", 287), Node (Leaf, ("w", ~75), Node (Leaf, ("y", ~145), Leaf)))))))
val _ = run_tenvBind_test ("tenvBind_test095", ("p", ~402, tenvEx12), Node (Node (Leaf, ("a", 165), Leaf), ("c", ~255), Node (Node (Leaf, ("e", 143), Leaf), ("g", 277), Node (Node (Leaf, ("i", 501), Node (Node (Leaf, ("k", ~125), Leaf), ("m", 243), Leaf)), ("o", ~31), Node (Node (Node (Node (Leaf, ("p", ~402), Leaf), ("q", 425), Leaf), ("s", ~199), Leaf), ("u", 287), Node (Leaf, ("w", ~75), Node (Leaf, ("y", ~145), Leaf)))))))
val _ = run_tenvBind_test ("tenvBind_test096", ("t", ~132, tenvEx12), Node (Node (Leaf, ("a", 165), Leaf), ("c", ~255), Node (Node (Leaf, ("e", 143), Leaf), ("g", 277), Node (Node (Leaf, ("i", 501), Node (Node (Leaf, ("k", ~125), Leaf), ("m", 243), Leaf)), ("o", ~31), Node (Node (Node (Leaf, ("q", 425), Leaf), ("s", ~199), Node (Leaf, ("t", ~132), Leaf)), ("u", 287), Node (Leaf, ("w", ~75), Node (Leaf, ("y", ~145), Leaf)))))))
val _ = run_tenvBind_test ("tenvBind_test097", ("f", ~492, tenvEx13), Node (Leaf, ("b", ~470), Node (Node (Node (Leaf, ("d", ~394), Node (Node (Leaf, ("f", ~492), Leaf), ("h", 256), Node (Leaf, ("j", ~486), Node (Leaf, ("l", 468), Leaf)))), ("n", 76), Leaf), ("p", ~402), Node (Node (Node (Leaf, ("r", 260), Node (Leaf, ("t", 306), Node (Leaf, ("v", 120), Leaf))), ("x", ~184), Leaf), ("z", 360), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test098", ("l", 322, tenvEx13), Node (Leaf, ("b", ~470), Node (Node (Node (Leaf, ("d", ~394), Node (Node (Leaf, ("f", ~404), Leaf), ("h", 256), Node (Leaf, ("j", ~486), Node (Leaf, ("l", 322), Leaf)))), ("n", 76), Leaf), ("p", ~402), Node (Node (Node (Leaf, ("r", 260), Node (Leaf, ("t", 306), Node (Leaf, ("v", 120), Leaf))), ("x", ~184), Leaf), ("z", 360), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test099", ("z", 126, tenvEx13), Node (Leaf, ("b", ~470), Node (Node (Node (Leaf, ("d", ~394), Node (Node (Leaf, ("f", ~404), Leaf), ("h", 256), Node (Leaf, ("j", ~486), Node (Leaf, ("l", 468), Leaf)))), ("n", 76), Leaf), ("p", ~402), Node (Node (Node (Leaf, ("r", 260), Node (Leaf, ("t", 306), Node (Leaf, ("v", 120), Leaf))), ("x", ~184), Leaf), ("z", 126), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test100", ("d", ~394, tenvEx13), Node (Leaf, ("b", ~470), Node (Node (Node (Leaf, ("d", ~394), Node (Node (Leaf, ("f", ~404), Leaf), ("h", 256), Node (Leaf, ("j", ~486), Node (Leaf, ("l", 468), Leaf)))), ("n", 76), Leaf), ("p", ~402), Node (Node (Node (Leaf, ("r", 260), Node (Leaf, ("t", 306), Node (Leaf, ("v", 120), Leaf))), ("x", ~184), Leaf), ("z", 360), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test101", ("r", 260, tenvEx13), Node (Leaf, ("b", ~470), Node (Node (Node (Leaf, ("d", ~394), Node (Node (Leaf, ("f", ~404), Leaf), ("h", 256), Node (Leaf, ("j", ~486), Node (Leaf, ("l", 468), Leaf)))), ("n", 76), Leaf), ("p", ~402), Node (Node (Node (Leaf, ("r", 260), Node (Leaf, ("t", 306), Node (Leaf, ("v", 120), Leaf))), ("x", ~184), Leaf), ("z", 360), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test102", ("h", 256, tenvEx13), Node (Leaf, ("b", ~470), Node (Node (Node (Leaf, ("d", ~394), Node (Node (Leaf, ("f", ~404), Leaf), ("h", 256), Node (Leaf, ("j", ~486), Node (Leaf, ("l", 468), Leaf)))), ("n", 76), Leaf), ("p", ~402), Node (Node (Node (Leaf, ("r", 260), Node (Leaf, ("t", 306), Node (Leaf, ("v", 120), Leaf))), ("x", ~184), Leaf), ("z", 360), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test103", ("p", ~402, tenvEx13), Node (Leaf, ("b", ~470), Node (Node (Node (Leaf, ("d", ~394), Node (Node (Leaf, ("f", ~404), Leaf), ("h", 256), Node (Leaf, ("j", ~486), Node (Leaf, ("l", 468), Leaf)))), ("n", 76), Leaf), ("p", ~402), Node (Node (Node (Leaf, ("r", 260), Node (Leaf, ("t", 306), Node (Leaf, ("v", 120), Leaf))), ("x", ~184), Leaf), ("z", 360), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test104", ("t", ~132, tenvEx13), Node (Leaf, ("b", ~470), Node (Node (Node (Leaf, ("d", ~394), Node (Node (Leaf, ("f", ~404), Leaf), ("h", 256), Node (Leaf, ("j", ~486), Node (Leaf, ("l", 468), Leaf)))), ("n", 76), Leaf), ("p", ~402), Node (Node (Node (Leaf, ("r", 260), Node (Leaf, ("t", ~132), Node (Leaf, ("v", 120), Leaf))), ("x", ~184), Leaf), ("z", 360), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test105", ("f", ~492, tenvEx14), Node (Node (Leaf, ("a", 311), Node (Leaf, ("c", 299), Node (Leaf, ("e", ~385), Node (Leaf, ("f", ~492), Leaf)))), ("g", ~425), Node (Node (Node (Leaf, ("i", 441), Leaf), ("k", ~359), Leaf), ("m", ~107), Node (Node (Node (Node (Leaf, ("o", 495), Leaf), ("q", 455), Node (Leaf, ("s", ~141), Leaf)), ("u", ~241), Node (Leaf, ("w", 41), Leaf)), ("y", 117), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test106", ("l", 322, tenvEx14), Node (Node (Leaf, ("a", 311), Node (Leaf, ("c", 299), Node (Leaf, ("e", ~385), Leaf))), ("g", ~425), Node (Node (Node (Leaf, ("i", 441), Leaf), ("k", ~359), Node (Leaf, ("l", 322), Leaf)), ("m", ~107), Node (Node (Node (Node (Leaf, ("o", 495), Leaf), ("q", 455), Node (Leaf, ("s", ~141), Leaf)), ("u", ~241), Node (Leaf, ("w", 41), Leaf)), ("y", 117), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test107", ("z", 126, tenvEx14), Node (Node (Leaf, ("a", 311), Node (Leaf, ("c", 299), Node (Leaf, ("e", ~385), Leaf))), ("g", ~425), Node (Node (Node (Leaf, ("i", 441), Leaf), ("k", ~359), Leaf), ("m", ~107), Node (Node (Node (Node (Leaf, ("o", 495), Leaf), ("q", 455), Node (Leaf, ("s", ~141), Leaf)), ("u", ~241), Node (Leaf, ("w", 41), Leaf)), ("y", 117), Node (Leaf, ("z", 126), Leaf)))))
val _ = run_tenvBind_test ("tenvBind_test108", ("d", ~394, tenvEx14), Node (Node (Leaf, ("a", 311), Node (Leaf, ("c", 299), Node (Node (Leaf, ("d", ~394), Leaf), ("e", ~385), Leaf))), ("g", ~425), Node (Node (Node (Leaf, ("i", 441), Leaf), ("k", ~359), Leaf), ("m", ~107), Node (Node (Node (Node (Leaf, ("o", 495), Leaf), ("q", 455), Node (Leaf, ("s", ~141), Leaf)), ("u", ~241), Node (Leaf, ("w", 41), Leaf)), ("y", 117), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test109", ("r", 260, tenvEx14), Node (Node (Leaf, ("a", 311), Node (Leaf, ("c", 299), Node (Leaf, ("e", ~385), Leaf))), ("g", ~425), Node (Node (Node (Leaf, ("i", 441), Leaf), ("k", ~359), Leaf), ("m", ~107), Node (Node (Node (Node (Leaf, ("o", 495), Leaf), ("q", 455), Node (Node (Leaf, ("r", 260), Leaf), ("s", ~141), Leaf)), ("u", ~241), Node (Leaf, ("w", 41), Leaf)), ("y", 117), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test110", ("h", 256, tenvEx14), Node (Node (Leaf, ("a", 311), Node (Leaf, ("c", 299), Node (Leaf, ("e", ~385), Leaf))), ("g", ~425), Node (Node (Node (Node (Leaf, ("h", 256), Leaf), ("i", 441), Leaf), ("k", ~359), Leaf), ("m", ~107), Node (Node (Node (Node (Leaf, ("o", 495), Leaf), ("q", 455), Node (Leaf, ("s", ~141), Leaf)), ("u", ~241), Node (Leaf, ("w", 41), Leaf)), ("y", 117), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test111", ("p", ~402, tenvEx14), Node (Node (Leaf, ("a", 311), Node (Leaf, ("c", 299), Node (Leaf, ("e", ~385), Leaf))), ("g", ~425), Node (Node (Node (Leaf, ("i", 441), Leaf), ("k", ~359), Leaf), ("m", ~107), Node (Node (Node (Node (Leaf, ("o", 495), Node (Leaf, ("p", ~402), Leaf)), ("q", 455), Node (Leaf, ("s", ~141), Leaf)), ("u", ~241), Node (Leaf, ("w", 41), Leaf)), ("y", 117), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test112", ("t", ~132, tenvEx14), Node (Node (Leaf, ("a", 311), Node (Leaf, ("c", 299), Node (Leaf, ("e", ~385), Leaf))), ("g", ~425), Node (Node (Node (Leaf, ("i", 441), Leaf), ("k", ~359), Leaf), ("m", ~107), Node (Node (Node (Node (Leaf, ("o", 495), Leaf), ("q", 455), Node (Leaf, ("s", ~141), Node (Leaf, ("t", ~132), Leaf))), ("u", ~241), Node (Leaf, ("w", 41), Leaf)), ("y", 117), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test113", ("f", ~492, tenvEx15), Node (Node (Node (Leaf, ("b", 174), Node (Leaf, ("d", 456), Node (Node (Leaf, ("f", ~492), Leaf), ("h", ~36), Leaf))), ("j", 216), Node (Node (Node (Leaf, ("l", 206), Leaf), ("n", 106), Leaf), ("p", ~314), Leaf)), ("r", 84), Node (Node (Leaf, ("t", ~308), Node (Leaf, ("v", 90), Leaf)), ("x", 138), Node (Leaf, ("z", 10), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test114", ("l", 322, tenvEx15), Node (Node (Node (Leaf, ("b", 174), Node (Leaf, ("d", 456), Node (Node (Leaf, ("f", 122), Leaf), ("h", ~36), Leaf))), ("j", 216), Node (Node (Node (Leaf, ("l", 322), Leaf), ("n", 106), Leaf), ("p", ~314), Leaf)), ("r", 84), Node (Node (Leaf, ("t", ~308), Node (Leaf, ("v", 90), Leaf)), ("x", 138), Node (Leaf, ("z", 10), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test115", ("z", 126, tenvEx15), Node (Node (Node (Leaf, ("b", 174), Node (Leaf, ("d", 456), Node (Node (Leaf, ("f", 122), Leaf), ("h", ~36), Leaf))), ("j", 216), Node (Node (Node (Leaf, ("l", 206), Leaf), ("n", 106), Leaf), ("p", ~314), Leaf)), ("r", 84), Node (Node (Leaf, ("t", ~308), Node (Leaf, ("v", 90), Leaf)), ("x", 138), Node (Leaf, ("z", 126), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test116", ("d", ~394, tenvEx15), Node (Node (Node (Leaf, ("b", 174), Node (Leaf, ("d", ~394), Node (Node (Leaf, ("f", 122), Leaf), ("h", ~36), Leaf))), ("j", 216), Node (Node (Node (Leaf, ("l", 206), Leaf), ("n", 106), Leaf), ("p", ~314), Leaf)), ("r", 84), Node (Node (Leaf, ("t", ~308), Node (Leaf, ("v", 90), Leaf)), ("x", 138), Node (Leaf, ("z", 10), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test117", ("r", 260, tenvEx15), Node (Node (Node (Leaf, ("b", 174), Node (Leaf, ("d", 456), Node (Node (Leaf, ("f", 122), Leaf), ("h", ~36), Leaf))), ("j", 216), Node (Node (Node (Leaf, ("l", 206), Leaf), ("n", 106), Leaf), ("p", ~314), Leaf)), ("r", 260), Node (Node (Leaf, ("t", ~308), Node (Leaf, ("v", 90), Leaf)), ("x", 138), Node (Leaf, ("z", 10), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test118", ("h", 256, tenvEx15), Node (Node (Node (Leaf, ("b", 174), Node (Leaf, ("d", 456), Node (Node (Leaf, ("f", 122), Leaf), ("h", 256), Leaf))), ("j", 216), Node (Node (Node (Leaf, ("l", 206), Leaf), ("n", 106), Leaf), ("p", ~314), Leaf)), ("r", 84), Node (Node (Leaf, ("t", ~308), Node (Leaf, ("v", 90), Leaf)), ("x", 138), Node (Leaf, ("z", 10), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test119", ("p", ~402, tenvEx15), Node (Node (Node (Leaf, ("b", 174), Node (Leaf, ("d", 456), Node (Node (Leaf, ("f", 122), Leaf), ("h", ~36), Leaf))), ("j", 216), Node (Node (Node (Leaf, ("l", 206), Leaf), ("n", 106), Leaf), ("p", ~402), Leaf)), ("r", 84), Node (Node (Leaf, ("t", ~308), Node (Leaf, ("v", 90), Leaf)), ("x", 138), Node (Leaf, ("z", 10), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test120", ("t", ~132, tenvEx15), Node (Node (Node (Leaf, ("b", 174), Node (Leaf, ("d", 456), Node (Node (Leaf, ("f", 122), Leaf), ("h", ~36), Leaf))), ("j", 216), Node (Node (Node (Leaf, ("l", 206), Leaf), ("n", 106), Leaf), ("p", ~314), Leaf)), ("r", 84), Node (Node (Leaf, ("t", ~132), Node (Leaf, ("v", 90), Leaf)), ("x", 138), Node (Leaf, ("z", 10), Leaf))))
val _ = run_tenvBind_test ("tenvBind_test121", ("f", ~492, tenvEx16), Node (Node (Node (Node (Leaf, ("a", ~127), Leaf), ("c", 329), Node (Leaf, ("e", 231), Node (Leaf, ("f", ~492), Leaf))), ("g", ~395), Node (Node (Node (Leaf, ("i", ~465), Node (Leaf, ("k", ~505), Leaf)), ("m", 69), Leaf), ("o", 291), Leaf)), ("q", 105), Node (Leaf, ("s", 181), Node (Leaf, ("u", 375), Node (Leaf, ("w", ~17), Node (Leaf, ("y", ~351), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test122", ("l", 322, tenvEx16), Node (Node (Node (Node (Leaf, ("a", ~127), Leaf), ("c", 329), Node (Leaf, ("e", 231), Leaf)), ("g", ~395), Node (Node (Node (Leaf, ("i", ~465), Node (Leaf, ("k", ~505), Node (Leaf, ("l", 322), Leaf))), ("m", 69), Leaf), ("o", 291), Leaf)), ("q", 105), Node (Leaf, ("s", 181), Node (Leaf, ("u", 375), Node (Leaf, ("w", ~17), Node (Leaf, ("y", ~351), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test123", ("z", 126, tenvEx16), Node (Node (Node (Node (Leaf, ("a", ~127), Leaf), ("c", 329), Node (Leaf, ("e", 231), Leaf)), ("g", ~395), Node (Node (Node (Leaf, ("i", ~465), Node (Leaf, ("k", ~505), Leaf)), ("m", 69), Leaf), ("o", 291), Leaf)), ("q", 105), Node (Leaf, ("s", 181), Node (Leaf, ("u", 375), Node (Leaf, ("w", ~17), Node (Leaf, ("y", ~351), Node (Leaf, ("z", 126), Leaf)))))))
val _ = run_tenvBind_test ("tenvBind_test124", ("d", ~394, tenvEx16), Node (Node (Node (Node (Leaf, ("a", ~127), Leaf), ("c", 329), Node (Node (Leaf, ("d", ~394), Leaf), ("e", 231), Leaf)), ("g", ~395), Node (Node (Node (Leaf, ("i", ~465), Node (Leaf, ("k", ~505), Leaf)), ("m", 69), Leaf), ("o", 291), Leaf)), ("q", 105), Node (Leaf, ("s", 181), Node (Leaf, ("u", 375), Node (Leaf, ("w", ~17), Node (Leaf, ("y", ~351), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test125", ("r", 260, tenvEx16), Node (Node (Node (Node (Leaf, ("a", ~127), Leaf), ("c", 329), Node (Leaf, ("e", 231), Leaf)), ("g", ~395), Node (Node (Node (Leaf, ("i", ~465), Node (Leaf, ("k", ~505), Leaf)), ("m", 69), Leaf), ("o", 291), Leaf)), ("q", 105), Node (Node (Leaf, ("r", 260), Leaf), ("s", 181), Node (Leaf, ("u", 375), Node (Leaf, ("w", ~17), Node (Leaf, ("y", ~351), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test126", ("h", 256, tenvEx16), Node (Node (Node (Node (Leaf, ("a", ~127), Leaf), ("c", 329), Node (Leaf, ("e", 231), Leaf)), ("g", ~395), Node (Node (Node (Node (Leaf, ("h", 256), Leaf), ("i", ~465), Node (Leaf, ("k", ~505), Leaf)), ("m", 69), Leaf), ("o", 291), Leaf)), ("q", 105), Node (Leaf, ("s", 181), Node (Leaf, ("u", 375), Node (Leaf, ("w", ~17), Node (Leaf, ("y", ~351), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test127", ("p", ~402, tenvEx16), Node (Node (Node (Node (Leaf, ("a", ~127), Leaf), ("c", 329), Node (Leaf, ("e", 231), Leaf)), ("g", ~395), Node (Node (Node (Leaf, ("i", ~465), Node (Leaf, ("k", ~505), Leaf)), ("m", 69), Leaf), ("o", 291), Node (Leaf, ("p", ~402), Leaf))), ("q", 105), Node (Leaf, ("s", 181), Node (Leaf, ("u", 375), Node (Leaf, ("w", ~17), Node (Leaf, ("y", ~351), Leaf))))))
val _ = run_tenvBind_test ("tenvBind_test128", ("t", ~132, tenvEx16), Node (Node (Node (Node (Leaf, ("a", ~127), Leaf), ("c", 329), Node (Leaf, ("e", 231), Leaf)), ("g", ~395), Node (Node (Node (Leaf, ("i", ~465), Node (Leaf, ("k", ~505), Leaf)), ("m", 69), Leaf), ("o", 291), Leaf)), ("q", 105), Node (Leaf, ("s", 181), Node (Node (Leaf, ("t", ~132), Leaf), ("u", 375), Node (Leaf, ("w", ~17), Node (Leaf, ("y", ~351), Leaf))))))
;

(* test-G-fenv.sml *)
val _ : 'a fenv = fenvEmpty
val _ : string * 'a fenv -> 'a = fenvFind
val _ : string * 'a * 'a fenv -> 'a fenv = fenvBind

fun run_fenv_test test = run_test (wrapFind fenvFind) (findResEq intEq) test

val _ = run_fenv_test ("fenv_test01", ("a", fenvEmpty), FR_NotFound "a")
val _ = run_fenv_test ("fenv_test02", ("b", fenvEmpty), FR_NotFound "b")
val _ = run_fenv_test ("fenv_test03", ("c", fenvEmpty), FR_NotFound "c")
val _ = run_fenv_test ("fenv_test04", ("a", fenvBind ("a", 1, fenvEmpty)), FR_Found 1)
val _ = run_fenv_test ("fenv_test05", ("b", fenvBind ("a", 1, fenvEmpty)), FR_NotFound "b")
val _ = run_fenv_test ("fenv_test06", ("c", fenvBind ("a", 1, fenvEmpty)), FR_NotFound "c")
val _ = run_fenv_test ("fenv_test07", ("a", fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty))), FR_Found 1)
val _ = run_fenv_test ("fenv_test08", ("b", fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty))), FR_Found 2)
val _ = run_fenv_test ("fenv_test09", ("c", fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty))), FR_NotFound "c")
val _ = run_fenv_test ("fenv_test10", ("a", fenvBind ("a", 3, fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty)))), FR_Found 3)
val _ = run_fenv_test ("fenv_test11", ("b", fenvBind ("a", 3, fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty)))), FR_Found 2)
val _ = run_fenv_test ("fenv_test12", ("c", fenvBind ("a", 3, fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty)))), FR_NotFound "c")
val _ = run_fenv_test ("fenv_test13", ("a", fenvBind ("z", 4, fenvBind ("a", 3, fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty))))), FR_Found 3)
val _ = run_fenv_test ("fenv_test14", ("b", fenvBind ("z", 4, fenvBind ("a", 3, fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty))))), FR_Found 2)
val _ = run_fenv_test ("fenv_test15", ("c", fenvBind ("z", 4, fenvBind ("a", 3, fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty))))), FR_NotFound "c")
val _ = run_fenv_test ("fenv_test16", ("a", fenvBind ("c", 5, fenvBind ("z", 4, fenvBind ("a", 3, fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty)))))), FR_Found 3)
val _ = run_fenv_test ("fenv_test17", ("b", fenvBind ("c", 5, fenvBind ("z", 4, fenvBind ("a", 3, fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty)))))), FR_Found 2)
val _ = run_fenv_test ("fenv_test18", ("c", fenvBind ("c", 5, fenvBind ("z", 4, fenvBind ("a", 3, fenvBind ("b", 2, fenvBind ("a", 1, fenvEmpty)))))), FR_Found 5)
;

(* test-Ha-alistAppend.sml *)
val _ : 'a alist * 'a alist -> 'a alist = alistAppend

fun run_alistAppend_test elemEq test = run_test alistAppend (alistEq elemEq) test

val _ = run_alistAppend_test intEq ("alistAppend_test01", (alistEx1, alistEx1), Nil)
val _ = run_alistAppend_test intEq ("alistAppend_test02", (alistEx1, alistEx2), NonNil (Sing (42)))
val _ = run_alistAppend_test intEq ("alistAppend_test03", (alistEx1, alistEx3), NonNil (Append (Sing (23), Sing (24))))
val _ = run_alistAppend_test intEq ("alistAppend_test04", (alistEx1, alistEx4), NonNil (Append (Append (Sing (17), Sing (18)), Sing (19))))
val _ = run_alistAppend_test intEq ("alistAppend_test05", (alistEx1, alistEx5), NonNil (Append (Sing (39), Append (Sing (38), Sing (37)))))
val _ = run_alistAppend_test intEq ("alistAppend_test06", (alistEx1, alistEx6), NonNil (Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77))))))
val _ = run_alistAppend_test intEq ("alistAppend_test07", (alistEx1, alistEx7), NonNil (Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60)))))
val _ = run_alistAppend_test intEq ("alistAppend_test08", (alistEx2, alistEx1), NonNil (Sing (42)))
val _ = run_alistAppend_test intEq ("alistAppend_test09", (alistEx2, alistEx2), NonNil (Append (Sing (42), Sing (42))))
val _ = run_alistAppend_test intEq ("alistAppend_test10", (alistEx2, alistEx3), NonNil (Append (Sing (42), Append (Sing (23), Sing (24)))))
val _ = run_alistAppend_test intEq ("alistAppend_test11", (alistEx2, alistEx4), NonNil (Append (Sing (42), Append (Append (Sing (17), Sing (18)), Sing (19)))))
val _ = run_alistAppend_test intEq ("alistAppend_test12", (alistEx2, alistEx5), NonNil (Append (Sing (42), Append (Sing (39), Append (Sing (38), Sing (37))))))
val _ = run_alistAppend_test intEq ("alistAppend_test13", (alistEx2, alistEx6), NonNil (Append (Sing (42), Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))))))
val _ = run_alistAppend_test intEq ("alistAppend_test14", (alistEx2, alistEx7), NonNil (Append (Sing (42), Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))))))
val _ = run_alistAppend_test intEq ("alistAppend_test15", (alistEx3, alistEx1), NonNil (Append (Sing (23), Sing (24))))
val _ = run_alistAppend_test intEq ("alistAppend_test16", (alistEx3, alistEx2), NonNil (Append (Append (Sing (23), Sing (24)), Sing (42))))
val _ = run_alistAppend_test intEq ("alistAppend_test17", (alistEx3, alistEx3), NonNil (Append (Append (Sing (23), Sing (24)), Append (Sing (23), Sing (24)))))
val _ = run_alistAppend_test intEq ("alistAppend_test18", (alistEx3, alistEx4), NonNil (Append (Append (Sing (23), Sing (24)), Append (Append (Sing (17), Sing (18)), Sing (19)))))
val _ = run_alistAppend_test intEq ("alistAppend_test19", (alistEx3, alistEx5), NonNil (Append (Append (Sing (23), Sing (24)), Append (Sing (39), Append (Sing (38), Sing (37))))))
val _ = run_alistAppend_test intEq ("alistAppend_test20", (alistEx3, alistEx6), NonNil (Append (Append (Sing (23), Sing (24)), Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))))))
val _ = run_alistAppend_test intEq ("alistAppend_test21", (alistEx3, alistEx7), NonNil (Append (Append (Sing (23), Sing (24)), Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))))))
val _ = run_alistAppend_test intEq ("alistAppend_test22", (alistEx4, alistEx1), NonNil (Append (Append (Sing (17), Sing (18)), Sing (19))))
val _ = run_alistAppend_test intEq ("alistAppend_test23", (alistEx4, alistEx2), NonNil (Append (Append (Append (Sing (17), Sing (18)), Sing (19)), Sing (42))))
val _ = run_alistAppend_test intEq ("alistAppend_test24", (alistEx4, alistEx3), NonNil (Append (Append (Append (Sing (17), Sing (18)), Sing (19)), Append (Sing (23), Sing (24)))))
val _ = run_alistAppend_test intEq ("alistAppend_test25", (alistEx4, alistEx4), NonNil (Append (Append (Append (Sing (17), Sing (18)), Sing (19)), Append (Append (Sing (17), Sing (18)), Sing (19)))))
val _ = run_alistAppend_test intEq ("alistAppend_test26", (alistEx4, alistEx5), NonNil (Append (Append (Append (Sing (17), Sing (18)), Sing (19)), Append (Sing (39), Append (Sing (38), Sing (37))))))
val _ = run_alistAppend_test intEq ("alistAppend_test27", (alistEx4, alistEx6), NonNil (Append (Append (Append (Sing (17), Sing (18)), Sing (19)), Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))))))
val _ = run_alistAppend_test intEq ("alistAppend_test28", (alistEx4, alistEx7), NonNil (Append (Append (Append (Sing (17), Sing (18)), Sing (19)), Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))))))
val _ = run_alistAppend_test intEq ("alistAppend_test29", (alistEx5, alistEx1), NonNil (Append (Sing (39), Append (Sing (38), Sing (37)))))
val _ = run_alistAppend_test intEq ("alistAppend_test30", (alistEx5, alistEx2), NonNil (Append (Append (Sing (39), Append (Sing (38), Sing (37))), Sing (42))))
val _ = run_alistAppend_test intEq ("alistAppend_test31", (alistEx5, alistEx3), NonNil (Append (Append (Sing (39), Append (Sing (38), Sing (37))), Append (Sing (23), Sing (24)))))
val _ = run_alistAppend_test intEq ("alistAppend_test32", (alistEx5, alistEx4), NonNil (Append (Append (Sing (39), Append (Sing (38), Sing (37))), Append (Append (Sing (17), Sing (18)), Sing (19)))))
val _ = run_alistAppend_test intEq ("alistAppend_test33", (alistEx5, alistEx5), NonNil (Append (Append (Sing (39), Append (Sing (38), Sing (37))), Append (Sing (39), Append (Sing (38), Sing (37))))))
val _ = run_alistAppend_test intEq ("alistAppend_test34", (alistEx5, alistEx6), NonNil (Append (Append (Sing (39), Append (Sing (38), Sing (37))), Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))))))
val _ = run_alistAppend_test intEq ("alistAppend_test35", (alistEx5, alistEx7), NonNil (Append (Append (Sing (39), Append (Sing (38), Sing (37))), Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))))))
val _ = run_alistAppend_test intEq ("alistAppend_test36", (alistEx6, alistEx1), NonNil (Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77))))))
val _ = run_alistAppend_test intEq ("alistAppend_test37", (alistEx6, alistEx2), NonNil (Append (Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))), Sing (42))))
val _ = run_alistAppend_test intEq ("alistAppend_test38", (alistEx6, alistEx3), NonNil (Append (Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))), Append (Sing (23), Sing (24)))))
val _ = run_alistAppend_test intEq ("alistAppend_test39", (alistEx6, alistEx4), NonNil (Append (Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))), Append (Append (Sing (17), Sing (18)), Sing (19)))))
val _ = run_alistAppend_test intEq ("alistAppend_test40", (alistEx6, alistEx5), NonNil (Append (Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))), Append (Sing (39), Append (Sing (38), Sing (37))))))
val _ = run_alistAppend_test intEq ("alistAppend_test41", (alistEx6, alistEx6), NonNil (Append (Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))), Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))))))
val _ = run_alistAppend_test intEq ("alistAppend_test42", (alistEx6, alistEx7), NonNil (Append (Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))), Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))))))
val _ = run_alistAppend_test intEq ("alistAppend_test43", (alistEx7, alistEx1), NonNil (Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60)))))
val _ = run_alistAppend_test intEq ("alistAppend_test44", (alistEx7, alistEx2), NonNil (Append (Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))), Sing (42))))
val _ = run_alistAppend_test intEq ("alistAppend_test45", (alistEx7, alistEx3), NonNil (Append (Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))), Append (Sing (23), Sing (24)))))
val _ = run_alistAppend_test intEq ("alistAppend_test46", (alistEx7, alistEx4), NonNil (Append (Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))), Append (Append (Sing (17), Sing (18)), Sing (19)))))
val _ = run_alistAppend_test intEq ("alistAppend_test47", (alistEx7, alistEx5), NonNil (Append (Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))), Append (Sing (39), Append (Sing (38), Sing (37))))))
val _ = run_alistAppend_test intEq ("alistAppend_test48", (alistEx7, alistEx6), NonNil (Append (Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))), Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))))))
val _ = run_alistAppend_test intEq ("alistAppend_test49", (alistEx7, alistEx7), NonNil (Append (Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))), Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))))))
;

(* test-Hb-alistCons.sml *)
val _ : 'a * 'a alist -> 'a alist = alistCons

fun run_alistCons_test elemEq test = run_test alistCons (alistEq elemEq) test

val _ = run_alistCons_test intEq ("alistCons_test01", (99, alistEx1), NonNil (Sing (99)))
val _ = run_alistCons_test intEq ("alistCons_test02", (99, alistEx2), NonNil (Append (Sing (99), Sing (42))))
val _ = run_alistCons_test intEq ("alistCons_test03", (99, alistEx3), NonNil (Append (Sing (99), Append (Sing (23), Sing (24)))))
val _ = run_alistCons_test intEq ("alistCons_test04", (99, alistEx4), NonNil (Append (Sing (99), Append (Append (Sing (17), Sing (18)), Sing (19)))))
val _ = run_alistCons_test intEq ("alistCons_test05", (99, alistEx5), NonNil (Append (Sing (99), Append (Sing (39), Append (Sing (38), Sing (37))))))
val _ = run_alistCons_test intEq ("alistCons_test06", (99, alistEx6), NonNil (Append (Sing (99), Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))))))
val _ = run_alistCons_test intEq ("alistCons_test07", (99, alistEx7), NonNil (Append (Sing (99), Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))))))
;

(* test-Hc-alistSnoc.sml *)
val _ : 'a alist * 'a -> 'a alist = alistSnoc

fun run_alistSnoc_test elemEq test = run_test alistSnoc (alistEq elemEq) test

val _ = run_alistSnoc_test intEq ("alistSnoc_test01", (alistEx1, 99), NonNil (Sing (99)))
val _ = run_alistSnoc_test intEq ("alistSnoc_test02", (alistEx2, 99), NonNil (Append (Sing (42), Sing (99))))
val _ = run_alistSnoc_test intEq ("alistSnoc_test03", (alistEx3, 99), NonNil (Append (Append (Sing (23), Sing (24)), Sing (99))))
val _ = run_alistSnoc_test intEq ("alistSnoc_test04", (alistEx4, 99), NonNil (Append (Append (Append (Sing (17), Sing (18)), Sing (19)), Sing (99))))
val _ = run_alistSnoc_test intEq ("alistSnoc_test05", (alistEx5, 99), NonNil (Append (Append (Sing (39), Append (Sing (38), Sing (37))), Sing (99))))
val _ = run_alistSnoc_test intEq ("alistSnoc_test06", (alistEx6, 99), NonNil (Append (Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Append (Sing (78), Sing (77)))), Sing (99))))
val _ = run_alistSnoc_test intEq ("alistSnoc_test07", (alistEx7, 99), NonNil (Append (Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60))), Sing (99))))
;

(* test-Hd-alistUnsnoc.sml *)
val _ : 'a alist -> ('a alist * 'a) option = alistUnsnoc

fun run_alistUnsnoc_test elemEq test = run_test alistUnsnoc (optionEq (pairEq (alistEq elemEq, elemEq))) test

val _ = run_alistUnsnoc_test intEq ("alistUnsnoc_test01", alistEx1, NONE)
val _ = run_alistUnsnoc_test intEq ("alistUnsnoc_test02", alistEx2, SOME (Nil, 42))
val _ = run_alistUnsnoc_test intEq ("alistUnsnoc_test03", alistEx3, SOME (NonNil (Sing (23)), 24))
val _ = run_alistUnsnoc_test intEq ("alistUnsnoc_test04", alistEx4, SOME (NonNil (Append (Sing (17), Sing (18))), 19))
val _ = run_alistUnsnoc_test intEq ("alistUnsnoc_test05", alistEx5, SOME (NonNil (Append (Sing (39), Sing (38))), 37))
val _ = run_alistUnsnoc_test intEq ("alistUnsnoc_test06", alistEx6, SOME (NonNil (Append (Append (Append (Sing (27), Sing (28)), Sing (29)), Append (Sing (79), Sing (78)))), 77))
val _ = run_alistUnsnoc_test intEq ("alistUnsnoc_test07", alistEx7, SOME (NonNil (Append (Append (Sing (50), Sing (51)), Sing (61))), 60))
;

(* test-He-alistMap.sml *)
val _ : ('a -> 'b) -> 'a alist -> 'b alist = alistMap

fun run_alistMap_test elemEq test = run_test (uncurry2 alistMap) (alistEq elemEq) test

val _ = run_alistMap_test intEq ("alistMap_test01", (fn x => x + 1, alistEx1), Nil)
val _ = run_alistMap_test intEq ("alistMap_test02", (fn x => x + 1, alistEx2), NonNil (Sing (43)))
val _ = run_alistMap_test intEq ("alistMap_test03", (fn x => x + 1, alistEx3), NonNil (Append (Sing (24), Sing (25))))
val _ = run_alistMap_test intEq ("alistMap_test04", (fn x => x + 1, alistEx4), NonNil (Append (Append (Sing (18), Sing (19)), Sing (20))))
val _ = run_alistMap_test intEq ("alistMap_test05", (fn x => x + 1, alistEx5), NonNil (Append (Sing (40), Append (Sing (39), Sing (38)))))
val _ = run_alistMap_test intEq ("alistMap_test06", (fn x => x + 1, alistEx6), NonNil (Append (Append (Append (Sing (28), Sing (29)), Sing (30)), Append (Sing (80), Append (Sing (79), Sing (78))))))
val _ = run_alistMap_test intEq ("alistMap_test07", (fn x => x + 1, alistEx7), NonNil (Append (Append (Sing (51), Sing (52)), Append (Sing (62), Sing (61)))))
val _ = run_alistMap_test boolEq ("alistMap_test08", (fn x => x mod 2 = 1, alistEx1), Nil)
val _ = run_alistMap_test boolEq ("alistMap_test09", (fn x => x mod 2 = 1, alistEx2), NonNil (Sing (false)))
val _ = run_alistMap_test boolEq ("alistMap_test10", (fn x => x mod 2 = 1, alistEx3), NonNil (Append (Sing (true), Sing (false))))
val _ = run_alistMap_test boolEq ("alistMap_test11", (fn x => x mod 2 = 1, alistEx4), NonNil (Append (Append (Sing (true), Sing (false)), Sing (true))))
val _ = run_alistMap_test boolEq ("alistMap_test12", (fn x => x mod 2 = 1, alistEx5), NonNil (Append (Sing (true), Append (Sing (false), Sing (true)))))
val _ = run_alistMap_test boolEq ("alistMap_test13", (fn x => x mod 2 = 1, alistEx6), NonNil (Append (Append (Append (Sing (true), Sing (false)), Sing (true)), Append (Sing (true), Append (Sing (false), Sing (true))))))
val _ = run_alistMap_test boolEq ("alistMap_test14", (fn x => x mod 2 = 1, alistEx7), NonNil (Append (Append (Sing (false), Sing (true)), Append (Sing (true), Sing (false)))))
val _ = run_alistMap_test stringEq ("alistMap_test15", (fn x => Int.toString x, alistEx1), Nil)
val _ = run_alistMap_test stringEq ("alistMap_test16", (fn x => Int.toString x, alistEx2), NonNil (Sing ("42")))
val _ = run_alistMap_test stringEq ("alistMap_test17", (fn x => Int.toString x, alistEx3), NonNil (Append (Sing ("23"), Sing ("24"))))
val _ = run_alistMap_test stringEq ("alistMap_test18", (fn x => Int.toString x, alistEx4), NonNil (Append (Append (Sing ("17"), Sing ("18")), Sing ("19"))))
val _ = run_alistMap_test stringEq ("alistMap_test19", (fn x => Int.toString x, alistEx5), NonNil (Append (Sing ("39"), Append (Sing ("38"), Sing ("37")))))
val _ = run_alistMap_test stringEq ("alistMap_test20", (fn x => Int.toString x, alistEx6), NonNil (Append (Append (Append (Sing ("27"), Sing ("28")), Sing ("29")), Append (Sing ("79"), Append (Sing ("78"), Sing ("77"))))))
val _ = run_alistMap_test stringEq ("alistMap_test21", (fn x => Int.toString x, alistEx7), NonNil (Append (Append (Sing ("50"), Sing ("51")), Append (Sing ("61"), Sing ("60")))))
;

(* test-Hf-alistFilter.sml *)
val _ : ('a -> bool) -> 'a alist -> 'a alist = alistFilter

fun run_alistFilter_test elemEq test = run_test (uncurry2 alistFilter) (alistEq elemEq) test

val _ = run_alistFilter_test intEq ("alistFilter_test01", (fn x => x < 42, alistEx1), Nil)
val _ = run_alistFilter_test intEq ("alistFilter_test02", (fn x => x < 42, alistEx2), Nil)
val _ = run_alistFilter_test intEq ("alistFilter_test03", (fn x => x < 42, alistEx3), NonNil (Append (Sing (23), Sing (24))))
val _ = run_alistFilter_test intEq ("alistFilter_test04", (fn x => x < 42, alistEx4), NonNil (Append (Append (Sing (17), Sing (18)), Sing (19))))
val _ = run_alistFilter_test intEq ("alistFilter_test05", (fn x => x < 42, alistEx5), NonNil (Append (Sing (39), Append (Sing (38), Sing (37)))))
val _ = run_alistFilter_test intEq ("alistFilter_test06", (fn x => x < 42, alistEx6), NonNil (Append (Append (Sing (27), Sing (28)), Sing (29))))
val _ = run_alistFilter_test intEq ("alistFilter_test07", (fn x => x < 42, alistEx7), Nil)
val _ = run_alistFilter_test intEq ("alistFilter_test08", (fn x => x >= 42, alistEx1), Nil)
val _ = run_alistFilter_test intEq ("alistFilter_test09", (fn x => x >= 42, alistEx2), NonNil (Sing (42)))
val _ = run_alistFilter_test intEq ("alistFilter_test10", (fn x => x >= 42, alistEx3), Nil)
val _ = run_alistFilter_test intEq ("alistFilter_test11", (fn x => x >= 42, alistEx4), Nil)
val _ = run_alistFilter_test intEq ("alistFilter_test12", (fn x => x >= 42, alistEx5), Nil)
val _ = run_alistFilter_test intEq ("alistFilter_test13", (fn x => x >= 42, alistEx6), NonNil (Append (Sing (79), Append (Sing (78), Sing (77)))))
val _ = run_alistFilter_test intEq ("alistFilter_test14", (fn x => x >= 42, alistEx7), NonNil (Append (Append (Sing (50), Sing (51)), Append (Sing (61), Sing (60)))))
val _ = run_alistFilter_test intEq ("alistFilter_test15", (fn x => x mod 2 = 1, alistEx1), Nil)
val _ = run_alistFilter_test intEq ("alistFilter_test16", (fn x => x mod 2 = 1, alistEx2), Nil)
val _ = run_alistFilter_test intEq ("alistFilter_test17", (fn x => x mod 2 = 1, alistEx3), NonNil (Sing (23)))
val _ = run_alistFilter_test intEq ("alistFilter_test18", (fn x => x mod 2 = 1, alistEx4), NonNil (Append (Sing (17), Sing (19))))
val _ = run_alistFilter_test intEq ("alistFilter_test19", (fn x => x mod 2 = 1, alistEx5), NonNil (Append (Sing (39), Sing (37))))
val _ = run_alistFilter_test intEq ("alistFilter_test20", (fn x => x mod 2 = 1, alistEx6), NonNil (Append (Append (Sing (27), Sing (29)), Append (Sing (79), Sing (77)))))
val _ = run_alistFilter_test intEq ("alistFilter_test21", (fn x => x mod 2 = 1, alistEx7), NonNil (Append (Sing (51), Sing (61))))
val _ = run_alistFilter_test intEq ("alistFilter_test22", (fn x => x mod 2 = 0, alistEx1), Nil)
val _ = run_alistFilter_test intEq ("alistFilter_test23", (fn x => x mod 2 = 0, alistEx2), NonNil (Sing (42)))
val _ = run_alistFilter_test intEq ("alistFilter_test24", (fn x => x mod 2 = 0, alistEx3), NonNil (Sing (24)))
val _ = run_alistFilter_test intEq ("alistFilter_test25", (fn x => x mod 2 = 0, alistEx4), NonNil (Sing (18)))
val _ = run_alistFilter_test intEq ("alistFilter_test26", (fn x => x mod 2 = 0, alistEx5), NonNil (Sing (38)))
val _ = run_alistFilter_test intEq ("alistFilter_test27", (fn x => x mod 2 = 0, alistEx6), NonNil (Append (Sing (28), Sing (78))))
val _ = run_alistFilter_test intEq ("alistFilter_test28", (fn x => x mod 2 = 0, alistEx7), NonNil (Append (Sing (50), Sing (60))))
;

(* test-Hg-alistFoldl.sml *)
val _ : ('a * 'b -> 'b) -> 'b -> 'a alist -> 'b = alistFoldl

fun run_alistFoldl_test check test = run_test (uncurry3 alistFoldl) check test

val _ = run_alistFoldl_test intEq ("alistFoldl_test01", (fn (x, b) => x + b, 0, alistEx1), 0)
val _ = run_alistFoldl_test intEq ("alistFoldl_test02", (fn (x, b) => x + b, 0, alistEx2), 42)
val _ = run_alistFoldl_test intEq ("alistFoldl_test03", (fn (x, b) => x + b, 0, alistEx3), 47)
val _ = run_alistFoldl_test intEq ("alistFoldl_test04", (fn (x, b) => x + b, 0, alistEx4), 54)
val _ = run_alistFoldl_test intEq ("alistFoldl_test05", (fn (x, b) => x + b, 0, alistEx5), 114)
val _ = run_alistFoldl_test intEq ("alistFoldl_test06", (fn (x, b) => x + b, 0, alistEx6), 318)
val _ = run_alistFoldl_test intEq ("alistFoldl_test07", (fn (x, b) => x + b, 0, alistEx7), 222)
val _ = run_alistFoldl_test intEq ("alistFoldl_test08", (fn (x, b) => x - b, 0, alistEx1), 0)
val _ = run_alistFoldl_test intEq ("alistFoldl_test09", (fn (x, b) => x - b, 0, alistEx2), 42)
val _ = run_alistFoldl_test intEq ("alistFoldl_test10", (fn (x, b) => x - b, 0, alistEx3), 1)
val _ = run_alistFoldl_test intEq ("alistFoldl_test11", (fn (x, b) => x - b, 0, alistEx4), 18)
val _ = run_alistFoldl_test intEq ("alistFoldl_test12", (fn (x, b) => x - b, 0, alistEx5), 38)
val _ = run_alistFoldl_test intEq ("alistFoldl_test13", (fn (x, b) => x - b, 0, alistEx6), 50)
val _ = run_alistFoldl_test intEq ("alistFoldl_test14", (fn (x, b) => x - b, 0, alistEx7), 0)
val _ = run_alistFoldl_test stringEq ("alistFoldl_test15", (fn (x, b) => Int.toString x ^ b, "", alistEx1), "")
val _ = run_alistFoldl_test stringEq ("alistFoldl_test16", (fn (x, b) => Int.toString x ^ b, "", alistEx2), "42")
val _ = run_alistFoldl_test stringEq ("alistFoldl_test17", (fn (x, b) => Int.toString x ^ b, "", alistEx3), "2423")
val _ = run_alistFoldl_test stringEq ("alistFoldl_test18", (fn (x, b) => Int.toString x ^ b, "", alistEx4), "191817")
val _ = run_alistFoldl_test stringEq ("alistFoldl_test19", (fn (x, b) => Int.toString x ^ b, "", alistEx5), "373839")
val _ = run_alistFoldl_test stringEq ("alistFoldl_test20", (fn (x, b) => Int.toString x ^ b, "", alistEx6), "777879292827")
val _ = run_alistFoldl_test stringEq ("alistFoldl_test21", (fn (x, b) => Int.toString x ^ b, "", alistEx7), "60615150")
;

(* test-Hh-alistToList.sml *)
val _ : 'a alist -> 'a list = alistToList

fun run_alistToList_test elemEq test = run_test alistToList (listEq elemEq) test

val _ = run_alistToList_test intEq ("alistToList_test01", alistEx1, [])
val _ = run_alistToList_test intEq ("alistToList_test02", alistEx2, [42])
val _ = run_alistToList_test intEq ("alistToList_test03", alistEx3, [23, 24])
val _ = run_alistToList_test intEq ("alistToList_test04", alistEx4, [17, 18, 19])
val _ = run_alistToList_test intEq ("alistToList_test05", alistEx5, [39, 38, 37])
val _ = run_alistToList_test intEq ("alistToList_test06", alistEx6, [27, 28, 29, 79, 78, 77])
val _ = run_alistToList_test intEq ("alistToList_test07", alistEx7, [50, 51, 61, 60])
;

(* test-Ia-fmlaSize.sml *)
val _ : fmla -> int = fmlaSize

fun run_fmlaSize_test test = run_test fmlaSize intEq test

val _ = run_fmlaSize_test ("fmlaSize_test01", fmlaEx01, 42)
val _ = run_fmlaSize_test ("fmlaSize_test02", fmlaEx02, 33)
val _ = run_fmlaSize_test ("fmlaSize_test03", fmlaEx03, 25)
val _ = run_fmlaSize_test ("fmlaSize_test04", fmlaEx04, 125)
val _ = run_fmlaSize_test ("fmlaSize_test05", fmlaEx05, 29)
val _ = run_fmlaSize_test ("fmlaSize_test06", fmlaEx06, 22)
val _ = run_fmlaSize_test ("fmlaSize_test07", fmlaEx07, 4)
val _ = run_fmlaSize_test ("fmlaSize_test08", fmlaEx08, 38)
val _ = run_fmlaSize_test ("fmlaSize_test09", fmlaEx09, 23)
val _ = run_fmlaSize_test ("fmlaSize_test10", fmlaEx10, 55)
val _ = run_fmlaSize_test ("fmlaSize_test11", fmlaEx11, 9)
val _ = run_fmlaSize_test ("fmlaSize_test12", fmlaEx12, 24)
val _ = run_fmlaSize_test ("fmlaSize_test13", fmlaEx13, 3)
val _ = run_fmlaSize_test ("fmlaSize_test14", fmlaEx14, 5)
val _ = run_fmlaSize_test ("fmlaSize_test15", fmlaEx15, 17)
val _ = run_fmlaSize_test ("fmlaSize_test16", fmlaEx16, 87)
val _ = run_fmlaSize_test ("fmlaSize_test17", fmlaEx17, 86)
val _ = run_fmlaSize_test ("fmlaSize_test18", fmlaEx18, 59)
val _ = run_fmlaSize_test ("fmlaSize_test19", fmlaEx19, 7)
val _ = run_fmlaSize_test ("fmlaSize_test20", fmlaEx20, 6)
val _ = run_fmlaSize_test ("fmlaSize_test21", fmlaEx21, 15)
val _ = run_fmlaSize_test ("fmlaSize_test22", fmlaEx22, 44)
val _ = run_fmlaSize_test ("fmlaSize_test23", fmlaEx23, 16)
val _ = run_fmlaSize_test ("fmlaSize_test24", fmlaEx24, 11)
val _ = run_fmlaSize_test ("fmlaSize_test25", fmlaEx25, 68)
val _ = run_fmlaSize_test ("fmlaSize_test26", fmlaEx26, 2)
val _ = run_fmlaSize_test ("fmlaSize_test27", fmlaEx27, 8)
val _ = run_fmlaSize_test ("fmlaSize_test28", fmlaEx28, 72)
val _ = run_fmlaSize_test ("fmlaSize_test29", fmlaEx29, 43)
val _ = run_fmlaSize_test ("fmlaSize_test30", fmlaEx30, 10)
val _ = run_fmlaSize_test ("fmlaSize_test31", fmlaEx31, 1)
val _ = run_fmlaSize_test ("fmlaSize_test32", fmlaEx32, 30)
;

(* test-Ib-fmlaVarsOf.sml *)
val _ : fmla -> string list = fmlaVarsOf

fun run_fmlaVarsOf_test test = run_test fmlaVarsOf (listSetEq stringEq) test

val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test01", fmlaEx01, ["f", "c", "g", "b", "e", "a", "h", "d"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test02", fmlaEx02, ["d", "b", "h", "a", "g", "c"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test03", fmlaEx03, ["d", "c", "e", "f", "b", "h"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test04", fmlaEx04, ["h", "c", "e", "b", "d", "g", "f", "a"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test05", fmlaEx05, ["g", "b", "e", "f", "c", "a"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test06", fmlaEx06, ["h", "f", "g", "c", "d"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test07", fmlaEx07, ["d"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test08", fmlaEx08, ["b", "h", "g", "d", "c", "f", "a"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test09", fmlaEx09, ["h", "g", "a", "f"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test10", fmlaEx10, ["g", "e", "h", "b", "f", "a", "c", "d"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test11", fmlaEx11, ["a", "c", "b", "e", "h"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test12", fmlaEx12, ["c", "f", "g", "e", "d"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test13", fmlaEx13, ["h"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test14", fmlaEx14, ["d"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test15", fmlaEx15, ["g", "d", "h", "a", "f", "e"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test16", fmlaEx16, ["f", "e", "d", "b", "c", "g", "h"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test17", fmlaEx17, ["e", "g", "c", "a", "f", "b", "d", "h"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test18", fmlaEx18, ["f", "g", "c", "e", "b", "d", "h", "a"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test19", fmlaEx19, ["d", "g", "f"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test20", fmlaEx20, ["a", "c"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test21", fmlaEx21, ["b", "f", "a", "h", "e", "d"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test22", fmlaEx22, ["g", "e", "a", "d", "f", "b", "h"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test23", fmlaEx23, ["c", "g", "h", "e", "a"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test24", fmlaEx24, ["e", "b", "d"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test25", fmlaEx25, ["a", "h", "b", "c", "g", "e", "d", "f"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test26", fmlaEx26, ["d"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test27", fmlaEx27, ["h", "e", "a"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test28", fmlaEx28, ["c", "f", "d", "e", "g", "b", "h", "a"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test29", fmlaEx29, ["e", "h", "a", "d", "g", "f", "b"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test30", fmlaEx30, ["h", "a", "f"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test31", fmlaEx31, ["a"])
val _ = run_fmlaVarsOf_test ("fmlaVarsOf_test32", fmlaEx32, ["g", "c", "d", "a"])
;

(* test-Ic-fmlaEval.sml *)
val _ : fmla * bool env -> bool = fmlaEval

fun run_fmlaEval_test test = run_test fmlaEval boolEq test

val _ = run_fmlaEval_test ("fmlaEval_test01", (fmlaEx01, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test02", (fmlaEx01, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test03", (fmlaEx01, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test04", (fmlaEx01, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test05", (fmlaEx02, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test06", (fmlaEx02, envEx02), false)
val _ = run_fmlaEval_test ("fmlaEval_test07", (fmlaEx02, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test08", (fmlaEx02, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test09", (fmlaEx03, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test10", (fmlaEx03, envEx02), false)
val _ = run_fmlaEval_test ("fmlaEval_test11", (fmlaEx03, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test12", (fmlaEx03, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test13", (fmlaEx04, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test14", (fmlaEx04, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test15", (fmlaEx04, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test16", (fmlaEx04, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test17", (fmlaEx05, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test18", (fmlaEx05, envEx02), false)
val _ = run_fmlaEval_test ("fmlaEval_test19", (fmlaEx05, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test20", (fmlaEx05, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test21", (fmlaEx06, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test22", (fmlaEx06, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test23", (fmlaEx06, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test24", (fmlaEx06, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test25", (fmlaEx07, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test26", (fmlaEx07, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test27", (fmlaEx07, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test28", (fmlaEx07, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test29", (fmlaEx08, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test30", (fmlaEx08, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test31", (fmlaEx08, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test32", (fmlaEx08, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test33", (fmlaEx09, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test34", (fmlaEx09, envEx02), false)
val _ = run_fmlaEval_test ("fmlaEval_test35", (fmlaEx09, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test36", (fmlaEx09, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test37", (fmlaEx10, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test38", (fmlaEx10, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test39", (fmlaEx10, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test40", (fmlaEx10, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test41", (fmlaEx11, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test42", (fmlaEx11, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test43", (fmlaEx11, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test44", (fmlaEx11, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test45", (fmlaEx12, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test46", (fmlaEx12, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test47", (fmlaEx12, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test48", (fmlaEx12, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test49", (fmlaEx13, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test50", (fmlaEx13, envEx02), false)
val _ = run_fmlaEval_test ("fmlaEval_test51", (fmlaEx13, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test52", (fmlaEx13, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test53", (fmlaEx14, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test54", (fmlaEx14, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test55", (fmlaEx14, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test56", (fmlaEx14, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test57", (fmlaEx15, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test58", (fmlaEx15, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test59", (fmlaEx15, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test60", (fmlaEx15, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test61", (fmlaEx16, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test62", (fmlaEx16, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test63", (fmlaEx16, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test64", (fmlaEx16, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test65", (fmlaEx17, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test66", (fmlaEx17, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test67", (fmlaEx17, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test68", (fmlaEx17, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test69", (fmlaEx18, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test70", (fmlaEx18, envEx02), false)
val _ = run_fmlaEval_test ("fmlaEval_test71", (fmlaEx18, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test72", (fmlaEx18, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test73", (fmlaEx19, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test74", (fmlaEx19, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test75", (fmlaEx19, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test76", (fmlaEx19, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test77", (fmlaEx20, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test78", (fmlaEx20, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test79", (fmlaEx20, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test80", (fmlaEx20, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test81", (fmlaEx21, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test82", (fmlaEx21, envEx02), false)
val _ = run_fmlaEval_test ("fmlaEval_test83", (fmlaEx21, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test84", (fmlaEx21, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test85", (fmlaEx22, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test86", (fmlaEx22, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test87", (fmlaEx22, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test88", (fmlaEx22, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test89", (fmlaEx23, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test90", (fmlaEx23, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test91", (fmlaEx23, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test92", (fmlaEx23, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test93", (fmlaEx24, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test94", (fmlaEx24, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test95", (fmlaEx24, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test96", (fmlaEx24, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test97", (fmlaEx25, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test98", (fmlaEx25, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test99", (fmlaEx25, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test100", (fmlaEx25, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test101", (fmlaEx26, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test102", (fmlaEx26, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test103", (fmlaEx26, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test104", (fmlaEx26, envEx04), false)
val _ = run_fmlaEval_test ("fmlaEval_test105", (fmlaEx27, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test106", (fmlaEx27, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test107", (fmlaEx27, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test108", (fmlaEx27, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test109", (fmlaEx28, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test110", (fmlaEx28, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test111", (fmlaEx28, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test112", (fmlaEx28, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test113", (fmlaEx29, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test114", (fmlaEx29, envEx02), false)
val _ = run_fmlaEval_test ("fmlaEval_test115", (fmlaEx29, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test116", (fmlaEx29, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test117", (fmlaEx30, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test118", (fmlaEx30, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test119", (fmlaEx30, envEx03), false)
val _ = run_fmlaEval_test ("fmlaEval_test120", (fmlaEx30, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test121", (fmlaEx31, envEx01), false)
val _ = run_fmlaEval_test ("fmlaEval_test122", (fmlaEx31, envEx02), false)
val _ = run_fmlaEval_test ("fmlaEval_test123", (fmlaEx31, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test124", (fmlaEx31, envEx04), true)
val _ = run_fmlaEval_test ("fmlaEval_test125", (fmlaEx32, envEx01), true)
val _ = run_fmlaEval_test ("fmlaEval_test126", (fmlaEx32, envEx02), true)
val _ = run_fmlaEval_test ("fmlaEval_test127", (fmlaEx32, envEx03), true)
val _ = run_fmlaEval_test ("fmlaEval_test128", (fmlaEx32, envEx04), true)
;

(* test-Id-fmlaTautology.sml *)
val _ : fmla -> bool = fmlaTautology

fun run_fmlaTautology_test test = run_test fmlaTautology boolEq test

val _ = run_fmlaTautology_test ("fmlaTautology_test01", fmlaEx01, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test02", fmlaEx02, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test03", fmlaEx03, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test04", fmlaEx04, true)
val _ = run_fmlaTautology_test ("fmlaTautology_test05", fmlaEx05, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test06", fmlaEx06, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test07", fmlaEx07, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test08", fmlaEx08, true)
val _ = run_fmlaTautology_test ("fmlaTautology_test09", fmlaEx09, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test10", fmlaEx10, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test11", fmlaEx11, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test12", fmlaEx12, true)
val _ = run_fmlaTautology_test ("fmlaTautology_test13", fmlaEx13, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test14", fmlaEx14, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test15", fmlaEx15, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test16", fmlaEx16, true)
val _ = run_fmlaTautology_test ("fmlaTautology_test17", fmlaEx17, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test18", fmlaEx18, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test19", fmlaEx19, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test20", fmlaEx20, true)
val _ = run_fmlaTautology_test ("fmlaTautology_test21", fmlaEx21, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test22", fmlaEx22, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test23", fmlaEx23, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test24", fmlaEx24, true)
val _ = run_fmlaTautology_test ("fmlaTautology_test25", fmlaEx25, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test26", fmlaEx26, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test27", fmlaEx27, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test28", fmlaEx28, true)
val _ = run_fmlaTautology_test ("fmlaTautology_test29", fmlaEx29, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test30", fmlaEx30, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test31", fmlaEx31, false)
val _ = run_fmlaTautology_test ("fmlaTautology_test32", fmlaEx32, true)
;

