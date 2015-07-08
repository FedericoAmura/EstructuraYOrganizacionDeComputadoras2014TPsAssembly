#ifndef _validate_C
#define _validate_C

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "findTag.h"

int validate(char *text, char **errmsg)
{
    int lineNumber = 0;
    char* tags[1024]; /*MAXTAGS 1024*/
    int startIndex = 0;
    int lastPosition = 0;
    int tagCount = 0;

    int result = findTag(text, startIndex, &lastPosition, tags, &tagCount, &lineNumber, errmsg);

    int i;
    for(i = 0; i < tagCount; i++)
    {
        free(tags[i]);
    }

    return result;
}

#endif
