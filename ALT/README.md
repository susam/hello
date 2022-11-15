"Hello, World" Programs Assembled With DEBUG.EXE
================================================

This directory provides some examples of writing "hello, world"
programs that do not depend on DOS services.

Here is a matrix that describes the various programs available in this
directory.

| Code style x Environment    | Runs in DOS           | Runs from boot sector |
|-----------------------------|-----------------------|-----------------------|
| Uses BIOS INT 10            | HELLO1.TXT (31 bytes) | BOOT1.TXT (36 bytes)  |
| Uses LODSB, STOSW, and LOOP | HELLO2.TXT (39 bytes) | BOOT2.TXT (44 bytes)  |
| Uses JNE-based loop         | HELLO3.TXT (40 bytes) | BOOT3.TXT (45 bytes)  |

The programs that run in DOS are presented in the section [DOS
Programs](#dos-programs) and the ones that can run from boot sector
are presented in the section [Boot Sector
Programs](#boot-sector-programs).


DOS Programs
------------

### HELLO1

Enter the following command to assemble this program:

```
DEBUG < HELLO1.TXT
```

Here is how the output looks:

```
C:\>DEBUG < HELLO1.TXT
-A
1165:0100 MOV AX, 1300
1165:0103 MOV BX, A
1165:0106 MOV CX, C
1165:0109 XOR DX, DX
1165:010B MOV BP, 113
1165:010E INT 10
1165:0110 HLT
1165:0111 JMP 110
1165:0113 DB 'hello, world'
1165:011F
-N HELLO1.COM
-R CX
CX 0000
:1F
-W
Writing 0001F bytes
-Q

C:\>
```

On a Unix or Linux system, the binary `HELLO1.COM` may be generated as
follows:

```sh
echo B8 00 13 BB 0A 00 B9 0C 00 31 D2 BD 13 01 CD 10 F4 EB FD 68 65 6C 6C 6F 2C 20 77 6F 72 6C 64 | xxd -r -p > HELLO1.COM
```

To test this program using DOSBox, enter the following command:

```sh
dosbox -c CLS HELLO1.COM
```


### HELLO2

Enter the following command to assemble this program:

```
DEBUG < HELLO2.TXT
```

Here is how the output looks:

```
C:\>DEBUG < HELLO2.TXT
-A
1165:0100 MOV AX, CS
1165:0102 MOV DS, AX
1165:0104 MOV AX, B800
1165:0107 MOV ES, AX
1165:0109 XOR DI, DI
1165:010B MOV SI, 11B
1165:010E MOV CX, C
1165:0111 MOV AH, A
1165:0113 CLD
1165:0114 LODSB
1165:0115 STOSW
1165:0116 LOOP 114
1165:0118 HLT
1165:0119 JMP 118
1165:011B DB 'hello, world'
1165:0127
-N HELLO2.COM
-R CX
CX 0000
:27
-W
Writing 00027 bytes
-Q

C:\>
```

On a Unix or Linux system, the binary `HELLO1.COM` may be generated as
follows:

```sh
echo 8C C8 8E D8 B8 00 B8 8E C0 31 FF BE 1B 01 B9 0C 00 B4 0A FC AC AB E2 FC F4 EB FD 68 65 6C 6C 6F 2C 20 77 6F 72 6C 64 | xxd -r -p > HELLO2.COM
```

To test this program using DOSBox, enter the following command:

```sh
dosbox -c CLS HELLO2.COM
```


### HELLO3

```
C:\>DEBUG < HELLO3.TXT
-A
1165:0100 MOV AX, B800
1165:0103 MOV DS, AX
1165:0105 XOR DI, DI
1165:0107 MOV SI, 11C
1165:010A MOV AH, A
1165:010C CS: MOV AL, [SI]
1165:010F MOV [DI], AX
1165:0111 INC SI
1165:0112 INC DI
1165:0113 INC DI
1165:0114 CMP DI, 18
1165:0117 JNE 10C
1165:0119 HLT
1165:011A JMP 119
1165:011C DB 'hello, world'
1165:0128
-N HELLO3.COM
-R CX
CX 0000
:28
-W
Writing 00028 bytes
-Q

C:\>
```

On a Unix or Linux system, the binary `HELLO1.COM` may be generated as
follows:

```sh
echo B8 00 B8 8E D8 31 FF BE 1C 01 B4 0A 2E 8A 04 89 05 46 47 47 83 FF 18 75 F3 F4 EB FD 68 65 6C 6C 6F 2C 20 77 6F 72 6C 64 | xxd -r -p > HELLO3.COM
```

To test this program using DOSBox, enter the following command:

```sh
dosbox -c CLS HELLO3.COM
```


Boot Sector Programs
--------------------

*CAUTION: The `W 100 2 0 1` debugger command presented in the boot
program examples writes the program to the boot sector of drive C.
Before you run this command, be absolutely sure that you really want
to write the program to the boot sector of drive C. After writing this
program to the boot sector of a drive, access to data on that drive
will be lost. If you prefer writing it to another drive, say, drive A,
then this command needs to be altered. For example, the command `W 100
0 0 1` writes the program to drive A. The second integer in this
command represents the drive. The syntax of the `W` command is `W
[address] [drive] [firstsector] [number]`.*


### BOOT1

Enter the following command to assemble this program and write it to
the boot sector of drive. Read the caution above before proceeding:

```
DEBUG < BOOT1.TXT
```

Here is how the output looks:

```
C:\>DEBUG < BOOT1.TXT
-A
1165:0100 JMP 0:7C05
1165:0105 MOV AX, 1300
1165:0108 MOV BX, A
1165:010B MOV CX, C
1165:010E XOR DX, DX
1165:0110 MOV BP, 7C18
1165:0113 INT 10
1165:0115 HLT
1165:0116 JMP 115
1165:0118 DB 'hello, world'
1165:0124
-E 2FE 55 AA
-W 100 2 0 1
-Q

C:\>
```

On a Unix or Linux system, the boot sector image can be created with the following command:

```sh
echo EA 05 7C 00 00 B8 00 13 BB 0A 00 B9 0C 00 31 D2 BD 18 7C CD 10 F4 EB FD 68 65 6C 6C 6F 2C 20 77 6F 72 6C 64 | xxd -r -p > BOOT1.IMG
echo 55 aa | xxd -r -p | dd seek=510 bs=1 of=BOOT1.IMG
```

To test this program with DOSBox, enter the following command:

```sh
dosbox -c CLS -c 'BOOT BOOT1.IMG'
```

To test this program with QEMU, enter the following command:

```sh
qemu-system-i386 -fda BOOT1.IMG
```


### BOOT2

Enter the following command to assemble this program and write it to
the boot sector of drive. Read the caution at the top of this section
before proceeding:

```
DEBUG < BOOT2.TXT
```

Here is how the output looks:

```
C:\>DEBUG.EXE < BOOT2.TXT
-A
1165:0100 JMP 0:7C05
1165:0105 MOV AX, CS
1165:0107 MOV DS, AX
1165:0109 MOV AX, B800
1165:010C MOV ES, AX
1165:010E XOR DI, DI
1165:0110 MOV SI, 7C20
1165:0113 MOV CX, C
1165:0116 MOV AH, A
1165:0118 CLD
1165:0119 LODSB
1165:011A STOSW
1165:011B LOOP 119
1165:011D HLT
1165:011E JMP 11D
1165:0120 DB 'hello, world'
1165:012C
-E 2FE 55 AA
-W 100 2 0 1
-Q

C:\>
```

On a Unix or Linux system, the boot sector image can be created with the following command:

```sh
echo EA 05 7C 00 00 8C C8 8E D8 B8 00 B8 8E C0 31 FF BE 20 7C B9 0C 00 B4 0A FC AC AB E2 FC F4 EB FD 68 65 6C 6C 6F 2C 20 77 6F 72 6C 64 | xxd -r -p > BOOT2.IMG
echo 55 aa | xxd -r -p | dd seek=510 bs=1 of=BOOT2.IMG
```

To test this program with DOSBox, enter the following command:

```sh
dosbox -c CLS -c 'BOOT BOOT2.IMG'
```

To test this program with QEMU, enter the following command:

```sh
qemu-system-i386 -fda BOOT2.IMG
```


### BOOT3

Enter the following command to assemble this program and write it to
the boot sector of drive. Read the caution at the top of this section
before proceeding:

```
DEBUG < BOOT3.TXT
```

Here is how the output looks:

```
C:\>DEBUG < BOOT3.TXT
-A
1165:0100 JMP 0:7C05
1165:0105 MOV AX, B800
1165:0108 MOV DS, AX
1165:010A XOR DI, DI
1165:010C MOV SI, 7C21
1165:010F MOV AH, A
1165:0111 CS: MOV AL, [SI]
1165:0114 MOV [DI], AX
1165:0116 INC SI
1165:0117 INC DI
1165:0118 INC DI
1165:0119 CMP DI, 18
1165:011C JNE 111
1165:011E HLT
1165:011F JMP 11E
1165:0121 DB 'hello, world'
1165:012D
-E 2FE 55 AA
-W 100 2 0 1
-Q

C:\>
```

On a Unix or Linux system, the boot sector image can be created with the following command:

```sh
echo EA 05 7C 00 00 B8 00 B8 8E D8 31 FF BE 21 7C B4 0A 2E 8A 04 89 05 46 47 47 83 FF 18 75 F3 F4 EB FD 68 65 6C 6C 6F 2C 20 77 6F 72 6C 64 | xxd -r -p > BOOT3.IMG
echo 55 aa | xxd -r -p | dd seek=510 bs=1 of=BOOT3.IMG
```

To test this program with DOSBox, enter the following command:

```sh
dosbox -c CLS -c 'BOOT BOOT3.IMG'
```

To test this program with QEMU, enter the following command:

```sh
qemu-system-i386 -fda BOOT3.IMG
```
