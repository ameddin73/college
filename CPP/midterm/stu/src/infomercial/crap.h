#ifndef CRAP_H
#define CRAP_H

#include <string>

/**
 * Vince is a sham and his products are crap!
 *
 * @author BillyMays
 */
struct Crap {
public:
    /**
     * Create another crappy product.
     *
     * @param name product name
     */
    Crap(const std::string& name);

    /**
     * Destroy a crappy product.  +1 for humanity.
     */
    virtual ~Crap();

    /**
     * Get one of Vince's vintage crappy slogans for the crappy product.
     *
     * @return the slogan string
     */
    virtual std::string slogan() const;

    /**
     * Get the name of the crappy product with the embedded id, e.g. Crap(#).
     *
     * @return product name
     */
    virtual std::string name() const;

private:
    /** used to count how many crappy products Vince has peddled */
    static unsigned int next_id;
    /** crappy product's name */
    std::string name_;
    /** crappy product's unique id */
    unsigned int id_;
};

#endif // CRAP_H
