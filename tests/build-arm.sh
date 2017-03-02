#!/bin/bash
arm-linux-gnueabihf-g++-4.8 -static -mfloat-abi=hard -mcpu=cortex-a9 -Wall -g -I. coroutine_example.cpp  ../libcontext.cpp -o test-linux-arm32 -I..
aarch64-linux-gnu-g++-4.8  -static -Wall -g -I. coroutine_example.cpp  ../libcontext.cpp -o test-linux-arm64 -I..
