#include "thing.h"

using std::ostream;

Thing::Thing(int id) : id_{id} {}

ostream &operator<<(ostream &os, const Thing &t) {
    return os << t.id_;
}
