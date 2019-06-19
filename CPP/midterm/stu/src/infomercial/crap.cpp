#include "crap.h"
#include <sstream>

using std::ostringstream;
using std::string;

unsigned int Crap::next_id = 1;

Crap::Crap(const string& name):
    name_(name),
    id_(next_id++) {
}

Crap::~Crap() {
}

std::string Crap::slogan() const {
    return name() + " is crap!";
}

std::string Crap::name() const {
    ostringstream os;
    os << id_;
    return name_ + "(" + os.str() + ")™";
}
