Review Questions and Exercises
==============================

1. What will be the value in EDX after each of the lines marked (a) and (b) execute?
```asm
    .data
    one WORD 8002h
    two WORD 4321h
    .code
    mov   edx,21348041h
    movsx edx,one           ; (a)
    movsx edx,two           ; (b)
```
\-\> (a) = FFFF8002h, (b) = 00004321h

2. What will be the value in EAX after the following lines execute?
```asm
    mov  eax,1002FFFFh
    inc ax
```
\-\> 10020000h

3. What will be the value in EAX after the following lines execute?
```asm
    mov  eax,30020000h
    dec  ax
```
\-\> 3002FFFFh

4. What will be the value in EAX after the following lines execute?
```asm
    mov  eax,1002FFFFh
    neg ax
```
\-\> 10020001


5. What will be the value of the Parity flag after the following lines execute?
```asm
    mov  al,1
    add  al,3
```
\-\> PF = 0

6. What will be the value of EAX and the Sign flag after the following lines execute? 
```asm
    mov  eax,5
    sub  eax,6
```
\-\> EAX = FFFFFFFF, SF = 1


7. In the following code, the value in AL is intended to be a signed byte. Explain how the
Overflow flag helps, or does not help you, to determine whether the final value in AL falls
within a valid signed range.
```asm
    mov al,-1
    add  al,130
```
\-\> OF = 0


8. What value will RAX contain after the following instruction executes?
```asm
    mov  rax,44445555h
```
\-\> 0000000044445555h

9. What value will RAX contain after the following instructions execute?
```asm
    .data
    dwordVal DWORD 84326732h
    .code
    mov  rax,0FFFFFFFF00000000h
    mov  rax,dwordVal
```
\-\> 0000000084326732h

10. What value will EAX contain after the following instructions execute?
```asm
    .data
    dVal DWORD 12345678h
    .code
    mov  ax,3
    mov  WORD PTR dVal+2,ax
    mov  eax,dVal
```
\-\> 00035678h

11. What will EAX contain after the following instructions execute?
```asm
    .data
    .dVal DWORD ?
    .code
    mov  dVal,12345678h
    mov  ax,WORD PTR dVal+2
    add  ax,3
    mov  WORD PTR dVal,ax
    mov  eax,dVal
```
\-\> 12341237h

12. (Yes/No): Is it possible to set the Overflow flag if you add a positive integer to a negative
integer?
\-\> No

13. (Yes/No): Will the Overflow flag be set if you add a negative integer to a negative integer
and produce a positive result?
\-\> YES

14. (Yes/No): Is it possible for the NEG instruction to set the Overflow flag?
\-\> YES

15. (Yes/No): Is it possible for both the Sign and Zero flags to be set at the same time?
Use the following variable definitions for Questions 16–19:
===========================================================
```asm
    .data
    var1 SBYTE -4,-2,3,1
    var2 WORD 1000h,2000h,3000h,4000h
    var3 SWORD -16,-42
    var4 DWORD 1,2,3,4,5
```
\-\> NO

16. For each of the following statements, state whether or not the instruction is valid:
    a. mov   ax,var1? \-\> NO
    b. mov   ax,var2 \-\> YES
    c. mov   eax,var3 \-\> NO
    d. mov   var2,var3 \-\> NO
    e. movzx ax,var2 \-\> NO
    f. movzx var2,al \-\> NO
    g. mov   ds,ax \-\> YES
    h. mov   ds,1000h \-\> NO

17. What will be the hexadecimal value of the destination operand after each of the following
instructions execute in sequence?
```asm
    mov  al,var1        ; a.
    mov  ah,[var1+3]    ; b.
```
\-\> al = 01 ah = FCh


18. What will be the value of the destination operand after each of the following instructions
execute in sequence?
```asm
    mov  ax,var2            ; a. 
    mov  ax,[var2+4]        ; b. 
    mov  ax,var3            ; c. 
    mov  ax,[var3-2]        ; d. 
```
\-\> a = 1000 b = 4000 c = FFF0h d = 4000h


19. What will be the value of the destination operand after each of the following instructions
execute in sequence?
```asm
    mov    edx,var4             ; a. 
    movzx  edx,var2             ; b. 
    mov    edx,[var4+4]         ; c. 
    movsx  edx,var1             ; d. 
```
\-\> a = 00000001 b = 00001000h c = 00000002 d = FFFFFFFCh


Algorithm Workbench
===================

1. Write a sequence of MOV instructions that will exchange the upper and lower words in a
doubleword variable named three.
```asm
.data
three DWORD 12345678h

.code
mov ax, WORD PTR three
mov bx, WORD PTR three+2
mov WORD PTR three, bx
mov WORD PTR three+2, ax
```

2. Using the XCHG instruction no more than three times, reorder the values in four 8-bit regis
ters from the order A,B,C,D to B,C,D,A.
```asm
XCHG al, bl
XCHG bl, cl
XCHG cl, dl
```

3. Transmitted messages often include a parity bit whose value is combined with a data byte to
produce an even number of 1 bits. Suppose a message byte in the AL register contains
01110101. Show how you could use the Parity flag combined with an arithmetic instruction
to determine if this message byte has even or odd parity.
```asm
mov al, 01110101b
and al, al
jp EvenParity
jmp OddParity
```

4. Write code using byte operands that adds two negative integers and causes the Overflow
flag to be set.
```asm
mov al, -127
mov al, -1
```

5. Write a sequence of two instructions that use addition to set the Zero and Carry flags at the
same time.
```asm
mov al, 0FFh
add al, 1
```

6. Write a sequence of two instructions that set the Carry flag using subtraction.
```asm
mov al, 1
sub al, 2
```
7. Implement the following arithmetic expression in assembly language: EAX = –val2 + 7 - val3 + val1. Assume that val1, val2, and val3 are 32-bit integer variables.
```asm
.data
val1 DWORD 10
val2 DWORD 20
val3 DWORD 30

.code
mov eax, val2
neg eax
add eax, 7
sub eax, val3
add eax val1
```
8. Write a loop that iterates through a doubleword array and calculates the sum of its elements
using a scale factor with indexed addressing.
```asm
.data
array DWORD 10,20,30,40,50
ArraySize = LENGTHOF array

.code
mov eax, 0
mov esi, 0
mov ecx, ArraySize

L1:
    add eax, array[esi*TYPE array]
    inc esi
    loop L1
```
9. Implement the following expression in assembly language: AX = (val2 + BX) –val4.
Assume that val2 and val4 are 16-bit integer variables.
```asm
.data
val2 WORD 1000h
val4 WORD 0200h

.code
mov ax, val2
add ax, bx
sub ax, val4
```
10. Write a sequence of two instructions that set both the Carry and Overflow flags at the same time.
```asm
mov al,80h
add al,80h
```
11. Write a sequence of instructions showing how the Zero flag could be used to indicate
unsigned overflow after executing INC and DEC instructions.
```asm
mov al, 0FFh
inc al
jz IncOverflow

mov al, 00h
or al, al
jz DevOverflow
dec al
```
Use the following data definitions for Questions 12–18:
=======================================================
```asm
    .data
    myBytes  BYTE 10h,20h,30h,40h
    myWords  WORD 3 DUP(?),2000h
    myString BYTE "ABCDE"
```

12. Insert a directive in the given data that aligns myBytes to an even-numbered address.
```asm
.data
ALIGN 2
myBytes BYTE 10h, 20h, 30h, 40h
myWords WORD 3 DUP(?), 2000h
myString BYTE "ABCDE"
```
13. What will be the value of EAX after each of the following instructions execute?
```asm
    mov  eax,TYPE myBytes           ; a. 
    mov  eax,LENGTHOF myBytes       ; b. 
    mov  eax,SIZEOF myBytes         ; c. 
    mov  eax,TYPE myWords           ; d. 
    mov  eax,LENGTHOF myWords       ; e. 
    mov  eax,SIZEOF myWords         ; f. 
    mov  eax,SIZEOF myString        ; g. 
```
a = 1, b = 4, c = 4, d = 2, e = 4, f = 8, g = 5


14. Write a single instruction that moves the first two bytes in myBytes to the DX register. The
resulting value will be 2010h.
```asm
mov dx, WORD PTR myBytes
```

15. Write an instruction that moves the second byte in myWords to the AL register.
```asm
mov al, BYTE PTR [myWords+1]
```
16. Write an instruction that moves all four bytes in myBytes to the EAX register.
```asm
mov eax, DWORD PTR myBytes
```
17. Insert a LABEL directive in the given data that permits myWords to be moved directly to a
32-bit register.
```asm
.data
myBytes BYTE 10h,20h,30h,40h
myWordsD LABEL DWORD
myWords WORD 3 DUP(?) 2000h
myString BYTE "ABCDE"

.code
mov eax, myWordsD
```
18. Insert a LABEL directive in the given data that permits myBytes to be moved directly to a
16-bit register.
```asm
.data
myBytesW LABEL WORD
myBytes BYTE 10h,20h,30h,40h
myWords WORD 3 DUP(?) 2000h
myString BYTE "ABCDE"

.code
mov eax, myBytesW
```

Programming Exercises
=====================
1. Converting from Big Endian to Little Endian 
Write a program that uses the variables below and MOV instructions to copy the value from
bigEndian to littleEndian, reversing the order of the bytes. The number’s 32-bit value is under
stood to be 12345678 hexadecimal.
```asm
TITLE bigEndian to littleEndian

.386
.MODEL flat,stdcall

.data
bigEndian BYTE 12h,34h,56h,78h
littleEndain DWORD ?

.code
main PROC
    movzx eax, BYTE PTR bigEndian+3
    shl eax, 24

    movzx ebx, BYTE PTR bigEndian+2
    shl ebx, 16
    or eax,ebx

    movzx ebx, BYTE PTR bigEndian+1
    shl ebx, 8
    or eax,ebx

    movzx ebx, BYTE PTR bigEndian
    or eax,ebx

    mov littleEndain, eax

    exit

main ENDP
END main
```

2. Exchanging Pairs of Array Values
Write a program with a loop and indexed addressing that exchanges every pair of values in an
array with an even number of elements. Therefore, item i will exchange with item i+1, and item
i+2 will exchange with item i+3, and so on.
```asm
TITLE Exchange

.386
.MODEL flat, stdcall

.data
myArray DWORD 1,2,3,4,5,6
arraySize = {$-myArray}/TYPE myArray

.code
main PROC
    mov esi, 0
    mov ecx, arraySize/2

L1:
    mov eax, myArray[esi]
    mov edx, myArray[esi+4]

    xchg eax,edx

    mov myArray[esi], eax
    mov myArray[esi+4], edx

    add esi,8
    loop L1

    exit
main ENDP
END main

```

3. Summing the Gaps between Array Values
Write a program with a loop and indexed addressing that calculates the sum of all the gaps
between successive array elements. The array elements are doublewords, sequenced in nonde
creasing order. So, for example, the array {0, 2, 5, 9, 10} has gaps of 2, 3, 4, and 1, whose sum
equals 10.

```asm
TITLE Sum of Gap

.386
.MODEL flat, stdcall

.data
myArray DWORD 0,2,5,9,10
arraySize = {$-myArray} / TYPE myArray

.code
main PROC
    mov esi,0
    mov eax,0
    mov ecx, arraySize-1

L1:
    mov edx, myArray[esi+4]
    sub edx, myArray[esi]

    add eax, edx
    add esi, 4

    loop L1

    exit

main ENDP
END main
```

4. Copying a Word Array to a DoubleWord array
Write a program that uses a loop to copy all the elements from an unsigned Word (16-bit) array
into an unsigned doubleword (32-bit) array. 

```asm
TITLE Copy Array

.386
.MODEL flat, stdcall

.data
sourceArray WORD 100h, 200h, 300h, 400h
sourceSize = {$-sourceArray} / TYPE sourceArray

destArray DWORD sourceSize DUP(?)

.code
main PROC
    mov esi, 0
    mov edi, 0
    mov ecx, sourceSize

L1:
    movzx eax, sourceSize[esi]
    mov destArray[edi], eax

    add esi, 2
    add edi, 4

    loop L1
    
    exit

main ENDP
END main
```

5. Fibonacci Numbers
Write a program that uses a loop to calculate the first seven values of the Fibonacci number sequence,
described by the following formula: Fib(1) = 1, Fib(2) = 1, Fib(n) = Fib(n – 1) + Fib(n – 2).

```asm
TITLE Fibonacci

.386
.MODEL flat, stdcall

.data
fibonacci DWORD 7 DUP(?)

.code
main PROC
    mov fibonacci[0], 1
    mov fibonacci[4], 1

    mov ecx, 5
    mov esi, 8

L1:
    mov eax, fibonacci[esi-4]
    mov edx, fibonacci[esi-8]

    add eax, edx

    mov fibonacci[esi], eax
    add esi, 4
    
    loop L1
    exit
main ENDP
END main
```

6. Reverse an Array
Use a loop with indirect or indexed addressing to reverse the elements of an integer array in
place. Do not copy the elements to any other array. Use the SIZEOF, TYPE, and LENGTHOF
operators to make the program as flexible as possible if the array size and type should be
changed in the future.

```asm
TITLE Reverse Array

.386
.MODEL flat, stdcall

.data
myArray DWORD 10,20,30,40,50,60

arrayType = TYPE myArray
arrayLength = LENGTHOF myArray
arraySize = SIZEOF myArray

.code
main PROC
    mov esi, OFFSET myArray
    mov edi, OFFSET myArray + arraySize - arrayType

    mov ecx, arrayLength/2

L1:
    mov eax, [esi]
    mov edx, [edi]

    xchg eax, edx

    mov [esi], eax
    mov [edi], edx

    add esi, arrayType
    sub edi, arrayType

    loop L1
    exit

main ENDP
END main
```

7. Copy a String in Reverse Order
Write a program with a loop and indirect addressing that copies a string from source to target,
reversing the character order in the process. Use the following variables:
source BYTE "This is the source string",0
target BYTE SIZEOF source DUP('#')

```asm
TITLE Copy

.386
.MODEL flat, stdcall

.data
    source BYTE "string",0
    target BYTE SIZEOF source DUP('#')

    sourceLength = $-source-1

.code
main PROC
    mov esi, OFFSET source + sourceLength -1
    mov edi, OFFSET target

    mov ecx, sourceLength

L1:
    mov al, [esi]
    mov [edi], al

    dec esi
    inc edi

    loop L1

    mov BYTE PTR [edi],0
    exit

main ENDP
END main

```

8. Shifting the Elements in an Array
Using a loop and indexed addressing, write code that rotates the members of a 32-bit integer
array forward one position. The value at the end of the array must wrap around to the first posi
tion. For example, the array [10,20,30,40] would be transformed into [40,10,20,30].

```asm
TITLE Rotate

.386
.MODEL flat, stdcall

.data
myArray DWORD 10,20,30,40
arraySize = LENGTHOF myArray

.code
main PROC
    mov eax, myArray[arraySize*4-4]
    mov ebx, eax

    mov ecx, arraySize-1
    mov esi, (arraySize-1)*4

L1:
    mov edx, myArray[esi-4]
    mov myArray[esi], edx

    sub esi,4

    loop L1

    mov myArray[0], ebx
    
    exit
main ENDP
END main
```