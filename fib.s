.section .bss
buffer: .space 256
buffer_size: .space 4

.section .text
.global _start
_start:
	mov x(%rip), %rbx
	add $48, %rbx
	mov %rbx, buffer
	movq $10, buffer + 1

	mov $1, %rax
	mov $1, %rdi
	lea buffer, %rsi
	mov $2, %rdx
	syscall

	mov $60, %rax
	mov $0, %rdi
	syscall

hello:
	.ascii "hello, world\n"
hello_len = . - hello

x: .4byte 6
