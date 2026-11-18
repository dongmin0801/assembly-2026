Short Answer
============
1. Which Direction flag setting causes index registers to move backward through memory
when executing string primitives?
\-\> std, DF를 1로 설정

2. When a repeat prefix is used with STOSW, what value is added to or subtracted from the
index register?
\-\> EDI에 2비트

3. In what way is the CMPS instruction ambiguous?
\-\> 명시적으로 피연산자를 적을 수 있지만 실제 비교 대상의 주소는 이름이 아니라 ESI, EDI에 의해 결정된다는 점

4. When the Direction flag is clear and SCASB has found a matching character, where does
EDI point?
\-\> 일치한 문자의 주소보다 1바이트 큰 위치 

5. When scanning an array for the first occurrence of a particular character, which repeat pre
fix would be best?
\-\> REPNE, REPNZ

6. What Direction flag setting is used in the Str_trim procedure from Section 9.3?
\-\> std

7. Why does the Str_trim procedure from Section 9.3 use the JNE instruction?
\-\> 제거할 문자와 다른 문자를 만나 검색이 끝났는지 확인하여 EDI의 추가 보정을 건너뛰고 올바른 위치에 널 문자를 넣기 위함

8. What happens in the Str_ucase procedure from Section 9.3 if the target string contains a
digit?
\-\> 변환되지 않고 유지

9. If the Str_length procedure from Section 9.3 used SCASB, which repeat prefix would be
most appropriate?
\-\> REPNZ, REPNE

10. If the Str_length procedure from Section 9.3 used SCASB, how would it calculate and
return the string length?
\-\> 정방향으로 널 문자를 찾은 뒤 최종 EDI에서 문자열 시작 주소를 뺴고 다시 1을 뺀 값을 EAX로 반환

11. What is the maximum number of comparisons needed by the binary search algorithm when
an array contains 1,024 elements?
\-\> 11번

12. In the FillArray procedure from the Binary Search example in Section 9.5, why must the
Direction flag be cleared by the CLD instruction?
\-\> STOSD가 값을 저장할 떄마다 EDI를 4씩 증가시켜 배열을 정방향으로 채우기 위함

13. In the BinarySearch procedure from Section 9.5, why could the statement at label L2 be
removed without affecting the outcome?
\-\> 앞에서 CMP EDX, EDI를 실행했고 JGE는 플래그를 바꾸지 않으므로 같은 비교를 할 필요가 없어서

14. In the BinarySearch procedure from Section 9.5, how might the statement at label L4 be
eliminated?
\-\>JMP L4를 모두 JMP L1으로 바꾼다

Algorithm Workbench
==================

1. Show an example of a base-index operand in 32-bit mode.
\-\>
```asm
mov eax, [ebx+esi]
```
2. Show an example of a base-index-displacement operand in 32-bit mode.
\-\>
```asm
mov eax, [ebx+esi+8]
```

3. Suppose a two-dimensional array of doublewords has three logical rows and four logical
columns. Write an expression using ESI and EDI that addresses the third column in the sec
ond row. (Numbering for rows and columns starts at zero.)
\-\>
```asm
mov esi,2*(4*TYPE myArray)
mov edi,3

mov eax, myArray[esi+edi*4]
```

4. Write instructions using CMPSW that compare two arrays of 16-bit values named sourcew
and targetw.
\-\>
```asm
cld
mov esi, OFFSET sourcew
mov edi, OFFSET targetw
mov ecx, LENGTHOF sourcew

repe cmpsw
jne ArraysDifferent

jmp CompareDone

ArrayDifferent:
```

5. Write instructions that use SCASW to scan for the 16-bit value 0100h in an array named
wordArray, and copy the offset of the matching member into the EAX register.
\-\>
```asm
cld
mov edi, OFFSET wordArray
mov ecx, LENGTHOF wordArray
mov ax, 0100h

jecxz NotFound
repne scasw
jne NotFound

lea eax, [edi-2]
jmp ScanDone

NotFound:
    mov eax,-1
ScanDone:
```

6. Write a sequence of instructions that use the Str_compare procedure to determine the larger
of two input strings and write it to the console window.
\-\>
```asm
INVOKE Str_compare, ADDR string1, ADDR string2
ja PrintString1

mov edx, OFFSET string2
jmp PrintSelected

PrintString1:
    mov edx, OFFSET string1

PrintSelected:
    call WriteString
    call Crlf
```

7. Show how to call the Str_trim procedure and remove all trailing "@" characters from a
string.
\-\>
```asm
.data
myString BYTE "Hello@@@",0

.code
INVOKE Str_trim, ADDR myString,'@'
cld
```

8. Show how to modify the Str_ucase procedure from the Irvine32 library so it changes all
characters to lower case. 
\-\>
```asm
Str_lcase PROC USES eax esi,
    pString:PTR BYTE
    mov esi, pString

L1:
    mov al,[esi]
    cmp al,0
    je L3

    cmp al,'A'
    jb L2
```
9. Create a 64-bit version of the Str_trim procedure.
\-\>
```asm
Str_trim PROC
    mov r8,rcx

FindEnd:
    cmp BYTE PTR [r8], 0
    je TrimLoop
    inc r8
    jmp FindEnd

TrimLoop:
    cmp r8, rcx
    je SetNull

    cmp BYTE PTR [r8-1], dl
    jne SetNull

    dec r8
    jmp TrimLoop

SetNull:
    mov BYTE PTR [r8], 0
    ret

Str_trim ENDP
```

10. Show an example of a base-index operand in 64-bit mode.
\-\>
```asm
mov rax, [rbx+rsi]
```

11. Assuming that EBX contains a row index into a two-dimensional array of 32-bit integers
named myArray and EDI contains the index of a column, write a single statement that
moves the content of the given array element into the EAX register.
\-\>
```asm
mov eax, myArray[ebx+edi*4]
```

12. Assuming that RBX contains a row index into a two-dimensional array of 64-bit integers
named myArray and RDI contains the index of a column, write a single statement that
moves the content of the given array element into the RAX register.
\-\>
```asm
mov rax, myArray[rbx+rdi*8]
```

Programming Exercises
=====================
1. Improved Str_copy Procedure
The Str_copy procedure shown in this chapter does not limit the number of characters to be cop
ied. Create a new version (named Str_copyN) that receives an additional input parameter indi
cating the maximum number of characters to be copied.
\-\>
```asm
INCLUDE Irvine32.inc

Str_copyN PROTO,
    pSource:PTR BYTE,
    pTarget:PTR BYTE,
    maxChars:DWORD

.data
sourceStr BYTE "Assembly Language",0
targetStr BYTE 9 DUP(0)
msg BYTE "Copied string: ",0

.code
main PROC
    INVOKE Str_copyN, ADDR sourceStr, ADDR targetStr, 8

    mov edx, OFFSET msg
    call WriteString
    mov edx, OFFSET targetStr
    call WriteString
    call Crlf
    exit
main ENDP

Str_copyN PROC USES eax ecx esi edi,
    pSource:PTR BYTE,
    pTarget:PTR BYTE,
    maxChars:DWORD

    mov esi, pSource
    mov edi, pTarget
    mov ecx, maxChars

SCN_Loop:
    test ecx, ecx
    jz SCN_Terminate

    mov al, [esi]
    test al, al
    jz SCN_Terminate

    mov [edi], al
    inc esi
    inc edi
    dec ecx
    jmp SCN_Loop

SCN_Terminate:
    mov BYTE PTR [edi], 0
    ret
Str_copyN ENDP

END main
```

2. Str_concat Procedure
Write a procedure named Str_concat that concatenates a source string to the end of a target
string. Sufficient space must exist in the target string to accommodate the new characters. Pass
pointers to the source and target strings. Here is a sample call:
```asm
.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0
.code
INVOKE Str_concat, ADDR targetStr, ADDR sourceStr
```
\-\>
```asm
INCLUDE Irvine32.inc

Str_concat PROTO, pTarget:PTR BYTE, pSource:PTR BYTE

.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0

.code
main PROC
    INVOKE Str_concat, ADDR targetStr, ADDR sourceStr

    mov edx, OFFSET targetStr
    call WriteString
    call Crlf
    exit
main ENDP

Str_concat PROC USES eax esi edi,
    pTarget:PTR BYTE,
    pSource:PTR BYTE

    mov edi, pTarget

SCT_FindEnd:
    cmp BYTE PTR [edi], 0
    je SCT_CopyStart
    inc edi
    jmp SCT_FindEnd

SCT_CopyStart:
    mov esi, pSource

SCT_Copy:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    test al, al
    jnz SCT_Copy
    ret
Str_concat ENDP

END main
```

3. Str_remove Procedure
Write a procedure named Str_remove that removes n characters from a string. Pass a pointer to
the position in the string where the characters are to be removed. Pass an integer specifying the
number of characters to remove. The following code, for example, shows how to remove “xxxx”
from target:
```asm
.data
target BYTE "abcxxxxdefghijklmop",0
.code
INVOKE Str_remove, ADDR [target+3], 4
```
\-\>
```asm
INCLUDE Irvine32.inc

Str_concat PROTO, pTarget:PTR BYTE, pSource:PTR BYTE

.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0

.code
main PROC
    INVOKE Str_concat, ADDR targetStr, ADDR sourceStr

    mov edx, OFFSET targetStr
    call WriteString
    call Crlf
    exit
main ENDP

Str_concat PROC USES eax esi edi,
    pTarget:PTR BYTE,
    pSource:PTR BYTE

    mov edi, pTarget

SCT_FindEnd:
    cmp BYTE PTR [edi], 0
    je SCT_CopyStart
    inc edi
    jmp SCT_FindEnd

SCT_CopyStart:
    mov esi, pSource

SCT_Copy:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    test al, al
    jnz SCT_Copy
    ret
Str_concat ENDP

END main
```

4. Str_find Procedure
Write a procedure named Str_find that searches for the first matching occurrence of a source string
inside a target string and returns the matching position. The input parameters should be a pointer to
the source string and a pointer to the target string. If a match is found, the procedure sets the Zero
flag and EAX points to the matching position in the target string. Otherwise, the Zero flag is clear
and EAX is undefined. The following code, for example, searches for “ABC” and returns with EAX
pointing to the “A” in the target string:
```asm
.data
target BYTE "123ABC342432",0
source BYTE "ABC",0
pos    DWORD ?
.code
INVOKE Str_find, ADDR source, ADDR target
jnz notFound
mov pos,eax
; store the position value
```
\-\>
```asm
.data
    target BYTE "123ABC342432",0
    source BYTE "ABC",0
    pos DWORD ?
.code
    INVOKE Str_find, ADDR source, ADDR target
    jnz notFound
    mov pos,eax
```

5. Str_nextWord Procedure
Write a procedure called Str_nextWord that scans a string for the first occurrence of a certain
delimiter character and replaces the delimiter with a null byte. There are two input parameters: a
pointer to the string and the delimiter character. After the call, if the delimiter was found, the Zero
flag is set and EAX contains the offset of the next character beyond the delimiter. Otherwise, the
Zero flag is clear and EAX is undefined. The following example code passes the address of target
and a comma as the delimiter:
```asm
.data
target BYTE "Johnson,Calvin",0
.code
INVOKE Str_nextWord, ADDR target, ','
jnz notFound
```
In Figure 9-5, after calling Str_nextWord, EAX points to the character following the position
where the comma was found (and replaced). 
Figure 9–5 Str_nextWord example.
J o h n s o n *
Null bytes
C a l v i n *
EAX
\-\>
```asm
INCLUDE Irvine32.inc

Str_nextWord PROTO, pString:PTR BYTE, delimiter:BYTE

.data
    target BYTE "Johnson,Calvin",0
    nextPtr DWORD ?
    firstMsg BYTE "First word: ",0
    nextMsg BYTE "Next word: ",0
    missingMsg BYTE "Delimiter not found",0

.code
main PROC
    INVOKE Str_nextWord, ADDR target, ','
    jnz NoDelimiter

    mov nextPtr, eax

    mov edx, OFFSET firstMsg
    call WriteString
    mov edx, OFFSET target
    call WriteString
    call Crlf

    mov edx, OFFSET nextMsg
    call WriteString
    mov edx, nextPtr
    call WriteString
    call Crlf
    jmp ProgramDone

NoDelimiter:
    mov edx, OFFSET missingMsg
    call WriteString
    call Crlf

ProgramDone:
    exit
main ENDP

Str_nextWord PROC USES edx esi,
    pString:PTR BYTE,
    delimiter:BYTE

    mov esi, pString
    mov dl, delimiter

SNW_Loop:
    mov al, [esi]
    test al, al
    jz SNW_Missing

    cmp al, dl
    je SNW_Found

    inc esi
    jmp SNW_Loop

SNW_Found:
    mov BYTE PTR [esi], 0
    lea eax, [esi+1]
    cmp eax, eax                ; ZF = 1
    ret

SNW_Missing:
    xor eax, eax
    cmp eax, 1                  ; ZF = 0
    ret
Str_nextWord ENDP

END main
```

6. Constructing a Frequency Table
Write a procedure named Get_frequencies that constructs a character frequency table. Input to
the procedure should be a pointer to a string and a pointer to an array of 256 doublewords initial
ized to all zeros. Each array position is indexed by its corresponding ASCII code. When the pro
cedure returns, each entry in the array contains a count of how many times the corresponding
character occurred in the string. For example,
```asm
.data
target BYTE "AAEBDCFBBC",0
freqTable DWORD 256 DUP(0)
.code
INVOKE Get_frequencies, ADDR target, ADDR freqTable
```
\-\>
```asm
INCLUDE Irvine32.inc

Get_frequencies PROTO, pString:PTR BYTE, pTable:PTR DWORD

.data
    target BYTE "AAEBDCFBBC",0
    freqTable DWORD 256 DUP(0)
    separator BYTE " : ",0

.code
main PROC
    INVOKE Get_frequencies, ADDR target, ADDR freqTable

    xor ebx, ebx

GF_Display:
    cmp DWORD PTR freqTable[ebx*4], 0
    je GF_Next

    mov eax, ebx
    call WriteChar
    mov edx, OFFSET separator
    call WriteString
    mov eax, freqTable[ebx*4]
    call WriteDec
    call Crlf

GF_Next:
    inc ebx
    cmp ebx, 256
    jb GF_Display
    exit
main ENDP

Get_frequencies PROC USES eax esi edi,
    pString:PTR BYTE,
    pTable:PTR DWORD

    mov esi, pString
    mov edi, pTable

GF_Loop:
    movzx eax, BYTE PTR [esi]
    test eax, eax
    jz GF_Done

    inc DWORD PTR [edi+eax*4]
    inc esi
    jmp GF_Loop

GF_Done:
    ret
Get_frequencies ENDP

END main
```

7. Sieve of Eratosthenes
The Sieve of Eratosthenes, invented by the Greek mathematician of the same name, provides a
quick way to find all prime numbers within a given range. The algorithm involves creating an array
of bytes in which positions are “marked” by inserting 1s in the following manner: Beginning with
position 2 (which is a prime number), insert a 1 in each array position that is a multiple of 2. Then
do the same thing for multiples of 3, the next prime number. Find the next prime number after 3,
which is 5, and mark all positions that are multiples of 5. Proceed in this manner until all multiples
of primes have been found. The remaining positions of the array that are unmarked indicate which
numbers are prime. For this program, create a 65,000-element array and display all primes
between 2 and 65,000. Declare the array in an uninitialized data segment (see Section 3.4.11) and
use STOSB to fill it with zeros. 
\-\>
```asm
INCLUDE Irvine32.inc

LIMIT = 65000

.data
    heading BYTE "Primes from 2 through 65000:",0

.data?
    sieve BYTE LIMIT DUP(?)

.code
main PROC
    call BuildSieve

    mov edx, OFFSET heading
    call WriteString
    call Crlf

    call PrintPrimes
    exit
main ENDP

BuildSieve PROC USES eax ebx ecx edx edi
    cld
    mov edi, OFFSET sieve
    mov ecx, LIMIT
    xor eax, eax
    rep stosb

    ; 인덱스 n-1이 숫자 n을 나타낸다.
    mov BYTE PTR sieve[0], 1      ; 1은 소수가 아님
    mov ebx, 2                   ; 현재 후보 p

BS_Candidate:
    mov eax, ebx
    mul ebx                      ; EAX = p*p (이 범위에서는 EDX=0)
    cmp eax, LIMIT
    ja BS_Done

    cmp BYTE PTR sieve[ebx-1], 0
    jne BS_Next

    ; p*p보다 작은 배수는 이전 소수의 단계에서 처리됨
    mov edx, eax

BS_Mark:
    mov BYTE PTR sieve[edx-1], 1
    add edx, ebx
    cmp edx, LIMIT
    jbe BS_Mark

BS_Next:
    inc ebx
    jmp BS_Candidate

BS_Done:
    ret
BuildSieve ENDP

PrintPrimes PROC USES eax ebx edx
    LOCAL column:DWORD

    mov column, 0
    mov ebx, 2

PP_Loop:
    cmp BYTE PTR sieve[ebx-1], 0
    jne PP_Next

    mov eax, ebx
    call WriteDec
    mov al, ' '
    call WriteChar

    inc column
    cmp column, 10
    jb PP_Next

    call Crlf
    mov column, 0

PP_Next:
    inc ebx
    cmp ebx, LIMIT
    jbe PP_Loop

    cmp column, 0
    je PP_Done
    call Crlf

PP_Done:
    ret
PrintPrimes ENDP

END main
```

8. Bubble Sort
Add a variable to the BubbleSort procedure in Section 9.5.1 that is set to 1 whenever a pair of
values is exchanged within the inner loop. Use this variable to exit the sort before its normal
completion if you discover that no exchanges took place during a complete pass through the
array. (This variable is commonly known as an exchange flag.)
\-\>
```asm
INCLUDE Irvine32.inc

BubbleSort PROTO, pArray:PTR SDWORD, itemCount:DWORD
DisplayArray PROTO, pArray:PTR SDWORD, itemCount:DWORD

.data
    numbers SDWORD 9, -3, 7, 1, -8, 4
    beforeMsg BYTE "Before: ",0
    afterMsg BYTE "After:  ",0

.code
main PROC
    mov edx, OFFSET beforeMsg
    call WriteString
    INVOKE DisplayArray, ADDR numbers, LENGTHOF numbers

    INVOKE BubbleSort, ADDR numbers, LENGTHOF numbers

    mov edx, OFFSET afterMsg
    call WriteString
    INVOKE DisplayArray, ADDR numbers, LENGTHOF numbers
    exit
main ENDP

BubbleSort PROC USES eax ecx esi,
    pArray:PTR SDWORD,
    itemCount:DWORD

    LOCAL exchanged:DWORD

    mov ecx, itemCount
    cmp ecx, 2
    jb BUB_Done
    dec ecx

BUB_Outer:
    mov exchanged, 0
    mov esi, pArray
    push ecx                     ; 바깥 반복 횟수 보관

BUB_Inner:
    mov eax, [esi]
    cmp eax, [esi+4]
    jle BUB_NoSwap                ; 부호 있는 정수의 오름차순

    xchg eax, [esi+4]
    mov [esi], eax
    mov exchanged, 1

BUB_NoSwap:
    add esi, 4
    loop BUB_Inner

    pop ecx
    cmp exchanged, 0
    je BUB_Done                  ; 교환이 없으면 조기 종료
    loop BUB_Outer

BUB_Done:
    ret
BubbleSort ENDP

DisplayArray PROC USES eax ebx esi,
    pArray:PTR SDWORD,
    itemCount:DWORD

    mov esi, pArray
    mov ebx, itemCount

DA_Loop:
    test ebx, ebx
    jz DA_Done
    mov eax, [esi]
    call WriteInt
    mov al, ' '
    call WriteChar
    add esi, 4
    dec ebx
    jmp DA_Loop

DA_Done:
    call Crlf
    ret
DisplayArray ENDP

END main
```

9. Binary Search
Rewrite the binary search procedure shown in this chapter by using registers for mid, first, and
last. Add comments to clarify the registers’ usage.
\-\>
```asm
INCLUDE Irvine32.inc

.data
numbers SDWORD -20, -5, 0, 7, 12, 30, 44
foundMsg BYTE "Index of 12: ",0
missingMsg BYTE "Index of 99: ",0

.code
main PROC
    push 12
    push LENGTHOF numbers
    push OFFSET numbers
    call BinarySearch
    push eax
    mov edx, OFFSET foundMsg
    call WriteString
    pop eax
    call WriteInt
    call Crlf

    push 99
    push LENGTHOF numbers
    push OFFSET numbers
    call BinarySearch
    push eax
    mov edx, OFFSET missingMsg
    call WriteString
    pop eax
    call WriteInt
    call Crlf
    exit
main ENDP

; 아래 프로시저는 스택 프레임을 직접 구성한다.
OPTION PROLOGUE:NONE
OPTION EPILOGUE:NONE

BinarySearch PROC
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    ; [EBP+8]  = 배열 주소
    ; [EBP+12] = 원소 개수
    ; [EBP+16] = 검색값
    ; ESI = first, EDI = last, EBX = mid
    ; ECX = 배열 주소, EDX = 검색값, EAX = 임시값/반환값

    mov ecx, [ebp+8]
    mov edi, [ebp+12]
    test edi, edi
    jz BIN_Missing
    dec edi
    xor esi, esi
    mov edx, [ebp+16]

BIN_Loop:
    cmp esi, edi
    jg BIN_Missing

    ; mid = first + (last-first)/2
    mov eax, edi
    sub eax, esi
    shr eax, 1
    add eax, esi
    mov ebx, eax

    mov eax, [ecx+ebx*4]
    cmp eax, edx
    je BIN_Found
    jl BIN_Right

    ; 현재 값이 더 크면 last = mid-1
    lea edi, [ebx-1]
    jmp BIN_Loop

BIN_Right:
    ; 현재 값이 더 작으면 first = mid+1
    lea esi, [ebx+1]
    jmp BIN_Loop

BIN_Found:
    mov eax, ebx
    jmp BIN_Done

BIN_Missing:
    mov eax, -1

BIN_Done:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret 12
BinarySearch ENDP

OPTION PROLOGUE:PrologueDef
OPTION EPILOGUE:EpilogueDef

END main
```

10. Letter Matrix
Create a procedure that generates a four-by-four matrix of randomly chosen capital letters.
When choosing the letters, there must be a 50% probability that the chosen letter is a vowel.
Write a test program with a loop that calls your procedure five times and displays each matrix in
the console window. Following is sample output for the first three matrices:
D W A L
S I V W
U I O L
L A I I
K X S V
N U U O
O R Q O
A U U T
P O A Z
A E A U
G K A E
I A G D
\-\>
```asm
INCLUDE Irvine32.inc


GenerateMatrix PROTO, pMatrix:PTR BYTE
DisplayMatrix PROTO, pMatrix:PTR BYTE

.data

vowels BYTE "AEIOU"
consonants BYTE "BCDFGHJKLMNPQRSTVWXYZ"
matrix BYTE 16 DUP(?)

.code
main PROC
    call Randomize
    mov ebx, 5

LM_Loop:
    INVOKE GenerateMatrix, ADDR matrix
    INVOKE DisplayMatrix, ADDR matrix
    call Crlf
    dec ebx
    jnz LM_Loop

    exit
main ENDP

GenerateMatrix PROC USES eax ebx esi,
    pMatrix:PTR BYTE

    mov esi, pMatrix
    xor ebx, ebx

GM_Loop:
    mov eax, 2
    call RandomRange             ; 0 또는 1
    test eax, eax
    jz GM_Vowel

    mov eax, LENGTHOF consonants
    call RandomRange
    mov al, consonants[eax]
    jmp GM_Store

GM_Vowel:
    mov eax, LENGTHOF vowels
    call RandomRange
    mov al, vowels[eax]

GM_Store:
    mov [esi+ebx], al
    inc ebx
    cmp ebx, 16
    jb GM_Loop
    ret
GenerateMatrix ENDP

DisplayMatrix PROC USES eax ebx esi,
    pMatrix:PTR BYTE

    mov esi, pMatrix
    xor ebx, ebx

DM_Loop:
    mov al, [esi+ebx]
    call WriteChar
    mov al, ' '
    call WriteChar

    inc ebx
    test ebx, 3
    jnz DM_Next
    call Crlf

DM_Next:
    cmp ebx, 16
    jb DM_Loop
    ret
DisplayMatrix ENDP

END main
```
11. Letter Matrix/Sets with Vowels
Use the letter matrix generated in the previous programming exercise as a starting point for this
program. Generate a single random four-by-four letter matrix in which each letter has a 50% prob
ability of being a vowel. Traverse each matrix row, column, and diagonal, generating sets of letters.
Display only four-letter sets containing exactly two vowels. Suppose, for example, the following
matrix was generated:
P O A Z
A E A U
G K A E
I A G D
Then the four-letter sets displayed by the program would be POAZ, GKAE, IAGD, PAGI,
ZUED, PEAD, and ZAKI. The order of letters within each set is unimportant.
\-\>
```asm
INCLUDE Irvine32.inc


GenerateMatrix PROTO, pMatrix:PTR BYTE
DisplayMatrix PROTO, pMatrix:PTR BYTE

DisplaySetIfTwo PROTO, pStart:PTR BYTE, stepSize:DWORD

.data

vowels BYTE "AEIOU"
consonants BYTE "BCDFGHJKLMNPQRSTVWXYZ"
matrix BYTE 16 DUP(?)

heading BYTE "Four-letter sets with exactly two vowels:",0

.code
main PROC
    call Randomize
    INVOKE GenerateMatrix, ADDR matrix
    INVOKE DisplayMatrix, ADDR matrix
    call Crlf

    mov edx, OFFSET heading
    call WriteString
    call Crlf

    ; 네 행: 시작 위치 0,4,8,12 / 이동 간격 1
    mov esi, OFFSET matrix
    mov ebx, 4

LMS_Rows:
    INVOKE DisplaySetIfTwo, esi, 1
    add esi, 4
    dec ebx
    jnz LMS_Rows

    ; 네 열: 시작 위치 0,1,2,3 / 이동 간격 4
    mov esi, OFFSET matrix
    mov ebx, 4

LMS_Columns:
    INVOKE DisplaySetIfTwo, esi, 4
    inc esi
    dec ebx
    jnz LMS_Columns

    ; 왼쪽 위 -> 오른쪽 아래: 0,5,10,15
    INVOKE DisplaySetIfTwo, ADDR matrix, 5

    ; 오른쪽 위 -> 왼쪽 아래: 3,6,9,12
    INVOKE DisplaySetIfTwo, ADDR matrix[3], 3

    exit
main ENDP

GenerateMatrix PROC USES eax ebx esi,
    pMatrix:PTR BYTE

    mov esi, pMatrix
    xor ebx, ebx

GM_Loop:
    mov eax, 2
    call RandomRange             ; 0 또는 1
    test eax, eax
    jz GM_Vowel

    mov eax, LENGTHOF consonants
    call RandomRange
    mov al, consonants[eax]
    jmp GM_Store

GM_Vowel:
    mov eax, LENGTHOF vowels
    call RandomRange
    mov al, vowels[eax]

GM_Store:
    mov [esi+ebx], al
    inc ebx
    cmp ebx, 16
    jb GM_Loop
    ret
GenerateMatrix ENDP

DisplayMatrix PROC USES eax ebx esi,
    pMatrix:PTR BYTE

    mov esi, pMatrix
    xor ebx, ebx

DM_Loop:
    mov al, [esi+ebx]
    call WriteChar
    mov al, ' '
    call WriteChar

    inc ebx
    test ebx, 3
    jnz DM_Next
    call Crlf

DM_Next:
    cmp ebx, 16
    jb DM_Loop
    ret
DisplayMatrix ENDP

DisplaySetIfTwo PROC USES eax ebx ecx esi edi,
    pStart:PTR BYTE,
    stepSize:DWORD

    mov esi, pStart
    mov edi, stepSize
    xor ebx, ebx                 ; 모음 개수
    mov ecx, 4

DST_Count:
    mov al, [esi]
    cmp al, 'A'
    je DST_Vowel
    cmp al, 'E'
    je DST_Vowel
    cmp al, 'I'
    je DST_Vowel
    cmp al, 'O'
    je DST_Vowel
    cmp al, 'U'
    jne DST_Next

DST_Vowel:
    inc ebx

DST_Next:
    add esi, edi
    loop DST_Count

    cmp ebx, 2
    jne DST_Done

    mov esi, pStart
    mov ebx, 4

DST_Print:
    mov al, [esi]
    call WriteChar
    add esi, edi
    dec ebx
    jnz DST_Print
    call Crlf

DST_Done:
    ret
DisplaySetIfTwo ENDP

END main
```


12. Calculating the Sum of an Array Row
Write a procedure named calc_row_sum that calculates the sum of a single row in a two-dimensional
array of bytes, words, or doublewords. The procedure should have the following stack parame
ters: array offset, row size, array type, row index. It must return the sum in EAX. Use explicit
stack parameters, not INVOKE or extended PROC. Write a program that tests your procedure
with arrays of byte, word, and doubleword. Prompt the user for the row index, and display the
sum of the selected row.
\-\>
```asm
INCLUDE Irvine32.inc

.data
byteArray BYTE 1,2,3,4
          BYTE 5,6,7,8
          BYTE 9,10,11,12

wordArray WORD 100,200,300,400
          WORD 500,600,700,800
          WORD 900,1000,1100,1200

dwordArray DWORD 1000,2000,3000,4000
           DWORD 5000,6000,7000,8000
           DWORD 9000,10000,11000,12000

ROW_COUNT = 3
COL_COUNT = 4
BYTE_ROW_SIZE  = COL_COUNT * TYPE byteArray
WORD_ROW_SIZE  = COL_COUNT * TYPE wordArray
DWORD_ROW_SIZE = COL_COUNT * TYPE dwordArray

prompt BYTE "Enter row index (0-2): ",0
invalidMsg BYTE "Invalid row index.",0
byteMsg BYTE "BYTE row sum: ",0
wordMsg BYTE "WORD row sum: ",0
dwordMsg BYTE "DWORD row sum: ",0

.code
main PROC
    LOCAL rowIndex:DWORD

    mov edx, OFFSET prompt
    call WriteString
    call ReadInt

    cmp eax, 0
    jl InvalidInput
    cmp eax, ROW_COUNT
    jae InvalidInput
    mov rowIndex, eax

    ; 우측 인수부터 PUSH:
    ; 행 인덱스, 원소 크기, 행 바이트 수, 배열 주소
    push rowIndex
    push TYPE byteArray
    push BYTE_ROW_SIZE
    push OFFSET byteArray
    call calc_row_sum

    push eax
    mov edx, OFFSET byteMsg
    call WriteString
    pop eax
    call WriteDec
    call Crlf

    push rowIndex
    push TYPE wordArray
    push WORD_ROW_SIZE
    push OFFSET wordArray
    call calc_row_sum

    push eax
    mov edx, OFFSET wordMsg
    call WriteString
    pop eax
    call WriteDec
    call Crlf

    push rowIndex
    push TYPE dwordArray
    push DWORD_ROW_SIZE
    push OFFSET dwordArray
    call calc_row_sum

    push eax
    mov edx, OFFSET dwordMsg
    call WriteString
    pop eax
    call WriteDec
    call Crlf
    jmp ProgramDone

InvalidInput:
    mov edx, OFFSET invalidMsg
    call WriteString
    call Crlf

ProgramDone:
    exit
main ENDP

OPTION PROLOGUE:NONE
OPTION EPILOGUE:NONE

calc_row_sum PROC
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi

    ; [EBP+8]  = 배열 시작 주소
    ; [EBP+12] = 한 행의 바이트 수
    ; [EBP+16] = 원소 크기: 1, 2, 4
    ; [EBP+20] = 행 인덱스: 0부터 시작

    ; 선택한 행의 시작 주소
    mov eax, [ebp+12]
    mul DWORD PTR [ebp+20]
    mov esi, [ebp+8]
    add esi, eax

    ; 행의 원소 개수 = 행 바이트 수 / 원소 크기
    mov ebx, [ebp+16]
    mov eax, [ebp+12]
    xor edx, edx
    div ebx
    mov ecx, eax
    xor eax, eax                 ; 합계
    jecxz CRS_Done

CRS_Loop:
    cmp ebx, 1
    je CRS_Byte
    cmp ebx, 2
    je CRS_Word

    mov edx, [esi]               ; DWORD
    jmp CRS_Add

CRS_Byte:
    movzx edx, BYTE PTR [esi]
    jmp CRS_Add

CRS_Word:
    movzx edx, WORD PTR [esi]

CRS_Add:
    add eax, edx
    add esi, ebx
    loop CRS_Loop

CRS_Done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret 16
calc_row_sum ENDP

OPTION PROLOGUE:PrologueDef
OPTION EPILOGUE:EpilogueDef

END main
```

13. Trimming Leading Characters
Create a variant of the Str_trim procedure that lets the caller remove all instances of a leading
character from a string. For example, if you were to call it with a pointer to the string “###ABC”
and pass it the # character, the resulting string would be “ABC.”
\-\>
```asm
INCLUDE Irvine32.inc

Str_trimLeading PROTO, pString:PTR BYTE, trimChar:BYTE

.data
target BYTE "###ABC",0
alsoTest BYTE "######",0

.code
main PROC
    INVOKE Str_trimLeading, ADDR target, '#'
    mov edx, OFFSET target
    call WriteString
    call Crlf

    INVOKE Str_trimLeading, ADDR alsoTest, '#'
    mov edx, OFFSET alsoTest
    call WriteString             ; 빈 문자열
    call Crlf
    exit
main ENDP

Str_trimLeading PROC USES eax edx esi edi,
    pString:PTR BYTE,
    trimChar:BYTE

    mov esi, pString
    mov edi, esi
    mov dl, trimChar

STL_Skip:
    mov al, [esi]
    test al, al
    jz STL_Copy
    cmp al, dl
    jne STL_Copy
    inc esi
    jmp STL_Skip

STL_Copy:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    test al, al
    jnz STL_Copy
    ret
Str_trimLeading ENDP

END main
```

14. Trimming a Set of Characters
Create a variant of the Str_trim procedure that lets the caller remove all instances of a set of
characters from the end of a string. For example, if you were to call it with a pointer to the string
“ABC#$&” and pass it a pointer to an array of filter characters containing “%#!;$&*”, the result
ing string would be “ABC”.
\-\>
```asm
INCLUDE Irvine32.inc

Str_trimSet PROTO, pString:PTR BYTE, pFilter:PTR BYTE

.data
target BYTE "ABC#$&",0
filterChars BYTE "%#!;$&*",0

.code
main PROC
    INVOKE Str_trimSet, ADDR target, ADDR filterChars

    mov edx, OFFSET target
    call WriteString
    call Crlf
    exit
main ENDP

Str_trimSet PROC USES eax ebx edx esi edi,
    pString:PTR BYTE,
    pFilter:PTR BYTE

    mov ebx, pString
    mov edi, ebx

STS_FindEnd:
    cmp BYTE PTR [edi], 0
    je STS_CheckLast
    inc edi
    jmp STS_FindEnd

STS_CheckLast:
    cmp edi, ebx
    je STS_Finish               ; 빈 문자열 또는 모두 제거됨

    mov al, [edi-1]             ; 현재 마지막 실제 문자
    mov esi, pFilter

STS_FilterLoop:
    mov dl, [esi]
    test dl, dl
    jz STS_Finish               ; 필터에 없으면 여기서 종료

    cmp al, dl
    je STS_Remove

    inc esi
    jmp STS_FilterLoop

STS_Remove:
    dec edi
    jmp STS_CheckLast

STS_Finish:
    mov BYTE PTR [edi], 0
    ret
Str_trimSet ENDP

END main
```