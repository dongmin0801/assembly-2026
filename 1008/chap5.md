Review Questions and Exercises
==============================

1. Which instruction pushes all of the 32-bit general-purpose registers on the stack?
\-\> PUSHAD

2. Which instruction pushes the 32-bit EFLAGS register on the stack?
\-\> PUSHFD

3. Which instruction pops the stack into the EFLAGS register?
\-\> POPFD

4. Challenge: Another assembler (called NASM) permits the PUSH instruction to list multiple
specific registers. Why might this approach be better than the PUSHAD instruction in
MASM? Here is a NASM example:
PUSH EAX EBX ECX
\-\> 스택 효율성, 선택적 저장

5. Challenge: Suppose there were no PUSH instruction. Write a sequence of two other instruc
tions that would accomplish the same as push eax.
```asm
sub esp, 4
mov [esp], eax
```


6. (True/False): The RET instruction pops the top of the stack into the instruction pointer.
\-\> True

7. (True/False): Nested procedure calls are not permitted by the Microsoft assembler unless
the NESTED operator is used in the procedure definition.
\-\> False

8. (True/False): In protected mode, each procedure call uses a minimum of 4 bytes of stack
space.
\-\> True

9. (True/False): The ESI and EDI registers cannot be used when passing 32-bit parameters to
procedures.
\-\> False

10. (True/False): The ArraySum procedure (Section 5.2.5) receives a pointer to any array of
doublewords.
\-\> True

11. (True/False): The USES operator lets you name all registers that are modified within a pro
cedure.
\-\> True

12. (True/False): The USES operator only generates PUSH instructions, so you must code POP
instructions yourself.
\-\> False

13. (True/False): The register list in the USES directive must use commas to separate the regis
ter names.
\-\> False

14. Which statement(s) in the ArraySum procedure (Section 5.2.5) would have to be modified so
it could accumulate an array of 16-bit words? Create such a version of ArraySum and test it.
\-\> 
```asm
ArraySum PROC
    push esi
    push ecx
    mov eax, 0
L1: add eax, [esi]
    add esi, TYPE WORD
    loop L1

    pop ecx
    pop esi
    ret

ArraySun ENDP
```

15. What will be the final value in EAX after these instructions execute?
```asm
push 5
push 6
pop  eax
pop  eax
```
\-\> eax = 5


16. Which statement is true about what will happen when the example code runs?
```asm
 1: main PROC
 2:     push 10
 3:     push 20
 4:     call Ex2Sub
 5:     pop  eax
 6:     INVOKE ExitProcess,0
 7: main ENDP
 8:
 9: Ex2Sub PROC
 10:    pop eax
 11:    ret
 12: Ex2Sub ENDP
```
a. EAX will equal 10 on line 6
b. The program will halt with a runtime error on Line 10
c. EAX will equal 20 on line 6
d. The program will halt with a runtime error on Line 11 
\-\> d

17. Which statement is true about what will happen when the example code runs?
```asm
 1: main PROC
 2:     mov  eax,30
 3:     push eax
 4:     push 40
 5:     call Ex3Sub
 6:     INVOKE ExitProcess,0
 7: main ENDP
 8:
 9: Ex3Sub PROC
 10:    pusha
 11:    mov eax,80
 12:    popa
 13:    ret
 14: Ex3Sub ENDP
```
a. EAX will equal 40 on line 6
b. The program will halt with a runtime error on Line 6
c. EAX will equal 30 on line 6 
d. The program will halt with a runtime error on Line 13
\-\> c

18. Which statement is true about what will happen when the example code runs?
```asm
 1: main PROC
 2:     mov eax,40
 3:     push offset Here
 4:     jmp  Ex4Sub
 5:    Here:
 6:     mov eax,30
 7:     INVOKE ExitProcess,0
 8: main ENDP
 9:
 10: Ex4Sub PROC
 11:     ret
 12: Ex4Sub ENDP
```
a. EAX will equal 30 on line 7
b. The program will halt with a runtime error on Line 4
c. EAX will equal 30 on line 6 
d. The program will halt with a runtime error on Line 11
\-\> a

19. Which statement is true about what will happen when the example code runs?
```asm
 1: main PROC
 2:     mov edx,0
 3:     mov eax,40
 4:     push eax
 5:     call Ex5Sub
 6:     INVOKE ExitProcess,0
 7: main ENDP
 8:
 9: Ex5Sub PROC
 10:    pop  eax
 11:    pop  edx
 12:    push eax
 13:    ret
 14: Ex5Sub ENDP
```
a. EDX will equal 40 on line 6 
b. The program will halt with a runtime error on Line 13
c. EDX will equal 0 on line 6 
d. The program will halt with a runtime error on Line 11
\-\> a

20. What values will be written to the array when the following code executes?
```asm
.data
array DWORD 4 DUP(0)

.code
main PROC
    mov eax,10
    mov  esi,0
    call proc_1
    add  esi,4
    add  eax,10
    mov  array[esi],eax
    INVOKE ExitProcess,0
main ENDP

proc_1 PROC
    call proc_2
    add  esi,4
    add  eax,10
    mov  array[esi],eax
    ret
proc_1 ENDP

proc_2 PROC
    call proc_3
    add  esi,4
    add  eax,10
    mov  array[esi],eax
    ret
proc_2 ENDP

proc_3 PROC
    mov  array[esi],eax
    ret
proc_3 ENDP
```
\-\> array = [10,20,30,40,], eax = 40, esi = 12

Algorithm Workbench
===================
The following exercises can be solved using either 32-bit or 64-bit code.

1. Write a sequence of statements that use only PUSH and POP instructions to exchange the
values in the EAX and EBX registers (or RAX and RBX in 64-bit mode). 
\-\> 
```asm
push eax
push ebx
pop eax
pop ebx
```

2. Suppose you wanted a subroutine to return to an address that was 3 bytes higher in memory
than the return address currently on the stack. Write a sequence of instructions that would be
inserted just before the subroutine’s RET instruction that accomplish this task.
\-\>
```asm
pop eax
add eax, 3
push eax
ret
```

3. Functions in high-level languages often declare local variables just below the return address
on the stack. Write an instruction that you could put at the beginning of an assembly language
subroutine that would reserve space for two integer doubleword variables. Then, assign the
values 1000h and 2000h to the two local variables.
\-\>
```asm
MySub PROC
    sub esp,8
    mov DWORD PTR[esp],1000h
    mov DWORD PRT[esp+4],2000h

    add esp, 8
    ret
MySub ENDP
```
4. Write a sequence of statements using indexed addressing that copies an element in a double
word array to the previous position in the same array.
\-\>
```asm
.data
array DWORD 10,20,30,40,50

.code
mov esi, 4
mov ecx, 4

CopyLoop:
    mov eax, array[esi*4]
    mov array[esi*4-4], eax
    dec esi
    loop CopyLoop
```
5. Write a sequence of statements that display a subroutine’s return address. Be sure that what
ever modifications you make to the stack do not prevent the subroutine from returning to its
caller.
```asm
MySubroutine PROC
    mov eax, [esp]
    call DisplayAddress
    ret
MySubroutine ENDP
```

Programming Exercises
=====================

1. Draw Text Colors
Write a program that displays the same string in four different colors, using a loop. Call the Set
TextColor procedure from the book’s link library. Any colors may be chosen, but you may find
it easiest to change the foreground color.
```asm
TITLE Draw Text Color

INCLUDE Irvine32.inc

.data
message BYTE "Hello World",0

colorArray DWORD \
    white,
    yellow,
    cyan,
    magenta

colorCount = ($-colorArray) / TYPE colorArray

.code
main PROC
    mov ecx, colorCount
    mov esi, 0

L1:
    mov eax, colorArray[esi]
    call SetTextColor

    lea edx, message
    call WriteString

    call Crlf

    add esi, 4
    loop L1

    exit
main ENDP
END main
```

2. Linking Array Items
Suppose you are given three data items that indicate a starting index in a list, an array of charac
ters, and an array of link index. You are to write a program that traverses the links and locates the
characters in their correct sequence. For each character you locate, copy it to a new array. Sup
pose you used the following sample data, and assumed the arrays use zero-based indexes:
```asm
start = 1
chars: H A C E B D F G
links: 0 4 5 6 2 3 7 0
```
Then the values copied (in order) to the output array would be A,B,C,D,E,F,G,H. Declare the
character array as type BYTE, and to make the problem more interesting, declare the links array
type DWORD.
```asm
TITLE Linking Array Items
INCLDUE Irvine32.inc

.data
start =1

chars BYTE 'H', 'A', 'C', 'E', 'B', 'D', 'F', 'G'
links BYTE '0' '4' '5' '6' '2' '3' '7' '0'

output BYTE 8 DUP(?)

.code
main PROC
    mov esi, start
    mov edi, 0
    mov ecx, 8

L1:
    movzx eax, chars[esi]
    mov output[edi], al

    movzx esi, links[esi]

    inc edi
    loop L1

    lea edx, output
    call WriteString
    call Crlf

    exit

main ENDP

END main
```

3. Simple Addition (1)
Write a program that clears the screen, locates the cursor near the middle of the screen, prompts
the user for two integers, adds the integers, and displays their sum.
```asm
TITLE SIMPLE Addition
INCLUDE Irvine32.inc

.data
prompt1 BYTE "Enter first Integer: ",0
prompt2 BYTE "Enter second Integer: ",0
sumMsg BYTE "Sum = ",0

.code
main PROC
    call Clrscr

    mov dh, 12
    mov dl, 40
    call Gotoxy

    lea edx,prompt1
    call WriteString
    call ReadInt
    mov ebx, eax

    call Crlf
    lea edx, prompt2
    call WriteString
    call ReadInt

    add eax, ebx

    call Crlf
    lea edx, sumMsg
    call WriteString
    call WriteInt
    call Crlf
    
    exit
main ENDP
END main
```

4. Simple Addition (2)
Use the solution program from the preceding exercise as a starting point. Let this new program
repeat the same steps three times, using a loop. Clear the screen after each loop iteration.
```asm
TITLE Simple Addition
INCLUDE irvine32.inc

.data
prompt1 BYTE "Enter first Integer: ",0
prompt2 BYTE "Enter second Integer: ",0
sumMsg BYTE "Sum = ",0
iteration BYTE "Iteration ",0

.code
main PROC
    mov ecx,3

L1:
    call Clrscr

    mov dh,5
    mov dl,20
    call Gotoxy
    
    lea edx, iteration
    call WriteString
    mov eax,4
    sub eax, ecx
    inc eax
    call WriteInt
    call Crlf

    lea edx, prompt1
    call WriteString
    call ReadInt
    mov ebx, eax

    call Crlf
    lea edx, prompt2
    call WriteString
    call ReadInt
    
    add eax, ebx

    call Crlf
    lea edx, sumMsg
    call WriteString
    call WriteInt
    call Crlf
    call Crlf
    call WaitMsg

    loop L1

    exit
main ENDP
END main
```

5. BetterRandomRange Procedure
The RandomRange procedure from the Irvine32 library generates a pseudorandom integer between
0 and N-1. Your task is to create an improved version that generates an integer between M and
N 1. Let the caller pass M in EBX and N in EAX. If we call the procedure BetterRandomRange, the
following code is a sample test:
```asm
mov  ebx,-300 ; lower bound
mov  eax,100 ; upper bound
call BetterRandomRange
```
Write a short test program that calls BetterRandomRange from a loop that repeats 50 times.
Display each randomly generated value.
```asm
TITLE BetterRandomRange
INCLUDE Irvine32.inc

.data
result DWORD ?

.code
BetterRandomRange PROC
    push eax
    push ebx

    sub eax, ebx
    call RandomRange

    pop ebx
    add eax, ebx

    pop ecx

    ret
BetterRandomRange ENDP

main PROC
    mov ecx, 50

L1:
    mov ebx, -300
    mov eax, 100
    call BetterRandomRange

    mov result, eax
    call WriteInt
    call Crlf

    loop L1

    exit

main ENDP
END main
```

6. Random Strings
Create a procedure that generates a random string of length L, containing all capital letters.
When calling the procedure, pass the value of L in EAX, and pass a pointer to an array of byte
that will hold the random string. Write a test program that calls your procedure 20 times and dis
plays the strings in the console window. 
```asm
TITLE Random String
INCLUDE Irvine32.inc

RandomString PROC
    push ecx
    push esi
    push eax

    mov esi, edx
    mov ecx, eax
    xor eax, eax

L1:
    mov eax, 26
    call RandomRange
    add al, 'A'

    mov [esi], al
    inc esi

    loop L1

    mov BYTE PTR [esi],0

    pop eax
    pop esi
    pop ecx
    ret
RandomString ENDP

.data
stringArray BYTE 30 DUP(?)

.code
main PROC
    mov ecx, 20

L1:
    mov eax, 10
    lea edx, stringArray
    call WriteString
    call Crlf

    loop L1

    exit

main ENDP
END main

```

7. Random Screen Locations
Write a program that displays a single character at 100 random screen locations, using a timing
delay of 100 milliseconds. Hint: Use the GetMaxXY procedure to determine the current size of
the console window.
```asm
TITLE Random Screen Location
INCLUDE Irvine32.inc

.code
main PROC
    call Clrscr
    call GetMaxXY

    mov ecx,100

L1:
    mov eax, ecx
    xor eax, eax
    mov eax, DWORD PTR [esp]
    call RandomRange
    mov dl, al

    mov al, dh
    dec al
    call RandomRange
    mov dh, al

    call Gotoxy

    mov al, '*'
    call WriteChar

    mov eax, 100
    call Delay

    loop L1

    call Crlf
    exit
main ENDP
END main
```

8. Color Matrix
Write a program that displays a single character in all possible combinations of foreground and
background colors (16X16=256). The colors are numbered from 0 to 15, so you can use a
nested loop to generate all possible combinations.
```asm
TITLE Color Matrix
INCLUDE Irvine32.inc

.code
main PROC
    call Clrscr

    mov ecx, 16

L2:
    mov ebx,ecx
    mov ecx,16
    mov eax,0

L1:
    mov esi, ecx

    mov eax, ebx
    sub eax,1
    imul eax, 16
    mov ecx,esi
    sub ecx,1
    mov eax,ecx

    call SetTextColor

    mov al, 'X'
    call WriteChar

    mov ecx,esi
    loop L1

    call Crlf
    mov ecx,ebx
    loop L2

    exit

main ENDP
END main
```

9. Recursive Procedure
Direct recursion is the term we use when a procedure calls itself. Of course, you never want to
let a procedure keep calling itself forever, because the runtime stack would fill up. Instead, you
must limit the recursion in some way. Write a program that calls a recursive procedure. Inside
this procedure, add 1 to a counter so you can verify the number of times it executes. Run your
program with a debugger, and at the end of the program, check the counter’s value. Put a num
ber in ECX that specifies the number of times you want to allow the recursion to continue. Using
only the LOOP instruction (and no other conditional statements from later chapters), find a way
for the recursive procedure to call itself a fixed number of times.
```asm
TITLE Recursive Procedure
INCLUDE Irvine32.inc

.data
counter DWORD 0
depth = 5

.code
RecursiveProc PROC
    cmp ecx,0
    je Done

    push ecx
    
    mov eax, counter
    inc eax
    mov counter, eax

    mov ecx, [esp]
    dec esp
    call RecursiveProc

    pop ecx
    jmp End

Done:
    inc counter

End:
    ret
RecursiveProc ENDP

main PROC
    mov counter,0
    mov ecx, depth
    call RecursiveProc

    mov eax,counter
    call WriteInt
    call Crlf

    exit

main ENDP
END main
```

10. Fibonacci Generator
Write a procedure that produces N values in the Fibonacci number series and stores them in an
array of doubleword. Input parameters should be a pointer to an array of doubleword, a
counter of the number of values to generate. Write a test program that calls your procedure,
passing N = 47. The first value in the array will be 1, and the last value will be 2,971,215,073.
Use the Visual Studio debugger to open and inspect the array contents.
```asm
TITLE Fibonacci Generator
INCLUDE Irvine32.inc

FibonacciProc PROC
    cmp ecx, 0
    je FibExit

    cmp ecx, 1
    je Fib1

    cmp ecx, 1
    je Fib2

    mov DWORD PTR [edx], 1
    mov DWORD PTR [edx+4],1

    mov eax,1
    mov ebx,1
    mov esi, edx
    add esi, 8

    mov edi,2

FibLoop:
    cmp edi, ecx
    jge FibExit

    mov eax, ebx
    add eax, [esi-8]

    mov [esi], eax

    mov eax, ebx
    mov ebx, [esi]

    add esi, 4
    inc edi
    jmp FibLoop

Fib1:
    mov DWORD PTR [edx], 1
    jmp FibExit

Fib2:
    mov DWORD PTR [edx],1
    mov DWORD PTR [edx+4], 1

FibExit:
    ret
FibonacciProc ENDP

.data
fibArray DWORD 47 DUP(?)

.code
main PROC
    lea edx, fibArray
    mov ecx, 47
    call FibonacciProc

    mov eax, fibArray[0]
    call WriteInt
    call Crlf

    mov eax, ibArray[184]
    call WriteInt
    call Crlf

    exit

main ENDP
END main
```

11. Finding Multiples of K
In a byte array of size N, write a procedure that finds all multiples of K that are less than N. Ini
tialize the array to all zeros at the beginning of the program, and then whenever a multiple is
found, set the corresponding array element to 1. Your procedure must save and restore any regis
ters it modifies. Call your procedure twice, with K = 2, and again with K = 3. Let N equal to 50.
Run your program in the debugger and verify that the array values were set correctly. Note: This
procedure can be a useful tool when finding prime integers. An efficient algorithm for finding
prime numbers is known as the Sieve of Eratosthenes. You will be able to implement this algo
rithm when conditional statements are covered in Chapter 6

```asm
TITLE Finding Multiples of K
INCLUDE Irvine32.inc

FindMultiples PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi

    mov esi, 0

FindLoop:
    cmp esi, eax
    jge FindExit

    mov ebx, esi
    xor edx, edx
    div ebx

    mov eax, esi
    mov ebx, [esp+8]
    xor edx,edx
    div dbx

    cmp edx,0
    jne NextItem

    mov ebx, [esp]
    mov BYTE PTR [ebx+esi],1

NextItem:
    inc esi
    jmp FindLoop

FindExit:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax

    ret

FindMultiples ENDP

.data
arraySize = 30
byteArray BYTE arraySize DUP(2)

.code
main PROC
    mov eax,3
    lea edx, byteArray
    mov ecx, arraySize
    call FindMultiples

    mov eax,5
    lea edx, byteArray
    mov ecx, arraySize
    call FindMultiples

    mov esi, 0

PrintLoop:
    cmp esi, arraySize
    jge PrintExit

    mov al, byteArray[esi]
    call WriteInt

    mov al, ' '
    call WriteChar

    inc esi
    jmp PrintLoop

PrintExit:
    call Crlf
    exit
main ENDP
END main
```