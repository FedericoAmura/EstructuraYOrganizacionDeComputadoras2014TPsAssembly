/******************************************************************
** Organización de computadoras - 66.20
** Trabajo Práctico 1 - ...
** @Author:
**           Daddario, Rubén
**           Amura, Federico
*******************************************************************/
#ifndef _FILE_READER_C
#define _FILE_READER_C

#include "file_reader.h"

char *AddStr(char *StrObj1,char *StrObj2)
{
    void * ptr;
    ptr = realloc(StrObj1,(strlen(StrObj1) + strlen(StrObj2) + 1));
    if (ptr == NULL)
        return(StrObj1);
    StrObj1 = ptr;
    strcat(StrObj1, StrObj2);
    return(StrObj1);
}

int readFile(ProgramOptions options, FILE * fp)
{
   /*const int maxLineSize = 1024;*/
   char line[1024];
   char * fullText = NULL;
   char * errors[10]; /*MAX ERRORS*/
   int result = 0;

   if ((fullText = malloc(1)) != NULL)
        fullText[0] = '\0';

   while(fgets(line, sizeof(line), fp) != NULL)
   {
       fullText = AddStr(fullText, line);
   }

   result = validate(fullText, errors);
   if(result == 0)
   {
        printf("Archivo valido\n");
   }
   else
   {
        printf("%s\n", errors[0]);
   }

   printf("%s", fullText);
   free(fullText);

   return result;
}

int readFiles(ProgramOptions options)
{
    int i;
    int result = 0;

    if(options.input != NULL && strcmp(options.input, "-") == 0)
    {
       result = readFile(options, stdin);
    }
    else
    {
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
    }

    return result;
}

#endif
