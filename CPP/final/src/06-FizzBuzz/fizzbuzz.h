// A class with overloaded constructors

#ifndef FIZZBUZZ_H
#define FIZZBUZZ_H

#include <string>
#include <iostream>

/**
 * A class the has a bunch of overloaded constructors.
 */
class FizzBuzz {
public:
    /** Default constructor */
    FizzBuzz();

    /**
     * Integer constructor.
     * @param i an int
     */
    FizzBuzz(int i);

    /**
     * Integer, character constructor.
     * @param i an int
     * @param c a char
     */
    FizzBuzz(int i, char c);

    /**
     * Integer, character, double constructor.
     * @param i an int
     * @param c a char
     * @param d a double
     */
    FizzBuzz(int i, char c, double d);

    /**
     * Integer, character, double, string constructor.
     * @param i an int
     * @param c a char
     * @param d a double
     * @param s a string
     */
    FizzBuzz(int i, char c, double d, const std::string &s);

    /**
     * The full constructor.
     * @param i an int
     * @param c a char
     * @param d a double
     * @param s a string
     * @param b  boolean
     */
    FizzBuzz(int i, char c, double d, const std::string &s, bool b);

    /**
     * Insert FizzBuzz into output stream.
     * @param os output stream
     * @param fb the FizzBuzz object
     * @return output stream (for chaining)
     */
    friend std::ostream &operator<<(std::ostream &os, const FizzBuzz &fb);

private:
    int i_;
    char c_;
    double d_;
    std::string s_;
    bool b_;
};

#endif
