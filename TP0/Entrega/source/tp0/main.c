#include <stdio.h>
#include <getopt.h>
#include <stdlib.h>

#include "options_reader.h"
#include "program_options.h"
#include "file_reader.h"

int main (int argc, char **argv)
{
  ProgramOptions options = parseOptions(argc, argv);

  /* Si se ejecuta sin parámetros ni opciones */
  if (argc == 1 || options.help == 1)
  {
    printHelp(options);
  }
  else if(options.error)
  {
    printHelp(options); /* código de salida 1 */
    exit(1);
  }
  else
  {
//  printf("help: %d\n", options.help);
//  printf("JoinBlankLines: %d\n", options.joinBlankLines);
//  printf("LineIncrement: %d\n", options.lineIncrement);
//  printf("NonEmpty: %d\n", options.nonEmpty);
//  printf("NumberSeparator: %s\n", options.numberSeparator);
//  printf("StartingLineNumber: %d\n", options.startingLineNumber);
//  printf("NumberOfFiles: %d\n", options.numberOfFiles);
//  int i;
//  for (i = 0; i < options.numberOfFiles; i++)
//  {
//    printf ("File %d: %s\n", i, options.files[i]);
//  }

    readFiles(options);
  }

  freeOptions(options);
  exit(EXIT_SUCCESS);
}
