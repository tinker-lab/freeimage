cmake_minimum_required (VERSION 2.6)
set (CMAKE_VERBOSE_MAKEFILE TRUE)

set (SOURCEFILES source/adler32.c source/compress.c source/crc32.c source/deflate.c source/gzclose.c source/gzlib.c source/gzread.c source/gzwrite.c source/infback.c source/inffast.c source/inflate.c source/inftrees.c source/trees.c source/uncompr.c source/zutil.c)

set (HEADERFILES source/crc32.h source/deflate.h source/gzguts.h source/inffast.c source/inffixed.h source/inflate.h source/inftrees.h source/trees.h source/zutil.h include/zconf.h include/zlib.h)

source_group("Header Files" FILES ${HEADERFILES})

include_directories(
	./source
	./include
)


if (CMAKE_SIZEOF_VOID_P EQUAL 8)
	set(CMAKE_DEBUG_POSTFIX "_x64")
	set(CMAKE_RELEASE_POSTFIX "_x64")
	set(CMAKE_RELWITHDEBINFO_POSTFIX "_x64")
	set(CMAKE_MINSIZEREL_POSTFIX "_x64")
else()
	set(CMAKE_DEBUG_POSTFIX "")
	set(CMAKE_RELEASE_POSTFIX "")
	set(CMAKE_RELWITHDEBINFO_POSTFIX "")
	set(CMAKE_MINSIZEREL_POSTFIX "")
endif()

#set the build postfix extension according to the current configuration
if (CMAKE_BUILD_TYPE MATCHES "Release")
  set(CMAKE_BUILD_POSTFIX "${CMAKE_RELEASE_POSTFIX}")
elseif (CMAKE_BUILD_TYPE MATCHES "MinSizeRel")
  set(CMAKE_BUILD_POSTFIX "${CMAKE_MINSIZEREL_POSTFIX}")
elseif (CMAKE_BUILD_TYPE MATCHES "RelWithDebInfo")
  set(CMAKE_BUILD_POSTFIX "${CMAKE_RELWITHDEBINFO_POSTFIX}")
elseif (CMAKE_BUILD_TYPE MATCHES "Debug")
  set(CMAKE_BUILD_POSTFIX "${CMAKE_DEBUG_POSTFIX}")
else()
  set(CMAKE_BUILD_POSTFIX "")
endif()

add_library(zlib ${SOURCEFILES} ${HEADERFILES})
