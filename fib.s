.section .text
.global print_number
print_number:
	pushq %rbp
	movq %rsp, %rbp
	movl %edi, -4(%rbp)
	movl -4(%rbp), %eax
	movl $0, -4(%rbp) # Local counter variable
	subq $256, %rsp # reserve 256 bytes above -8(%rbp) for buffer
	leaq -260(%rbp), %r12
	addq $255, %r12
	movb $10, (%r12) # add new line to the buffer
	dec %r12
	addl $1, -4(%rbp) # Increase counter
	movl $10, %ecx
.L0:
	## remainder in %edx, quotient in %eax
	cdq
	div %ecx 
	addl $48, %edx
	movb %dl, (%r12) # Store the converted number to ascii into buffer
	dec %r12
	addl $1, -4(%rbp) # Increase counter
	cmp $0, %eax
	jg .L0
.L1:
	movq $1, %rax
	movq $1, %rdi
	leaq 1(%r12), %rsi 
	movq -4(%rbp), %rdx
	syscall
	addq $256, %rsp
	popq %rbp
	ret

fib:
	pushq %rbp
	movq %rsp, %rbp
	movl %edi, -4(%rbp)
	movl -4(%rbp), %eax

	cmpl $0, %eax
	jz .fib_0
	cmpl $1, %eax
	jle .fib_0
	
	subq $16, %rsp
	movl $0, -12(%rbp) # First
	movl $1, -16(%rbp) # Second
	movl $1, -20(%rbp) # Nth
	movl $2, -24(%rbp) # int i = 2
	jmp .fib_L1
.fib_L0:
	movl -12(%rbp), %ebx # Move first into register
	addl -16(%rbp), %ebx # Add it with second
	movl %ebx, -20(%rbp) # update nth = first + second
	# update first = second
	movl -16(%rbp), %ebx
	movl %ebx, -12(%rbp) 
	# update second = nth
	movl -20(%rbp), %ebx
	movl %ebx, -16(%rbp)
	addl $1, -24(%rbp) 
.fib_L1:
	cmpl %eax, -24(%rbp)
	jle .fib_L0

	movl -20(%rbp), %eax
	addq $16, %rsp
	popq %rbp
	retq
.fib_0:
	popq %rbp
	retq

.global _start
_start:
	movl $6, %edi
	call fib
	
	movl %eax, %edi
	call print_number

	mov $60, %rax
	mov $0, %rdi
	syscall

; .section .data
; hello: .string "hello, world\n"
; num: .long 4589
