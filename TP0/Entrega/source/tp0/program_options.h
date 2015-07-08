#ifndef _PROGRAM_OPTIONS_H
#define _PROGRAM_OPTIONS_H

#include <stdio.h>
#include <getopt.h>
#include <stdlib.h>

/* Una cadena que lista las opciones cortas válidas */
const char* const shortOptions;

/* Una estructura de varios arrays describiendo los valores largos */
const struct option longOptions[7];

typedef struct {
	int nonEmpty;
	char* numberSeparator;
	int startingLineNumber;
	int lineIncrement;
	int joinBlankLines;
	int help;
	char* programName;
	int error;
	char **files;
	int numberOfFiles;
} ProgramOptions;

void printHelp(ProgramOptions options);
void freeOptions(ProgramOptions options);

#endif
