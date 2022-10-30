Programming "Hello, World" in MS-DOS
====================================

The program `HELLO.COM` was developed on MS-DOS Version 6.22 using the
DOS program named `DEBUG.EXE`. It is exactly 23 bytes in length. It
can be used to print the string "hello, world" followed by newline to
standard output.


Assemble
--------

Here is the complete `DEBUG.EXE` session that shows how this program
was written:

```
C:\>debug
-A
1165:0100 MOV AH, 9
1165:0102 MOV DX, 108
1165:0105 INT 21
1165:0107 RET
1165:0108 DB 'hello, world', D, A, '$'
1165:0117
-G
hello, world

Program terminated normally
-N HELLO.COM
-R CX
CX 0000
:17
-W
Writing 00017 bytes
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
printf '\xB4\x09\xBA\x08\x01\xCD\x21\xC3\x68\x65\x6C\x6C\x6F\x2C\x20\x77\x6F\x72\x6C\x64\x0D\x0A\x24' > HELLO.COM
```


Unassemble
----------

Here is a disassembly of `HELLO.COM` to confirm that it has been
written correctly:

```
C:\>DEBUG
-N HELLO.COM
-L
-U 100 116
117C:0100 B409          MOV     AH,09
117C:0102 BA0801        MOV     DX,0108
117C:0105 CD21          INT     21
117C:0107 C3            RET
117C:0108 68            DB      68
117C:0109 65            DB      65
117C:010A 6C            DB      6C
117C:010B 6C            DB      6C
117C:010C 6F            DB      6F
117C:010D 2C20          SUB     AL,20
117C:010F 776F          JA      0180
117C:0111 726C          JB      017F
117C:0113 64            DB      64
117C:0114 0D0A24        OR      AX,240A
-D 100 116
117C:0100  B4 09 BA 08 01 CD 21 C3-68 65 6C 6C 6F 2C 20 77   ......!.hello, w
117C:0110  6F 72 6C 64 0D 0A 24                              orld..$
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


More
----

If you liked this repository, see
[reboot](https://github.com/susam/reboot).
