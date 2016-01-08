/*
            Copyright Oliver Kowalke 2009.
            Copyright Thomas Sailer 2013.
   Distributed under the Boost Software License, Version 1.0.
      (See accompanying file LICENSE_1_0.txt or copy at
            http://www.boost.org/LICENSE_1_0.txt)
*/

.file	"make_i386_ms_pe_gas.S"
.text
.p2align 4,,15
.globl	_make_fcontext
.def	_make_fcontext;	.scl	2;	.type	32;	.endef
_make_fcontext:
mov    0x4(%esp),%eax
lea    -0x8(%eax),%eax
and    $0xfffffff0,%eax
lea    -0x3c(%eax),%eax
mov    0x4(%esp),%ecx
mov    %ecx,0x14(%eax)
mov    0x8(%esp),%edx
neg    %edx
lea    (%ecx,%edx,1),%ecx
mov    %ecx,0x10(%eax)
mov    %ecx,0xc(%eax)
mov    0xc(%esp),%ecx
mov    %ecx,0x2c(%eax)
stmxcsr (%eax)
fnstcw 0x4(%eax)
mov    $finish,%ecx
mov    %ecx,0x30(%eax)
mov    %fs:0x0,%ecx

walk:
mov    (%ecx),%edx
inc    %edx
je     found
dec    %edx
xchg   %edx,%ecx
jmp    walk

found:
mov    0x4(%ecx),%ecx
mov    %ecx,0x3c(%eax)
mov    $0xffffffff,%ecx
mov    %ecx,0x38(%eax)
lea    0x38(%eax),%ecx
mov    %ecx,0x18(%eax)
ret
finish:
xor    %eax,%eax
mov    %eax,(%esp)
call   _exit
hlt
.def	__exit;	.scl	2;	.type	32;	.endef  /* standard C library function */
