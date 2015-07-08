/******************************************************************
** Organización de computadoras - 66.20
** Trabajo Práctico 1 - ...
** @Author:
**           Daddario, Rubén
**           Amura, Federico
*******************************************************************/
#ifndef _PROGRAM_OPTIONS_C
#define _PROGRAM_OPTIONS_C

#include "program_options.h"

void printHelp(ProgramOptions options)
{
    printf("Uso: %s opciones [ argumentos ...]\n", options.programName);
    printf("-h, --help     Prints usage information.\n");
    printf("-V, --version  Prints version information.\n");
    printf("-i, --input    Path to input file (-i - for stdin)\n");
}

void freeOptions(ProgramOptions options)
{
    if(options.files != NULL)
    {
        free(options.files);
    }
}

#endif
