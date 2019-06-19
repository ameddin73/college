#include "bike.h"

#include <iostream>

using ritcs::Bike;
using std::cout;
using std::endl;

/**
 * Print the details of the bike to standard output
 *
 * @param bike the bike to print
 */
void print_bike(const Bike& bike) {
//#if 0 // REMOVE AFTER IMPLEMENT BIKE CLASS
    cout << "Brand: " << bike.brand()
            << ", Gear: " << bike.gear()
            << ", Speed: " << bike.speed() << endl;
//#endif // REMOVE AFTER IMPLEMENT BIKE CLASS
}

/**
 * The main function tests a couple of bikes out.
 *
 * @return 0
 */
int main() {
//#if 0 // REMOVE AFTER IMPLEMENT BIKE CLASS
    Bike huffy("Huffy", 10);
    huffy.change_gear(5);
    huffy.pedal(10);
    huffy.change_gear(3);
    huffy.brake(2);
    print_bike(huffy);

    Bike schwinn("Schwinn", 5);
    schwinn.pedal(5);
    schwinn.change_gear(5);
    schwinn.pedal(10);
    schwinn.brake(15);
    print_bike(schwinn);

    Bike scott("Scott", 1);
    scott.change_gear(5);
    scott.pedal(6);
    print_bike(scott);
//#endif // REMOVE AFTER IMPLEMENT BIKE CLASS

    return 0;
}

