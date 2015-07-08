/******************************************************************
** Organización de computadoras - 66.20
** Trabajo Práctico 1 - Conjunto de instrucciones MIPS
** @Author:
**           Daddario, Rubén
**           Amura, Federico
*******************************************************************/
#include <stdio.h>
#include <stdlib.h>

#include "options_reader.h"
#include "program_options.h"
#include "file_reader.h"

int main (int argc, char **argv)
{
    ProgramOptions options = parseOptions(argc, argv);
    int result = EXIT_SUCCESS;

    /* Si se ejecuta sin parámetros ni opciones */
    if (argc == 1 || options.help == 1)
    {
        printHelp(options);
    }
    else if(options.version)
    {
        printf("Version 1.0\n");
    }
    else if(options.error)
    {
        printHelp(options); /* código de salida 1 */
        result = 1;
    }
    else
    {
        result = readFiles(options);
    }

    freeOptions(options);
    exit(result);
}

