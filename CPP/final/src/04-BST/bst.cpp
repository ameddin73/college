// Problem 4 - BST
//
// Add a move constructor and a move assignment to this node based binary
// search tree.  When the main program runs, the move semantics should
// cause the nodes of the tree on the right hand side of the assignment
// to be "moved" to the tree on the left hand side (rather than copied,
// by default).
//
// Note: see the provided output.txt for the correct output, assuming you
// put appropriate output messages in your new methods (which you should!)

#include <iostream>

#include "bst.h"

using std::cout;
using std::endl;
using std::string;

/**
 * The main program creates some BST's and invokes copy and move semantics
 * on them.
 *
 * @return 0
 */
int main() {
    cout << "(List ctor) bst1 = { 1, 3, 5, 4 };" << endl;
    BST<unsigned> bst1 = {1, 3, 5, 4};
    cout << "bst1: " << bst1 << endl;

    cout << endl << "(Copy ctor) bst2 = bst1;" << endl;
    BST<unsigned> bst2 = bst1;
    cout << "bst2: " << bst2 << endl;

    cout << endl << "(Copy assignment) bst2 = bst1;" << endl;
    bst2 = bst1;
    cout << "bst1: " << bst1 << endl;

    cout << endl << "(Default ctor) lincolnBST1;" << endl;
    BST<string> lincolnBST1;

    vector<string> words{"give", "me", "six", "hours", "to", "chop",
                         "down", "a", "BST", "and", "I", "will", "spend",
                         "the", "first", "four", "sharpening", "the", "axe"};

    cout << endl << "lincolnBST1 << \"give\" << \"me\" << \"six\" << (...) << \"axe\";" << endl;
    for (auto &word : words) {
        lincolnBST1 << word;
    }

    cout << endl << "(Move ctor) lincolnBST2{move(lincolnBST1)};" << endl;
    BST<string> lincolnBST2{move(lincolnBST1)};
    // lincolnBST1 should now be empty
    cout << "lincolnBST1: " << lincolnBST1 << endl;
    cout << "lincolnBST2: " << lincolnBST2 << endl;

    // repopulate lincolnBST1 with some data
    cout << endl << "lincolnBST1 << \"I\" << \"like\" << \"beards\"" << endl;
    lincolnBST1 << "I" << "like" << "beards";

    cout << endl << "(Move assignment) lincolnBST1 = move(lincolnBST2)};" << endl;
    // this move should clear out the data in lincolnBST1 before moving
    // lincolnBST2 over
    lincolnBST1 = move(lincolnBST2);
    cout << "lincolnBST1: " << lincolnBST1 << endl;
    cout << "lincolnBST2: " << lincolnBST2 << endl;

    cout << endl << "Function main() finishing." << endl;
    return 0;
}
