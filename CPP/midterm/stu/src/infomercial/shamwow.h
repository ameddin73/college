#ifndef SHAMWOW_H
#define SHAMWOW_H

#include "crap.h"

/**
 * Introducing, the ShamWow!
 *
 * https://www.youtube.com/watch?v=W3d4-oQ7EQY
 */
class ShamWow : public Crap {
public:
    /**
     * Create a ShamWow.
     *
     * @param name ShamWow name
     */
    ShamWow(const std::string& name);

    /**
     * Get the ShamWow slogan.
     *
     * @return the slogan
     */
    std::string slogan() const;
};

#endif // SHAMWOW_H
