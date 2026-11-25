# assembly-2026

2026년 어셈블리 언어 수업 정리 저장소입니다.
교재(Kip Irvine, *Assembly Language for x86 Processors*) 각 장의 **Review Questions / Short Answer / Exercises** 풀이와 MASM 실습 코드를 날짜별 폴더로 정리했습니다.

## 폴더 구조

```
assembly-2026/
├── MMDD/            # 수업 날짜
│   ├── chapN.md     # N장 문제 풀이 (Short Answer, Algorithm Workbench, Programming Exercises)
│   └── *.asm, *.png # 실습 코드와 실행 결과
└── README.md
```

## 장별 내용

| 날짜 | 장 | 주제 | 파일 |
|------|----|------|------|
| [09/03](./0903) | 1장 | 기본 개념 (2진·16진수 변환, 부호 있는 정수, ASCII) | [chap1.md](./0903/chap1.md) |
| [09/10](./0910) | 2장 | x86 프로세서 구조 (레지스터, 상태 플래그) | [chap2.md](./0910/chap2.md) |
| [09/17](./0917) | 3장 | 어셈블리 언어 기초 (명령어, 지시어, 엔디언, 데이터 정의) | [chap3.md](./0917/chap3.md) |
| [10/01](./1001) | 4장 | 데이터 전송, 주소 지정, 산술 연산 (`MOVSX`, 플래그, `NEG`) | [chap4.md](./1001/chap4.md) |
| [10/08](./1008) | 5장 | 프로시저 (스택, `PUSHAD`/`POPFD`, `CALL`/`RET`, `USES`) | [chap5.md](./1008/chap5.md) |
| [10/15](./1015) | 6장 | 조건 처리 (`AND`/`OR`/`XOR`, 조건 점프, 플래그) | [chap6.md](./1015/chap6.md) |
| [10/29](./1029) | 7장 | 정수 산술 (시프트·회전, `MUL`/`DIV`, 확장 덧셈·뺄셈) | [chap7.md](./1029/chap7.md) |
| [11/05](./1105) | 8장 | 고급 프로시저 (스택 매개변수, 지역 변수, 호출 규약, `LEA`) | [chap8.md](./1105/chap8.md) |
| [11/12](./1112) | 9장 | 문자열과 배열 (문자열 기본 명령어, `Str_*` 프로시저, 이진 탐색) | [chap9.md](./1112/chap9.md) |
| [11/19](./1119) | 10장 | 구조체와 매크로 (`STRUCT`, `MACRO`, 조건부 어셈블리) | [chap10.md](./1119/chap10.md) |


## 개발 환경

- Visual Studio + MASM (x86, 32비트)
