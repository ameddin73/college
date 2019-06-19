#include "widget.h"

#include<iostream>

using std::cout;
using std::endl;
using std::string;

Widget::Widget(int id, const string& name) :
        id_(id),
        name_(name){}

Widget::~Widget() {}

int Widget::id() const { return id_; }

string Widget::name() const { return name_; }

void Widget::use() const {
    cout << "Using Widget #" << id_ << ", " << name_ << endl;
}
