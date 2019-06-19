#include "thingamajig.h"

int main() {
    ThingAMaJig thing(1, "TheThing", 10);
    thing.attach(new Widget(2, "furminator"), 0);
    thing.attach(new Widget(3, "burninator"), 3);
    thing.attach(new Widget(4, "squirminator"), 6);
    thing.attach(new Widget(5, "terminator"), 7);
    thing.attach(new Widget(6, "eliminator"), 9);
    thing.attach(new Widget(7, "machinator"), 9);
    thing.use();
    thing.detach(6);

    ThingAMaJig thing2(8, "Watchamacallit", 4);
    thing2.attach(new Widget(9, "vaccinator"), 3);
    ThingAMaJig thing3(thing2);
    thing = thing3;
    thing.use();

    Widget* thing4 = new ThingAMaJig(10, "ThatThing", 3);
    thing4->use();
    delete thing4;
}
