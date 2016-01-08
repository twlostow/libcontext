/*
            Copyright Oliver Kowalke 2009.
            Copyright Thomas Sailer 2013.
   Distributed under the Boost Software License, Version 1.0.
      (See accompanying file LICENSE_1_0.txt or copy at
            http://www.boost.org/LICENSE_1_0.txt)
*/



.file	"make_x86_64_ms_pe_gas.S"
.text
.p2align 4,,15
.globl	make_fcontext
.def	make_fcontext;	.scl	2;	.type	32;	.endef
.seh_proc	make_fcontext
make_fcontext:
.seh_endprologue
mov    %rcx,%rax
sub    $0x28,%rax
and    $0xfffffffffffffff0,%rax
sub    $0x128,%rax
mov    %r8,0x118(%rax)
mov    %rcx,0xd0(%rax)
neg    %rdx
lea    (%rcx,%rdx,1),%rcx
mov    %rcx,0xc8(%rax)
mov    %rcx,0xc0(%rax)
stmxcsr 0xa8(%rax)
fnstcw 0xac(%rax)
leaq  finish(%rip), %rcx
mov    %rcx,0x120(%rax)
mov    $0x1,%rcx
mov    %rcx,(%rax)
retq
finish:
xor    %rcx,%rcx
callq  0x63
hlt
   .seh_endproc

.def	_exit;	.scl	2;	.type	32;	.endef  /* standard C library function */
