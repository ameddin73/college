#include <iomanip>

#include "pair.h"

using std::boolalpha;
using std::cout;
using std::endl;
using std::string;

int main() {

    Pair<int> p1(1,2);
    cout << "p1: " << p1 << endl;
    cout << "p1 less: " << boolalpha << p1.less() << endl;

    Pair<int> p2 = p1;
    p2.first(5);
    p2.second(4);
    cout << "p2: " << p2 << endl;
    cout << "p2 less: " << boolalpha << p2.less() << endl;
    cout << "p2 sum: " << p2.sum() << endl;
    p2.combine();
    p2.combine();
    cout << "p2 first: " << p2.first() << endl;
    cout << "p2 second: " << p2.second() << endl;
    cout << "Num int combines: " << p2.num_combines() << endl;

    Pair<double> p3(3.5, 1.9);
    cout << "p3: " << p3 << endl;
    cout << "p3 less: " << boolalpha << p3.less() << endl;
    cout << "p3 sum: " << p3.sum() << endl;
    p3.combine();
    p3.combine();
    p3.combine();
    cout << "p3 first: " << p3.first() << endl;
    cout << "p3 second: " << p3.second() << endl;
    cout << "Num double combines: " << p3.num_combines() << endl;

    Pair<string> p4("a", "b");
    cout << "p4: " << p4 << endl;
    cout << "p4 less: " << boolalpha << p4.less() << endl;
    cout << "p4 sum: " << p4.sum() << endl;
    p4.combine();
    cout << "p4 first: " << p4.first() << endl;
    cout << "p4 second: " << p4.second() << endl;
    cout << "Num string combines: " << p4.num_combines() << endl;

    
    return 0;
}
