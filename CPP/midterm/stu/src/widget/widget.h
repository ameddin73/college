#ifndef WIDGET_H
#define WIDGET_H

#include <string>

/**
 * A widget class.
 */
class Widget {
public:
    /**
     * Create a new widget.
     *
     * @param id widget id
     * @param name widget name
     */
    Widget(int id, const std::string& name);

    /**
     * Destruct widget
     */
     virtual ~Widget();

    /**
     * Get the widget id.
     *
     * @return widget id
     */
    int id() const;

    /**
     * Get the widget name.
     *
     * @return widget name
     */
    std::string name() const;

    /**
     * When used the widget prints out its id and name.
     */
    virtual void use() const;

private:
    /** widget id */
    int id_;
    /** widget name */
    std::string name_;
};

#endif // WIDGET_H
