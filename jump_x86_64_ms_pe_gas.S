/*
            Copyright Oliver Kowalke 2009.
            Copyright Thomas Sailer 2013.
   Distributed under the Boost Software License, Version 1.0.
      (See accompanying file LICENSE_1_0.txt or copy at
            http://www.boost.org/LICENSE_1_0.txt)
*/


.file	"jump_x86_64_ms_pe_gas.S"
.text
.p2align 4,,15
.globl	jump_fcontext
.def	jump_fcontext;	.scl	2;	.type	32;	.endef
.seh_proc	jump_fcontext
jump_fcontext:
.seh_endprologue
	push   %rbp
	push   %rbx
	push   %rsi
	push   %rdi
	push   %r15
	push   %r14
	push   %r13
	push   %r12
	mov    %gs:0x30,%r10
	mov    0x8(%r10),%rax
	push   %rax
	mov    0x10(%r10),%rax
	push   %rax
	mov    0x1478(%r10),%rax
	push   %rax
	mov    0x18(%r10),%rax
	push   %rax
	lea    -0xa8(%rsp),%rsp
	test   %r9,%r9
	je     nxt1
	stmxcsr 0xa0(%rsp)
	fnstcw 0xa4(%rsp)
	movaps %xmm6,(%rsp)
	movaps %xmm7,0x10(%rsp)
	movaps %xmm8,0x20(%rsp)
	movaps %xmm9,0x30(%rsp)
	movaps %xmm10,0x40(%rsp)
	movaps %xmm11,0x50(%rsp)
	movaps %xmm12,0x60(%rsp)
	movaps %xmm13,0x70(%rsp)
	movaps %xmm14,0x80(%rsp)
	movaps %xmm15,0x90(%rsp)
nxt1:
	xor    %r10,%r10
	push   %r10
	mov    %rsp,(%rcx)
	mov    %rdx,%rsp
	pop    %r10
	test   %r9,%r9
	je     nxt2
	ldmxcsr 0xa0(%rsp)
	fldcw  0xa4(%rsp)
	movaps (%rsp),%xmm6
	movaps 0x10(%rsp),%xmm7
	movaps 0x20(%rsp),%xmm8
	movaps 0x30(%rsp),%xmm9
	movaps 0x40(%rsp),%xmm10
	movaps 0x50(%rsp),%xmm11
	movaps 0x60(%rsp),%xmm12
	movaps 0x70(%rsp),%xmm13
	movaps 0x80(%rsp),%xmm14
	movaps 0x90(%rsp),%xmm15
nxt2:
	mov    $0xa8,%rcx
    test   %r10,%r10
    je     nxt3
    add    $0x8,%rcx
nxt3:
	lea    (%rsp,%rcx,1),%rsp
	mov    %gs:0x30,%r10
	pop    %rax
	mov    %rax,0x18(%r10)
	pop    %rax
	mov    %rax,0x1478(%r10)
	pop    %rax
	mov    %rax,0x10(%r10)
	pop    %rax
	mov    %rax,0x8(%r10)
	pop    %r12
	pop    %r13
	pop    %r14
	pop    %r15
	pop    %rdi
	pop    %rsi
	pop    %rbx
	pop    %rbp
	pop    %r10
	mov    %r8,%rax
	mov    %r8,%rcx
	jmpq   *%r10
.seh_endproc
