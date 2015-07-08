#ifndef _findTag_H
#define _findTag_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTag(const char* text, int startIndex, int* lastPosition, char** tags, int* tagCount, int *lineNumber, char** errmsg);

#endif
