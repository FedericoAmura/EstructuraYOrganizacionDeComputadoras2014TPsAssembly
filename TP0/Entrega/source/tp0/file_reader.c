#define _GNU_SOURCE
#ifndef _FILE_READER_C
#define _FILE_READER_C

//#include <getline.h>
#include "file_reader.h"

int blankLinesToPrint(ProgramOptions options, int blankLines)
{
    int joinBlankLines = options.joinBlankLines = 0 ? 1 : options.joinBlankLines;
    return blankLines / joinBlankLines + blankLines % joinBlankLines;
}

int printLine(ProgramOptions options, char* line, int lineLength, int currentLineNumber)
{
   int formatted = 0;
   if(shouldFormat(options, line, lineLength))
   {
       formatLine(options, line, currentLineNumber, lineLength);
       formatted = 1;
   }
   else
   {
       printUnformatted(line);
   }

   return formatted;
}

int readFile(ProgramOptions options, FILE * fp)
{
   char * line = NULL;
   size_t len = 0;
   ssize_t read;

   int currentLineNumber = options.startingLineNumber;
   int blankLineCounter = 0;
   while ((read = getline(&line, &len, fp)) != -1)
   {
       if(isLineEmpty(line, read))
       {
           blankLineCounter++;
       }
       else
       {
            int blankLinesToPrintCount = blankLinesToPrint(options, blankLineCounter);
            blankLineCounter = 0;
            int i;
            int formatted = 0;
            for(i = 0; i < blankLinesToPrintCount; i++)
            {
               formatted = printLine(options, "\n", 0, currentLineNumber);
               if(formatted)
               {
                currentLineNumber = currentLineNumber + options.lineIncrement;
               }
            }

            formatted = printLine(options, line, read, currentLineNumber);
            if(formatted)
            {
               currentLineNumber = currentLineNumber + options.lineIncrement;
            }
       }
   }


   free(line);

   return 0;
}

int readFiles(ProgramOptions options)
{
  int i;
  int result = 0;

  if(options.numberOfFiles > 0)
  {
      for (i = 0; i < options.numberOfFiles; i++)
      {
           FILE * fp;

           fp = fopen(options.files[i], "r");
           if (fp == NULL)
           {
               fprintf(stderr, "Error abriendo archivo %s\n", options.files[i]);
               return 1;
           }

           result = readFile(options, fp);
           fclose(fp);
      }
  }
  else
  {
      result = readFile(options, stdin);
  }

  return result;
}

#endif
