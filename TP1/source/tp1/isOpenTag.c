#ifndef _isOpenTag_C
#define _isOpenTag_C

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isOpenTag(char* tag)
{
    if(tag[1] == '/') /* Caso: </ */
    {
        return 0;
    }

    return 1;
}

#endif
