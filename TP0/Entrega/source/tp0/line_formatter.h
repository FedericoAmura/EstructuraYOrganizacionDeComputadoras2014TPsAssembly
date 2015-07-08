#ifndef _LINE_FORMATTER_H
#define _LINE_FORMATTER_H

#include "program_options.h"

void formatLine(ProgramOptions options, char *line, int lineNumber, int lineLength);
int isLineEmpty(char* line, int lineLength);
int shouldFormat(ProgramOptions options, char *line, int lineLength);
void printUnformatted(char* line);

#endif
