/******************************************************************
** Organización de computadoras - 66.20
** Trabajo Práctico 1 - ...
** @Author:
**           Daddario, Rubén
**           Amura, Federico
*******************************************************************/
#ifndef _PROGRAM_OPTIONS_H
#define _PROGRAM_OPTIONS_H

#include <stdio.h>
#include <getopt.h>
#include <stdlib.h>

typedef struct {
    int error;
	int help;
	int version;
	char* input;
	char* programName;
	char **files;
	int numberOfFiles;
} ProgramOptions;

void printHelp(ProgramOptions options);
void freeOptions(ProgramOptions options);

#endif
