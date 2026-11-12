; ------------------------------------------------------------
; 5개의 정수를 입력받아 합계와 평균을 출력하는 프로그램
; Visual Studio + MASM + Irvine32 라이브러리 기준
; ------------------------------------------------------------
INCLUDE Irvine32.inc

COUNT = 5                          ; 입력받을 숫자 개수

.data
promptMsg   BYTE "Enter an integer: ", 0
sumMsg      BYTE "Sum       = ", 0
avgMsg      BYTE "Average   = ", 0
remMsg      BYTE "  (remainder ", 0
closeMsg    BYTE "/5)", 0

.code
main PROC
    mov  ebx, 0                    ; EBX = 합계
    mov  ecx, COUNT                ; 반복 횟수

InputLoop:
    mov  edx, OFFSET promptMsg
    call WriteString               ; 안내 문구 출력
    call ReadInt                   ; 정수 입력 -> EAX
    add  ebx, eax                  ; 합계 누적
    loop InputLoop

    ; ---- 합계 출력 ----
    mov  edx, OFFSET sumMsg
    call WriteString
    mov  eax, ebx
    call WriteInt
    call Crlf

    ; ---- 평균 계산 (정수 나눗셈) ----
    mov  eax, ebx
    cdq                            ; EDX:EAX 부호 확장
    mov  ecx, COUNT
    idiv ecx                       ; EAX = 몫(평균), EDX = 나머지
    mov  ebx, edx                  ; 나머지 보관

    ; ---- 평균 출력 ----
    mov  edx, OFFSET avgMsg
    call WriteString
    call WriteInt                  ; EAX = 몫
    mov  edx, OFFSET remMsg
    call WriteString
    mov  eax, ebx
    call WriteInt                  ; 나머지
    mov  edx, OFFSET closeMsg
    call WriteString
    call Crlf

    exit
main ENDP
END main