Short Answer 
============

1. Which statements belong in a procedure’s epilogue when the procedure has stack parame
ters and local variables?
\-\> RET

2. When a C function returns a 32-bit integer, where is the return value stored?
\-\> EAX

3. How does a program using the STDCALL calling convention clean up the stack after a pro
cedure call?
\-\> 호출된 함수가 스택을 직접 정리한다

4. How is the LEA instruction more powerful than the OFFSET operator?
\-\> OFFSE은 변수의 고정된 오프셋을 구할 떄 쓴다, LEA는 주소 계산식 전체를 처리한다

5. In the C++ example shown in Section 8.2.3, how much stack space is used by a variable of
type int?
\-\> 4byte

6. What advantages might the C calling convention have over the STDCALL calling
convention?
\-\> C 호출 규약은 호출자가 스택 매개변수를 정리하므로, 가변 개수의 매개변수를 받는 함수를 구현하기에 유리합니다.

7. (True/False): When using the PROC directive, all parameters must be listed on the same
line.
\-\> False

8. (True/False): If you pass a variable containing the offset of an array of bytes to a procedure
that expects a pointer to an array of words, the assembler will flag this as an error.
\-\> True

9. (True/False): If you pass an immediate value to a procedure that expects a reference param
eter, you can generate a general-protection fault.
\-\> True

Algorithm Workbench
===================

1. Here is a calling sequence for a procedure named AddThree that adds three doublewords
(assume that the STDCALL calling convention is used):
```asm
push 10h
push 20h
push 30h
call AddThree
```
Draw a picture of the procedure’s stack frame immediately after EBP has been pushed on
the runtime stack.
\-\>
```md
             높은 주소
        ┌──────────────────────┐
[EBP+16]│ 10h                  │ 첫 번째로 push한 인수
        ├──────────────────────┤
[EBP+12]│ 20h                  │ 두 번째로 push한 인수
        ├──────────────────────┤
 [EBP+8]│ 30h                  │ 세 번째로 push한 인수
        ├──────────────────────┤
 [EBP+4]│ 복귀 주소             │ CALL이 저장한 주소
        ├──────────────────────┤
   [EBP]│ 호출자의 이전 EBP     │ PUSH EBP로 저장
        └──────────────────────┘
             낮은 주소
```
2. Create a procedure named AddThree that receives three integer parameters and calculates
and returns their sum in the EAX register.
\-\>
```asm
AddThree PROC STDCALL,
    num1:DWORD,
    num2:DWORD,
    num3:DWORD

    push ebp
    mov ebp, esp

    mov eax, num1
    add eax, num2
    add eax, num3

    pop ebp
    ret 12
AddThree ENDP
```

3. Declare a local variable named pArray that is a pointer to an array of doublewords.
\-\>
```asm
LOCAL pArray:PTR DWORD
```

4. Declare a local variable named buffer that is an array of 20 bytes.
\-\>
```asm
LOCAL buffer[20]:BYTE
```

5. Declare a local variable named pwArray that points to a 16-bit unsigned integer.
\-\>
```asm
LOCAL pwArray:PTR WORD
```

6. Declare a local variable named myByte that holds an 8-bit signed integer.
\-\>
```asm
LOCAL myByte:PTR SBYTE
```

7. Declare a local variable named myArray that is an array of 20 doublewords.
\-\>
```asm
LOCAL myArray[20]:DWORD
```

8. Create a procedure named SetColor that receives two stack parameters: forecolor and back
color, and calls the SetTextColor procedure from the Irvine32 library. 
\-\>
```asm
SetColor PROC STDCALL,
    forecolor:DWORD,
    backcolor:DWORD

    mov eax,backcolor
    shl eax, 4
    or eax,forecolor
    call SetTextColor

    ret 8
SetColor ENDP
```

9. Create a procedure named WriteColorChar that receives three stack parameters: char,
forecolor, and backcolor. It displays a single character, using the color attributes specified in
forecolor and backcolor.
\-\>
```asm
WriteColorChar PROC STDCALL USES eax,
    char:DWORD,
    forecolor:DWORD,
    backcolor:DWORD

    mov eax,backcolor
    shl eax, 4
    or eax, forecolor
    call SetTextColor

    mov al, BYTE PTR char
    call WriteChar

    ret 12
WriteColorChar ENDP
```

10. Write a procedure named DumpMemory that encapsulates the DumpMem procedure in the
Irvine32 library. Use declared parameters and the USES directive. The following is an
example of how it should be called: INVOKE DumpMemory, OFFSET array, LENGTHOF
array, TYPE array.
\-\>
```asm
DumpMemory PROC STDCALL USES esi ecx ebx,
    pArray:PTR BYTE,
    itemCount:DWORD,
    itemSize:DWORD

    mov esi,pArray
    mov ecx,itemCount
    mov ebx,itemSize
    call DumpMem

    ret 12
DumpMemory ENDP
```


11. Declare a procedure named MultArray that receives two pointers to arrays of doublewords,
and a third parameter indicating the number of array elements.  Also, create a PROTO dec
laration for this procedure.
\-\>
```asm
MultiArray PROTO STDCALL,
    pArray:PTR DWORD,
    pArray2:PTR DWORD,
    elementCount: DWORD

MultiArray PROC STDCALL,
    pArray:PTR DWORD,
    pArray2:PTR DWORD,
    elementCount:DWORD

    ret 12
MultiArray ENDP
```

Programming Exercises
=====================

1. FindLargest Procedure
Create a procedure named FindLargest that receives two parameters: a pointer to a signed
doubleword array, and a count of the array’s length. The procedure must return the value of
the largest array member in EAX. Use the PROC directive with a parameter list when declar
ing the procedure. Preserve all registers (except EAX) that are modified by the procedure.
Write a test program that calls FindLargest and passes three different arrays of different
lengths. Be sure to include negative values in your arrays. Create a PROTO declaration for
FindLargest.
\-\>
```asm
INCLUDE Irvine32.inc

FindLargest PROTO, pArray:PTR SDWORD, arraySize:DWORD

.data
array1 SDWORD 6, -2, 43, 3
array2 SDWORD 4, 32
array3 SDWORD 10, 7, -5, 15, 3, 5

msg1 BYTE "array1 largest: ",0
msg2 BYTE "array2 largest: ",0
msg3 BYTE "array3 largest: ",0

.code
main PROC
    INVOKE FindLargest, ADDR array1, LENGTHOF array1
    mov edx, OFFSET msg1
    call WriteString
    call WriteInt
    call Crlf

    INVOKE FindLargest, ADDR array2, LENGTHOF array2
    mov edx, OFFSET msg2
    call WriteString
    call WriteInt
    call Crlf

    INVOKE FindLargest, ADDR array3, LENGTHOF array3
    mov edx, OFFSET msg3
    call WriteString
    call WriteInt
    call Crlf

    exit
main ENDP

FindLargest PROC USES esi ecx edx,
    pArray:PTR SDWORD
    arraySize:DWORD

    mov esi, pArray
    mov ecx, arraySize

    xor eax, eax
    cmp ecx, 0
    je FL_Done

    mov eax, [esi]
    add esi, TYPE SDWORD
    dec ecx
    jz FL_Done

FL_Loop:
    mov edx, [esi]
    cmp edx, eax
    jle FL_Next
    mov eax, edx

FL_Next:
    add esi, TYPE SDWORD
    loop FL_Loop

FL_Done:
    ret
FindLargest ENDP

END main
```

2. Chess Board
Write a program that draws an 8x8 chess board, with alternating gray and white squares. You
can use the SetTextColor and Gotoxy procedures from the Irvine32 library. Avoid the use of glo
bal variables, and use declared parameters in all procedures. Use short procedures that are
focused on a single task.
\-\>
```asm
INCLUDE Irvine32.inc

DrawSquare PROTO, xPos:DWORD, yPos:DWORD, bgColor:DWORD
DrawBoard PROTO, grayColor:DWORD, whiteColor:DWORD

.code
main PROC
    call Clrscr
    INVOKE DrawBoard, 7,15
    mov eax,0
    call SetTextColor
    exit
main ENDP

DrawSquare PROC USES eax ecx edx esi,
    xPos:DWORD
    yPos:DWORD
    bgColor:DWORD

    mov eax, bgColor
    shl eax, 4
    call SetTextColor

    mov esi,0

DS_Row:
    mov eax, yPos
    add eax, esi
    mov dh, al
    mov eax, xPos
    mov dl, al
    call Gotoxy

    mov ecx, 4

DS_Column:
    mov al, ' '
    call WriteChar
    loop DS_Column

    inc esi
    cmp esi, 2
    jb DS_Row
    
    ret
DrawSquare ENDP

DrawBoard PROC USES eax,
    grayColor:DWORD,
    whiteColor:DWORD

    LOCAL row:DWORD
    LOCAL col:DWORD
    LOCAL xPOS:DWORD
    LOVAL yPOS:DWORD
    LOCAL squareColor:DWORD

    mov row,0

DB_row:
    mov col,0
DB_Column:
    mov eax, col
    shl eax,2
    mov xPos, eax

    mov eax, row
    shl eax, 1
    mov yPos, eax

    mov eax, row
    add eax, col
    test eax, 1
    jnz DB_White

    mov eax, grayColor
    mov squareColor, eax
    jmp DB_Draw

DB_White:
    mov eax, whiteColor
    mov squareColor, eax

DB_Draw:
    INVOKE DrawSquare, xPos, yPos, squareColor

    inc col
    cmp col,8
    jb DB_Column

    inc row
    cmp row, 8
    jb DB_Row
    ret
DrawBoard ENDP

END main
```

3. Chess Board with Alternating Colors
This exercise extends Exercise 2. Every 500 milliseconds, change the color of the colored
squares and redisplay the board. Continue until you have shown the board 16 times, using all
possible 4-bit background colors. (The white squares remain white throughout.)
\-\>
```asm
INCLUDE Irvine32.inc

DrawSquare PROTO, xPos:DWORD, yPos:DWORD, bgColor:DWORD
DrawBoard PROTO, coloredColor:DWORD, whiteColor:DWORD

.code
main PROC
    mov ebx, 0

CB_Loop:
    call Clrscr
    INVOKE DrawBoard, ebx, 15
    mov eax,500
    call Delay

    inc ebx
    cmp ebx, 16
    jb CB_Loop

    mov eax, 0
    call SetTextColor
    exit
main ENDP

DrawSquare PROC USES eax ecx edx esi,
    xPos:DWORD
    yPos:DWORD
    bgColor:DWORD

    mov eax, bgColor
    shl eax, 4
    call SetTextColor
    
    mov esi,0

CBS_Row:
    mov eax, yPos
    add eax, esi
    mov dh, al
    mov eax, xPos
    mov dl, al
    call Gotoxy

    mov ecx, 4
CBS_Column:
    mov al, ' '
    call WriteChar
    loop CBS_Column

    inc esi
    cmp esi,2
    jb CBS_Column
    ret
DrawSquare ENDP

DrawBoard PROC USES eax,
    coloredColor:DWORD
    whiteColor:DWORD

    LOCAL row:DWORD
    LOCAL col:DWORD
    LOCAL xPos:DWORD
    LOCAL yPos:DWORD
    LOCAL squareColor:DWORD

    mov row,0

CDB_Row:
    mov col,0
CDB_Column:
    mov eax, col
    shl eax, 2
    mov xPos, eax
    
    mov eax,row
    shl eax, 1
    mov yPos,eax
    
    mov eax, row
    add eax, col
    test eax,1
    jnz CDB_White

    mov eax,coloredColor
    mov squareColor, eax
    jmp CDB_Draw

CDB_White:
    mov eax, whiteColor
    mov squareColor, eax

CDB_Draw:
    INVOKE DrawSquare, xPos, yPos, squareColor
    
    inc col
    cmp col,8
    jb CDB_Column

    inc row
    cmp row, 8
    jb CDB_Row
    ret
DrawBoard ENDP

END main

```

4. FindThrees Procedure
Create a procedure named FindThrees that returns 1 if an array has three consecutive values of
3 somewhere in the array. Otherwise, return 0. The procedure’s input parameter list contains a
pointer to the array and the array’s size. Use the PROC directive with a parameter list when
declaring the procedure. Preserve all registers (except EAX) that are modified by the procedure.
Write a test program that calls FindThrees several times with different arrays. 
\-\>
```asm
INCLUDE Irvine32.inc

FindThree PROTO, pArray:PTR SDWORD, arraySize:DWORD

.data
array1 SDWORD 1,3,3,3,8
array2 SDWORD 3,3,2,3,3
array3 SDWORD 3,3,3
array4 SDWORD 1,2,3,4,5

msg BYTE "Find Three result: ",0

.code
main PROC
    INVOKE FindThree, ADDR array1, LENGTHOF array1
    call DisplayResult

    INVOKE FindThree, ADDR array2, LENGTHOF array2
    call DisplayResult

    INVOKE FindThree, ADDR array3, LENGTHOF array3
    call DisplayResult

    INVOKE FindThree, ADDR array4, LENGTHOF array4
    call DisplayResult

    exit
main ENDP

DisplayResult PROC
    mov edx, OFFSET msg
    call WriteString
    call WriteDec
    call Crlf
    ret
DisplayResult ENDP

FindThree PROC USES esi ecx edx,
    pArray:PTR SDWORD,
    arraySize:DWORD

    mov esi, pArray
    mov ecx, arraySize
    xor edx, edx
    xor eax, eax

FT_Loop:
    cmp ecx,0
    je FT_Done

    cmp DWORD PRT [esi], 3
    jne FT_Reset

    inc edx
    cmp edx,3
    je FT_Found
    jmp FT_Next

FT_Reset:
    xor edx,edx

FT_Next:
    add esi, TYPE SDWORD
    dec, ecx
    jmp FT_Loop

FT_Found:
    mov eax,1

FT_Done:
    ret
FindThree ENDP

END main
```

5. DifferentInputs Procedure
Write a procedure named DifferentInputs that returns EAX = 1 if the values of its three input
parameters are all different; otherwise, return with EAX = 0. Use the PROC directive with a
parameter list when declaring the procedure. Create a PROTO declaration for your procedure,
and call it five times from a test program that passes different inputs.
\-\>
```asm
INVOKE Irvine32.inc

DifferentInputs PROTO, value1:DWORD, value2:DWORD, value3:DWORD

.data
resultMsg BYTE "Result: ",0

.code
main PROC
    INVOKE DifferentInputs, 10,20,30
    call ShowAnswer

    INVOKE DifferentInputs, 10,10,30
    call ShowAnswer

    INVOKE DifferentInputs, 5,8,5
    call ShowAnswer

    INVOKE DifferentInputs, 1,2,3
    call ShowAnswer

    INVOKE DifferentInputs, 7,7,7
    call ShowAnswer

    exit
ENDP main

ShowAnswer PROC
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteDec
    call Crlf
    ret
ShowAnswer ENDP

DifferentInputs PROC,
    value1:DWORD,
    value2:DWORD,
    value3:DWORD

    mov eax, 0
    
    mov edx, value1
    cmp edx, value2
    je DI_Done

    cmp edx, value3
    je DI_Done

    mov edx, value2
    cmp edx, value3
    je DI_Done

    mov eax,1

DI_Done:
    ret
DifferentInputs ENDP

END main
```

6. Exchanging Integers
Create an array of randomly ordered integers. Using the Swap procedure from Section 8.4.6 as a
tool, write a loop that exchanges each consecutive pair of integers in the array.
\-\>
```asm
INCLUDE Irvine32.inc

Swap PROTO, pValue1:PTR DWORD, pValue2:PTR DWORD

.data
intArray DWORD 8,3,12,5,1,10,6,2
arraySize = LENGTHOF intArray

beforeMsg BYTE "Before Swapping : ",0
afterMsg BYTE "After Swapping : ",0

.code
main ENDP
    mov edx, OFFSET beforeMsg
    call WriteString
    mov esi, OFFSET intArray
    mov ecx, arraySize
    call DisplayArray
    call Crlf

    mov esi,0
    mov ecx, arraySize/2

Ex_Loop:
    mov eax, OFFSET intArray
    lea edx, [eax+esi*TYPE DWORD]
    lea edi, [edx + TYPE DWORD]

    INVOKE Swap, edx, edi

    add esi,2
    loop EX_Loop

    mov edx, OFFSET afterMsg
    call WriteString
    mov esi, OFFSET intArray
    mov ecx, arraySize
    call DisplayArray
    call Crlf

    exit

main ENDP

Swap PROC USES eax esi edi,
    pValue1:PTR DWORD,
    pValue2:PTR DWORD

    mov esi, pValue1
    mov edi, pValue2

    mov eax, [esi]
    xchg eax, [edi]
    mov [esi], eax
    ret
Swap ENDP

DisplayArray PROC USES eax ecx esi
DA_Loop:
    mov eax, [esi]
    call WriteDec
    mov al, ' '
    call WriteChar
    add esi, TYPE DWORD
    loop DA_Loop
    ret
DisplayArray ENDP

END main
```

7. Greatest Common Divisor
Write a recursive implementation of Euclid’s algorithm for finding the greatest common divisor
(GCD) of two integers. Descriptions of this algorithm are available in algebra books and on the
Web. Write a test program that calls your GCD procedure five times, using the following pairs of
integers: (5,20), (24,18), (11,7), (432,226), (26,13). After each procedure call, display the GCD.
\-\>
```asm
INCLUDE Irvine32.inc

GCD PROTO, num1:DWORD, num2:DWORD

.data
msg BYTE "GCD = ",0

.code
main PROC
    INVOKE GCD, 5,20
    call DisplayGCD

    INVOKE GCD, 24,18
    call DisplayGCD

    INVOKE GCD, 11,7
    call DisplayGCD

    INVOKE GCD, 432,226
    call DisplayGCD

    INVOKE GCD, 26,13
    call DisplayGCD

    exit
ENDP main

DisplayGCD PROC
    mov edx, OFFSET msg
    call WriteString
    call WriteDec
    call Crlf
    ret
DisplayGCD ENDP

GCD PROC USES edx,
    num1:DWORD
    num2:DWORD

    LOCAL remainder:DWORD

    mov eax,num2
    cmp eax,0
    jne GCD_Recurse

    mov eax, num1
    ret

GCD_Recurse:
    mov eax,num1
    xor edx,edx
    div num2
    mov remainder, edx

    INVOKE GCD, num2, remainder
    ret
GCD ENDP

END main
```

8. Counting Matching Elements
Write a procedure named CountMatches that receives points to two arrays of signed double
words, and a third parameter that indicates the length of the two arrays. For each element xi in
the first array, if the corresponding yi in the second array is equal, increment a count. At the end,
return a count of the number of matching array elements in EAX. Write a test program that calls
your procedure and passes pointers to two different pairs of arrays. Use the INVOKE statement
to call your procedure and pass stack parameters. Create a PROTO declaration for Count
Matches. Save and restore any registers (other than EAX) changed by your procedure.
\-\>
```asm
INCLUDE Irvine32.inc

CountMatches PROTO,
    pArray1:PTR SDWORD,
    pArray2:PTR SDWORD,
    arraySize:DWORD

.data
array1 SDWORD 1, 5, 3, 7, 9
array2 SDWORD 1, 2, 3, 4, 9

array3 SDWORD -5, 10, 15, 20
array4 SDWORD -5, 11, 15, 18

msg BYTE "Matching elements: ",0

.code
main PROC
    INVOKE CountMatches, ADDR array1, ADDR array2, LENGTHOF array1
    call ShowCount

    INVOKE CountMatches, ADDR array3, ADDR array4, LENGTHOF array3
    call ShowCount

    exit
main ENDP

ShowCount PROC
    mov edx, OFFSET msg
    call WriteString
    call WriteDec
    call Crlf
    ret
ShowCount ENDP

CountMatches PROC USES esi edi ecx edx,
    pArray1:PTR SDWORD,
    pArray2:PTR SDWORD,
    arraySize:DWORD

    mov esi, pArray1
    mov edi, pArray2
    mov ecx, arraySize
    xor eax, eax

CM_Loop:
    cmp ecx, 0
    je CM_Done

    mov edx, [esi]
    cmp edx, [edi]
    jne CM_Next

    inc eax

CM_Next:
    add esi, TYPE SDWORD
    add edi, TYPE SDWORD
    dec ecx
    jmp CM_Loop

CM_Done:
    ret
CountMatches ENDP

END main
```

9. Counting Nearly Matching Elements
Write a procedure named CountNearMatches that receives pointers to two arrays of signed dou
blewords, a parameter that indicates the length of the two arrays, and a parameter that indicates the
maximum allowed difference (called diff) between any two matching elements. For each element
xi in the first array, if the difference between it and the corresponding yi in the second array is less
than or equal to diff, increment a count. At the end, return a count of the number of nearly match
ing array elements in EAX. Write a test program that calls CountNearMatches and passes pointers
to two different pairs of arrays. Use the INVOKE statement to call your procedure and pass stack
parameters. Create a PROTO declaration for CountMatches. Save and restore any registers (other
than EAX) changed by your procedure.
\-\>
```asm
INCLUDE Irvine32.inc

CountNearMatches PROTO,
    pArray1:PTR SDWORD,
    pArray2:PTR SDWORD,
    arraySize:DWORD,
    diff:DWORD

.data
array1 SDWORD 10, 20, 30, 40, 50
array2 SDWORD 12, 25, 27, 48, 60

array3 SDWORD -10, 0, 10, 20
array4 SDWORD -7, 3, 15, 30

msg BYTE "Nearly matching elements: ",0

.code
main PROC
    INVOKE CountNearMatches, ADDR array1, ADDR array2, LENGTHOF array1, 5
    call ShowNearCount

    INVOKE CountNearMatches, ADDR array3, ADDR array4, LENGTHOF array3, 5
    call ShowNearCount

    exit
main ENDP

ShowNearCount PROC
    mov edx, OFFSET msg
    call WriteString
    call WriteDec
    call Crlf
    ret
ShowNearCount ENDP

CountNearMatches PROC USES esi edi ecx edx ebx,
    pArray1:PTR SDWORD,
    pArray2:PTR SDWORD,
    arraySize:DWORD,
    diff:DWORD

    mov esi, pArray1
    mov edi, pArray2
    mov ecx, arraySize
    xor ebx, ebx       

CNM_Loop:
    cmp ecx, 0
    je CNM_Done

    mov eax, [esi]              
    mov edx, [edi]  


    cmp eax, edx
    jge CNM_XGreater


    sub edx, eax
    mov eax, edx
    jmp CNM_Check

CNM_XGreater:
    sub eax, edx

CNM_Check:
    cmp eax, diff
    ja CNM_Next
    inc ebx

CNM_Next:
    add esi, TYPE SDWORD
    add edi, TYPE SDWORD
    dec ecx
    jmp CNM_Loop

CNM_Done:
    mov eax, ebx
    ret
CountNearMatches ENDP

END main
```

10. Show Procedure Parameters
Write a procedure named ShowParams that displays the address and hexadecimal value of the
32-bit parameters on the runtime stack of the procedure that called it. The parameters are to be
displayed in order from the lowest address to the highest. Input to the procedure will be a single
integer that indicates the number of parameters to display. For example, suppose the following
statement in main calls MySample, passing three arguments:
```asm
INVOKE MySample, 1234h, 5000h, 6543h
```
Next, inside MySample, you should be able to call ShowParams, passing the number of param
eters you want to display:
```asm
MySample PROC first:DWORD, second:DWORD, third:DWORD
paramCount = 3
call ShowParams, paramCount
```
ShowParams should display output in the following format:
```asm
Stack parameters:--------------------------
Address 0012FF80 = 00001234
Address 0012FF84 = 00005000
Address 0012FF88 = 00006543
```
\-\>
```asm
INCLUDE Irvine32.inc

MySample PROTO, first:DWORD, second:DWORD, third:DWORD
ShowParams PROTO, paramCount:DWORD

.data
heading BYTE "Stack parameters:",0
separator BYTE "---------------------------",0
addressText BYTE "Address ",0
equalsText BYTE " = ",0

.code
main PROC
    INVOKE MySample, 1234h, 5000h, 6543h
    exit
main ENDP

MySample PROC USES eax,
    first:DWORD,
    second:DWORD,
    third:DWORD

    INVOKE ShowParams, 3
    ret
MySample ENDP

ShowParams PROC USES ebx esi edx,
    paramCount:DWORD
    mov esi, [ebp]
    add esi, 8                  

    mov edx, OFFSET heading
    call WriteString
    call Crlf

    mov edx, OFFSET separator
    call WriteString
    call Crlf

    mov ebx, paramCount

SP_Loop:
    cmp ebx, 0
    je SP_Done

    mov edx, OFFSET addressText
    call WriteString
    mov eax, esi
    call WriteHex

    mov edx, OFFSET equalsText
    call WriteString
    mov eax, [esi]
    call WriteHex
    call Crlf

    add esi, TYPE DWORD
    dec ebx
    jmp SP_Loop

SP_Done:
    ret
ShowParams ENDP

END main
```
