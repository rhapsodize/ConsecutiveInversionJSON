CC=g++
DEV=-Wall -g -std=c++14
OPT=-O3 -std=c++14

JSON=json.hpp

SORTING_HEADERS=$(SORTING_SOURCES:.cpp=.h)
SORTING_DEV_OBJ=$(SORTING_SOURCES:.cpp=.o)
SORTING_OPT_OBJ=$(SORTING_SOURCES:.cpp=.o3)

EXPERIMENT_EXE_SOURCES=timealgorithms.cxx
EXPERIMENT_EXE=$(EXPERIMENT_EXE_SOURCES:.cxx=.exe)

VERIFICATION_EXE_SOURCES=createdata.cxx sortedverification.cxx 
VERIFICATION_EXE=$(VERIFICATION_EXE_SOURCES:.cxx=.exe)

.PHONY: all
all: sorting_lib $(EXPERIMENT_EXE) $(VERIFICATION_EXE)

# Sorting library
.PHONY: $(SORTING_LIB)
sorting_lib: $(SORTING_DEV_OBJ) $(SORTING_OPT_OBJ)

$(SORTING_DEV_OBJ): %.o: %.cpp %.h
	$(CC) $(DEV) -c $< -o $@

$(SORTING_OPT_OBJ): %.o3: %.cpp %.h
	$(CC) $(OPT) -c $< -o $@

# Executables
$(EXPERIMENT_EXE): %.exe: %.cxx $(SORTING_OPT_OBJ)
	$(CC) $(OPT) $^ -o $@

$(VERIFICATION_EXE): %.exe: %.cxx $(JSON)
	$(CC) $(DEV) -o $@ $<

# Build
.PHONY: clean
clean:
	rm -f *.o
	rm -f *.o3
	rm -f *.exe
	rm -rf *.exe.dSYM

.PHONY: update
update:
	make clean
	make all