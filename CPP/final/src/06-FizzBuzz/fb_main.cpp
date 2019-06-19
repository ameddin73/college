// Problem// Problem 6 - FizzBuzz
//
// Change only the implementation of the FizzBuzz class (fizzbuzz.cpp)
// so that all "lesser" constructors (0-4), delegate to the full
// constructor (5), to initialize all data members.  No other constructor
// other than the full one is allowed to directly initialize data members.
//
// Expected output:
// $ ./fizzbuzz
// Ctor 5 called:
// Ctor 0 called:
//      fb1: 100, z, 111.11, null, true
// Ctor 5 called:
// Ctor 1 called:
//      fb2: 1, x, 999.99, dummy, false
// Ctor 5 called:
// Ctor 2 called:
//      fb3: 2, a, 9001.1, none, true
// Ctor 5 called:
// Ctor 3 called:
//      fb4: 3, b, 12.3, empty, false
// Ctor 5 called:
// Ctor 4 called:
//      fb5: 4, c, 45.6, fb5, true
// Ctor 5 called:
//      fb6: 5, d, 78.9, fb6, true

#include "fizzbuzz.h"
#include <iostream>

using std::cout;
using std::endl;

int main() {
    FizzBuzz fb1;
    cout << "\tfb1: " << fb1 << endl;
    FizzBuzz fb2{1};
    cout << "\tfb2: " << fb2 << endl;
    FizzBuzz fb3{2, 'a'};
    cout << "\tfb3: " << fb3 << endl;
    FizzBuzz fb4{3, 'b', 12.3};
    cout << "\tfb4: " << fb4 << endl;
    FizzBuzz fb5{4, 'c', 45.6, "fb5"};
    cout << "\tfb5: " << fb5 << endl;
    FizzBuzz fb6{5, 'd', 78.9, "fb6", true};
    cout << "\tfb6: " << fb6 << endl;
}
