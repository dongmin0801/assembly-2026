Short Answer
============

1. In the following code sequence, show the value of AL after each shift or rotate instruction
has executed:
```asm
mov al,0D4h
shr al,1        ; a.
mov al,0D4h
sar al,1        ; b.
mov al,0D4h
sar al,4        ; c.
mov al,0D4h
rol al,1        ; d.
```
\-\> a = 6Ah, b = EAh, c = FDh, d = A9h

2. In the following code sequence, show the value of AL after each shift or rotate instruction
has executed:
```asm
mov al,0D4h
ror al,3        ; a.
mov al,0D4h
rol al,7        ; b.
stc
mov al,0D4h
rcl al,1        ; c.
stc
mov al,0D4h
rcr al,3        ; d.
```
\-\> a = 9Ah, b = 6Ah, c = A9h, d = 3Ah

3. What will be the contents of AX and DX after the following operation?
```asm
mov dx,0
mov ax,222h
mov cx,100h
mul cx
```
\-\> AX=2200h, DX = 0002h

4. What will be the contents of AX after the following operation?
```asm
mov ax,63h
mov bl,10h
div bl
```
\-\> AX = 0306h

5. What will be the contents of EAX and EDX after the following operation?
```asm
mov eax,123400h
mov edx,0
mov ebx,10h
div ebx
```
\-\> EAX = 00012340h, EDX = 00000000h


6. What will be the contents of AX and DX after the following operation?
```asm
mov ax,4000h
mov dx,500h
mov bx,10h
div bx
```
\-\> DIV BX, 명령어에서 나눗셈 오류 발생

7. What will be the contents of BX after the following instructions execute?
```asm
mov bx,5
stc
mov ax,60h
adc bx,ax
```
\-\> BX = 0066h

8. Describe the output when the following code executes in 64-bit mode:
```asm
.data
    dividend_hi  QWORD 00000108h
    dividend_lo  QWORD 33300020h
    divisor      QWORD 00000100h
.code
    mov  rdx,dividend_hi
    mov  rax,dividend_lo
    div  divisor
```
\-\> DIV 명령어에서 나눗셈 오류 발생

9. The following program is supposed to subtract val2 from val1. Find and correct all logic
errors (CLC clears the Carry flag):
```asm
.data
    val1   QWORD 20403004362047A1h
    val2   QWORD 055210304A2630B2h
    result QWORD 0
.code
    mov  cx,8               ; loop counter
    mov  esi,val1           ; set index to start
    mov  edi,val2
    clc                     ; clear Carry flag
    top:
        mov  al,BYTE PTR[esi]   ; get first number
        sbb  al,BYTE PTR[edi]   ; subtract second
        mov  BYTE PTR[esi],al   ; store the result
        dec  esi
        dec  edi
        loop top

```
\-\>
```asm
.data
val1 QWORD 20403004362047A1h
val2 QWORD 055210304A2630B2h
result QWORD 0

.code
mov cx,8
mov esi,OFFSET val1
mov edi, OFFSET val2
mov ebx, OFFSET result
clc

top:
    mov al,BYTE PTR [esi]
    sbb al,BYTE PTR [edi]
    mov BYTE PTR [ebx],al

    inc esi
    inc edi
    inc ebx
    loop top
```

10. What will be the hexadecimal contents of RAX after the following instructions execute in
64-bit mode?
```asm
.data
multiplicand QWORD 0001020304050000h
.code
imul rax,multiplicand, 4
```
\-\> RAX = 0004080C10140000h

Algorithm Workbench
===================

1. Write a sequence of shift instructions that cause AX to be sign-extended into EAX. In other words,
the sign bit of AX is copied into the upper 16 bits of EAX. Do not use the CWD instruction.
\-\>
```asm
shl eax,16
sar eax,16
```

2. Suppose the instruction set contained no rotate instructions. Show how you would use
SHR and a conditional jump instruction to rotate the contents of the AL register 1 bit to
the right.
\-\>
```asm
shr al,1
jnc no_wrap
or al,80h
no_wrap:
```

3. Write a logical shift instruction that multiplies the contents of EAX by 16.
\-\>
```asm
shl eax,4
```

4. Write a logical shift instruction that divides EBX by 4.
\-\>
```asm
shr ebx,2
```


5. Write a single rotate instruction that exchanges the high and low halves of the DL register.
\-\>
```asm
ror dl,4
```

6. Write a single SHLD instruction that shifts the highest bit of the AX register into the lowest
bit position of DX and shifts DX one bit to the left.
\-\>
```asm
shld dx,ax,1
```

7. Write a sequence of instructions that shift three memory bytes to the right by 1 bit position.
Use the following test data:
```asm
byteArray BYTE 81h,20h,33h
```
\-\>
```asm
shr byteArray+2,1
rcr byteArray+1,1
rcr byteArray,1
```

8. Write a sequence of instructions that shift three memory words to the left by 1 bit position.
Use the following test data:
```asm
wordArray WORD 810Dh, 0C064h,93ABh
```
\-\>
```asm
shl wordArray,1
rcl wordArray+2,1
rcl wordArray+4,1
```

9. Write instructions that multiply 5 by 3 and store the result in a 16-bit variable val1.
\-\>
```asm
mov ax,-5
imul ax,3
mov val1,ax
```

10. Write instructions that divide 276 by 10 and store the result in a 16-bit variable val1.
\-\>
```asm
mov ax,-276
cwd
mov bx,10
idiv bx
mov val1,ax
```

11. Implement the following C++ expression in assembly language, using 32-bit unsigned
operands:
```asm
val1 = (val2 * val3) / (val4 - 3)
```
\-\>
```asm
mov eax,val2
mul val3
mov ecx,val4
sub ecx,3
div ecx
mov val1,eax
```

12. Implement the following C++ expression in assembly language, using 32-bit signed
operands:
```asm
val1 = (val2 / val3) * (val1 + val2)
```
\-\>
```asm
mov eax,val2
cdq
idiv val3
mov ebx,eax

mov eax,val1
add eax,val2
imul eax,ebx
mov val1,eax
```

13. Write a procedure that displays an unsigned 8-bit binary value in decimal format. Pass the
binary value in AL. The input range is limited to 0 to 99, decimal. The only procedure you
can call from the book’s link library is WriteChar. The procedure should contain approxi
mately eight instructions. Here is a sample call:
```asm
mov  al,65            ; range limit: 0 to 99 
call showDecimal8
```
\-\>
```asm
showDecimal8 PROC
    mov ah,0
    mov bl,10
    div bl
    mov dl,ah
    test al,al
    jz one_digit
    add al,'0'
    call WriteChar
one_digit:
    mov al,dl
    add al,'0'
    call WriteChar
    ret
showDecimal8 ENDP
```
14. Challenge: Suppose AX contains 0072h and the Auxiliary Carry flag is set as a result of
adding two unknown ASCII decimal digits. Use the Intel 64 and IA-32 Instruction Set Ref
erence to determine what output the AAA instruction would produce. Explain your answer.
\-\>
AX = 0108h
AH = 01h, AL = 08h
AF = 1, CF = 1

15. Challenge: Using only SUB, MOV, and AND instructions, show how to calculate x = n mod y,
assuming that you are given the values of n and y. You can assume that n is any 32-bit
unsigned integer, and y is a power of 2.
\-\>
```asm
mov eax,n
mov ecx,y
sub ecx,1
and eax,ecx
mov x,eax
```

16. Challenge: Using only SAR, ADD, and XOR instructions (but no conditional jumps), write
code that calculates the absolute value of the signed integer in the EAX register. Hints: A
number can be negated by adding 1 to it and then forming its one’s complement. Also, if
you XOR an integer with all 1s, its 1s are reversed. On the other hand, if you XOR an inte
ger with all zeros, the integer is unchanged.
\-\>
```asm
mov edx,eax
sar edx,31
xor eax,edx
xor edx,0FFFFFFFFh
add edx,1
add eax,edx
```

Programming Exercises
=====================

1. Display ASCII Decimal
Write a procedure named WriteScaled that outputs a decimal ASCII number with an implied dec
imal point. Suppose the following number were defined as follows, where DECIMAL_OFFSET
indicates that the decimal point must be inserted five positions from the right side of the number:
```asm
DECIMAL_OFFSET = 5
.data
decimal_one BYTE "100123456789765"
```
WriteScaled would display the number like this:
```asm
1001234567.89765
```
When calling WriteScaled, pass the number’s offset in EDX, the number length in ECX, and the
decimal offset in EBX. Write a test program that passes three numbers of different sizes to the
WriteScaled procedure.
\-\>
```asm
TITLE Display ASCII Decimal

INCLUDE Irvine32.inc

.data
decimal1 BYTE "100123456789765"
decimal2 BYTE "123456789"
decimal3 BYTE "987654321012"

.code
; EDX = 숫자 문자열 주소
; ECX = 문자열 길이
; EBX = 소수점 오른쪽 자릿수
WriteScaled PROC
    push eax
    push ecx
    push edx
    push esi
    push edi
    push ebx

    mov esi, edx                 ; ESI = 문자열 시작 주소
    mov edi, ecx                 ; EDI = 전체 문자열 길이
    sub edi, ebx                 ; EDI = 소수점 왼쪽에 출력할 자릿수

    ; 소수점 왼쪽 숫자 출력
    mov ecx, edi
LeftPart:
    cmp ecx, 0
    je  PrintPoint
    mov al, [esi]
    call WriteChar
    inc esi
    loop LeftPart

PrintPoint:
    mov al, '.'
    call WriteChar

    ; 소수점 오른쪽 숫자 출력
    mov ecx, ebx
RightPart:
    cmp ecx, 0
    je  WriteScaledDone
    mov al, [esi]
    call WriteChar
    inc esi
    loop RightPart

WriteScaledDone:
    call Crlf

    pop ebx
    pop edi
    pop esi
    pop edx
    pop ecx
    pop eax
    ret
WriteScaled ENDP

main PROC
    ; 첫 번째 숫자: 15자리, 소수점 오른쪽 5자리
    mov edx, OFFSET decimal1
    mov ecx, LENGTHOF decimal1
    mov ebx, 5
    call WriteScaled

    ; 두 번째 숫자: 9자리, 소수점 오른쪽 3자리
    mov edx, OFFSET decimal2
    mov ecx, LENGTHOF decimal2
    mov ebx, 3
    call WriteScaled

    ; 세 번째 숫자: 12자리, 소수점 오른쪽 4자리
    mov edx, OFFSET decimal3
    mov ecx, LENGTHOF decimal3
    mov ebx, 4
    call WriteScaled

    exit
main ENDP
END main
```

2. Extended Subtraction Procedure
Create a procedure named Extended_Sub that subtracts two binary integers of arbitrary size.
The storage size of the two integers must be the same, and their size must be a multiple of 32
bits. Write a test program that passes several pairs of integers, each at least 10 bytes long.
\-\>
```asm
TITLE Extended Subtraction

INCLUDE Irvine32.inc

.data
; 각 정수는 12바이트(96비트)
; 가장 낮은 바이트가 배열의 첫 번째 요소에 저장되는 리틀 엔디안 형식
numA1 BYTE 12h, 34h, 56h, 78h, 9Ah, 0BCh, 0DEh, 0F0h, 11h, 22h, 33h, 44h
numB1 BYTE 01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
result1 BYTE 12 DUP(?)

numA2 BYTE 50h, 40h, 30h, 20h, 10h, 01h, 02h, 03h, 04h, 05h, 06h, 07h
numB2 BYTE 10h, 20h, 30h, 40h, 50h, 01h, 02h, 03h, 04h, 05h, 06h, 07h
result2 BYTE 12 DUP(?)

.code
; ESI = 첫 번째 정수 주소
; EDI = 두 번째 정수 주소
; EDX = 결과 저장 주소
; ECX = 바이트 수
Extended_Sub PROC
    push eax
    push esi
    push edi
    push edx
    push ecx

    clc                          ; 최초 빌림(borrow)을 0으로 설정

SubLoop:
    mov al, [esi]                ; 첫 번째 정수의 현재 바이트
    sbb al, [edi]                ; AL = AL - 두 번째 바이트 - CF
    mov [edx], al                ; 결과 바이트 저장

    ; LEA와 MOV는 Carry Flag를 변경하지 않음
    lea esi, [esi + 1]
    lea edi, [edi + 1]
    lea edx, [edx + 1]

    loop SubLoop                 ; LOOP는 플래그를 변경하지 않음

    pop ecx
    pop edx
    pop edi
    pop esi
    pop eax
    ret
Extended_Sub ENDP

main PROC
    ; 첫 번째 12바이트 정수 쌍
    mov esi, OFFSET numA1
    mov edi, OFFSET numB1
    mov edx, OFFSET result1
    mov ecx, LENGTHOF numA1
    call Extended_Sub

    mov edx, OFFSET result1
    mov ecx, LENGTHOF result1
    mov ebx, TYPE result1
    call DumpMem

    ; 두 번째 12바이트 정수 쌍
    mov esi, OFFSET numA2
    mov edi, OFFSET numB2
    mov edx, OFFSET result2
    mov ecx, LENGTHOF numA2
    call Extended_Sub

    mov edx, OFFSET result2
    mov ecx, LENGTHOF result2
    mov ebx, TYPE result2
    call DumpMem

    exit
main ENDP
END main
```

3. Packed Decimal Conversion
Write a procedure named PackedToAsc that converts a 4-byte packed decimal integer to a string
of ASCII decimal digits. Pass the packed integer and the address of a buffer holding the ASCII
digits to the procedure. Write a short test program that passes at least 5 packed decimal integers
to your procedure.
\-\>
```asm
TITLE Packed Decimal Conversion

INCLUDE Irvine32.inc

.data
; 4바이트 packed decimal: 숫자 7개 + 부호 니블
packed1 DWORD 1234567Ch
packed2 DWORD 7654321Ch
packed3 DWORD 0000123Ch
packed4 DWORD 9876543Ch
packed5 DWORD 2468101Ch

buffer BYTE 8 DUP(0)

.code
; EAX = 4바이트 packed decimal 값
; EDX = ASCII 문자열을 저장할 버퍼 주소
; 여기서는 양수 부호 니블 C를 사용하는 7자리 packed decimal을 처리
PackedToAsc PROC
    push eax
    push ebx
    push ecx
    push edx
    push edi

    mov ebx, eax                 ; EBX에 원본 packed decimal 저장
    mov edi, edx                 ; EDI = 출력 버퍼 주소
    mov ecx, 7                   ; 숫자 니블은 7개

ConvertLoop:
    ; 최상위 니블을 AL로 가져옴
    mov eax, ebx
    shr eax, 28
    and al, 0Fh
    add al, '0'                  ; 0~9를 ASCII '0'~'9'로 변환
    mov [edi], al

    inc edi
    shl ebx, 4                   ; 다음 숫자 니블을 최상위로 이동
    loop ConvertLoop

    mov byte ptr [edi], 0        ; 문자열 끝에 NULL 추가

    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
PackedToAsc ENDP

main PROC
    mov eax, packed1
    mov edx, OFFSET buffer
    call PackedToAsc
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    mov eax, packed2
    mov edx, OFFSET buffer
    call PackedToAsc
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    mov eax, packed3
    mov edx, OFFSET buffer
    call PackedToAsc
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    mov eax, packed4
    mov edx, OFFSET buffer
    call PackedToAsc
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    mov eax, packed5
    mov edx, OFFSET buffer
    call PackedToAsc
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    exit
main ENDP
END main
```

4. Encryption Using Rotate Operations
Write a procedure that performs simple encryption by rotating each plaintext byte a varying
number of positions in different directions. For example, in the following array that represents
the encryption key, a negative value indicates a rotation to the left and a positive value indicates
a rotation to the right. The integer in each position indicates the magnitude of the rotation:
```asm
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
```
Your procedure should loop through a plaintext message and align the key to the first 10 bytes of
the message. Rotate each plaintext byte by the amount indicated by its matching key array value.
Then, align the key to the next 10 bytes of the message and repeat the process. Write a program
that tests your encryption procedure by calling it twice, with different data sets.
\-\>
```asm
TITLE Encryption Using Rotate Operations

INCLUDE Irvine32.inc

.data
key SBYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6

message1 BYTE "Assembly language is fun!", 0
message2 BYTE "Rotate each byte to encrypt!", 0

.code
; ESI = 평문 문자열 주소
; 문자열은 NULL 문자(0)로 끝남
Encrypt PROC
    push eax
    push ebx
    push ecx
    push esi
    push edi

    mov edi, 0                   ; 키 배열 인덱스 = 0

EncryptLoop:
    mov al, [esi]
    cmp al, 0
    je  EncryptDone              ; NULL이면 문자열 끝

    movsx ecx, key[edi]          ; 현재 키 값을 부호 확장

    cmp ecx, 0
    jl  RotateLeft
    jg  RotateRight
    jmp NextByte                 ; 키가 0이면 회전하지 않음

RotateLeft:
    neg ecx                      ; 음수를 양수 회전 횟수로 변경
    rol byte ptr [esi], cl       ; 왼쪽 회전
    jmp NextByte

RotateRight:
    ror byte ptr [esi], cl       ; 오른쪽 회전

NextByte:
    inc esi                      ; 다음 평문 바이트
    inc edi                      ; 다음 키 위치

    cmp edi, 10
    jb  EncryptLoop
    mov edi, 0                   ; 키 10개를 사용했으면 처음으로

    jmp EncryptLoop

EncryptDone:
    pop edi
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret
Encrypt ENDP

main PROC
    ; 첫 번째 메시지 암호화
    mov esi, OFFSET message1
    call Encrypt

    mov edx, OFFSET message1
    call WriteString
    call Crlf

    ; 두 번째 메시지 암호화
    mov esi, OFFSET message2
    call Encrypt

    mov edx, OFFSET message2
    call WriteString
    call Crlf

    exit
main ENDP
END main
```

5. Prime Numbers
Write a program that generates all prime numbers between 2 and 1000, using the Sieve of Era
tosthenes method. You can find many articles that describe the method for finding primes in this
manner on the Internet. Display all the prime values.
\-\>
```asm
TITLE Prime Numbers - Sieve of Eratosthenes

INCLUDE Irvine32.inc

.data
isPrime BYTE 1001 DUP(1)          ; 처음에는 모든 수를 소수라고 가정

.code
main PROC
    ; 0과 1은 소수가 아님
    mov isPrime[0], 0
    mov isPrime[1], 0

    mov esi, 2                    ; 검사할 소수 후보 p = 2

OuterLoop:
    cmp esi, 31                   ; sqrt(1000)은 약 31.6
    ja  DisplayPrimes

    cmp isPrime[esi], 0
    je  NextPrime                  ; 이미 소수가 아니면 건너뜀

    ; p의 배수 제거는 p*p부터 시작
    mov eax, esi
    imul eax, esi                 ; EAX = p * p
    mov edi, eax                  ; EDI = 제거할 배수

MarkMultiples:
    cmp edi, 1000
    ja  NextPrime

    mov isPrime[edi], 0           ; p의 배수는 소수가 아님
    add edi, esi                  ; 다음 배수로 이동
    jmp MarkMultiples

NextPrime:
    inc esi
    jmp OuterLoop

DisplayPrimes:
    mov esi, 2

PrintLoop:
    cmp esi, 1000
    ja  ProgramDone

    cmp isPrime[esi], 1
    jne SkipNumber

    mov eax, esi
    call WriteDec
    mov al, ' '
    call WriteChar

SkipNumber:
    inc esi
    jmp PrintLoop

ProgramDone:
    call Crlf
    exit
main ENDP
END main
```

6. Greatest Common Divisor (GCD)
The greatest common divisor (GCD) of two integers is the largest integer that will evenly divide
both integers. The GCD algorithm involves integer division in a loop, described by the following
pseudocode:
```c
int GCD(int x, int y)
{
    x = abs(x)          // absolute value
    y = abs(y)
    do {
        int n = x % y
        x = y
        y = n
    } while (y > 0)
    return x
}
```
Implement this function in assembly language and write a test program that calls the function
several times, passing it different values. Display all results on the screen.
\-\>
```asm
TITLE Greatest Common Divisor

INCLUDE Irvine32.inc

.data
msg1 BYTE "GCD(48, 18) = ", 0
msg2 BYTE "GCD(-84, 30) = ", 0
msg3 BYTE "GCD(100, 25) = ", 0
msg4 BYTE "GCD(17, 13) = ", 0

.code
; EAX = 첫 번째 정수 x
; EBX = 두 번째 정수 y
; 반환값 EAX = GCD
GCD PROC
    push ebx
    push edx

    ; x의 절댓값
    test eax, eax
    jns CheckY
    neg eax

CheckY:
    ; y의 절댓값
    test ebx, ebx
    jns GCDLoop
    neg ebx

GCDLoop:
    cmp ebx, 0
    je  GCDDone

    xor edx, edx
    div ebx                      ; EDX = x % y

    mov eax, ebx                 ; x = y
    mov ebx, edx                 ; y = 나머지
    jmp GCDLoop

GCDDone:
    pop edx
    pop ebx
    ret
GCD ENDP

main PROC
    ; GCD(48, 18)
    mov edx, OFFSET msg1
    call WriteString
    mov eax, 48
    mov ebx, 18
    call GCD
    call WriteDec
    call Crlf

    ; GCD(-84, 30)
    mov edx, OFFSET msg2
    call WriteString
    mov eax, -84
    mov ebx, 30
    call GCD
    call WriteDec
    call Crlf

    ; GCD(100, 25)
    mov edx, OFFSET msg3
    call WriteString
    mov eax, 100
    mov ebx, 25
    call GCD
    call WriteDec
    call Crlf

    ; GCD(17, 13)
    mov edx, OFFSET msg4
    call WriteString
    mov eax, 17
    mov ebx, 13
    call GCD
    call WriteDec
    call Crlf

    exit
main ENDP
END main
```

7. Bitwise Multiplication
Write a procedure named BitwiseMultiply that multiplies any unsigned 32-bit integer by
EAX, using only shifting and addition. Pass the integer to the procedure in the EBX register,
and return the product in the EAX register. Write a short test program that calls the procedure
and displays the product. (We will assume that the product is never larger than 32 bits.) This is
a fairly challenging program to write. One possible approach is to use a loop to shift the mul
tiplier to the right, keeping track of the number of shifts that occur before the Carry flag is set.
The resulting shift count can then be applied to the SHL instruction, using the multiplicand as
the destination operand. Then, the same process must be repeated until you find the last 1 bit
in the multiplier.
\-\>
```asm
TITLE Bitwise Multiplication

INCLUDE Irvine32.inc

.code
; EAX = 곱할 첫 번째 값(multiplicand)
; EBX = 곱할 두 번째 값(multiplier)
; 반환값 EAX = 곱
BitwiseMultiply PROC
    push ebx
    push ecx
    push edx

    mov ecx, eax                 ; ECX = multiplicand
    xor eax, eax                 ; EAX = 결과 누산기

MultiplyLoop:
    cmp ebx, 0
    je  MultiplyDone

    test ebx, 1                  ; multiplier의 최하위 비트 확인
    jz  SkipAdd

    add eax, ecx                 ; 현재 비트가 1이면 더함

SkipAdd:
    shl ecx, 1                   ; 다음 비트 위치에 맞게 multiplicand 이동
    shr ebx, 1                   ; multiplier를 오른쪽으로 1비트 이동
    jmp MultiplyLoop

MultiplyDone:
    pop edx
    pop ecx
    pop ebx
    ret
BitwiseMultiply ENDP

main PROC
    ; 25 * 12
    mov eax, 25
    mov ebx, 12
    call BitwiseMultiply

    call WriteDec
    call Crlf

    ; 123 * 7
    mov eax, 123
    mov ebx, 7
    call BitwiseMultiply

    call WriteDec
    call Crlf

    exit
main ENDP
END main
```

8. Add Packed Integers
Extend the AddPacked procedure from Section 7.6.1 so that it adds two packed decimal inte
gers of arbitrary size (both lengths must be the same). Write a test program that passes
AddPacked several pairs of integers: 4-byte, 8-byte, and 16-byte. We suggest that you use the
following registers to pass information to the procedure:
ESI - pointer to the first number
EDI - pointer to the second number
EDX - pointer to the sum
ECX - number of bytes to add
\-\>
```asm
TITLE Add Packed Integers

INCLUDE Irvine32.inc

.data
; Packed BCD는 한 바이트에 십진 숫자 두 자리를 저장
; 아래 배열은 낮은 자리 바이트부터 저장하는 리틀 엔디안 순서

; 4바이트 packed decimal
numA4 BYTE 34h, 12h, 00h, 00h
numB4 BYTE 66h, 87h, 00h, 00h
sum4  BYTE 4 DUP(0)

; 8바이트 packed decimal
numA8 BYTE 00h, 00h, 00h, 00h, 00h, 00h, 12h, 34h
numB8 BYTE 00h, 00h, 00h, 00h, 00h, 00h, 56h, 78h
sum8  BYTE 8 DUP(0)

; 16바이트 packed decimal
numA16 BYTE 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 12h, 34h
numB16 BYTE 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 56h, 78h
sum16 BYTE 16 DUP(0)

.code
; ESI = 첫 번째 packed decimal 주소
; EDI = 두 번째 packed decimal 주소
; EDX = 합계를 저장할 주소
; ECX = 더할 바이트 수
AddPacked PROC
    push eax
    push esi
    push edi
    push edx
    push ecx

    clc                          ; 처음 Carry를 0으로 설정

AddLoop:
    mov al, [esi]                ; 첫 번째 숫자의 현재 바이트
    adc al, [edi]                ; 두 번째 바이트와 이전 Carry를 더함
    daa                          ; AL을 packed BCD 형식으로 보정
    mov [edx], al                ; 결과 바이트 저장

    ; INC는 Carry Flag를 변경하지 않으므로 다음 바이트에 Carry 전달 가능
    inc esi
    inc edi
    inc edx

    loop AddLoop

    pop ecx
    pop edx
    pop edi
    pop esi
    pop eax
    ret
AddPacked ENDP

main PROC
    ; 4바이트 덧셈
    mov esi, OFFSET numA4
    mov edi, OFFSET numB4
    mov edx, OFFSET sum4
    mov ecx, LENGTHOF numA4
    call AddPacked

    mov esi, OFFSET sum4
    mov ecx, LENGTHOF sum4
    mov ebx, TYPE sum4
    call DumpMem

    ; 8바이트 덧셈
    mov esi, OFFSET numA8
    mov edi, OFFSET numB8
    mov edx, OFFSET sum8
    mov ecx, LENGTHOF numA8
    call AddPacked

    mov esi, OFFSET sum8
    mov ecx, LENGTHOF sum8
    mov ebx, TYPE sum8
    call DumpMem

    ; 16바이트 덧셈
    mov esi, OFFSET numA16
    mov edi, OFFSET numB16
    mov edx, OFFSET sum16
    mov ecx, LENGTHOF numA16
    call AddPacked

    mov esi, OFFSET sum16
    mov ecx, LENGTHOF sum16
    mov ebx, TYPE sum16
    call DumpMem

    exit
main ENDP
END main
```