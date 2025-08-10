.global _start
_start:
	mov $0, %r15
	mov num, %r12
	lea buffer(%rip), %r11
	jmp .L2
.L3:
	mov %r12, %rax
	cdq
	mov $10, %rcx
	cmp $0, %rax
	jle .L4
	div %rcx
	mov %rax, %r12
	add $48, %rdx
	mov %rdx, (%r11)
	addl $1, buffer_len
	add $1, %r11
	add $1, %r15
.L2:
	cmp $9, %r15
	jle .L3
.L4:

	add $1, %r11
	movl $10, (%r11)

	mov $1, %rax
	mov $1, %rdi
	lea buffer(%rip), %rsi
	lea buffer_len(%rip), %rdx
	syscall

	mov $60, %rax
	mov $0, %rdi
	syscall

.section .bss
buffer: .space 256
buffer_len: .space 4

.section .data
hello: .string "hello, world\n"
num: .long 123
