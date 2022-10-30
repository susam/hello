Programming "Hello, World" in MS-DOS
====================================

The program `HELLO.COM` was developed on MS-DOS Version 6.22 using the
DOS program named `DEBUG.EXE`. It is exactly 26 bytes in length. It
can be used to print the string "hello, world" followed by newline to
standard output.xb


Assemble
--------

Here is the complete `DEBUG.EXE` session that shows how this program
was written:

```
C:\>DEBUG
-A
1165:0100 MOV AH, 9
1165:0102 MOV DX, 10B
1165:0105 INT 21
1165:0107 MOV AH, 0
1165:0109 INT 21
1165:010B DB 'hello, world', D, A, '$'
1165:011A
-G
hello, world

Program terminated normally
-N HELLO.COM
-R CX
CX 0000
:1A
-W
Writing 0001A bytes
-Q

C:\>HELLO
hello, world

C:\>
```

Note that the `N` (name) command specifies the name of the file where
we write the binary machine code to. Also, note that the `W` (write)
command expects the registers BX and CX to contain the number of bytes
to be written to the file. When `DEBUG.EXE` starts, it already
initializes BX to 0 automatically, so we only set the register CX to
1A (decimal 26) with the `R CX` command above.

The debugger session inputs are archived in the file named
`HELLO.TXT`, so the binary file named `HELLO.COM` can also be created
by running the following DOS command:

```
DEBUG < HELLO.TXT
```

The binary executable file can be created on a Unix or Linux system
using the `printf` command as follows:

```
printf '\xB4\x09\xBA\x0B\x01\xCD\x21\xB4\x00\xCD\x21\x68\x65\x6C\x6C\x6F\x2C\x20\x77\x6F\x72\x6C\x64\x0D\x0A\x24' > HELLO.COM
```


Unassemble
----------

Here is a disassembly of `HELLO.COM` to confirm that it has been
written correctly:

```
C:\>DEBUG
-N HELLO.COM
-L
-U 100 119
117C:0100 B409          MOV     AH,09
117C:0102 BA0B01        MOV     DX,010B
117C:0105 CD21          INT     21
117C:0107 B400          MOV     AH,00
117C:0109 CD21          INT     21
117C:010B 68            DB      68
117C:010C 65            DB      65
117C:010D 6C            DB      6C
117C:010E 6C            DB      6C
117C:010F 6F            DB      6F
117C:0110 2C20          SUB     AL,20
117C:0112 776F          JA      0183
117C:0114 726C          JB      0182
117C:0116 64            DB      64
117C:0117 0D0A24        OR      AX,240A
-D 100 119
117C:0100  B4 09 BA 0B 01 CD 21 B4-00 CD 21 68 65 6C 6C 6F   ......!...!hello
117C:0110  2C 20 77 6F 72 6C 64 0D-0A 24                     , world..$
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
