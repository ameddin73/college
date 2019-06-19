#ifndef THINGAMAJIG
#define THINGAMAJIG

#include "widget.h"

/**
 * A ThingAMaJig is a special kind of widgets that can hold other widgets
 * as attachments.
 */
class ThingAMaJig : public Widget {
public:
    /**
     * Create a ThingAMaJig.
     *
     * @param id the widget id
     * @param name the widget name
     * @param num_attachments the number of widgets that can be attached
     */
    ThingAMaJig(int id, const std::string& name, unsigned int num_attachments);

    ThingAMaJig(const ThingAMaJig& other);

    ~ThingAMaJig();

    //void operator delete(void * ptr);

    /**
     * Assign to a ThingAMaJig.  Any widgets current attached need to be
     * deleted and then the new ones need to be deep copied.
     */
     ThingAMaJig& operator=(const ThingAMaJig& other);

    /**
     * When used, it uses each of the attached widgets in order by slot.
     */
    void use() const;

    /**
     * Attach a new widget in a slot.
     *
     * @param widget the widget to attach
     * @param slot the slot number
     */
    void attach(Widget* widget, unsigned int slot);

    /**
     * Detach a widget from a slot.
     *
     * @param slot the slot number
     */
    void detach(unsigned int slot);

private:
    /** array of widget points to be dynamically allocated */
    Widget** attachments_;
    /** the number of widgets it can hold */
    unsigned int num_attachments_;
};

#endif // THINGAMAJIG_H
