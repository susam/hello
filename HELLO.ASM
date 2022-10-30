MOV AH, 9
MOV DX, 10B
INT 21
MOV AH, 0
INT 21
DB 'hello, world', D, A, '$'
