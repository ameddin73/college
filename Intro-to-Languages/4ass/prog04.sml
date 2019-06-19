(* 
 * Name: Alex Meddin 
 * Time spent on assignment: ~30 hrs
 * Collaborators: 
 *)

(* **************************************** *)
(* **************************************** *)

exception Unimplemented of string

(* **************************************** *)
(* **************************************** *)


(* Part A (unzip/zip) *)

(* A.a *)
(* DEFINE unzip HERE *)
fun unzip [] = ([],[])
    | unzip ((x,y)::xys) =
        let val (xs,ys) = unzip xys
        in (x::xs,y::ys)
        end

(* A.b *)
(* DEFINE zip HERE *)
fun zip ([],[]) = []
    | zip ([],x) = []
    | zip (x,[]) = []
    | zip (x::xs,y::ys) =
        let val xys = zip (xs,ys)
        in ((x,y)::xys)
        end

(* **************************************** *)
(* **************************************** *)


(* Part B *)

(* DEFINE compound HERE *)

fun compound 0 f x = x
    | compound n f x = f(compound (n-1) f x)

(* **************************************** *)
(* **************************************** *)


(* Part C *)

(* DEFINE exp HERE *)
fun exp b 0 = 1
    | exp b 1 = b
    | exp b e = compound (e-1) (fn x => b*x) b

(* **************************************** *)
(* **************************************** *)


(* Part D *)

(* DEFINE existsUnique HERE *)
fun existsUnique f [] = false
    | existsUnique f x = 
        let fun uni (f,b,[]) = b
                | uni (f,b,x::xs) =
                    if (b andalso (f x)) then
                        false else
                        if (f x) then
                            uni (f,true,xs) else
                            uni (f,b,xs)
        in uni (f,false,x)
        end

(* **************************************** *)
(* **************************************** *)


(* Part E *)

(* DEFINE allAlt HERE *)
fun allAlt f [] = true
    | allAlt f [x] = f x
    | allAlt f (x::y::xs) =
        (f x) andalso not(f y) andalso (allAlt f xs)

(* **************************************** *)
(* **************************************** *)

type name = string
fun nameCompare (n1: name, n2: name) : order = String.compare (n1, n2)
fun nameEqual (n1: name, n2: name) : bool =
   case nameCompare (n1, n2) of EQUAL => true | _ => false
exception NotFound of name

(* list representation for environments *)
type 'a lenv = (name * 'a) list
val lenvEmpty = []
fun lenvFind (name, rho) =
   case rho of
      [] => raise NotFound name
    | (n, d)::tail =>
         if nameEqual (name, n) then d else lenvFind (name, tail)
fun lenvBind (name, data, rho) = (name, data) :: rho


(* **************************************** *)
(* **************************************** *)


(* Part F (binary search tree representation for environments) *)

datatype 'a btree = Leaf | Node of 'a btree * 'a * 'a btree

fun btreeInsert cmp =
   let
      fun ins (x, btree) =
         case btree of
            Leaf => Node (Leaf, x, Leaf)
          | Node (lt, y, rt) =>
               (case cmp (x, y) of
                   LESS => Node (ins (x, lt), y, rt)
                 | EQUAL => Node (lt, x, rt)
                 | GREATER => Node (lt, y, ins (x, rt)))
   in
      ins
   end
val _ : ('a * 'a -> order) -> ('a * 'a btree) -> 'a btree = btreeInsert

fun btreeLookup cmp =
   let
      fun lkup (x, btree) =
         case btree of
            Leaf => NONE
          | Node (lt, y, rt) =>
               (case cmp (x, y) of
                   LESS => lkup (x, lt)
                 | EQUAL => SOME y
                 | GREATER => lkup (x, rt))
   in
      lkup
   end
val _ : ('a * 'a -> order) -> ('a * 'a btree) -> 'a option = btreeLookup
val _ : ('a * 'b -> order) -> ('a * 'b btree) -> 'b option = btreeLookup


type 'a tenv = (name * 'a) btree


(* F.a *)
(* DEFINE tenvEmpty HERE *)
val tenvEmpty = Leaf

(* F.b *)
(* DEFINE tenvFind HERE *)
fun tenvFind (name, rho) =
        case btreeLookup 
            (fn (name,(na,data)) => nameCompare (name,na))
                (name,rho)
        of
            NONE => raise NotFound name
            | SOME (name,y) => y

(* F.c *)
(* DEFINE tenvBind HERE *)
fun tenvBind (name,data,rho) =
    btreeInsert
    (fn ((nameN,dataN),(nameO,dataO)) => nameCompare (nameN,nameO))
    ((name,data),rho)

(* **************************************** *)
(* **************************************** *)


(* Part G (function representation for environments) *)

type 'a fenv = name -> 'a


(* G.a *)
(* DEFINE fenvEmpty HERE *)
val fenvEmpty = fn name => raise NotFound name

(* G.b *)
(* DEFINE fenvFind HERE *)
fun fenvFind (name,rho) =
    rho name

(* G.c *)
(* DEFINE fenvBind HERE *)
fun fenvBind (name,data,rho) =
    fn (nameN) => if nameEqual(nameN,name) then data else rho(nameN)

(* **************************************** *)
(* **************************************** *)


(* Part H (append lists) *)

datatype 'a alistNN = Sing of 'a | Append of 'a alistNN * 'a alistNN
datatype 'a alist = Nil | NonNil of 'a alistNN


(* H.a *)
(* DEFINE alistAppend HERE *)
fun alistAppend (Nil,y) = y
    | alistAppend (x,Nil) = x
    | alistAppend (NonNil x, NonNil y) =
        NonNil (Append (x,y))

(* H.b *)
(* DEFINE alistCons HERE *)
fun alistCons (x,Nil) = NonNil (Sing x)
    | alistCons (x,NonNil xs) = NonNil (Append (Sing x, xs))


fun alistUncons (xs: 'a alist) : ('a * 'a alist) option =
   case xs of
      Nil => NONE
    | NonNil xs =>
         let
            fun unconsNN (xs: 'a alistNN) : 'a * 'a alist =
               case xs of
                  Sing x => (x, Nil)
                | Append (ys, zs) =>
                     let
                        val (w, ws) = unconsNN ys
                     in
                        (w, alistAppend (ws, NonNil zs))
                     end
         in
            SOME (unconsNN xs)
         end


(* H.c *)
(* DEFINE alistSnoc HERE *)
fun alistSnoc (Nil,x) = NonNil (Sing x)
    | alistSnoc (NonNil xs,x) = NonNil (Append (xs, Sing x))
    

(* H.d *)
(* DEFINE alistUnsnoc HERE *)
fun alistUnsnoc (Nil) = NONE
    | alistUnsnoc (NonNil x) =
        let fun uns (Append (xs,Sing y)) = (NonNil xs, y)
                | uns (Append (xs,Append(x,Append(Sing y,Sing z)))) =
                    (NonNil (Append (xs, Append (x, Sing y))), z)
                | uns (Append (xs,Append (ys,z))) =
                    uns (Append (Append (xs,ys),z))
                | uns (Sing x) = (Nil, x)
        in SOME (uns x)
        end

(* H.e *)
(* DEFINE alistMap HERE *)
fun alistMap f Nil = Nil
    | alistMap f (NonNil x) =
        let fun lmap (Append (xs,ys)) = Append (lmap xs, lmap ys)
                | lmap (Sing y) = Sing (f y)
        in NonNil (lmap x)
        end

(* H.f *)
(* DEFINE alistFilter HERE *)
fun alistFilter f Nil = Nil
    | alistFilter f (NonNil (Sing x)) =
        if (f x) then NonNil (Sing x) else Nil
    | alistFilter f (NonNil (Append (Sing x, Sing y))) =
        if ((f x) andalso (f y)) then NonNil (Append (Sing x, Sing y)) else
            if (f x) then NonNil (Sing x) else 
                if (f y) then NonNil (Sing y) else Nil
    | alistFilter f (NonNil (Append (Sing x, y))) =
        if (f x) then alistCons (x, (alistFilter f (NonNil y))) else
            alistFilter f (NonNil y)
    | alistFilter f (NonNil (Append (x, Sing y))) =
        if (f y) then alistSnoc (alistFilter f (NonNil x), y) else
            alistFilter f (NonNil x)
    | alistFilter f (NonNil (Append (x,y))) =
        alistAppend (alistFilter f (NonNil x),alistFilter f (NonNil y))
        

fun alistFoldr (f: 'a * 'b -> 'b) (b: 'b) (xs: 'a alist) : 'b =
   case xs of
      Nil => b
    | NonNil xs =>
         let
            fun foldrNN (b: 'b) (xs: 'a alistNN): 'b =
               case xs of
                  Sing x => f (x, b)
                | Append (ys, zs) => foldrNN (foldrNN b zs) ys
         in
            foldrNN b xs
         end


(* H.g *)
(* DEFINE alistFoldl HERE *)
fun alistFoldl (f: 'a * 'b -> 'b) (b: 'b) (xs: 'a alist) : 'b =
    case xs of
        Nil => b
        | NonNil xs =>
            let fun foldlNN (b: 'b) (xs: 'a alistNN): 'b =
                case xs of
                    Sing x => f (x, b)
                    | Append (ys, zs) => foldlNN (foldlNN b ys) zs
            in
                foldlNN b xs
            end

(* H.h *)
(* DEFINE alistToList HERE *)
fun alistToList Nil = []
    | alistToList x =
        alistFoldr (fn (x,b) => [x]@b) [] x

(* **************************************** *)
(* **************************************** *)


(* Part I (propositional-logic formulas) *)

datatype fmla =
   F_Var of string
 | F_Not of fmla
 | F_And of fmla * fmla
 | F_Or of fmla * fmla

type 'a env = 'a lenv
val envEmpty = lenvEmpty
val envFind = lenvFind
val envBind = lenvBind


(* I.a *)
(* DEFINE fmlaSize HERE *)
fun fmlaSize (x: fmla) : int = 
        case x of
            F_Var x => 1
            | F_Not x => 1 + (fmlaSize x)
            | F_And (x,y) => 1 + ((fmlaSize x) + (fmlaSize y)) 
            | F_Or (x,y) => 1 + ((fmlaSize x) + (fmlaSize y)) 
(* I.b *)
(* DEFINE fmlaVarsOf HERE *)
fun fmlaVarsOf (x) =
    let fun lava (x) =
        case x of
            F_Var x => [x]
            | F_Not x => lava x
            | F_And (x,y) => (lava x)@(lava y) 
            | F_Or (x,y) => (lava x)@(lava y)
        fun dedup (x::xs) =
            if (List.exists 
                    (fn y => 
                        case (String.compare(x,y)) of
                            LESS => false
                            | EQUAL => true
                            | GREATER => false)
            xs) then dedup xs else x::(dedup xs)
        | dedup [] = [] 
    in dedup (lava x)
    end

(* I.c *)
(* DEFINE fmlaEval HERE *)
fun fmlaEval (x,env) =
    case x of
        F_Not x => not(fmlaEval (x,env))
        | F_And (x,y) => (fmlaEval (x,env)) andalso (fmlaEval (y,env))
        | F_Or (x,y) => (fmlaEval (x,env)) orelse (fmlaEval (y,env))
        | F_Var x => lenvFind(x,env)

(* I.d !bonus!*)
(* DEFINE fmlaTautology HERE *)
fun fmlaTautology x =
    let fun tau (x,env) = 
    case x of
        F_Not x => tau (x,not(env)) andalso not(tau (x,env))
        | F_And (x,y) => (*((tau (x,true)) andalso (tau (y,true)))
                     andalso*)
                     ((tau (x,true)) andalso (tau (y,false)))
                     (*andalso
                     ((tau (x,false)) andalso (tau (y,true))) *)
                     (*andalso
                     ((tau (x,false)) andalso (tau (y,false)))
                     andalso
                     (tau (x,env)) andalso (tau (y,env)))
                     andalso
                     t((tau (x,env)) andalso (tau (y,not(env))))
                     andalso 
                     ((tau (x,not(env))) andalso (tau (y,env)))*)
        | F_Or (x,y) => (*((tau (x,true)) orelse (tau (y,true)))
                    andalso 
                    ((tau (x,true)) orelse (tau (y,false)))
                    andalso
                    ((tau (x,false)) orelse (tau (y,true)))
                    andalso *)
                    ((tau (x,false)) orelse (tau (y,false)))
                    andalso ( 
                    ((tau (x,env)) orelse (tau (y,env)))
                    orelse 
                    ((tau (x,env)) orelse (tau (y,not(env))))
                    andalso
                    ((tau (x,not(env))) orelse (tau (y,env)))
                    )
        | F_Var x => env
    in (tau (x,true)) andalso (tau (x,false))
    end
