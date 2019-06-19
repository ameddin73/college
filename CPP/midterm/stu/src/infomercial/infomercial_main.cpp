#include <iostream>
#include <vector>

#include "schticky.h"
#include "shamwow.h"
#include "slapchop.h"

using std::cin;
using std::cout;
using std::endl;
using std::vector;

/**
 * The main function creates the products and prints their slogans.
 *
 * @return 0
 */
int main() {
    // create products
    SlapChop slapchop("SlapChop");
    ShamWow shamwow("ShamWow");
    Schticky schticky("Schticky");

    SlapChop* slap = &slapchop;
    ShamWow* sham = &shamwow;
    Schticky* schtick = &schticky;

    // add products to collection
    vector<Crap*> products;
    products.push_back(slap);
    products.push_back(sham);
    products.push_back(schtick);

    // loop through collection and print slogans
    for (unsigned int i=0; i<products.size(); ++i) {
        cout << products[i]->slogan() << endl;
    }

    // fix it so you can't do this.  uncomment next line when mission is
    // accomplished.
    //Crap crap("crap!");

    return 0;
}
