#ifndef PAIR_H
#define PAIR_H

#include <iostream>

using std::ostream;

// A class that holds two Tegers as a pair.
template<class T>
class Pair {
public:
    /**
     * Initialize the pair.
     *
     * @param first first value
     * @param second second value
     */
    Pair(T first, T second) :
            first_(first),
            second_(second) {
    }

    /**
     * Get the first value in pair.
     *
     * @return first value
     */
    T first() const { return first_; }

    /**
     * Get the second value in pair.
     *
     * @return second value
     */
    T second() const { return second_; }

    /**
     * Find out how many times combine has been called
     *
     * @return number of times combine was called
     */
    int num_combines() const { return num_combines_; }

    /**
     * Change the pair's first value.
     *
     * @param val new first value
     */
    void first(T val) { first_ = val; }

    /**
     * Change the pair's second value.
     *
     * @param val
     */
    void second(T val) { second_ = val; }

    /**
     * Get the sum of adding the first and second values to each other.
     *
     * @return sum of first and second value
     */
    T sum() const { return first_ + second_; }

    /**
     * Sum the first and second values and set both to the sum.
     */
    void combine() {
        ++num_combines_;
        T val = sum();
        first_ = second_ = val;
    }

    /**
     * Tells whether the first value is less than the second
     *
     * @return first value less than second?
     */
    bool less() const { return first_ < second_; }

    /**
     * The pair is prTed to the ostream as "(first, second)".
     *
     * @param os the ostream to insert To
     * @param p the pair
     * @return the same ostream that was passed in
     */
    friend ostream& operator<<(ostream& os, const Pair & p) {
        return os << "(" << p.first() << ", " << p.second() << ")";
    }

private:
    /** counts the total number of pairs created */
    static int num_combines_;
    /** the first value */
    T first_;
    /** the second value */
    T second_;
}; // Pair

// initialize the static combine counter
template<class T>
int Pair<T>::num_combines_ = 0;

#endif // PAIR_H
