/******************************************************************
** Organización de computadoras - 66.20
** Trabajo Práctico 1 - ...
** @Author:
**           Daddario, Rubén
**           Amura, Federico
*******************************************************************/
#ifndef _OPTIONS_READER_H
#define _OPTIONS_READER_H

#include "program_options.h"

ProgramOptions parseOptions(int argc, char **argv);
char* ignoreEquals(char* option);
int startsWith(const char *a, const char *b);

#endif
