#include "widget.h"

using std::ostream;
using std::string;
using std::vector;

int Widget::id{0};

Widget::Widget(const string &name, int numThings, vector<shared_ptr<Thing>> &things) :
        name_{name},
        things_{} {
    for (int val = 0; val < numThings; ++val) {
        things_.push_back(things[val]);
    }
}

ostream &operator<<(ostream &os, const Widget &w) {
    os << w.name_ << ": ";
    for (auto &t : w.things_) {
        os << *t << " ";
    }
    return os;
}
