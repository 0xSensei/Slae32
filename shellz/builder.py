import binascii
import socket
import sys


host = sys.argv[1]
port = int(sys.argv[2])


print "push dword 0x" + binascii.hexlify(socket.inet_aton(host))

print "push dword 0x" + (("%04x"% port)[2:]+("%04x"% port)[0:2]  + "0002")

#print "push dword " + hex(443) + "0002"
