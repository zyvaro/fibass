.global _start

_start:
	mov $1, %rax
	mov $1, %rdi
	mov $hello, %rsi
	mov $hello_len, %rdx
	syscall

	mov $60, %rax
	mov $0, %rdi
	syscall

hello:
	.ascii "hello, world\n"
hello_len = . - hello
