// Problem 3 - Lambda
//
// Rewrite the code for the transform() call on line 68 so that instead of
// using the cmp functor, it uses an anonymous lambda expression created
// directly inside the function call.
//
// Expected output on CS machines:
// $ lambda
// all: 16 100 4 60 55 6 64 43 85 91 43 66 94 35 26 45 80 70 56 29
// larger: -9.9 100 -9.9 60 55 -9.9 64 43 85 91 43 66 94 35 26 45 80 70 56 29

#include <algorithm>
#include <iostream>
#include <random>
#include <vector>

using std::cout;
using std::endl;
using std::mt19937_64;
using std::transform;
using std::uniform_int_distribution;
using std::vector;

/**
 * a functor that takes an integer value and returns the value as a double
 * (if the value is greater than some minimum), or a sentinel value otherwise.
 */
//struct cmp {
//    int min_;
//    double sentinel_;
//
//    cmp(int min, double sentinel) :
//            min_{min},
//            sentinel_{sentinel} {}
//
//    double operator()(int val) const {
//        if (val >= min_) return val;
//        else return sentinel_;
//    }
//};

constexpr int NUMS{20};
constexpr int MIN{25};
constexpr int MAX{100};
constexpr int SEED{0};
constexpr double SENTINEL{-9.9};

int main() {
    // create a random number generator
    mt19937_64 gen{SEED};
    std::uniform_int_distribution<int> dist{1, MAX};

    // create vectors
    vector<int> all;
    vector<double> larger;

    // add 20 random integers to all, range 1-100
    cout << "all: ";
    for (int i = 0; i < NUMS; ++i) {
        all.push_back(dist(gen));
        cout << all.at(i) << " ";
    }
    cout << endl;

    // retain all numbers greater than or equal to 25 from all into larger,
    // and replace all other numbers from all into larger with -9.9
    larger.resize(all.size());
    //transform(all.begin(), all.end(), larger.begin(), cmp{MIN, SENTINEL});
    transform(all.begin(), all.end(), larger.begin(),
            [&](int val) -> double {
            if (val >= MIN) return val;
            else return SENTINEL;
            });

    // print out the values in larger
    cout << "larger: ";
    for (double val : larger) {
        cout << val << " ";
    }
    cout << endl;
}
