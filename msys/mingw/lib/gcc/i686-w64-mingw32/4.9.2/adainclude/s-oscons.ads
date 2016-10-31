------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                  S Y S T E M . O S _ C O N S T A N T S                   --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 2000-2013, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

pragma Style_Checks ("M32766");
--  Allow long lines

--  This package provides target dependent definitions of constant for use
--  by the GNAT runtime library. This package should not be directly with'd
--  by an application program.

--  This file is generated automatically, do not modify it by hand! Instead,
--  make changes to s-oscons-tmplt.c and rebuild the GNAT runtime library.
--  This is the version for i686-w64-mingw32

with Interfaces.C;
package System.OS_Constants is

   pragma Pure;

   ---------------------------------
   -- General platform parameters --
   ---------------------------------

   type OS_Type is (Windows, VMS, Other_OS);
   Target_OS                     : constant OS_Type := Windows;
   pragma Warnings (Off, Target_OS);
   --  Suppress warnings on Target_OS since it is in general tested for
   --  equality with a constant value to implement conditional compilation,
   --  which normally generates a constant condition warning.

   Target_Name                   : constant String  := "i686-w64-mingw32";
   SIZEOF_unsigned_int           : constant := 4;           --  Size of unsigned int

   -------------------
   -- System limits --
   -------------------

   IOV_MAX                       : constant := 2147483647;  --  Maximum writev iovcnt
   NAME_MAX                      : constant := 255;         --  Maximum file name length
   FILENAME_MAX                  : constant := 260;         --  Maximum file path length

   ---------------------
   -- File open modes --
   ---------------------

   O_RDWR                        : constant := 2;           --  Read/write
   O_NOCTTY                      : constant := -1;          --  Don't change ctrl tty
   O_NDELAY                      : constant := -1;          --  Nonblocking

   ----------------------
   -- Fcntl operations --
   ----------------------

   F_GETFL                       : constant := -1;          --  Get flags
   F_SETFL                       : constant := -1;          --  Set flags

   -----------------
   -- Fcntl flags --
   -----------------

   FNDELAY                       : constant := -1;          --  Nonblocking

   ----------------------
   -- Ioctl operations --
   ----------------------

   subtype IOCTL_Req_T is Interfaces.C.int;
   FIONBIO                       : constant := -2147195266; --  Set/clear non-blocking io
   FIONREAD                      : constant := 1074030207;  --  How many bytes to read

   ------------------
   -- Errno values --
   ------------------

   --  The following constants are defined from <errno.h>

   EAGAIN                        : constant := 11;          --  Try again
   ENOENT                        : constant := 2;           --  File not found
   ENOMEM                        : constant := 12;          --  Out of memory

   --  The following constants are defined from <winsock2.h> (WSA*)

   EACCES                        : constant := 13;          --  Permission denied
   EADDRINUSE                    : constant := 10048;       --  Address already in use
   EADDRNOTAVAIL                 : constant := 10049;       --  Cannot assign address
   EAFNOSUPPORT                  : constant := 10047;       --  Addr family not supported
   EALREADY                      : constant := 10037;       --  Operation in progress
   EBADF                         : constant := 9;           --  Bad file descriptor
   ECONNABORTED                  : constant := 10053;       --  Connection aborted
   ECONNREFUSED                  : constant := 10061;       --  Connection refused
   ECONNRESET                    : constant := 10054;       --  Connection reset by peer
   EDESTADDRREQ                  : constant := 10039;       --  Destination addr required
   EFAULT                        : constant := 14;          --  Bad address
   EHOSTDOWN                     : constant := 10064;       --  Host is down
   EHOSTUNREACH                  : constant := 10065;       --  No route to host
   EINPROGRESS                   : constant := 10036;       --  Operation now in progress
   EINTR                         : constant := 4;           --  Interrupted system call
   EINVAL                        : constant := 22;          --  Invalid argument
   EIO                           : constant := 5;           --  Input output error
   EISCONN                       : constant := 10056;       --  Socket already connected
   ELOOP                         : constant := 10062;       --  Too many symbolic links
   EMFILE                        : constant := 24;          --  Too many open files
   EMSGSIZE                      : constant := 10040;       --  Message too long
   ENAMETOOLONG                  : constant := 38;          --  Name too long
   ENETDOWN                      : constant := 10050;       --  Network is down
   ENETRESET                     : constant := 10052;       --  Disconn. on network reset
   ENETUNREACH                   : constant := 10051;       --  Network is unreachable
   ENOBUFS                       : constant := 10055;       --  No buffer space available
   ENOPROTOOPT                   : constant := 10042;       --  Protocol not available
   ENOTCONN                      : constant := 10057;       --  Socket not connected
   ENOTSOCK                      : constant := 10038;       --  Operation on non socket
   EOPNOTSUPP                    : constant := 10045;       --  Operation not supported
   EPIPE                         : constant := 32;          --  Broken pipe
   EPFNOSUPPORT                  : constant := 10046;       --  Unknown protocol family
   EPROTONOSUPPORT               : constant := 10043;       --  Unknown protocol
   EPROTOTYPE                    : constant := 10041;       --  Unknown protocol type
   ERANGE                        : constant := 34;          --  Result too large
   ESHUTDOWN                     : constant := 10058;       --  Cannot send once shutdown
   ESOCKTNOSUPPORT               : constant := 10044;       --  Socket type not supported
   ETIMEDOUT                     : constant := 10060;       --  Connection timed out
   ETOOMANYREFS                  : constant := 10059;       --  Too many references
   EWOULDBLOCK                   : constant := 10035;       --  Operation would block
   E2BIG                         : constant := 7;           --  Argument list too long
   EILSEQ                        : constant := 42;          --  Illegal byte sequence

   ----------------------
   -- Terminal control --
   ----------------------

   DTR_CONTROL_ENABLE            : constant := 1;           --  Enable DTR flow ctrl
   RTS_CONTROL_ENABLE            : constant := 1;           --  Enable RTS flow ctrl

   -----------------------------
   -- Pseudo terminal library --
   -----------------------------

   PTY_Library                   : constant String  := "";            --  for g-exptty

   --------------
   -- Families --
   --------------

   AF_INET                       : constant := 2;           --  IPv4 address family
   AF_INET6                      : constant := 23;          --  IPv6 address family

   ------------------
   -- Socket modes --
   ------------------

   SOCK_STREAM                   : constant := 1;           --  Stream socket
   SOCK_DGRAM                    : constant := 2;           --  Datagram socket

   -----------------
   -- Host errors --
   -----------------

   HOST_NOT_FOUND                : constant := 11001;       --  Unknown host
   TRY_AGAIN                     : constant := 11002;       --  Host name lookup failure
   NO_DATA                       : constant := 11004;       --  No data record for name
   NO_RECOVERY                   : constant := 11003;       --  Non recoverable errors

   --------------------
   -- Shutdown modes --
   --------------------

   SHUT_RD                       : constant := 0;           --  No more recv
   SHUT_WR                       : constant := 1;           --  No more send
   SHUT_RDWR                     : constant := 2;           --  No more recv/send

   ---------------------
   -- Protocol levels --
   ---------------------

   SOL_SOCKET                    : constant := 65535;       --  Options for socket level
   IPPROTO_IP                    : constant := 0;           --  Dummy protocol for IP
   IPPROTO_UDP                   : constant := 17;          --  UDP
   IPPROTO_TCP                   : constant := 6;           --  TCP

   -------------------
   -- Request flags --
   -------------------

   MSG_OOB                       : constant := 1;           --  Process out-of-band data
   MSG_PEEK                      : constant := 2;           --  Peek at incoming data
   MSG_EOR                       : constant := -1;          --  Send end of record
   MSG_WAITALL                   : constant := 8;           --  Wait for full reception
   MSG_NOSIGNAL                  : constant := -1;          --  No SIGPIPE on send
   MSG_Forced_Flags              : constant := 0;
   --  Flags set on all send(2) calls

   --------------------
   -- Socket options --
   --------------------

   TCP_NODELAY                   : constant := 1;           --  Do not coalesce packets
   SO_REUSEADDR                  : constant := 4;           --  Bind reuse local address
   SO_REUSEPORT                  : constant := -1;          --  Bind reuse port number
   SO_KEEPALIVE                  : constant := 8;           --  Enable keep-alive msgs
   SO_LINGER                     : constant := 128;         --  Defer close to flush data
   SO_BROADCAST                  : constant := 32;          --  Can send broadcast msgs
   SO_SNDBUF                     : constant := 4097;        --  Set/get send buffer size
   SO_RCVBUF                     : constant := 4098;        --  Set/get recv buffer size
   SO_SNDTIMEO                   : constant := 4101;        --  Emission timeout
   SO_RCVTIMEO                   : constant := 4102;        --  Reception timeout
   SO_ERROR                      : constant := 4103;        --  Get/clear error status
   IP_MULTICAST_IF               : constant := 9;           --  Set/get mcast interface
   IP_MULTICAST_TTL              : constant := 10;          --  Set/get multicast TTL
   IP_MULTICAST_LOOP             : constant := 11;          --  Set/get mcast loopback
   IP_ADD_MEMBERSHIP             : constant := 12;          --  Join a multicast group
   IP_DROP_MEMBERSHIP            : constant := 13;          --  Leave a multicast group
   IP_PKTINFO                    : constant := 19;          --  Get datagram info

   ----------------------
   -- Type definitions --
   ----------------------

   --  Sizes (in bytes) of the components of struct timeval
   SIZEOF_tv_sec                 : constant := 4;           --  tv_sec
   SIZEOF_tv_usec                : constant := 4;           --  tv_usec

   --  Maximum allowed value for tv_sec
   MAX_tv_sec                    : constant := 2 ** (SIZEOF_tv_sec * 8 - 1) - 1;

   --  Sizes of various data types
   SIZEOF_sockaddr_in            : constant := 16;          --  struct sockaddr_in
   SIZEOF_sockaddr_in6           : constant := 28;          --  struct sockaddr_in6
   SIZEOF_fd_set                 : constant := 4100;        --  fd_set
   FD_SETSIZE                    : constant := 1024;        --  Max fd value
   SIZEOF_struct_hostent         : constant := 16;          --  struct hostent
   SIZEOF_struct_servent         : constant := 16;          --  struct servent

   --  Fields of struct msghdr
   subtype Msg_Iovlen_T is Interfaces.C.size_t;

   ----------------------------------------
   -- Properties of supported interfaces --
   ----------------------------------------

   Need_Netdb_Buffer             : constant := 0;           --  Need buffer for Netdb ops
   Need_Netdb_Lock               : constant := 0;           --  Need lock for Netdb ops
   Has_Sockaddr_Len              : constant := 0;           --  Sockaddr has sa_len field
   Thread_Blocking_IO            : constant Boolean := True;
   --  Set False for contexts where socket i/o are process blocking

   Inet_Pton_Linkname            : constant String  := "__gnat_inet_pton";

   ---------------------
   -- Threads support --
   ---------------------

   --  Clock identifier definitions

   CLOCK_REALTIME                : constant := 0;           --  System realtime clock
   CLOCK_MONOTONIC               : constant := 1;           --  System monotonic clock
   CLOCK_THREAD_CPUTIME_ID       : constant := 3;           --  Thread CPU clock
   CLOCK_RT_Ada                  : constant := CLOCK_REALTIME;

   --------------------------------
   -- File and directory support --
   --------------------------------

   SIZEOF_struct_file_attributes : constant := 20;          --  struct file_attributes
   SIZEOF_struct_dirent_alloc    : constant := 264;         --  struct dirent allocation

   ------------------------------
   -- MinGW-specific constants --
   ------------------------------

   --  These constants may be used only within the MinGW version of
   --  GNAT.Sockets.Thin.
   WSASYSNOTREADY                : constant := 10091;       --  System not ready
   WSAVERNOTSUPPORTED            : constant := 10092;       --  Version not supported
   WSANOTINITIALISED             : constant := 10093;       --  Winsock not initialized
   WSAEDISCON                    : constant := 10101;       --  Disconnected

end System.OS_Constants;
