#ifndef _OPTIONS_READER_C
#define _OPTIONS_READER_C

#include <stdio.h>
#include <getopt.h>
#include <stdlib.h>
#include <string.h>
#include "options_reader.h"

int startsWith(const char *a, const char *b)
{
   if(strncmp(a, b, strlen(b)) == 0) return 1;
   return 0;
};

char* ignoreEquals(char* option)
{
   if(startsWith(option, "="))
   {
       return ++option;
   }

   return option;
};

ProgramOptions parseOptions(int argc, char **argv)
{
    int nextOption;

    ProgramOptions options;
    options.nonEmpty = 0;
    options.numberSeparator = ".";
    options.startingLineNumber = 0;
    options.lineIncrement = 1;
    options.joinBlankLines = 1;
    options.help = 0;
    options.programName = argv[0];
    options.error = 0;
    options.numberOfFiles = 0;
    options.files = NULL;

    while (1)
    {
      /* Llamamos a la función getopt */
      nextOption = getopt_long (argc, argv, shortOptions, longOptions, NULL);

      if (nextOption == -1)
          break; /* No hay más opciones.*/

      switch (nextOption)
      {
          case 'h' :
              options.help = 1;
              break;

          case 't' :
              options.nonEmpty = 1 ;
              break;

          case 's' :
              options.numberSeparator = ignoreEquals(optarg);
              break;

          case 'v' :
              options.startingLineNumber = atoi(optarg);
              break;

          case 'i' :
              options.lineIncrement = atoi(optarg);
              break;

          case 'l' :
              options.joinBlankLines = atoi(optarg);
              break;

          case '?' : /* opción no valida */
              options.error = 1;
              break;

          case -1 : /* No hay más opciones */
              break;

          default : /* Algo más? No esperado.*/
              abort();
      }
    }

    //"Elementos de ARGV que no son opciones"
    if (optind < argc) //Hay uno o mas nombres de archivo
    {
        int fileIndex = 0;
        options.numberOfFiles = argc - optind;
        options.files = (char**)malloc(options.numberOfFiles*sizeof(char*));
        while (optind < argc){
          options.files[fileIndex] = argv[optind++];
          fileIndex++;
        }
    }

    return options;
}

#endif
