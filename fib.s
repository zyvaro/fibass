.section .text
.global print_number
print_number:
	pushq %rbp
	movq %rsp, %rbp
	movl %edi, -4(%rbp)
	movl -4(%rbp), %eax
	movl $0, -4(%rbp) # Local counter variable
	subq $256, %rsp # reserve 256 bytes above -8(%rbp) for buffer
	leaq -256(%rbp), %r12
	movb $10, (%r12) # add new line to the buffer
	inc %r12
	addl $1, -4(%rbp) # Increase counter
	movl $10, %ecx
.L0:
	## remainder in %edx, quotient in %eax
	cdq
	div %ecx 
	addl $48, %edx
	movb %dl, (%r12) # Store the converted number to ascii into buffer
	inc %r12
	addl $1, -4(%rbp) # Increase counter
	cmp $0, %eax
	jg .L0
.L1:
	movq $1, %rax
	movq $1, %rdi
	leaq -4(%r12), %rsi 
	movq -4(%rbp), %rdx
	syscall
	addq $256, %rsp
	popq %rbp
	ret

.global _start
_start:
	movl $123, %edi
	call print_number

	mov $60, %rax
	mov $0, %rdi
	syscall

; .section .data
; hello: .string "hello, world\n"
; num: .long 4589
