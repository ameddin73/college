#ifndef SLAPCHOP_H
#define SLAPCHOP_H

#include "crap.h"

/**
 * It's the SlapChop!  You're gonna love my nuts!
 *
 * https://www.youtube.com/watch?v=rUbWjIKxrrs
 */
class SlapChop : public Crap {
public:
    /**
     * Create a SlapChop.
     *
     * @param name SlapChop name
     */
    SlapChop(const std::string& name);

    /**
     * Get the SlapChop slogan.
     *
     * @return the slogan
     */
    std::string slogan() const;
};

#endif // SLAPCHOP_H
