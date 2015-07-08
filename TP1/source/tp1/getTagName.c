#ifndef _getTagName_C
#define _getTagName_C

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "isOpenTag.h"

char* getTagName(char* tag)
{
    char* tagName = NULL;
    int nameLength = strlen(tag) - 2;
    int nameStart = 1;
    if(isOpenTag(tag) == 0)
    {
        nameLength = strlen(tag) - 3;
        nameStart = 2;
    }

    tagName = (char*) malloc(nameLength+1);
    strncpy(tagName, tag+nameStart, nameLength);
    tagName[nameLength] = '\0';

    return tagName;
}

#endif
