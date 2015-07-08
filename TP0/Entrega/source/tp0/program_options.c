#ifndef _PROGRAM_OPTIONS_C
#define _PROGRAM_OPTIONS_C

#include "program_options.h"

/* Una cadena que lista las opciones cortas válidas */
const char* const shortOptions = "s:v:i:tl:h" ;

/* Una estructura de varios arrays describiendo los valores largos */
const struct option longOptions[] =
{
  { "number-separator",         1,  NULL,   's'},
  { "starting-line-number",     1,  NULL,   'v'},
  { "line-increment",           1,  NULL,   'i'},
  { "non-empty",                0,  NULL,   't'},
  { "join-blank-lines",         1,  NULL,   'l'},
  { "help",                     1,  NULL,   'h'},
  { NULL,                       0,  NULL,   0  }
};

void printHelp(ProgramOptions options)
{
    printf("Uso: %s opciones [ argumentos ...]\n", options.programName);
    printf("    -s, --number-separator. Indica el texto separador entre número de línea y la\n"
           "          línea.\n"
           "    -v, --starting-line-number. Indica el número de la primer línea.\n"
           "    -i, --line-increment. Indica el incremento entre líneas consecutivas.\n"
           "    -t, --non-empty. Si está presente, solo se deben numerar las líneas no\n"
           "          vacias. Caso contrario, también deben numerar las líneas vacias.\n"
           "    -l, --join-blank-lines. Indica la cantidad de líneas vacias a agrupar en una\n"
           "          unica línea.\n"
           "    -h, --help. Imprime el mensaje de ayuda.\n");
}

void freeOptions(ProgramOptions options)
{
    if(options.files != NULL)
    {
        free(options.files);
    }
}

#endif
