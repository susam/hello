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
to be written to the file. When `DEBUG.EXE` starts, BX is already
initialized to 0, so we only set the register CX to 17 (decimal 23)
with the `R CX` command above.

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


Credits
-------

- [colejohnson66](https://news.ycombinator.com/user?id=colejohnson66)
  for suggesting that moving the string from top to bottom avoids a
  `JMP` instruction thus saving 2 bytes.
- [userbinator](https://news.ycombinator.com/user?id=userbinator) for
  suggesting that `MOV AH, 0` and `INT 21` instructions to terminate
  the program can be replaced with `RET` thus saving 3 bytes.


INT 20 vs. RET
--------------

Another way to terminate a program, especially with .COM programs, is
to simply use `INT 20`. This consumes 2 bytes: `CD 20`.

While producing the smallest possible executable is not the goal of
this project, this project indulges in a little bit of size reduction
by using `RET` to terminate the program. This consumes 1 byte: `C3`.
This works because when a .COM file starts up, the register SP
contains FFFE. The stack memory locations at offset FFFE and FFFF
contain 00 and 00, respectively. Further, the memory address offset
0000 contains the instruction `INT 20`.

```
C:\>DEBUG HELLO.COM
-R SP
SP FFFE
:
-D FFFE
117C:FFF0                                            00 00
-U 0 1
117C:0000 CD20          INT     20
```

As a result, executing a `RET` instruction pops 0000 off the stack at
FFFE and loads it into IP. This results in the intstruction `INT 20`
at offset 0000 getting executed which leads to program termination.

While both `INT 20` and `RET` lead to successful program termination
both in DOS as well as while debugging with `DEBUG.EXE`, there is some
difference between them which affects the debugging experience.
Terminating the program with `INT 20` allows us to run the program
repeatedly within the debugger by repeated applications of the `G`
debugger command. But when we terminate the program with `RET`, we
cannot run the program repeatedly with `G`. The program runs and
terminates successfully the first time we run it with `G` but the
stack does not get reinitialized with zeros to prepare it for
subsequent usage of `G`. Therefore on a subsequenct run of `G` the
program does not terminate successfully. It hangs instead. It is
possible to work around this by reinitializing the stack with the
debugger command `E FFFE 0 0` before running `G` again.


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
