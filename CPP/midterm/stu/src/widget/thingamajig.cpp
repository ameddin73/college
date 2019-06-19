#include "thingamajig.h"
#include <cassert>
#include <iostream>

using std::cout;
using std::endl;

ThingAMaJig::ThingAMaJig(int id, const std::string& name, unsigned int num_attachments) :
        Widget(id, name),
        attachments_(new Widget*[num_attachments]),
        num_attachments_(num_attachments) {
    // explicity null out each entry in the new array
    for (unsigned int i=0; i<num_attachments; ++i) {
        attachments_[i] = NULL;
    }
}

ThingAMaJig::ThingAMaJig(const ThingAMaJig& other) : 
        Widget(1,"no"),
        attachments_(new Widget*[other.num_attachments_]),
        num_attachments_(num_attachments_) {
    // set up the new attachments
    for (unsigned int i=0; i<num_attachments_; ++i) {
        if (other.attachments_[i] != NULL) {
            attachments_[i] = new Widget(*(other.attachments_[i]));
        } else {
            attachments_[i] = NULL;
        }
    }
    // destroy the old attachments
    for (unsigned int i=0; i<other.num_attachments_; ++i) {
        if (other.attachments_[i] != NULL) {
            delete other.attachments_[i];
        }
    }
    delete [] other.attachments_;

}

ThingAMaJig::~ThingAMaJig() {
    cout << "destruct";
    for (unsigned int i=0; i<num_attachments_; ++i) {
        if (attachments_[i] != NULL) {
            delete attachments_[i];
        }
    }
    delete [] attachments_;
}

//void ThingAMaJig::operator delete(void * ptr) {
//    cout <<"hello";
//    delete ptr;
//}

ThingAMaJig& ThingAMaJig::operator=(const ThingAMaJig& other) {
    if (this != &other) {
        // destroy the old attachments
        for (unsigned int i=0; i<num_attachments_; ++i) {
            if (attachments_[i] != NULL) {
                delete attachments_[i];
            }
        }
        delete [] attachments_;

        // set up the new attachments
        num_attachments_ = other.num_attachments_;
        attachments_ = new Widget*[num_attachments_];
        for (unsigned int i=0; i<num_attachments_; ++i) {
            if (other.attachments_[i] != NULL) {
                attachments_[i] = new Widget(*(other.attachments_[i]));
            } else {
                attachments_[i] = NULL;
            }
        }
    }
    return *this;
}

void ThingAMaJig::attach(Widget *widget, unsigned int slot) {
    assert(slot < num_attachments_);
    delete attachments_[slot];
    attachments_[slot] = widget;
}

void ThingAMaJig::detach(unsigned int slot) {
    assert(slot < num_attachments_);
    delete attachments_[slot];
    attachments_[slot] = NULL;
}

void ThingAMaJig::use() const {
    cout << "Using ThingAMaJig #" << id() << endl;
    for (unsigned int i=0; i<num_attachments_; ++i) {
        if (attachments_[i] != NULL) {
            attachments_[i]->use();
        }
    }
}
