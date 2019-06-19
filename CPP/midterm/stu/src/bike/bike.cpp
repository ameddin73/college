#include "bike.h"
#include <string>
#include <algorithm>

unsigned int GEARS_ = 0;
std::string brand_ = "";
unsigned int gear_ = 0;
double speed_ = 0;

/**
 * Create a new bike in first gear that is not moving.
 *
 * @param brand
 * @param gears
 */
ritcs::Bike::Bike(const std::string &brand, unsigned int gears) :
    brand_(brand),
    GEARS_(gears),
    gear_(1) {}

/**
 * Get the bike brand.
 *
 * @return brand name
 */
std::string ritcs::Bike::brand() const {return brand_;}

/**
 * Get the current gear the bike is in.
 *
 * @return current gear
 */
unsigned int ritcs::Bike::gear() const {return gear_;}

/**
 * Get the current speed of the bike.
 *
 * @return bike speed
 */
double ritcs::Bike::speed() const {return speed_;}
 
/**
 * Change bike gear.  If the caller tries changing the gear
 * out of range it should keep the gear the same.
 *
 * @param gear
 */
void ritcs::Bike::change_gear(unsigned int gear) {
    if (gear < GEARS_ && gear > 0 )
        gear_ = gear;
}

/**
 * Pedal the bike for a certain number of seconds.  The speed of the
 * bike is increased by the current gear times the number of seconds.
 *
 * @param sec number of seconds pedalling
 */
void ritcs::Bike::pedal(unsigned int sec) {
    speed_ += gear_ * sec;
}

/**
 * Hit the brakes on the bike for a certain number of seconds.  The
 * speed of the bike is decreased by the current gear times the number
 * of seconds.  In the event the speed of the bike drops to or below
 * zero, the speed should be set to 0 and the bike should be put
 * into first gear.
 *
 * @param sec number of seconds braking
 */
void ritcs::Bike::brake(unsigned int sec) {
    double brk = (double)gear_ * (double)sec;
    if (brk >= speed_) {
        speed_ = 0;
        gear_ = 1;
    } else {
        speed_ -= brk;
    }
}
