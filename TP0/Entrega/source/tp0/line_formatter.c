#ifndef _LINE_FORMATTER_C
#define _LINE_FORMATTER_C

#include "line_formatter.h"

int isLineEmpty(char* line, int lineLength)
{
    //Mejorar este metodo;
    return lineLength <= 1; //Only '/n' was read
}

int shouldFormat(ProgramOptions options, char *line, int lineLength)
{
    return !(options.nonEmpty && isLineEmpty(line, lineLength));
}

void formatLine(ProgramOptions options, char *line, int lineNumber, int lineLength)
{
    printf("%d%s%s", lineNumber, options.numberSeparator, line);
}

void printUnformatted(char* line)
{
    printf("%s", line);
}


#endif
