#ifndef _OPTIONS_READER_H
#define _OPTIONS_READER_H

#include "program_options.h"

ProgramOptions parseOptions(int argc, char **argv);
char* ignoreEquals(char* option);
int startsWith(const char *a, const char *b);

#endif
