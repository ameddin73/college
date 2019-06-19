#ifndef BIKE_H
#define BIKE_H

#include <string>

namespace ritcs {

    class Bike {
    public:
        /**
         * Create a new bike in first gear that is not moving.
         *
         * @param brand
         * @param gears
         */
        Bike(const std::string &brand, unsigned int gears);

        /**
         * Get the bike brand.
         *
         * @return brand name
         */
        std::string brand() const;

        /**
         * Get the current gear the bike is in.
         *
         * @return current gear
         */
        unsigned int gear() const;

        /**
         * Get the current speed of the bike.
         *
         * @return bike speed
         */
        double speed() const;

        /**
         * Change bike gear.  If the caller tries changing the gear
         * out of range it should keep the gear the same.
         *
         * @param gear
         */
        void change_gear(unsigned int gear);

        /**
         * Pedal the bike for a certain number of seconds.  The speed of the
         * bike is increased by the current gear times the number of seconds.
         *
         * @param sec number of seconds pedalling
         */
        void pedal(unsigned int sec);

        /**
         * Hit the brakes on the bike for a certain number of seconds.  The
         * speed of the bike is decreased by the current gear times the number
         * of seconds.  In the event the speed of the bike drops to or below
         * zero, the speed should be set to 0 and the bike should be put
         * into first gear.
         *
         * @param sec number of seconds braking
         */
        void brake(unsigned int sec);

    private:
        /** the number of gears on the bike */
        const unsigned int GEARS_;
        /** bike brand name */
        std::string brand_;
        /* the current bike gear */
        unsigned int gear_;
        /** the current bike speed */
        double speed_;
    };

} // ritcs

#endif // BIKE_H
