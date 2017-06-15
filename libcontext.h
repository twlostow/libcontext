/*

    libcontext - a slightly more portable version of boost::context

    Copyright Martin Husemann 2013.
    Copyright Oliver Kowalke 2009.
    Copyright Sergue E. Leontiev 2013.
    Copyright Thomas Sailer 2013.
    Minor modifications by Tomasz Wlostowski 2016.

 Distributed under the Boost Software License, Version 1.0.
      (See accompanying file LICENSE_1_0.txt or copy at
            http://www.boost.org/LICENSE_1_0.txt)

*/

#ifndef __LIBCONTEXT_H
#define __LIBCONTEXT_H

#include <stdint.h>
#include <stdio.h>
#include <stddef.h>


#if defined(__GNUC__) || defined(__APPLE__)

    #define LIBCONTEXT_COMPILER_gcc

    #if defined(__linux__)
	#ifdef __x86_64__
	    #define LIBCONTEXT_PLATFORM_linux_x86_64
	    #define LIBCONTEXT_CALL_CONVENTION

	#elif __i386__
	    #define LIBCONTEXT_PLATFORM_linux_i386
	    #define LIBCONTEXT_CALL_CONVENTION
	#elif __arm__
	    #define LIBCONTEXT_PLATFORM_linux_arm32
	    #define LIBCONTEXT_CALL_CONVENTION
	#elif __aarch64__
	    #define LIBCONTEXT_PLATFORM_linux_arm64
	    #define LIBCONTEXT_CALL_CONVENTION
	#elif __powerpc64__
	    #define LIBCONTEXT_PLATFORM_linux_ppc64
	    #define LIBCONTEXT_CALL_CONVENTION
	#elif __powerpc__
	    #define LIBCONTEXT_PLATFORM_linux_ppc32
	    #define LIBCONTEXT_CALL_CONVENTION
	#endif

    #elif defined(__MINGW32__) || defined (__MINGW64__)
	#if defined(__x86_64__)
	    #define LIBCONTEXT_COMPILER_gcc
    	    #define LIBCONTEXT_PLATFORM_windows_x86_64
	    #define LIBCONTEXT_CALL_CONVENTION
	#endif

	#if defined(__i386__)
	    #define LIBCONTEXT_COMPILER_gcc
	    #define LIBCONTEXT_PLATFORM_windows_i386
	    #define LIBCONTEXT_CALL_CONVENTION __cdecl
	#endif
    #elif defined(__APPLE__) && defined(__MACH__)
	#if defined (__i386__)
	    #define LIBCONTEXT_PLATFORM_apple_i386
	    #define LIBCONTEXT_CALL_CONVENTION
	#elif defined (__x86_64__)
	    #define LIBCONTEXT_PLATFORM_apple_x86_64
	    #define LIBCONTEXT_CALL_CONVENTION
	#endif
    #endif
#endif


#if defined(_WIN32_WCE)
typedef int intptr_t;
#endif

typedef void*   fcontext_t;

#ifdef __cplusplus
extern "C"{
#endif


intptr_t LIBCONTEXT_CALL_CONVENTION jump_fcontext( fcontext_t * ofc, fcontext_t nfc,
                                               intptr_t vp, bool preserve_fpu = false);
fcontext_t LIBCONTEXT_CALL_CONVENTION make_fcontext( void * sp, size_t size, void (* fn)( intptr_t) );

#ifdef __cplusplus
};
#endif

#endif
