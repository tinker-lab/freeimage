#.SILENT:

ifneq ($(WINDIR),)
  ARCH=WIN32
  ifeq ($(shell uname -o), Cygwin)
    WINCURDIR = $(shell cygpath -wm $(CURDIR))
  else
    WINCURDIR = $(CURDIR)
  endif
else
  UNAME=$(shell uname)
  ifeq ($(UNAME), Linux)
    ARCH=linux
    NPROCS = $(shell nproc)
    CUR_DIR_NAME:=$(shell basename $(CURDIR))
  else ifeq ($(UNAME), Darwin)
    ARCH=OSX
  else
    $(error The Makefile does not recognize the architecture: $(UNAME))
  endif
endif

all: cmake

cmake:
	mkdir -p ./build
        ifeq ($(ARCH),linux)
	  mkdir -p ./build/Release
	  mkdir -p ./build/Debug	  
	  cd ./build/Release; cmake -DCMAKE_BUILD_TYPE=Release ../../
	  cd ./build/Debug; cmake -DCMAKE_BUILD_TYPE=Debug ../../
        endif
        ifeq ($(ARCH),WIN32)
	  cd ./build; cmake ../ -G "Visual Studio 10 Win64"
        endif
        ifeq ($(ARCH),OSX)
	  cd ./build; cmake ../ -G Xcode
        endif
	@echo "Go to the build directory and make your project"

clean:  
	rm -rf ./build/

linux: linux-debug linux-opt

linux-debug:
	cd ./build/Debug; make

linux-opt:
	cd ./build/Release; make

clean-linux:
	cd ./build/Debug; make clean
	cd ./build/Release; make clean
