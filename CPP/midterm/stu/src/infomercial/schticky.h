#ifndef SCHTICKY_H
#define SCHTICKY_H

#include "crap.h"

/**
 * It's the Schticky!
 *
 * https://www.youtube.com/watch?v=VAQjF5RPgbg
 */
class Schticky : public Crap{
public:
    /**
     * Create a SlapChop.
     *
     * @param name SlapChop name
     */
    Schticky(const std::string& name);

    /**
     * Get the SlapChop slogan.
     *
     * @return the slogan
     */
    std::string slogan() const;
};
#endif // SCHTICKY_H
