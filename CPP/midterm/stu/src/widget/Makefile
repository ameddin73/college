#
# Created by gmakemake (Ubuntu Jul 25 2014) on Sun Mar 19 17:28:10 2017
#

#
# Definitions
#

.SUFFIXES:
.SUFFIXES:	.a .o .c .C .cpp .s .S
.c.o:
		$(COMPILE.c) $<
.C.o:
		$(COMPILE.cc) $<
.cpp.o:
		$(COMPILE.cc) $<
.S.s:
		$(CPP) -o $*.s $<
.s.o:
		$(COMPILE.cc) $<
.c.a:
		$(COMPILE.c) -o $% $<
		$(AR) $(ARFLAGS) $@ $%
		$(RM) $%
.C.a:
		$(COMPILE.cc) -o $% $<
		$(AR) $(ARFLAGS) $@ $%
		$(RM) $%
.cpp.a:
		$(COMPILE.cc) -o $% $<
		$(AR) $(ARFLAGS) $@ $%
		$(RM) $%

CC =		gcc
CXX =		g++

RM = rm -f
AR = ar
LINK.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
LINK.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
COMPILE.c = $(CC) $(CFLAGS) $(CPPFLAGS) -c
COMPILE.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) -c
CPP = $(CPP) $(CPPFLAGS)
########## Flags from header.mak

CXXFLAGS = -g -gdwarf-2 -Wall -Wextra -Weffc++ -pedantic -std=c++98

########## End of flags from header.mak


CPP_FILES =	thingamajig.cpp widget.cpp widget_main.cpp
C_FILES =	
PS_FILES =	
S_FILES =	
H_FILES =	thingamajig.h widget.h
SOURCEFILES =	$(H_FILES) $(CPP_FILES) $(C_FILES) $(S_FILES)
.PRECIOUS:	$(SOURCEFILES)
OBJFILES =	thingamajig.o widget.o 

#
# Main targets
#

all:	widget_main 

widget_main:	widget_main.o $(OBJFILES)
	$(CXX) $(CXXFLAGS) -o widget_main widget_main.o $(OBJFILES) $(CCLIBFLAGS)

#
# Dependencies
#

thingamajig.o:	thingamajig.h widget.h
widget.o:	widget.h
widget_main.o:	thingamajig.h widget.h

#
# Housekeeping
#

Archive:	archive.tgz

archive.tgz:	$(SOURCEFILES) Makefile
	tar cf - $(SOURCEFILES) Makefile | gzip > archive.tgz

clean:
	-/bin/rm -f $(OBJFILES) widget_main.o core

realclean:        clean
	-/bin/rm -f widget_main 
