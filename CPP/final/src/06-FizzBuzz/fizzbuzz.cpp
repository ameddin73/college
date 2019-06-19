#include "fizzbuzz.h"
#include <iostream>

using std::boolalpha;
using std::cout;
using std::endl;
using std::string;
using std::ostream;

FizzBuzz::FizzBuzz() :
        FizzBuzz(100,'z',111.11,"null",true) {
    cout << "Ctor 0 called: " << endl;
}

FizzBuzz::FizzBuzz(int i) :
        FizzBuzz(i,'x',999.99,"dummy",false) {
    cout << "Ctor 1 called: " << endl;
}

FizzBuzz::FizzBuzz(int i, char c) :
        FizzBuzz(i,c,9001.1,"non",true) {
    cout << "Ctor 2 called: " << endl;
}

FizzBuzz::FizzBuzz(int i, char c, double d) :
        FizzBuzz(i,c,d,"empty",false) {
    cout << "Ctor 3 called: " << endl;
}

FizzBuzz::FizzBuzz(int i, char c, double d, const string &s) :
        FizzBuzz(i,c,d,s,true) {
    cout << "Ctor 4 called: " << endl;
}

FizzBuzz::FizzBuzz(int i, char c, double d, const string &s, bool b) :
        i_{i},
        c_{c},
        d_{d},
        s_{s},
        b_{b} {
    cout << "Ctor 5 called: " << endl;
}

ostream &operator<<(ostream &os, const FizzBuzz &fb) {
    return os << fb.i_ << ", " << fb.c_ << ", " << fb.d_ << ", " <<
              fb.s_ << ", " << boolalpha << fb.b_;
}
