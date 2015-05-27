cmake_minimum_required (VERSION 2.6)
project(FreeImage)

set (CMAKE_VERBOSE_MAKEFILE TRUE)

file(GLOB freeimage_SRC
    "source/DeprecationManager/*.cpp"
	"source/FreeImage/*.cpp"
	"source/FreeImagePlus/*.cpp"
	"source/FreeImageToolkit/*.cpp"
	"source/LibJPEG/*.c"
	"source/LibOpenJPEG/*.c"
	"source/LibPNG/*.c"
	"source/LibRawLite/internal/*.c"
	"source/LibRawLite/internal/*.cpp"
	"source/LibRawLite/src/*.cpp"
	"source/LibTIFF4/*.c"
	"source/LibTIFF4/*.cxx"
	"source/Metadata/*.cpp"
	"source/OpenEXR/Half/*.cpp"
	"source/OpenEXR/Iex/*.cpp"
	"source/OpenEXR/IlmImf/*.cpp"
	"source/OpenEXR/IlmThread/*.cpp"
	"source/OpenEXR/Imath/*.cpp"
)

list(REMOVE_ITEM freeimage_SRC ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/Half/eLut.cpp ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/Half/toFloat.cpp ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/example.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibPNG/pngtest.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibOpenJPEG/t1_generate_luts.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/ansi2knr.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/jpegtran.c  ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/cjpeg.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibTIFF4/mkg3states.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibTIFF4/mkspans.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibTIFF4/tif_win32.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibTIFF4/tif_wince.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibTIFF4/tif_unix.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibTIFF4/tif_vms.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/jmemmac.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/jmemsys.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/jmemdos.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/jmemdosa.asm ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/jmemname.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/jmemnobs.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/rdjpgcom.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/wrjpgcom.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/cdjpeg.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/djpeg.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibJPEG/ckconfig.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibRawLite/dcraw/dcraw.c ${CMAKE_CURRENT_SOURCE_DIR}/source/LibRawLite/internal/dcb_demosaicing.c ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/IlmImf/b44ExpLogTable.cpp ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/IlmThread/IlmThreadWin32.cpp ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/IlmThread/IlmThreadPosix.cpp ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/IlmThread/IlmThreadMutexWin32.cpp ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/IlmThread/IlmThreadMutexPosix.cpp ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/IlmThread/IlmThreadSemaphoreWin32.cpp ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/IlmThread/IlmThreadSemaphorePosix.cpp ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/IlmThread/IlmThreadSemaphorePosixCompat.cpp ${CMAKE_CURRENT_SOURCE_DIR}/source/OpenEXR/IlmThread/IlmThreadSemaphorePosix.cpp)

file(GLOB freeimage_Headers
	"include/*.h"
	"source/*.h"
	"source/DeprecationManager/*.h"
	"source/FreeImage/*.h"
	"source/FreeImageToolkit/*.h"
	"source/LibJPEG/*.h"
	"source/LibOpenJPEG/*.h"
	"source/LibPNG/*.h"
	"source/LibRawLite/internal/*.h"
	"source/LibRawLite/libraw/*.h"
	"source/LibTIFF4*.h"
	"source/Metadata/*.h"
	"source/OpenEXR/Half/*.h"
	"source/OpenEXR/Iex/*.h"
	"source/OpenEXR/IlmImf/*.h"
	"source/OpenEXR/IlmThread/*.h"
	"source/OpenEXR/Imath/*.h"
)

set (SOURCEFILES ${freeimage_SRC})

set (HEADERFILES ${freeimage_Headers})

source_group("Header Files" FILES ${HEADERFILES})

include_directories(
	./source
	./include
	./source/DeprecationManager
	./source/FreeImage
	./source/FreeImageToolkit
	./source/LibJPEG
	./source/LibOpenJPEG
	./source/LibPNG
	./source/LibRawLite
	./source/LibRawLite/internal
	./source/LibRawLite/libraw
	./source/LibTIFF4
	./source/Metadata
	./source/OpenEXR
	./source/OpenEXR/Half
	./source/OpenEXR/Iex
	./source/OpenEXR/IlmImf
	./source/OpenEXR/IlmThread
	./source/OpenEXR/Imath
	./zlib.lib/include
)

add_definitions(-DNO_LCMS -DLIBRAW_NODLL -DOPJ_STATIC)

if (CMAKE_SIZEOF_VOID_P EQUAL 8)
	set(CMAKE_DEBUG_POSTFIX "_x64d")
	set(CMAKE_RELEASE_POSTFIX "_x64")
	set(CMAKE_RELWITHDEBINFO_POSTFIX "_x64rd")
	set(CMAKE_MINSIZEREL_POSTFIX "_x64s")
else()
	set(CMAKE_DEBUG_POSTFIX "d")
	set(CMAKE_RELEASE_POSTFIX "")
	set(CMAKE_RELWITHDEBINFO_POSTFIX "rd")
	set(CMAKE_MINSIZEREL_POSTFIX "s")
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

find_package(ZLIB QUIET)
if (NOT ZLIB_FOUND)
  add_subdirectory (zlib.lib)
endif()

add_library(freeimage ${SOURCEFILES} ${HEADERFILES})
