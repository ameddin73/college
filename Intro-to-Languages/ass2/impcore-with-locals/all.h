/* {\Tt all.h} for \impcore 31 */
#include <assert.h>
#include <ctype.h>
#include <setjmp.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* type definitions for \impcore 33c */
typedef struct UnitTestlist *UnitTestlist; // list of UnitTest
/* type definitions for \impcore 33d */
typedef struct Explist *Explist; // list of Exp
/* type definitions for \impcore 34c */
typedef int Value;
typedef struct Valuelist *Valuelist;     // list of Value
/* type definitions for \impcore 34d */
typedef struct Funlist *Funlist; // list of Fun
/* type definitions for \impcore 35b */
typedef struct Valenv *Valenv;
typedef struct Funenv *Funenv;
/* type definitions for \impcore (BUG: software can't tell where this code came from [NWvPdTi-32mcxO-1]) */
typedef struct Exp *Exp;
typedef enum { LITERAL, VAR, SET, IFX, WHILEX, BEGIN, APPLY } Expalt;

/* type definitions for \impcore (BUG: software can't tell where this code came from [NWuNYj-32mcxO-1]) */
typedef struct Userfun Userfun; 
typedef struct Def *Def;
typedef enum { VAL, EXP, DEFINE } Defalt; 
/* type definitions for \impcore (BUG: software can't tell where this code came from [NW3rFzh4-32mcxO-1]) */
typedef struct XDef *XDef;
typedef enum { DEF, USE, TEST } XDefalt; 
typedef struct UnitTest *UnitTest;
typedef enum { CHECK_EXPECT, CHECK_ERROR } UnitTestalt;

/* type definitions for \impcore (BUG: software can't tell where this code came from [NWROIcV-32mcxO-1]) */
typedef struct Fun Fun;
typedef enum { USERDEF, PRIMITIVE } Funalt; 
/* shared type definitions 34a */
typedef struct Name *Name;
typedef struct Namelist *Namelist;   // list of Name
/* shared type definitions 36a */
typedef struct XDefstream *XDefstream;
/* shared type definitions 36d */
typedef enum Prompts { NO_PROMPTS, STD_PROMPTS } Prompts;
/* shared type definitions 37b */
typedef enum Echo { NO_ECHOES, ECHOES } Echo;
/* shared type definitions 41b */
typedef struct Sourceloc *Sourceloc;
/* shared type definitions 41d */
typedef enum ErrorFormat { WITH_LOCATIONS, WITHOUT_LOCATIONS } ErrorFormat;
/* shared type definitions 1103b */
typedef struct ParserState *ParserState;
typedef struct ParsingContext *ParsingContext;
/* shared type definitions 1104a */
typedef enum ParserResult {
  PARSED,            /* some input was parsed without any errors */
  INPUT_EXHAUSTED,   /* there aren't enough inputs */
  INPUT_LEFTOVER,    /* there are too many inputs */
  BAD_INPUT,         /* an input wasn't what it should have been */
  STOP_PARSING       /* all the inputs have been parsed; it's time to stop */
} ParserResult;
/* shared type definitions 1104b */
typedef ParserResult (*ShiftFun)(ParserState);
/* shared type definitions 1108c */
typedef struct ParserRow *ParserTable;
/* shared type definitions 1116a */
enum Sugar {
  CAND, COR,    /* short-circuit Boolean operators */

  WHILESTAR, DO_WHILE, FOR,     /* bonus loop forms */

  WHEN, UNLESS,       /* single-sided conditionals */

  RECORD,             /* record-type definition */

  COND                /* McCarthy's conditional from Lisp */

};
/* shared type definitions 1076a */
typedef struct Linestream *Linestream;
/* shared type definitions 1079c */
typedef struct Parlist *Parlist; /* list of Par */
/* shared type definitions 1079d */
typedef struct Parstream *Parstream;
/* shared type definitions 1085d */
/* definition of [[va_list_box]] 1085e */
typedef struct va_list_box {
  va_list ap;
} va_list_box;
typedef void Printer(FILE *output, va_list_box *args);
/* shared type definitions 1192d */
typedef enum TestResult { TEST_PASSED, TEST_FAILED } TestResult;
/* shared type definitions (BUG: software can't tell where this code came from [NW1U7EG1-qYINM-1]) */
typedef struct Par *Par;
typedef enum { ATOM, LIST } Paralt; 

/* structure definitions for \impcore 1101a */
struct Component {
    Exp exp;
    Explist exps;
    Name name;
    Namelist names;
};
/* structure definitions for \impcore (BUG: software can't tell where this code came from [NWvPdTi-3xZ6qB-1]) */
struct Exp {
    Expalt alt;
    union {
        Value literal;
        Name var;
        struct { Name name; Exp exp; } set;
        struct { Exp cond; Exp truex; Exp falsex; } ifx;
        struct { Exp cond; Exp exp; } whilex;
        Explist begin;
        struct { Name name; Explist actuals; } apply;
    } u;
};

/* structure definitions for \impcore (BUG: software can't tell where this code came from [NWuNYj-3xZ6qB-1]) */
struct Userfun { Namelist formals; Namelist locals; Exp body; };
struct Def {
    Defalt alt;
    union {
        struct { Name name; Exp exp; } val;
        Exp exp;
        struct { Name name; Userfun userfun; } define;
    } u;
};

/* structure definitions for \impcore (BUG: software can't tell where this code came from [NW3rFzh4-3xZ6qB-1]) */
struct XDef {
    XDefalt alt; union { Def def; Name use; UnitTest test; } u;
};

struct UnitTest {
    UnitTestalt alt;
    union {
        struct { Exp check; Exp expect; } check_expect; Exp check_error;
    } u;
};

/* structure definitions for \impcore (BUG: software can't tell where this code came from [NWROIcV-3xZ6qB-1]) */
struct Fun { Funalt alt; union { Userfun userdef; Name primitive; } u; }; 
/* structure definitions for \impcore 38 */
struct Parlist {
   Par hd;
   struct Parlist *tl;
};

struct UnitTestlist {
   UnitTest hd;
   struct UnitTestlist *tl;
};

struct Explist {
   Exp hd;
   struct Explist *tl;
};

struct Namelist {
   Name hd;
   struct Namelist *tl;
};

struct Valuelist {
   Value hd;
   struct Valuelist *tl;
};

struct Funlist {
   Fun hd;
   struct Funlist *tl;
};

/* shared structure definitions 1103a */
#define MAXCOMPS 4 /* max # of components in any syntactic form */
struct ParserState {
    int nparsed;           /* number of components parsed so far */
    struct Component components[MAXCOMPS];  /* those components */
    Parlist input;         /* the part of the input not yet parsed */

    struct ParsingContext {   /* context of this parse */
        Par par;       /* the original thing we are parsing */
        struct Sourceloc {
            int line;                /* current line number */
            const char *sourcename;  /* where the line came from */
        } *source;
        Name name;     /* a keyword, or name of a function being defined */
    } context;
};
/* shared structure definitions 1107d */
struct ParserRow {
    const char *keyword;
    int code;
    ShiftFun *shifts;  /* points to array of shift functions */
};
/* shared structure definitions 1077a */
struct Linestream {
    char *buf;               /* holds the last line read */
    int bufsize;                /* size of buf */

    struct Sourceloc source; /* where the last line came from */
    FILE *fin;               /* non-NULL if filelines */
    const char *s;           /* non-NULL if stringlines */
};
/* shared structure definitions (BUG: software can't tell where this code came from [NW1U7EG1-3JdwEE-1]) */
struct Par { Paralt alt; union { Name atom; Parlist list; } u; }; 

/* function prototypes for \impcore 35c */
Valenv mkValenv(Namelist vars, Valuelist vals);
Funenv mkFunenv(Namelist vars, Funlist   defs);
/* function prototypes for \impcore 35d */
Value fetchval(Name name, Valenv env);
Fun   fetchfun(Name name, Funenv env);
/* function prototypes for \impcore 35e */
bool isvalbound(Name name, Valenv env);
bool isfunbound(Name name, Funenv env);
/* function prototypes for \impcore 35f */
void bindval(Name name, Value val, Valenv env);
void bindfun(Name name, Fun   fun, Funenv env);
/* function prototypes for \impcore 36e */
Value eval   (Exp e, Valenv globals, Funenv functions, Valenv formals, Valenv locals); //ADDED LOCALS
void  evaldef(Def d, Valenv globals, Funenv functions, Echo echo_level);
/* function prototypes for \impcore 37a */
void readevalprint(XDefstream s, Valenv globals, Funenv functions, Echo
                                                                    echo_level);
/* function prototypes for \impcore 50b */
void process_tests(UnitTestlist tests, Valenv globals, Funenv functions);
/* function prototypes for \impcore 1192a */
int number_of_good_tests(UnitTestlist tests, Valenv globals, Funenv functions);
/* function prototypes for \impcore 1192e */
TestResult test_result(UnitTest t, Valenv globals, Funenv functions);
/* function prototypes for \impcore (BUG: software can't tell where this code came from [NWvPdTi-4I66Qz-1]) */
Exp mkLiteral(Value literal);
Exp mkVar(Name var);
Exp mkSet(Name name, Exp exp);
Exp mkIfx(Exp cond, Exp truex, Exp falsex);
Exp mkWhilex(Exp cond, Exp exp);
Exp mkBegin(Explist begin);
Exp mkApply(Name name, Explist actuals);
struct Exp mkLiteralStruct(Value literal);
struct Exp mkVarStruct(Name var);
struct Exp mkSetStruct(Name name, Exp exp);
struct Exp mkIfxStruct(Exp cond, Exp truex, Exp falsex);
struct Exp mkWhilexStruct(Exp cond, Exp exp);
struct Exp mkBeginStruct(Explist begin);
struct Exp mkApplyStruct(Name name, Explist actuals);
/* function prototypes for \impcore 32b */
Userfun mkUserfun(Namelist formals, Namelist locals, Exp body);
Def mkVal(Name name, Exp exp);
Def mkExp(Exp exp);
Def mkDefine(Name name, Userfun userfun);
struct Def mkValStruct(Name name, Exp exp);
struct Def mkExpStruct(Exp exp);
struct Def mkDefineStruct(Name name, Userfun userfun);
/* function prototypes for \impcore (BUG: software can't tell where this code came from [NW3rFzh4-4I66Qz-1]) */
XDef mkDef(Def def);
XDef mkUse(Name use);
XDef mkTest(UnitTest test);
struct XDef mkDefStruct(Def def);
struct XDef mkUseStruct(Name use);
struct XDef mkTestStruct(UnitTest test);
UnitTest mkCheckExpect(Exp check, Exp expect);
UnitTest mkCheckError(Exp check_error);
struct UnitTest mkCheckExpectStruct(Exp check, Exp expect);
struct UnitTest mkCheckErrorStruct(Exp check_error);
/* function prototypes for \impcore 35a */
Fun mkUserdef(Userfun userdef);
Fun mkPrimitive(Name primitive);
/* function prototypes for \impcore 39 */
int     lengthPL(Parlist ps);
Par     nthPL   (Parlist ps, unsigned n);
Parlist mkPL    (Par p, Parlist ps);
Parlist popPL   (Parlist ps);
Printer printparlist;

int          lengthUL(UnitTestlist us);
UnitTest     nthUL   (UnitTestlist us, unsigned n);
UnitTestlist mkUL    (UnitTest u, UnitTestlist us);
UnitTestlist popUL   (UnitTestlist us);
Printer      printunittestlist;

int     lengthEL(Explist es);
Exp     nthEL   (Explist es, unsigned n);
Explist mkEL    (Exp e, Explist es);
Explist popEL   (Explist es);
Printer printexplist;

int      lengthNL(Namelist ns);
Name     nthNL   (Namelist ns, unsigned n);
Namelist mkNL    (Name n, Namelist ns);
Namelist popNL   (Namelist ns);
Printer  printnamelist;

int       lengthVL(Valuelist vs);
Value     nthVL   (Valuelist vs, unsigned n);
Valuelist mkVL    (Value v, Valuelist vs);
Valuelist popVL   (Valuelist vs);
Printer   printvaluelist;

int     lengthFL(Funlist fs);
Fun     nthFL   (Funlist fs, unsigned n);
Funlist mkFL    (Fun f, Funlist fs);
Funlist popFL   (Funlist fs);
Printer printfunlist;

/* shared function prototypes 34b */
Name strtoname(const char *s);
const char *nametostr(Name x);
/* shared function prototypes 36b */
XDef getxdef(XDefstream xdefs);
/* shared function prototypes 36c */
XDefstream stringxdefs(const char *stringname, const char *input);
XDefstream filexdefs  (const char *filename, FILE *input, Prompts prompts);
/* shared function prototypes 40a */
void print (const char *fmt, ...);  // print to standard output
void fprint(FILE *output, const char *fmt, ...);  // print to given file
/* shared function prototypes 40b */
void installprinter(unsigned char c, Printer *take_and_print);
/* shared function prototypes 41a */
void runerror(const char *fmt, ...);
extern jmp_buf errorjmp;        // longjmp here on error
/* shared function prototypes 41c */
void synerror(Sourceloc src, const char *fmt, ...);
/* shared function prototypes 42a */
void set_toplevel_error_format(ErrorFormat format);
/* shared function prototypes 42b */
void checkargc(Exp e, int expected, int actual);
/* shared function prototypes 42c */
Name duplicatename(Namelist names);
/* shared function prototypes 1098a */
Exp  parseexp (Par p, Sourceloc source);
XDef parsexdef(Par p, Sourceloc source);
/* shared function prototypes 1098b */
Exp exp_of_atom(Name atom);
/* shared function prototypes 1101b */
Exp  reduce_to_exp (int alt, struct Component *components);
XDef reduce_to_xdef(int alt, struct Component *components);
/* shared function prototypes 1103d */
struct ParserState mkParserState(Par p, Sourceloc source);
/* shared function prototypes 1104c */
ParserResult sExp     (ParserState state);  /* shift 1 input into Exp */
ParserResult sExps    (ParserState state);  /* shift all inputs into Explist */
ParserResult sName    (ParserState state);  /* shift 1 input into Name */
ParserResult sNamelist(ParserState state);  /* shift 1 input into Namelist */
/* shared function prototypes 1104e */
void halfshift(ParserState state); /* advance input, check for room in output */
/* shared function prototypes 1105c */
Explist parseexplist(Parlist p, Sourceloc source);
/* shared function prototypes 1105e */
Name parsename(Par p, ParsingContext context);
/* shared function prototypes 1106d */
ParserResult stop(ParserState state);
/* shared function prototypes 1106f */
ParserResult setcontextname(ParserState state);
/* shared function prototypes 1107c */
ParserResult sLocals(ParserState state);  // shift locals if (locals x y z ...)
/* shared function prototypes 1108b */
void rowparse(struct ParserRow *table, ParserState s);
void usage_error(int alt, ParserResult r, ParsingContext context);
/* shared function prototypes 1108e */
struct ParserRow *tableparse(ParserState state, ParserTable t);
/* shared function prototypes 1111d */
ParserResult use_exp_parser(ParserState state);
/* shared function prototypes 1115c */
int code_of_name(Name n);
/* shared function prototypes 1115d */
void check_exp_duplicates(Sourceloc source, Exp e);
void check_def_duplicates(Sourceloc source, Def d);
/* shared function prototypes 1076b */
char *getline_(Linestream r, const char *prompt);
/* shared function prototypes 1076c */
Linestream stringlines(const char *stringname, const char *s);
Linestream filelines  (const char *filename,   FILE *fin);
/* shared function prototypes 1079e */
Parstream parstream(Linestream lines, Prompts prompts);
Par       getpar   (Parstream r);
Sourceloc parsource(Parstream pars);
/* shared function prototypes 1080a */
extern bool read_tick_as_quote;
/* shared function prototypes 1085b */
void print (const char *fmt, ...);                /* print to standard output */
void fprint(FILE *output, const char *fmt, ...);  /* print to given file */
/* shared function prototypes 1085c */
void installprinter(unsigned char specifier, Printer *take_and_print);
/* shared function prototypes 1086a */
void vprint(FILE *output, const char *fmt, va_list_box *box);
/* shared function prototypes 1087d */
Printer printpercent, printstring, printdecimal, printchar, printname;
/* shared function prototypes 1088e */
Printer printpar;
/* shared function prototypes 1089a */
typedef enum ErrorMode { NORMAL, TESTING } ErrorMode;
void set_error_mode(ErrorMode mode);
extern jmp_buf testjmp;         /* longjmp here if error occurs during a test */
/* shared function prototypes 1093a */
extern int checkoverflow(int limit);
/* shared function prototypes 1094a */
void fprint_utf8(FILE *output, unsigned code_point);
void print_utf8 (unsigned u);
/* shared function prototypes 1192b */
void report_test_results(int npassed, int ntests);
/* shared function prototypes 1194d */
Printer printexp, printdef, printvalue, printfun;
/* shared function prototypes (BUG: software can't tell where this code came from [NW1U7EG1-1K7da4-1]) */
Par mkAtom(Name atom);
Par mkList(Parlist list);
struct Par mkAtomStruct(Name atom);
struct Par mkListStruct(Parlist list);

/* macro definitions used in parsing 1102a */
#define ANEXP(ALT)  (  0+(ALT))
#define ADEF(ALT)   (100+(ALT))
#define ATEST(ALT)  (200+(ALT))
#define ANXDEF(ALT) (300+(ALT))
#define ALET(ALT)   (400+(ALT))
#define SUGAR(CODE) (500+(CODE))
#define LATER       1000
#define EXERCISE    1001
/* declarations of global variables used in lexical analysis and parsing 1109b */
extern struct ParserRow exptable[];
extern struct ParserRow xdeftable[];
/* declarations of global variables used in lexical analysis and parsing 1113b */
extern struct Usage {
    int code;
                         /* codes for form in reduce_to_exp or reduce_to_xdef */
    const char *expected;  /* shows the expected usage of the identified form */
} usage_table[];
