/* -*- buffer-read-only: t -*-
 *
 *    opnames.h
 *
 *    Copyright (C) 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007,
 *    2008 by Larry Wall and others
 *
 *    You may distribute under the terms of either the GNU General Public
 *    License or the Artistic License, as specified in the README file.
 *
 * !!!!!!!   DO NOT EDIT THIS FILE   !!!!!!!
 * This file is built by regen/opcode.pl from its data.
 * Any changes made here will be lost!
 */

typedef enum opcode {
	OP_NULL		 = 0,
	OP_STUB		 = 1,
	OP_SCALAR	 = 2,
	OP_PUSHMARK	 = 3,
	OP_WANTARRAY	 = 4,
	OP_CONST	 = 5,
	OP_GVSV		 = 6,
	OP_GV		 = 7,
	OP_GELEM	 = 8,
	OP_PADSV	 = 9,
	OP_PADAV	 = 10,
	OP_PADHV	 = 11,
	OP_PADANY	 = 12,
	OP_RV2GV	 = 13,
	OP_RV2SV	 = 14,
	OP_AV2ARYLEN	 = 15,
	OP_RV2CV	 = 16,
	OP_ANONCODE	 = 17,
	OP_PROTOTYPE	 = 18,
	OP_REFGEN	 = 19,
	OP_SREFGEN	 = 20,
	OP_REF		 = 21,
	OP_BLESS	 = 22,
	OP_BACKTICK	 = 23,
	OP_GLOB		 = 24,
	OP_READLINE	 = 25,
	OP_RCATLINE	 = 26,
	OP_REGCMAYBE	 = 27,
	OP_REGCRESET	 = 28,
	OP_REGCOMP	 = 29,
	OP_MATCH	 = 30,
	OP_QR		 = 31,
	OP_SUBST	 = 32,
	OP_SUBSTCONT	 = 33,
	OP_TRANS	 = 34,
	OP_TRANSR	 = 35,
	OP_SASSIGN	 = 36,
	OP_AASSIGN	 = 37,
	OP_CHOP		 = 38,
	OP_SCHOP	 = 39,
	OP_CHOMP	 = 40,
	OP_SCHOMP	 = 41,
	OP_DEFINED	 = 42,
	OP_UNDEF	 = 43,
	OP_STUDY	 = 44,
	OP_POS		 = 45,
	OP_PREINC	 = 46,
	OP_I_PREINC	 = 47,
	OP_PREDEC	 = 48,
	OP_I_PREDEC	 = 49,
	OP_POSTINC	 = 50,
	OP_I_POSTINC	 = 51,
	OP_POSTDEC	 = 52,
	OP_I_POSTDEC	 = 53,
	OP_POW		 = 54,
	OP_MULTIPLY	 = 55,
	OP_I_MULTIPLY	 = 56,
	OP_DIVIDE	 = 57,
	OP_I_DIVIDE	 = 58,
	OP_MODULO	 = 59,
	OP_I_MODULO	 = 60,
	OP_REPEAT	 = 61,
	OP_ADD		 = 62,
	OP_I_ADD	 = 63,
	OP_SUBTRACT	 = 64,
	OP_I_SUBTRACT	 = 65,
	OP_CONCAT	 = 66,
	OP_MULTICONCAT	 = 67,
	OP_STRINGIFY	 = 68,
	OP_LEFT_SHIFT	 = 69,
	OP_RIGHT_SHIFT	 = 70,
	OP_LT		 = 71,
	OP_I_LT		 = 72,
	OP_GT		 = 73,
	OP_I_GT		 = 74,
	OP_LE		 = 75,
	OP_I_LE		 = 76,
	OP_GE		 = 77,
	OP_I_GE		 = 78,
	OP_EQ		 = 79,
	OP_I_EQ		 = 80,
	OP_NE		 = 81,
	OP_I_NE		 = 82,
	OP_NCMP		 = 83,
	OP_I_NCMP	 = 84,
	OP_SLT		 = 85,
	OP_SGT		 = 86,
	OP_SLE		 = 87,
	OP_SGE		 = 88,
	OP_SEQ		 = 89,
	OP_SNE		 = 90,
	OP_SCMP		 = 91,
	OP_BIT_AND	 = 92,
	OP_BIT_XOR	 = 93,
	OP_BIT_OR	 = 94,
	OP_NBIT_AND	 = 95,
	OP_NBIT_XOR	 = 96,
	OP_NBIT_OR	 = 97,
	OP_SBIT_AND	 = 98,
	OP_SBIT_XOR	 = 99,
	OP_SBIT_OR	 = 100,
	OP_NEGATE	 = 101,
	OP_I_NEGATE	 = 102,
	OP_NOT		 = 103,
	OP_COMPLEMENT	 = 104,
	OP_NCOMPLEMENT	 = 105,
	OP_SCOMPLEMENT	 = 106,
	OP_SMARTMATCH	 = 107,
	OP_ATAN2	 = 108,
	OP_SIN		 = 109,
	OP_COS		 = 110,
	OP_RAND		 = 111,
	OP_SRAND	 = 112,
	OP_EXP		 = 113,
	OP_LOG		 = 114,
	OP_SQRT		 = 115,
	OP_INT		 = 116,
	OP_HEX		 = 117,
	OP_OCT		 = 118,
	OP_ABS		 = 119,
	OP_LENGTH	 = 120,
	OP_SUBSTR	 = 121,
	OP_VEC		 = 122,
	OP_INDEX	 = 123,
	OP_RINDEX	 = 124,
	OP_SPRINTF	 = 125,
	OP_FORMLINE	 = 126,
	OP_ORD		 = 127,
	OP_CHR		 = 128,
	OP_CRYPT	 = 129,
	OP_UCFIRST	 = 130,
	OP_LCFIRST	 = 131,
	OP_UC		 = 132,
	OP_LC		 = 133,
	OP_QUOTEMETA	 = 134,
	OP_RV2AV	 = 135,
	OP_AELEMFAST	 = 136,
	OP_AELEMFAST_LEX = 137,
	OP_AELEM	 = 138,
	OP_ASLICE	 = 139,
	OP_KVASLICE	 = 140,
	OP_AEACH	 = 141,
	OP_AVALUES	 = 142,
	OP_AKEYS	 = 143,
	OP_EACH		 = 144,
	OP_VALUES	 = 145,
	OP_KEYS		 = 146,
	OP_DELETE	 = 147,
	OP_EXISTS	 = 148,
	OP_RV2HV	 = 149,
	OP_HELEM	 = 150,
	OP_HSLICE	 = 151,
	OP_KVHSLICE	 = 152,
	OP_MULTIDEREF	 = 153,
	OP_UNPACK	 = 154,
	OP_PACK		 = 155,
	OP_SPLIT	 = 156,
	OP_JOIN		 = 157,
	OP_LIST		 = 158,
	OP_LSLICE	 = 159,
	OP_ANONLIST	 = 160,
	OP_ANONHASH	 = 161,
	OP_SPLICE	 = 162,
	OP_PUSH		 = 163,
	OP_POP		 = 164,
	OP_SHIFT	 = 165,
	OP_UNSHIFT	 = 166,
	OP_SORT		 = 167,
	OP_REVERSE	 = 168,
	OP_GREPSTART	 = 169,
	OP_GREPWHILE	 = 170,
	OP_MAPSTART	 = 171,
	OP_MAPWHILE	 = 172,
	OP_RANGE	 = 173,
	OP_FLIP		 = 174,
	OP_FLOP		 = 175,
	OP_AND		 = 176,
	OP_OR		 = 177,
	OP_XOR		 = 178,
	OP_DOR		 = 179,
	OP_COND_EXPR	 = 180,
	OP_ANDASSIGN	 = 181,
	OP_ORASSIGN	 = 182,
	OP_DORASSIGN	 = 183,
	OP_ENTERSUB	 = 184,
	OP_LEAVESUB	 = 185,
	OP_LEAVESUBLV	 = 186,
	OP_ARGCHECK	 = 187,
	OP_ARGELEM	 = 188,
	OP_ARGDEFELEM	 = 189,
	OP_CALLER	 = 190,
	OP_WARN		 = 191,
	OP_DIE		 = 192,
	OP_RESET	 = 193,
	OP_LINESEQ	 = 194,
	OP_NEXTSTATE	 = 195,
	OP_DBSTATE	 = 196,
	OP_UNSTACK	 = 197,
	OP_ENTER	 = 198,
	OP_LEAVE	 = 199,
	OP_SCOPE	 = 200,
	OP_ENTERITER	 = 201,
	OP_ITER		 = 202,
	OP_ENTERLOOP	 = 203,
	OP_LEAVELOOP	 = 204,
	OP_RETURN	 = 205,
	OP_LAST		 = 206,
	OP_NEXT		 = 207,
	OP_REDO		 = 208,
	OP_DUMP		 = 209,
	OP_GOTO		 = 210,
	OP_EXIT		 = 211,
	OP_METHOD	 = 212,
	OP_METHOD_NAMED	 = 213,
	OP_METHOD_SUPER	 = 214,
	OP_METHOD_REDIR	 = 215,
	OP_METHOD_REDIR_SUPER = 216,
	OP_ENTERGIVEN	 = 217,
	OP_LEAVEGIVEN	 = 218,
	OP_ENTERWHEN	 = 219,
	OP_LEAVEWHEN	 = 220,
	OP_BREAK	 = 221,
	OP_CONTINUE	 = 222,
	OP_OPEN		 = 223,
	OP_CLOSE	 = 224,
	OP_PIPE_OP	 = 225,
	OP_FILENO	 = 226,
	OP_UMASK	 = 227,
	OP_BINMODE	 = 228,
	OP_TIE		 = 229,
	OP_UNTIE	 = 230,
	OP_TIED		 = 231,
	OP_DBMOPEN	 = 232,
	OP_DBMCLOSE	 = 233,
	OP_SSELECT	 = 234,
	OP_SELECT	 = 235,
	OP_GETC		 = 236,
	OP_READ		 = 237,
	OP_ENTERWRITE	 = 238,
	OP_LEAVEWRITE	 = 239,
	OP_PRTF		 = 240,
	OP_PRINT	 = 241,
	OP_SAY		 = 242,
	OP_SYSOPEN	 = 243,
	OP_SYSSEEK	 = 244,
	OP_SYSREAD	 = 245,
	OP_SYSWRITE	 = 246,
	OP_EOF		 = 247,
	OP_TELL		 = 248,
	OP_SEEK		 = 249,
	OP_TRUNCATE	 = 250,
	OP_FCNTL	 = 251,
	OP_IOCTL	 = 252,
	OP_FLOCK	 = 253,
	OP_SEND		 = 254,
	OP_RECV		 = 255,
	OP_SOCKET	 = 256,
	OP_SOCKPAIR	 = 257,
	OP_BIND		 = 258,
	OP_CONNECT	 = 259,
	OP_LISTEN	 = 260,
	OP_ACCEPT	 = 261,
	OP_SHUTDOWN	 = 262,
	OP_GSOCKOPT	 = 263,
	OP_SSOCKOPT	 = 264,
	OP_GETSOCKNAME	 = 265,
	OP_GETPEERNAME	 = 266,
	OP_LSTAT	 = 267,
	OP_STAT		 = 268,
	OP_FTRREAD	 = 269,
	OP_FTRWRITE	 = 270,
	OP_FTREXEC	 = 271,
	OP_FTEREAD	 = 272,
	OP_FTEWRITE	 = 273,
	OP_FTEEXEC	 = 274,
	OP_FTIS		 = 275,
	OP_FTSIZE	 = 276,
	OP_FTMTIME	 = 277,
	OP_FTATIME	 = 278,
	OP_FTCTIME	 = 279,
	OP_FTROWNED	 = 280,
	OP_FTEOWNED	 = 281,
	OP_FTZERO	 = 282,
	OP_FTSOCK	 = 283,
	OP_FTCHR	 = 284,
	OP_FTBLK	 = 285,
	OP_FTFILE	 = 286,
	OP_FTDIR	 = 287,
	OP_FTPIPE	 = 288,
	OP_FTSUID	 = 289,
	OP_FTSGID	 = 290,
	OP_FTSVTX	 = 291,
	OP_FTLINK	 = 292,
	OP_FTTTY	 = 293,
	OP_FTTEXT	 = 294,
	OP_FTBINARY	 = 295,
	OP_CHDIR	 = 296,
	OP_CHOWN	 = 297,
	OP_CHROOT	 = 298,
	OP_UNLINK	 = 299,
	OP_CHMOD	 = 300,
	OP_UTIME	 = 301,
	OP_RENAME	 = 302,
	OP_LINK		 = 303,
	OP_SYMLINK	 = 304,
	OP_READLINK	 = 305,
	OP_MKDIR	 = 306,
	OP_RMDIR	 = 307,
	OP_OPEN_DIR	 = 308,
	OP_READDIR	 = 309,
	OP_TELLDIR	 = 310,
	OP_SEEKDIR	 = 311,
	OP_REWINDDIR	 = 312,
	OP_CLOSEDIR	 = 313,
	OP_FORK		 = 314,
	OP_WAIT		 = 315,
	OP_WAITPID	 = 316,
	OP_SYSTEM	 = 317,
	OP_EXEC		 = 318,
	OP_KILL		 = 319,
	OP_GETPPID	 = 320,
	OP_GETPGRP	 = 321,
	OP_SETPGRP	 = 322,
	OP_GETPRIORITY	 = 323,
	OP_SETPRIORITY	 = 324,
	OP_TIME		 = 325,
	OP_TMS		 = 326,
	OP_LOCALTIME	 = 327,
	OP_GMTIME	 = 328,
	OP_ALARM	 = 329,
	OP_SLEEP	 = 330,
	OP_SHMGET	 = 331,
	OP_SHMCTL	 = 332,
	OP_SHMREAD	 = 333,
	OP_SHMWRITE	 = 334,
	OP_MSGGET	 = 335,
	OP_MSGCTL	 = 336,
	OP_MSGSND	 = 337,
	OP_MSGRCV	 = 338,
	OP_SEMOP	 = 339,
	OP_SEMGET	 = 340,
	OP_SEMCTL	 = 341,
	OP_REQUIRE	 = 342,
	OP_DOFILE	 = 343,
	OP_HINTSEVAL	 = 344,
	OP_ENTEREVAL	 = 345,
	OP_LEAVEEVAL	 = 346,
	OP_ENTERTRY	 = 347,
	OP_LEAVETRY	 = 348,
	OP_GHBYNAME	 = 349,
	OP_GHBYADDR	 = 350,
	OP_GHOSTENT	 = 351,
	OP_GNBYNAME	 = 352,
	OP_GNBYADDR	 = 353,
	OP_GNETENT	 = 354,
	OP_GPBYNAME	 = 355,
	OP_GPBYNUMBER	 = 356,
	OP_GPROTOENT	 = 357,
	OP_GSBYNAME	 = 358,
	OP_GSBYPORT	 = 359,
	OP_GSERVENT	 = 360,
	OP_SHOSTENT	 = 361,
	OP_SNETENT	 = 362,
	OP_SPROTOENT	 = 363,
	OP_SSERVENT	 = 364,
	OP_EHOSTENT	 = 365,
	OP_ENETENT	 = 366,
	OP_EPROTOENT	 = 367,
	OP_ESERVENT	 = 368,
	OP_GPWNAM	 = 369,
	OP_GPWUID	 = 370,
	OP_GPWENT	 = 371,
	OP_SPWENT	 = 372,
	OP_EPWENT	 = 373,
	OP_GGRNAM	 = 374,
	OP_GGRGID	 = 375,
	OP_GGRENT	 = 376,
	OP_SGRENT	 = 377,
	OP_EGRENT	 = 378,
	OP_GETLOGIN	 = 379,
	OP_SYSCALL	 = 380,
	OP_LOCK		 = 381,
	OP_ONCE		 = 382,
	OP_CUSTOM	 = 383,
	OP_COREARGS	 = 384,
	OP_AVHVSWITCH	 = 385,
	OP_RUNCV	 = 386,
	OP_FC		 = 387,
	OP_PADCV	 = 388,
	OP_INTROCV	 = 389,
	OP_CLONECV	 = 390,
	OP_PADRANGE	 = 391,
	OP_REFASSIGN	 = 392,
	OP_LVREF	 = 393,
	OP_LVREFSLICE	 = 394,
	OP_LVAVREF	 = 395,
	OP_ANONCONST	 = 396,
	OP_ISA		 = 397,
	OP_CMPCHAIN_AND	 = 398,
	OP_CMPCHAIN_DUP	 = 399,
	OP_ENTERTRYCATCH = 400,
	OP_LEAVETRYCATCH = 401,
	OP_POPTRY	 = 402,
	OP_CATCH	 = 403,
	OP_PUSHDEFER	 = 404,
	OP_IS_BOOL	 = 405,
	OP_IS_WEAK	 = 406,
	OP_WEAKEN	 = 407,
	OP_UNWEAKEN	 = 408,
	OP_BLESSED	 = 409,
	OP_REFADDR	 = 410,
	OP_REFTYPE	 = 411,
	OP_CEIL		 = 412,
	OP_FLOOR	 = 413,
	OP_max		
} opcode;

#define MAXO 414
#define OP_FREED MAXO

/* the OP_IS_* macros are optimized to a simple range check because
    all the member OPs are contiguous in regen/opcodes table.
    opcode.pl verifies the range contiguity, or generates an OR-equals
    expression */

#define OP_IS_SOCKET(op)	\
	((op) >= OP_SEND && (op) <= OP_GETPEERNAME)

#define OP_IS_FILETEST(op)	\
	((op) >= OP_FTRREAD && (op) <= OP_FTBINARY)

#define OP_IS_FILETEST_ACCESS(op)	\
	((op) >= OP_FTRREAD && (op) <= OP_FTEEXEC)

#define OP_IS_NUMCOMPARE(op)	\
	((op) >= OP_LT && (op) <= OP_I_NCMP)

#define OP_IS_DIRHOP(op)	\
	((op) >= OP_READDIR && (op) <= OP_CLOSEDIR)

#define OP_IS_INFIX_BIT(op)	\
	((op) >= OP_BIT_AND && (op) <= OP_SBIT_OR)

/* ex: set ro: */
