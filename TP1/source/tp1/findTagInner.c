#ifndef _findTagInner_C
#define _findTagInner_C

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findTagInner(const char* text, const int startIndex, int* lastPosition, int* lineNumber)
{
    int currentPosition = startIndex;
    int found = 0;
    int textLength = strlen(text);
    int tagStartPosition = -1;
    char* tagName;

    while(currentPosition < textLength && !found)
    {
        if(text[currentPosition] == '<')
        {
            tagStartPosition = currentPosition;
        }

        if(text[currentPosition] == '\n')
        {
            (*lineNumber)++;
        }

        if(text[currentPosition] == '>')
        {
            int totalLength = currentPosition - tagStartPosition + 1;
            found = 1;
            tagName = (char*) malloc(totalLength+1);
            strncpy(tagName, text+tagStartPosition, totalLength);
            tagName[totalLength] = '\0';
        }

        currentPosition++;
    }

    if(found == 1){
        *lastPosition = currentPosition;
        return tagName;
    }
    else
    {
        lastPosition = 0;
        return NULL;
    }
}

#endif
