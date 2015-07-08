/******************************************************************
** Organización de computadoras - 66.20
** Trabajo Práctico 1 - ...
** @Author:
**           Daddario, Rubén
**           Amura, Federico
*******************************************************************/
#ifndef _FILE_READER_H
#define _FILE_READER_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "program_options.h"
#include "isOpenTag.h"
#include "findTagInner.h"
#include "getTagName.h"
#include "findTag.h"
#include "validate.h"

int readFiles(ProgramOptions options);
int readFile(ProgramOptions options, FILE * fp);

#endif
