#include "shamwow.h"

using std::string;

ShamWow::ShamWow(const std::string &name) :
        Crap(name) {
}

string ShamWow::slogan() const {
    return "You'll be saying \"wow\" everytime you use your " +
           name() + "!";
}
