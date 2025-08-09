.section .bss
buffer: .space 256
buffer_size: .space 4

.section .text
.global _start
_start:
	mov x(%rip), %rbx
	add $48, %rbx
	mov %rbx, buffer
	addl $1, buffer_size
	movq $10, buffer + 1
	addl $1, buffer_size
	movq $0, buffer + 2

	mov $1, %rax
	mov $1, %rdi
	lea buffer, %rsi
	lea buffer_size, %rdx
	syscall

	mov $60, %rax
	mov $0, %rdi
	syscall

hello:
	.ascii "hello, world\n"
hello_len = . - hello

x: .4byte 6
