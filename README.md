Programming "Hello, World" in MS-DOS
====================================

The program `HELLO.COM` was developed on MS-DOS Version 6.22 using the
DOS program named `DEBUG.EXE`. It is exactly 28 bytes in length. It
can be used to print the string "hello, world" followed by newline to
standard output.xb


Assemble
--------

Here is the complete `DEBUG.EXE` session that shows how this program
was written:

```
C:\>DEBUG
-A
1165:0100 JMP 111
1165:0102 DB 'hello, world', d, A, '$'
1165:0111 MOV AH, 9
1165:0113 MOV DX, 102
1165:0116 INT 21
1165:0118 MOV AH, 0
1165:011A INT 21
1165:011C
-G
hello, world

Program terminated normally
-N HELLO.COM
-R CX
CX 0000
:1C
-W
Writing 0001C bytes
-Q

C:\>
```

Note that the `N` (name) command specifies the name of the file where
we write the binary machine code to. Also, note that the `W` (write)
command expects the registers BX and CX to contain the number of bytes
to be written to the file. When `DEBUG.EXE` starts, it already
initializes BX to 0 automatically, so we only set the register CX to
1C (decimal 28) with the `R CX` command above.

The debugger session inputs are archived in the file named
`HELLO.TXT`, so the binary file named `HELLO.COM` can also be created
by running the following DOS command:

```
DEBUG < HELLO.TXT
```

The binary executable file can be created on a Unix or Linux system
using the `printf` command as follows:

```
printf "\xEB\x0F\x68\x65\x6C\x6C\x6F\x2C\x20\x77\x6F\x72\x6C\x64\x0D\x0A\x24\xB4\x09\xBA\x02\x01\xCD\x21\xB4\x00\xCD\x21" > HELLO.COM
```


Unassemble
----------

Here is a disassembly of `HELLO.COM` to confirm that it has been
written correctly:

```
C:\>DEBUG
-N HELLO.COM
-L
-U 100 11B
117C:0100 EB0F          JMP     0111
117C:0102 68            DB      68
117C:0103 65            DB      65
117C:0104 6C            DB      6C
117C:0105 6C            DB      6C
117C:0106 6F            DB      6F
117C:0107 2C20          SUB     AL,20
117C:0109 776F          JA      017A
117C:010B 726C          JB      0179
117C:010D 64            DB      64
117C:010E 0D0A24        OR      AX,240A
117C:0111 B409          MOV     AH,09
117C:0113 BA0201        MOV     DX,0102
117C:0116 CD21          INT     21
117C:0118 B400          MOV     AH,00
117C:011A CD21          INT     21
-D 100 11B
117C:0100  EB 0F 68 65 6C 6C 6F 2C-20 77 6F 72 6C 64 0D 0A   ..hello, world..
117C:0110  24 B4 09 BA 02 01 CD 21-B4 00 CD 21               $......!...!
```


Run
---

To run this program on MS-DOS, simply enter the following command at
the command prompt:

```
HELLO
```


License
-------

This is free and open source software. You can use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of it,
under the terms of the MIT License. See [LICENSE.md][L] for details.

This software is provided "AS IS", WITHOUT WARRANTY OF ANY KIND,
express or implied. See [LICENSE.md][L] for details.

[L]: LICENSE.md
