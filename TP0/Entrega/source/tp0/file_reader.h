#ifndef _FILE_READER_H
#define _FILE_READER_H

#include <stdio.h>
#include <stdlib.h>
#include "program_options.h"
#include "line_formatter.h"

int printLine(ProgramOptions options, char* line, int lineLength, int currentLineNumber);
int blankLinesToPrint(ProgramOptions options, int blankLines);
int readFiles(ProgramOptions options);
int readFile(ProgramOptions options, FILE * fp);

#endif
