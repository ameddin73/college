#
# Created by gmakemake (Ubuntu Jul 25 2014) on Wed Mar 22 11:48:05 2017
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


CPP_FILES =	crap.cpp infomercial_main.cpp schticky.cpp shamwow.cpp slapchop.cpp
C_FILES =	
PS_FILES =	
S_FILES =	
H_FILES =	crap.h schticky.h shamwow.h slapchop.h
SOURCEFILES =	$(H_FILES) $(CPP_FILES) $(C_FILES) $(S_FILES)
.PRECIOUS:	$(SOURCEFILES)
OBJFILES =	crap.o schticky.o shamwow.o slapchop.o 

#
# Main targets
#

all:	infomercial_main 

infomercial_main:	infomercial_main.o $(OBJFILES)
	$(CXX) $(CXXFLAGS) -o infomercial_main infomercial_main.o $(OBJFILES) $(CCLIBFLAGS)

#
# Dependencies
#

crap.o:	crap.h
infomercial_main.o:	crap.h schticky.h shamwow.h slapchop.h
schticky.o:	crap.h schticky.h
shamwow.o:	crap.h shamwow.h
slapchop.o:	crap.h slapchop.h

#
# Housekeeping
#

Archive:	archive.tgz

archive.tgz:	$(SOURCEFILES) Makefile
	tar cf - $(SOURCEFILES) Makefile | gzip > archive.tgz

clean:
	-/bin/rm -f $(OBJFILES) infomercial_main.o core

realclean:        clean
	-/bin/rm -f infomercial_main 
