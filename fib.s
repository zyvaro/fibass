.global _start
_start:
	mov $0, %r15
	mov num, %r12
	lea buffer(%rip), %r11
	add $255, %r11
	movb $10, (%r11)
	addl $1, buffer_len
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
	dec %r11
	movb %dl, (%r11)
	addl $1, buffer_len
	add $1, %r15
.L2:
	cmp $9, %r15
	jle .L3
.L4:

	mov $1, %rax
	mov $1, %rdi
	mov %r11, %rsi
	mov buffer_len, %rdx
	syscall

	mov $60, %rax
	mov $0, %rdi
	syscall

.section .bss
buffer: .space 256
buffer_len: .space 4

.section .data
hello: .string "hello, world\n"
num: .long 4589
