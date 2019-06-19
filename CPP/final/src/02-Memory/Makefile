#
# Created by gmakemake (Ubuntu Jul 25 2014) on Fri May  4 20:22:53 2018
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

CXXFLAGS = -g -gdwarf-2 -Wall -Wextra -Weffc++ -pedantic -std=c++17

########## End of flags from header.mak


CPP_FILES =	memory.cpp thing.cpp widget.cpp
C_FILES =	
PS_FILES =	
S_FILES =	
H_FILES =	thing.h widget.h
SOURCEFILES =	$(H_FILES) $(CPP_FILES) $(C_FILES) $(S_FILES)
.PRECIOUS:	$(SOURCEFILES)
OBJFILES =	thing.o widget.o 

#
# Main targets
#

all:	memory 

memory:	memory.o $(OBJFILES)
	$(CXX) $(CXXFLAGS) -o memory memory.o $(OBJFILES) $(CCLIBFLAGS)

#
# Dependencies
#

memory.o:	thing.h widget.h
thing.o:	thing.h
widget.o:	thing.h widget.h

#
# Housekeeping
#

Archive:	archive.tgz

archive.tgz:	$(SOURCEFILES) Makefile
	tar cf - $(SOURCEFILES) Makefile | gzip > archive.tgz

clean:
	-/bin/rm -f $(OBJFILES) memory.o core

realclean:        clean
	-/bin/rm -f memory 
