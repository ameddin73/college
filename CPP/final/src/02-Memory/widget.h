// A Widget is a simple class that has a name and a collection
// of dynamic Things

#ifndef WIDGET_H
#define WIDGET_H

#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include "thing.h"

using std::shared_ptr;

/**
 * A Widget can hold a bunch of Things.
 */
class Widget {
public:
    /**
     * Construct a Widget with 'numThings' dynamic things
     *
     * @param name the name of the widget
     * @param numThings number of attachments
     * @param things the collection of things to choose from
     */
    Widget(const std::string &name, int numThings, std::vector<shared_ptr<Thing>> &things);

    // friendly output routine
    friend std::ostream &operator<<(std::ostream &os, const Widget &w);

private:
    /** the next thing id */
    static int id;
    /** the name of the widget */
    std::string name_;
    /** the collection of things for this widget */
    std::vector<shared_ptr<Thing>> things_;
};

#endif
