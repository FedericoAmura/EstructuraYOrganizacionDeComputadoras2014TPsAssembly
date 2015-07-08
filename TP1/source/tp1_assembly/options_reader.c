/******************************************************************
** Organizaci�n de computadoras - 66.20
** Trabajo Pr�ctico 1 - ...
** @Author:
**           Daddario, Rub�n
**           Amura, Federico
*******************************************************************/
#ifndef _OPTIONS_READER_C
#define _OPTIONS_READER_C

#include <stdio.h>
#include <getopt.h>
#include <stdlib.h>
#include <string.h>

#include "options_reader.h"


/* Una cadena que lista las opciones cortas v�lidas */
const char* const shortOptions = "hVi:" ;

/* Una estructura de varios arrays describiendo los valores largos */
const struct option longOptions[] =
{
  { "help",     0,  NULL,   'h'},
  { "version",  0,  NULL,   'v'},
  { "input",    1,  NULL,   'i'}, /*1=Argumento obligatorio; 2=Argumento opcional*/
  { NULL,       0,  NULL,   0  }
};

int startsWith(const char *a, const char *b)
{
   if(strncmp(a, b, strlen(b)) == 0) return 1;
   return 0;
}

char* ignoreEquals(char* option)
{
   if(startsWith(option, "="))
   {
       return ++option;
   }

   return option;
}

ProgramOptions parseOptions(int argc, char **argv)
{
    int nextOption;

    ProgramOptions options;
    options.error = 0;
    options.help = 0;
    options.programName = argv[0];
    options.numberOfFiles = 0;
    options.files = NULL;
    options.version = 0;
    options.input = "";

    while (1)
    {
      /* Llamamos a la funci�n getopt */
      nextOption = getopt_long (argc, argv, shortOptions, longOptions, NULL);

      if (nextOption == -1)
          break; /* No hay m�s opciones.*/

      switch (nextOption)
      {
          case 'h' :
              options.help = 1;
              break;

          case 'V' :
              options.version = 1;
              break;

          case 'i' :
              options.input = optarg;
              break;

          case '?' : /* opci�n no valida */
              options.error = 1;
              break;

          case -1 : /* No hay m�s opciones */
              break;

          default : /* Algo m�s? No esperado.*/
              abort();
      }
    }

    /*"Elementos de ARGV que no son opciones"*/
    if (optind < argc) /*Hay uno o mas nombres de archivo*/
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
