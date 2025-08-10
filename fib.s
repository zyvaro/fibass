.global _start
_start:
	mov $0, %r15
	jmp .L2
.L3:
	mov $1, %rax
	mov $1, %rdi
	lea hello(%rip), %rsi
	mov $13, %rdx
	syscall
	add $1, %r15
.L2:
	cmp $9, %r15
	jle .L3

	mov $60, %rax
	mov $0, %rdi
	syscall

.section .data
hello:
	.string "hello, world\n"
