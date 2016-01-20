#!/bin/bash
g++ -g -m64 -I. coroutine_example.cpp  ../libcontext.cpp -o test-linux-gcc-x86-64 -I..
g++ -g -m32 -I. coroutine_example.cpp  ../libcontext.cpp -o test-linux-gcc-i386  -I..
#clang++ -g -m64 -static -I. coroutine_example.cpp  ../libcontext.cpp -o test-linux-clang-x86-64 -I..
#clang++ -g -m32 -static -I. coroutine_example.cpp  ../libcontext.cpp -o test-linux-clang-i386  -I..
#i586-mingw32msvc-g++  -g -static -I. coroutine_example.cpp  ../libcontext.cpp -o test-win32-i386.exe -I..
#x86_64-w64-mingw32-g++ -g -static -I. coroutine_example.cpp  ../libcontext.cpp -o test-win64-x86_64.exe -I..