#ifndef _MACHINE__TYPES_H
#define _MACHINE__TYPES_H

#include <machine/_default_types.h>

/* Use 64bit types */
typedef __int64_t _off_t;
#define __machine_off_t_defined

typedef __int64_t _fpos_t;
#define __machine_fpos_t_defined

typedef __uint32_t __ino_t;
#define __machine_ino_t_defined

typedef __uint32_t __dev_t;
#define __machine_dev_t_defined
#endif

