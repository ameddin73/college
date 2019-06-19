// Problem 2 - Memory
//
// Rewrite the program so that it uses smart pointers instead of raw pointers.
//
// Usage:
// $ ./memory #
// Where # is the number of widgets (with a random number of things
// for each)
//
// Expected output on CS machines:
// $ ./memory 10
// Widget #0: 0
// Widget #1: 0
// Widget #2: 0 1 2
// Widget #3: 0
// Widget #4: 0 1
// Widget #5: 0 1 2 3 4
// Widget #6: 0 1 2
// Widget #7: 0
// Widget #8: 0 1 2
// Widget #9: 0 1 2 3
//
// Verify the program has no memory leaks by running:
// $ valgrind --leak-check=full memory 10

#include "widget.h"
#include <iostream>
#include <sstream>
#include <random>
#include <vector>
#include <memory>

using std::cout;
using std::default_random_engine;
using std::endl;
using std::istringstream;
using std::mt19937_64;
using std::ostringstream;
using std::uniform_int_distribution;
using std::vector;
using std::shared_ptr;
using std::make_shared;

constexpr size_t SEED{1};
constexpr int MAX_THINGS{5};

int main(int argc, char *argv[]) {
    if (argc != 2) {
        cout << "Usage: memory numWidgets" << endl;
        return 0;
    }

    // read # of widgets
    istringstream iss{argv[1]};
    int numWidgets;
    iss >> numWidgets;

    // create a seeded random number generator
    mt19937_64 gen{SEED};
    uniform_int_distribution<int> dist{1, 5};

    // create a vector of 5 dynamic things
    vector<std::shared_ptr<Thing>> things;
    for (int i=0; i<MAX_THINGS; ++i) {
        things.push_back(make_shared<Thing>(i));
    }

    // create a vector of dynamic widgets and attach a random number
    // of things to them (1 to 5).
    vector<std::shared_ptr<Widget>> widgets;
    for (int i = 0; i < numWidgets; ++i) {
        ostringstream oss;
        oss << "Widget #" << i;
        widgets.push_back(make_shared<Widget>(oss.str(), dist(gen), things));
    }

    // display the widgets
    for (auto &w : widgets) {
        cout << *w << endl;
    }

    //// free the widgets
    //for (auto &w : widgets) {
    //    delete w;
    //}

    //// free the things
    //for (auto &t : things) {
    //    delete t;
    //}

    return 0;
}
