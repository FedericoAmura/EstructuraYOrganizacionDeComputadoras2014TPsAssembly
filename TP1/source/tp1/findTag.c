#ifndef _findTag_C
#define _findTag_C

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "findTagInner.h"
#include "isOpenTag.h"
#include "getTagName.h"

#define ERROR_INVALID_CLOSING_TAG 1
#define SUCCESS 0

int findTag(const char* text, int startIndex, int* lastPosition, char** tags, int* tagCount, int *lineNumber, char** errmsg)
{
    int result = SUCCESS;
    char* currentTag = findTagInner(text, startIndex, lastPosition, lineNumber);

    if(currentTag != NULL)
    {
        int isOpening = isOpenTag(currentTag);

        if(isOpening == 1)
        {
            /*Enqueue*/
            int tagLength = strlen(currentTag);
            tags[(*tagCount)] = (char*)malloc(tagLength + 1);
            strcpy(tags[(*tagCount)], currentTag);
            (*tagCount)++;
        }
        else
        {
            /*Dequeue*/
            char* lastOpenTag = tags[(*tagCount) - 1];

            char* openTagName = getTagName(lastOpenTag);
            char* closeTagName = getTagName(currentTag);
            if(strcmp(openTagName, closeTagName) != 0)
            {
               char msgBuffer[255];
               result = ERROR_INVALID_CLOSING_TAG;
               sprintf(msgBuffer, "Error en linea %d: %s cerrado antes que %s", *lineNumber, closeTagName, openTagName);
               errmsg[0] = msgBuffer;
            }

            free(tags[(*tagCount) - 1]);
            (*tagCount)--;

            free(openTagName);
            free(closeTagName);
        }

        if(result == SUCCESS)
        {
            result = findTag(text, *lastPosition, lastPosition, tags, tagCount, lineNumber, errmsg);
        }

    }


    free(currentTag);

    return result;
}

#endif
