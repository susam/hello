MOV AH, 9
MOV DX, 108
INT 21
RET
DB 'hello, world', D, A, '$'
