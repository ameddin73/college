// A Thing is just a simple wrapper for an integer

#ifndef THING_H
#define THING_H

#include <iostream>

/**
 * A Thing is an integer wrapper.
 */
class Thing {
    int id_;
public:
    /**
     * Construct a Thing.
     *
     * @param id the id
     */
    Thing(int id);

    /**
     * Insert a Thing into the output stream.
     *
     * @param os output stream
     * @param t the thing
     * @return output stream
     */
    friend std::ostream &operator<<(std::ostream &os, const Thing &t);
};

#endif
