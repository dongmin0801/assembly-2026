; ------------------------------------------------------------
; 두 개의 정수를 입력받아 사칙연산을 수행하고,
; 각 연산 직후의 AX, BX, CX, DX 레지스터 내용을 출력하는 프로그램
; Visual Studio + MASM + Irvine32 라이브러리 기준 (x86)
;
; 입력 범위: 16비트 부호 있는 정수 (-32768 ~ 32767)
;
; 레지스터 사용 규칙
;   덧셈/뺄셈 : AX = A, BX = B, CX = 결과,        DX = 0
;   곱셈      : AX = 곱의 하위 16비트, DX = 상위 16비트, BX = B, CX = 0
;   나눗셈    : AX = 몫, DX = 나머지, BX = B, CX = A(피제수)
; ------------------------------------------------------------
INCLUDE Irvine32.inc

.data
promptA     BYTE "Enter first number  (A): ", 0
promptB     BYTE "Enter second number (B): ", 0

titleAdd    BYTE "[ A + B ]", 0
titleSub    BYTE "[ A - B ]", 0
titleMul    BYTE "[ A * B ]  (32-bit product = DX:AX)", 0
titleDiv    BYTE "[ A / B ]  (AX = quotient, DX = remainder)", 0

resultMsg   BYTE "Result    = ", 0
quotMsg     BYTE "Quotient  = ", 0
remMsg      BYTE "Remainder = ", 0
divZeroMsg  BYTE "Cannot divide by zero.", 0

lblAX       BYTE "AX = ", 0
lblBX       BYTE "BX = ", 0
lblCX       BYTE "CX = ", 0
lblDX       BYTE "DX = ", 0
hexEnd      BYTE "h  (", 0
decEnd      BYTE ")", 0

numA        SWORD ?
numB        SWORD ?

valAX       WORD ?                 ; ShowRegs가 저장해 두는 레지스터 값
valBX       WORD ?
valCX       WORD ?
valDX       WORD ?

.code
; ------------------------------------------------------------
; PrintReg : EDX = 라벨 주소, EAX = 값(16비트, 0 확장)
;            "AX = 0014h  (+20)" 형식으로 한 줄 출력
; ------------------------------------------------------------
PrintReg PROC
    push eax
    call WriteString               ; 라벨 출력
    mov  ebx, 2                    ; 2바이트(4자리) 16진수
    call WriteHexB                 ; EAX를 16진수로 출력
    mov  edx, OFFSET hexEnd
    call WriteString
    pop  eax
    movsx eax, ax                  ; 부호 있는 10진수로도 출력
    call WriteInt
    mov  edx, OFFSET decEnd
    call WriteString
    call Crlf
    ret
PrintReg ENDP

; ------------------------------------------------------------
; ShowRegs : 호출 시점의 AX, BX, CX, DX 값을 출력 (레지스터는 그대로 보존)
; ------------------------------------------------------------
ShowRegs PROC
    mov  valAX, ax                 ; 먼저 값을 메모리에 저장
    mov  valBX, bx
    mov  valCX, cx
    mov  valDX, dx
    pushad                         ; 출력 중 레지스터가 바뀌므로 보존

    mov  edx, OFFSET lblAX
    movzx eax, valAX
    call PrintReg
    mov  edx, OFFSET lblBX
    movzx eax, valBX
    call PrintReg
    mov  edx, OFFSET lblCX
    movzx eax, valCX
    call PrintReg
    mov  edx, OFFSET lblDX
    movzx eax, valDX
    call PrintReg

    popad
    ret
ShowRegs ENDP

main PROC
    ; ---- 두 수 입력 ----
    mov  edx, OFFSET promptA
    call WriteString
    call ReadInt
    mov  numA, ax

    mov  edx, OFFSET promptB
    call WriteString
    call ReadInt
    mov  numB, ax
    call Crlf

    ; ==================== 덧셈 ====================
    mov  edx, OFFSET titleAdd
    call WriteString
    call Crlf

    mov  ax, numA
    mov  bx, numB
    mov  cx, ax
    add  cx, bx                    ; CX = A + B
    xor  dx, dx
    call ShowRegs

    mov  edx, OFFSET resultMsg
    call WriteString
    movsx eax, valCX
    call WriteInt
    call Crlf
    call Crlf

    ; ==================== 뺄셈 ====================
    mov  edx, OFFSET titleSub
    call WriteString
    call Crlf

    mov  ax, numA
    mov  bx, numB
    mov  cx, ax
    sub  cx, bx                    ; CX = A - B
    xor  dx, dx
    call ShowRegs

    mov  edx, OFFSET resultMsg
    call WriteString
    movsx eax, valCX
    call WriteInt
    call Crlf
    call Crlf

    ; ==================== 곱셈 ====================
    mov  edx, OFFSET titleMul
    call WriteString
    call Crlf

    mov  ax, numA
    mov  bx, numB
    imul bx                        ; DX:AX = AX * BX (부호 있는 곱셈)
    xor  cx, cx
    call ShowRegs

    mov  edx, OFFSET resultMsg
    call WriteString
    movzx eax, valDX               ; DX:AX 를 32비트 값으로 합치기
    shl  eax, 16
    movzx edx, valAX
    or   eax, edx
    call WriteInt
    call Crlf
    call Crlf

    ; ==================== 나눗셈 ====================
    mov  edx, OFFSET titleDiv
    call WriteString
    call Crlf

    cmp  numB, 0
    jne  DoDivide
    mov  edx, OFFSET divZeroMsg    ; 0으로 나누기 방지
    call WriteString
    call Crlf
    jmp  Finish

DoDivide:
    mov  ax, numA
    mov  bx, numB
    mov  cx, ax                    ; CX = 피제수(A)
    cwd                            ; DX:AX 로 부호 확장
    idiv bx                        ; AX = 몫, DX = 나머지
    call ShowRegs

    mov  edx, OFFSET quotMsg
    call WriteString
    movsx eax, valAX
    call WriteInt
    call Crlf

    mov  edx, OFFSET remMsg
    call WriteString
    movsx eax, valDX
    call WriteInt
    call Crlf

Finish:
    exit
main ENDP
END main