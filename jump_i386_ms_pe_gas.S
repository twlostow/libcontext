/*
            Copyright Oliver Kowalke 2009.
            Copyright Thomas Sailer 2013.
   Distributed under the Boost Software License, Version 1.0.
      (See accompanying file LICENSE_1_0.txt or copy at
            http://www.boost.org/LICENSE_1_0.txt)
*/


.file	"jump_i386_ms_pe_gas.S"
.text
.p2align 4,,15
.globl	_jump_fcontext
.def	_jump_fcontext;	.scl	2;	.type	32;	.endef
_jump_fcontext:

    mov    0x10(%esp),%ecx
    push   %ebp
    push   %ebx
    push   %esi
    push   %edi
    mov    %fs:0x18,%edx
    mov    (%edx),%eax
    push   %eax
    mov    0x4(%edx),%eax
    push   %eax
    mov    0x8(%edx),%eax
    push   %eax
    mov    0xe0c(%edx),%eax
    push   %eax
    mov    0x10(%edx),%eax
    push   %eax
    lea    -0x8(%esp),%esp
    test   %ecx,%ecx
    je     nxt1
    stmxcsr (%esp)
    fnstcw 0x4(%esp)

nxt1:
    mov    0x30(%esp),%eax
    mov    %esp,(%eax)
    mov    0x34(%esp),%edx
    mov    0x38(%esp),%eax
    mov    %edx,%esp
    test   %ecx,%ecx
    je     nxt2
    ldmxcsr (%esp)
    fldcw  0x4(%esp)

nxt2:
    lea    0x8(%esp),%esp
    mov    %fs:0x18,%edx
    pop    %ecx
    mov    %ecx,0x10(%edx)
    pop    %ecx
    mov    %ecx,0xe0c(%edx)
    pop    %ecx
    mov    %ecx,0x8(%edx)
    pop    %ecx
    mov    %ecx,0x4(%edx)
    pop    %ecx
    mov    %ecx,(%edx)
    pop    %edi
    pop    %esi
    pop    %ebx
    pop    %ebp
    pop    %edx
    mov    %eax,0x4(%esp)
    jmp    *%edx
