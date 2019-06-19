#include "schticky.h"

using std::string;

Schticky::Schticky(const std::string &name) :
        Crap(name) {
}

string Schticky::slogan() const {
    return "You'll clean it up in a Jiffy when you use your " + name() + "!";
}
