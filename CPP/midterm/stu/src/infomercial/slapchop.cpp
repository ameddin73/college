#include "slapchop.h"

using std::string;

SlapChop::SlapChop(const std::string &name) :
        Crap(name) {
}

string SlapChop::slogan() const {
    return "Slap your troubles away with your " + name() + "!";
}
