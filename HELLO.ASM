JMP 111
DB 'hello, world', D, A, '$'
MOV AH, 9
MOV DX, 102
INT 21
MOV AH, 0
INT 21
