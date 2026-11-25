Short Answer
============
1. What is the purpose of the STRUCT directive?
\-\>관련된 여러 데이터를 하나의 자료형으로 묶는 구조체의 틀을 정의하는 것

2. Assume that the following structure has been defined:
```asm
RentalInvoice STRUCT
invoiceNum BYTE 5 DUP(' ')
dailyPrice WORD ?
daysRented WORD ?
RentalInvoice ENDS
```
State whether or not each of the following declarations is valid:
a. rentals RentalInvoice <>
b. RentalInvoice rentals <>
c. march RentalInvoice <'12345',10,0>
d. RentalInvoice <,10,0>
e. current RentalInvoice <,15,0,0>
\-\> a = 유효, b = 유효하지 않음, c = 유효, d = 유효하지 않음, e = 유효하지 않음 

3. (True/False): A macro cannot contain data definitions.
\-\> false

4. What is the purpose of the LOCAL directive?
\-\> 각 매크로 확장마다 고유한 이름으로 만들어 중복 선언을 방지

5. Which directive displays a message on the console during the assembly step?
\-\> echo

6. Which directive marks the end of a conditional block of statements?
\-\> endif

7. List all the relational operators that can be used in constant boolean expressions.
\-\> lt, gt, eq, ne, le, ge

8. What is the purpose of the & operator in a macro definition?
\-\> 매크로 매개변수의 값을 문자열 리터럴 내부에 삽입하도록 하는 치환 연산자

9. What is the purpose of the ! operator in a macro definition?
\-\> 특수 문자를 연산자로 해석하지 않고 일반 문자 그대로 처리하도록 하는 리터럴 문자 연산자

10. What is the purpose of the % operator in a macro definition?
\-\> 텍스트 매크로나 상수 표현식을 확장하거나 계산하여 텍스트 형태로 변환하는 확장 연산자

Algorithm Workbench
===================
1. Create a structure named SampleStruct containing two fields: field1, a single 16-bit WORD, and
field2, an array of 20 32-bit DWORDs. The initial values of the fields may be left undefined.
\-\> ```asm
SampleStruct STRUCT
    field1 WORD ?
    field2 DWORD 20 DUP(?)
SampleStruct ENDS
```

2. Write a statement that retrieves the wHour field of a SYSTEMTIME structure.
\-\>
```asm
.data
time SYSTEMTIME <>

.code   
mov ax, time.wHour
```

3. Using the following Triangle structure, declare a structure variable and initialize its vertices
to (0,0), (5, 0), and (7,6):
```asm
Triangle STRUCT
Vertex1 COORD <>
Vertex2 COORD <>
Vertex3 COORD <>
Triangle ENDS
```
\-\>
```asm
myShape Triangle <<0,0>, <5,0>, <7,6>>
```

4. Declare an array of Triangle structures. Write a loop that initializes Vertex1 of each triangle
to random coordinates in the range (0...10, 0...10).
\-\>
```asm
.data
ARRAY_SIZE = 5
triangles Triangle ARRAY_SIZE DUP(<>)

.code
mov ecx, ARRAY_SIZE
mov esi,0

L1:
    mov eax, 11
    call RandomRange
    mov triangles[esi].Vertex1.X, ax

    mov eax, 11
    call RandomRange
    mov triangles[esi].Vertex.Y, ax

    add esi, TYPE Triangle
    loop L1
```

5. Write a macro named mPrintChar that displays a single character on the screen. It should
have two parameters: this first specifies the character to be displayed and the second speci
fies how many times the character should be repeated. Here is a sample call:
```asm
mPrintChar 'X',20
```
\-\>
```asm
myPrintChar MACRO char,count
    LOCAL temp
    .data
    temp BYTE count DUP(&char),0
    .code
    push edx
    mov edx, OFFSET temp
    call WriteString
    pop edx
ENDM
```
6. Write a macro named mGenRandom that generates a random integer between 0 and n 1.
Let n be the only parameter.
\-\>
```asm
mGenRandom MACRO n
    mov eax, n
    call RandomRange
ENDM
```

7. Write a macro named mPromptInteger that displays a prompt and inputs an integer from
the user. Pass it a string literal and the name of a doubleword variable. Sample call:
```asm
.data
minVal DWORD ?
.code
mPromptInteger "Enter the minimum value", minVal
```
\-\>
```asm
mPromptInteger MACRO prompt, returnVal
    mWrite prompt
    call ReadInt
    mov returnVal, eax
ENDM
```

8. Write a macro named mWriteAt that locates the cursor and writes a string literal to the console
window. Suggestion: Invoke the mGotoxy and mWrite macros from the book’s macro library.
\-\>
```asm
mWriteAt MACRO X,Y,literal
    mGotoxy X,Y
    mWrite literal
ENDM
```

9. Show the expanded code produced by the following statement that invokes the mWrite
String macro from Section 10.2.5:
```asm
mWriteStr namePrompt
```
\-\>
```asm
push edx
mov edx, OFFSET namePrompt
call WriteString
pop edx
```

10. Show the expanded code produced by the following statement that invokes the mRead
String macro from Section 10.2.5:
```asm
mReadStr customerName
```
\-\>
```asm
push ecx
push edx
mov edx, OFFSET customerName
mov ecx, (SIZEOF customerName)-1
call ReadString
pop edx
pop ecx
```

11. Write a macro named mDumpMemx that receives a single parameter, the name of a variable.
Your macro must call the mDumpMem macro from the book’s library, passing it the variable’s
offset, number of units, and unit size. Demonstrate a call to the mDumpMemx macro.
\-\>
```asm
mDumpMem MACRO varName
    mDumpMem OFFSET varName, LENGTHOF varName, TYPE varName
ENDM
```

12. Show an example of a macro parameter having a default argument initializer.
\-\>
```asm
mWriteLn MACRO text=<" ">
    mWrite text
    call Crlf
ENDM
```

13. Write a short example that uses the IF, ELSE, and ENDIF directives.
\-\>
```asm
mCopyWord MACRO intVal
    IF (TYPE intVal) EQ 2
        mov ax, intVal
    ELSE
        ECHO Invalid Operand Size
    ENDIF
ENDM
```

14. Write a statement using the IF directive that checks the value of the constant macro parame
ter Z; if Z is less than zero, display a message during assembly indicating that Z is invalid.
\-\>
```asm
mCheck MACRO z
    IF z LT 0
        ECHO Operand z is invalid
    ENDIF
ENDM
```

15. Write a short macro that demonstrates the use of the & operator when the macro parameter
is embedded in a literal string.
\-\>
```asm
CreateString MACRO strVal
    LOCAL temp
    .data
    temp BYTE "Val&strVal",0
    .code
ENDM
```

16. Assume the following mLocate macro definition:
```asm
mLocate MACRO xval,yval
    IF xval LT 0    ;; xval < 0?
        EXITM       ;; if so, exit
    ENDIF
    IF yval LT 0    ;; yval < 0?
        EXITM       ;; if so, exit
    ENDIF
    mov bx,0        ;; video page 0
    mov ah,2        ;; locate cursor
    mov dh,yval
    mov dl,xval
    int 10h         ;; call the BIOS
ENDM
```
Show the source code generated by the preprocessor when the macro is expanded by each of
the following statements:
```asm
.data
    row BYTE 15
    col BYTE 60
.code
    mLocate -2,20
    mLocate 10,20
    mLocate col,row
```
\-\>
mLocate -2,20
```asm
없음
```
mLocate 10,20
```asm
    mov bx,0      
    mov ah,2        
    mov dh,20
    mov dl,10
```
mLocate col,row
```asm
    mov bx,0      
    mov ah,2        
    mov dh,row
    mov dl,col
```

Programming Exercises
=====================
1. mReadkey Macro
Create a macro that waits for a keystroke and returns the key that was pressed. The macro
should include parameters for the ASCII code and keyboard scan code. Hint: Call ReadChar
from the book’s link library. Write a program that tests your macro. For example, the follow
ing code waits for a key; when it returns, the two arguments contain the ASCII code and scan
code:
```asm
.data
ascii BYTE ?
scan BYTE ?
.code
mReadkey ascii, scan
```
\-\>
```asm
mReadkey MACRO asciiArg, scanArg
    call ReadChar
    mov asciiArg, al
    mov scanArg, ah
ENDM
```
```asm
INCLUDE Irvine32.inc

mReadkey MACRO asciiArg, scanArg
    call ReadChar
    mov asciiArg, al
    mov scanArg, ah
ENDM

.data
ascii BYTE ?
scan BYTE ?

.code
main PROC
    mReadkey ascii, scan

    movzx eax, ascii
    call WriteHex
    call Crlf

    movzx eax, scan
    call WriteHex
    Call Crlf

    exit
main ENDP
END main
```
2. mWritestringAttr Macro 
(Requires reading ahead to Section 11.1.11.) Create a macro that writes a null-terminated string to
the console with a given text color. The macro parameters should include the string name and the
color. Hint: Call SetTextColor from the book’s link library. Write a program that tests your macro
with several strings in different colors. Sample call:
```asm
.data
myString db "Here is my string",0
.code
mWritestring myString, white
```
\-\>
```asm
mWriteStringAttr MACRO stringName, textColor
    mov eax, textColor
    call SetTextColor
    mov edx, OFFSET stringName
    call WriteString
ENDM
```
```asm
INCLUDE Irivine32.inc

mWriteStringAttr MACRO stringName, textColor
    mov eax, textColor
    call SetTextColor
    mov edx, OFFSET stringName
    call WriteString
ENDM

.data
str1 BYTE "Red text",0
str2 BYTE "Green text",0
str3 BYTE "Blue text",0

.code
main PROC
    mWriteStringAttr str1, red
    call Crlf

    mWriteStringAttr str2, lightgreen
    call Crlf

    mWriteStringAttr str3, blue
    call Crlf

    mov eax, white
    call SetTextColor

    exit
main ENDP

END main
```

3. mMove32 Macro
Write a macro named mMove32 that receives two 32-bit memory operands. The macro should
move the source operand to the destination operand. Write a program that tests your macro.
\-\>
```asm
mMove32 MACRO destination, source
    push eax
    mov eax,source
    mov destination, eax
    pop eax
ENDM
```
```asm
INCLUDE Irvine32.inc

mMove32 MACRO destination, source
    push eax
    mov eax, source
    mov destination, eax
    pop eax
ENDM

.data
sourceVal DWORD 12345678h
destVal DWORD ?

.code
main PROC
    mMove32 destVal, sourceVal

    mov eax, destVal
    call WriteHex
    call Crlf

    exit
main ENDP
END main
```

4. mMult32 Macro
Create a macro named mMult32 that multiplies two 32-bit memory operands and produces a
32-bit product. Write a program that tests your macro.
\-\>
```asm
mMult32 MACRO destination, operand1, operand2
    push eax
    push edx

    mov eax, operand1
    mul DWORD PTR operand2
    mov destination, eax

    pop edx
    pop eax
ENDM
```
```asm
INCLUDE Irvine32.inc

mMult32 MACRO destination, operand1, operand2
    push eax
    push edx

    mov eax, operand1
    mul DWORD PTR operand2
    mov destination, eax

    pop edx
    pop eax
ENDM

.data
value1 DWORD 1200
value2 DWORD 30
product DWORD ?

.code
main PROC
    mMult32 product, value1, value2

    mov eax, product
    call WriteDec
    call Crlf

    exit
main ENDP
END main
```

5. mReadInt Macro
Create a macro named mReadInt that reads a 16- or 32-bit signed integer from standard input and
returns the value in an argument. Use conditional operators to allow the macro to adapt to the size
of the desired result. Write a program that tests the macro, passing it operands of various sizes. 
\-\>
```asm
mReadInt MACRO destination
    call ReadInt

    IF TYPE destination EQ 2
        mov WORD PTR destination, ax
    ELSEIF TYPE destination EQ 4
        mov DWORD PTR destination, eax
    ENDIF
ENDM
```
```asm
INCLUDE Irvine32.inc

mReadInt MACRO destination
    call ReadInt

    IF TYPE destination EQ 2
        mov WORD PTR destination, ax
    ELSEIF TYPE destination EQ 4
        mov DWORD PTR destination, eax
    ENDIF
ENDM

.data
shortValue SWORD ?
longValue SDWORD ?

.code
main PROC
    mReadInt shortValue
    mReadInt longValue

    movzx eax,shortValue
    call WriteInt
    call Crlf

    mov eax, longValue
    call WriteInt
    call Crlf

    exit
main ENDP
END main
```

6. mWriteInt Macro
Create a macro named mWriteInt that writes a signed integer to standard output by calling
the WriteInt library procedure. The argument passed to the macro can be a byte, word, or
doubleword. Use conditional operators in the macro so it adapts to the size of the argument.
Write a program that tests the macro, passing it arguments of different sizes.
\-\>
```asm
mWriteInt MACRO source
    IF TYPE source EQ 1
        movsz eax, BYTE PTR source
    ELSEIF TYPE source EQ 2
        movsz eax, WORD PTR source
    ELSEIF TYPE source EQ 4
        movsz eax, DWORD PTR source
    ENDIF

    call WriteInt
ENDM
```
```asm
INCLUDE Irvine32.inc

mWriteInt MACRO source
    IF TYPE source EQ 1
        movxz eax, BYTE PTR source
    ELSEIF TYPE source EQ 2
        movsz eax, WORD PTR source
    ELSEIF TYPE source EQ 4
        movsz eax, DWORD PTR source
    ENDIF

    call WriteInt
ENDM

.data
byteValue SBYTE -12
wordValue SWORD -1234
dwordValue SDWORD -123456

.code
main PROC
    mWriteInt byteValue
    call Crlf
    
    mWriteInt wordValue
    call Crlf

    mWriteInt dwordValue
    call Crlf
    
    exit
main ENDP
END main
```

7. The Professsor’s Lost Phone
When the professor took the drunkard's walk around campus in Section 10.1.6, we discovered that
he lost his cell phone somewhere along the path. When you simulate the drunken walk, your pro
gram must drop the phone wherever the professor is standing at some random time interval. Each
time you run the program, the cell phone will be lost at a different time interval (and location).
\-\>
```asm
.data
MAX_STEP EQU 100
stepCount DWORD 0
dropStep DWORD ?
professorX SDWORD ?
professorY SDWORD ?
phoneX SDWORD ?
phoneY SDWORD ?
phoneLost BYTE 0

.code
call Randomize
mov eax, MAX_STEP
call RandomRange
inc eax
mov dropStep, eax
mov stepCount, 0
mov phoneLost, 0

inc stepCount
mov eax, stepCount
cmp eax, dropStep
jnz ContinueWalk

mov eax, professorX
mov phoneX, eax
mov eax, professorY
mov phoneY, eax
mov phoneLost, 1

ContinueWalk:
```

8. Drunkard’s Walk with Probabilities
When testing the DrunkardWalk program, you may have noticed that the professor doesn’t seem
to wander very far from the starting point. This is no doubt caused by an equal probability of the
professor moving in any direction. Modify the program so there is a 50% probability the professor
will continue to walk in the same direction as he or she did when taking the previous step. There
should be a 10% probability that he or she will reverse direction and a 20% probability that he or
she will turn either right or left. Assign a default starting direction before the loop begins. 
\-\>
```asm
NORTH EQU 0
EAST  EQU 1
SOUTH EQU 2
WEST  EQU 3

.data
direction DWORD ?

.code
call Randomize
mov direction, NORTH

WalkLoop:
    mov eax, 100
    call RandomRange 

    cmp eax, 50
    jb KeepDirection         

    cmp eax, 60
    jb ReverseDirection    

    cmp eax, 80
    jb TurnRight           

    ; 80~99: 20% 왼쪽
TurnLeft:
    mov eax, direction
    add eax, 3
    and eax, 3
    mov direction, eax
    jmp MoveProfessor

ReverseDirection:
    mov eax, direction
    add eax, 2
    and eax, 3
    mov direction, eax
    jmp MoveProfessor

TurnRight:
    mov eax, direction
    inc eax
    and eax, 3
    mov direction, eax
    jmp MoveProfessor

KeepDirection:


MoveProfessor:

```

9. Shifting Multiple Doublewords
Create a macro that shifts an array of 32-bit integers a variable number of bits in either direction,
using the SHRD and SHLD instructions. Write a test program that tests your macro by shifting
the same array in both directions and displaying the resulting values. You can assume that the
array is in little-endian order. Here is a sample macro declaration:
```asm
mShiftDoublewords MACRO arrayName, direction, numberOfBits
Parameters:
   arrayName        Name of the array
   direction        Right (R) or Left (L)
   numberOfBits     Number of bit positions to shift
```
\-\>
```asm
mShiftDoublewords MACRO arrayName, direction, numberOfBits
    LOCAL chunkLoop, chunkReady, leftLoop, leftLow, rightLoop, rightHigh, shiftDone

    push eax
    push ecx
    push edx
    push esi

    mov edx, numberOfBits
    test edx, edx
    jz shiftDone

chunkLoop:
    mov ecx, edx
    cmp ecx, 31
    jbe chunkReady
    mov ecx, 31

chunkReady:
    IFIDNI <direction>, <L>
        mov esi, LENGTHOF arrayName - 1

leftLoop:
        cmp esi, 0
        je leftLow
        mov eax, arrayName[esi*4-4]
        shld arrayName[esi*4], eax, cl
        dec esi
        jmp leftLoop

leftLow:
        shl arrayName[0], cl

    ELSE
        xor esi, esi

rightLoop:
        cmp esi, LENGTHOF arrayName - 1
        jae rightHigh
        mov eax, arrayName[esi*4+4]
        shrd arrayName[esi*4], eax, cl
        inc esi
        jmp rightLoop

rightHigh:
        shr arrayName[esi*4], cl
    ENDIF

    sub edx, ecx
    jnz chunkLoop

shiftDone:
    pop esi
    pop edx
    pop ecx
    pop eax
ENDM
```
```asm
INCLUDE Irvine32.inc

.data
values DWORD 12345678h, 9ABCDEF0h, 13579BDFh, 2468ACE0h

.code
main PROC
    mShiftDoublewords values, L, 4
    mov esi, OFFSET values
    mov ecx, LENGTHOF values
    mov ebx, TYPE values
    call DumpMem

    mov values[0], 12345678h
    mov values[4], 9ABCDEF0h
    mov values[8], 13579BDFh
    mov values[12], 2468ACE0h

    mShiftDoublewords values, R, 4
    mov esi, OFFSET values
    mov ecx, LENGTHOF values
    mov ebx, TYPE values
    call DumpMem

    exit
main ENDP
END main
```

10. Three-Operand Instructions
Some computer instruction sets permit arithmetic instructions with three operands. Such opera
tions sometimes appear in simple virtual assemblers used to introduce students to the concept of
assembly language or using intermediate language in compilers. In the following macros,
assume EAX is reserved for macro operations and is not preserved. Other registers modified by
the macro must be preserved. All parameters are signed memory doublewords. Write macros
that simulate the following operations:
```asm
a. add3 destination, source1, source2
b. sub3 destination, source1, source2 (destination =  source1 - source2)
c. mul3 destination, source1, source2
d. div3 destination, source1, source2 (destination =  source1 / source2)
```
For example, the following macro calls implement the expression x = (w+y)*z
```asm
.data
    temp DWORD ?
.code
    add3 temp, w, y     ; temp = w + y
    mul3 x, temp, z     ; x = temp * z
```
Write a program that tests your macros by implementing four arithmetic expressions, each
involving multiple operations.
\-\>
```asm
add3 MACRO destination, source1, source2
    mov eax, source1
    add eax, source2
    mov destination, eax
ENDM

sub3 MACRO destination, source1, source2
    mov eax, source1
    sub eax, source2
    mov destination, eax
ENDM

mul3 MACRO destination, source1, source2
    mov eax, source1
    imul eax, source2
    mov destination, eax
ENDM

div3 MACRO destination, source1, source2
    push edx
    mov eax, source1
    cdq
    idiv DWORD PTR source2
    mov destination, eax
    pop edx
ENDM
```
```asm
INCLUDE Irvine32.inc

.data
a SDWORD 20
b SDWORD 5
c SDWORD 3

temp1 SDWORD ?
temp2 SDWORD ?
temp3 SDWORD ?
temp4 SDWORD ?

result1 SDWORD ?
result2 SDWORD ?
result3 SDWORD ?
result4 SDWORD ?

.code
main PROC
    add3 temp1, a, b
    mul3 result1, temp1, c

    sub3 temp2, a, b
    add3 result2, temp2, c

    mul3 temp3, a, b
    sub3 result3, temp3, c

    div3 temp4, a, b
    mul3 result4, temp4, c

    mov eax, result1
    call WriteInt
    call Crlf

    mov eax, result2
    call WriteInt
    call Crlf

    mov eax, result3
    call WriteInt
    call Crlf

    mov eax, result4
    call WriteInt
    call Crlf

    exit
main ENDP
END main
```