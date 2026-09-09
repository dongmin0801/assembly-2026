Review Questions and Exercises
==============================

1\. In an 8-bit binary number, which is the most significant bit (MSB)?  
\-\> 가장 왼쪽 비트  
2\. What is the decimal representation of each of the following unsigned binary integers?  
  a. 00110101 -\> 53  
  b. 10010110 -\> 150  
  c. 11001100 -\> 204

3\. What is the sum of each pair of binary integers?  
  a. 10101111 + 11011011 -\> 110001010  
  b. 10010111 + 11111111 -\> 110010110  
  c. 01110101 + 10101100 -\> 100100001

4\. Calculate binary 00001101 minus 00000111.  
\-\> 00000110

5\. How many bits are used by each of the following data types?  
  a. word -\> 16비트  
  b. doubleword -\> 32비트  
  c. quadword -\> 64비트  
  d. double quadword -\> 128비트

6\. What is the minimum number of binary bits needed to represent each of the following  
unsigned decimal integers?  
  a. 4095 -\> 12비트  
  b. 65534 -\> 16비트  
  c. 42319 -\> 16비트

7\. What is the hexadecimal representation of each of the following binary numbers?  
  a. 0011 0101 1101 1010 -\> 35DA  
  b. 1100 1110 1010 0011 -\> CEA3  
  c. 1111 1110 1101 1011 -\> FEDB

8\. What is the binary representation of the following hexadecimal numbers?  
  a. 0126F9D4 -\> 0000 0001 0010 0110 1111 1001 1101 0100  
  b. 6ACDFA95 -\> 0110 1010 1100 1101 1111 1010 1001 0101  
  c. F69BDC2A -\> 1111 0110 1001 1011 1101 1100 0010 1010

9\. What is the unsigned decimal representation of each of the following hexadecimal integers?  
  a. 3A -\> 58  
  b. 1BF -\> 447  
  c. 1001 -\> 4097

10\. What is the unsigned decimal representation of each of the following hexadecimal integers?  
  a. 62 -\> 98  
  b. 4B3 -\> 1203  
  c. 29F -\> 671

11\. What is the 16-bit hexadecimal representation of each of the following signed decimal integers?  
  a. -24 -\> FFE8
  b. -331 -\> FEB5 

12\. What is the 16-bit hexadecimal representation of each of the following signed decimal integers?  
  a. -21 -\> FFEB
  b. -45 -\> FFD3

13\. The following 16-bit hexadecimal numbers represent signed integers. Convert each to decimal.  
  a. 6BF9 -\> 27641  
  b. C123 -\> -16093

14\. The following 16-bit hexadecimal numbers represent signed integers. Convert each to  
decimal.  
  a. 4CD2 -\> 19666
  b. 8230 -\> -32208

15\. What is the decimal representation of each of the following signed binary numbers?  
  a. 10110101 -\> -75
  b. 00101010 -\> 42
  c. 11110000 -\> -16

16\. What is the decimal representation of each of the following signed binary numbers?  
  a. 10000000 -\> -128
  b. 11001100 -\> -52
  c. 10110111 -\> -73

17\. What is the 8-bit binary (two’s-complement) representation of each of the following signed  
decimal integers?  
  a. -5 -\> 11111011  
  b. -42 -\> 11010110  
  c. -16 -\> 11110000

18\. What is the 8-bit binary (two’s-complement) representation of each of the following signed  
decimal integers?  
  a. -72 -\> 10111000  
  b. -98 -\> 10011110  
  c. -26 -\> 11100110

19\. What is the sum of each pair of hexadecimal integers?  
  a. 6B4 + 3FE -\> AB2  
  b. A49 + 6BD -\> 1106

20\. What is the sum of each pair of hexadecimal integers?  
  a. 7C4  3BE -\> B82  
  b. B69  7AD -\> 1316

1. What are the hexadecimal and decimal representations of the ASCII character capital B? -\> 42(16진수) 66(10진수)

1. What are the hexadecimal and decimal representations of the ASCII character capital G? -\> 47(16진수) 71(10진수)

23\. Challenge: What is the largest decimal value you can represent, using a 129-bit unsigned  
integer? -\> 2^129-1

24\. Challenge: What is the largest decimal value you can represent, using a 86-bit signed  
integer? -\> 2^85-1

25\. Create a truth table to show all possible inputs and outputs for the boolean function  
described by ¬( ).  
\-\> A B ¬(AuB)  
   1 0    0  
   0 1    0  
   1 1    0  
   0 0    1

26\. Create a truth table to show all possible inputs and outputs for the boolean function  
described by ( ). How would you describe the rightmost column of this table in  
relation to the table from question number 25? Have you heard of De Morgan’s Theorem?  
\-\> A B (¬A n ¬B)  
   1 0     0  
   0 1     0  
   1 1     0  
   0 0     1

27\. If a boolean function has four inputs, how many rows are required for its truth table?  
\-\> 16행  
28\. How many selector bits are required for a four-input multiplexer?  
\-\> 2비트


Use any high-level programming language you wish for the following programming exercises.
Do not call built-in library functions that accomplish these tasks automatically. (Examples are
sprintf and sscanf from the Standard C library.)
1. Write a function that receives a string containing a 16-bit binary integer. The function must return the string’s integer value.

```python
def binary_to_int(s):
    result = 0

    for ch in s:
        result = result * 2

        if ch == '1':
            result += 1

    return result


print(binary_to_int("101101"))
```

2. Write a function that receives a string containing a 32-bit hexadecimal integer. The function must return the string’s integer value.

```python
def hex_to_int(s):
    result = 0

    for ch in s:
        result = result * 16

        if '0' <= ch <= '9':
            value = ord(ch) - ord('0')
        elif 'A' <= ch <= 'F':
            value = ord(ch) - ord('A') + 10
        elif 'a' <= ch <= 'f':
            value = ord(ch) - ord('a') + 10
        else:
            return None

        result += value

    return result


print(hex_to_int("1A3"))
print(hex_to_int("FF"))
```
3. Write a function that receives an integer. The function must return a string containing the binary representation of the integer.

```python
def int_to_binary(n):
    if n == 0:
        return "0"

    result = ""

    while n > 0:
        remainder = n % 2

        if remainder == 0:
            result = "0" + result
        else:
            result = "1" + result

        n = n // 2

    return result


print(int_to_binary(13))
print(int_to_binary(255))
```

4. Write a function that receives an integer. The function must return a string containing the hexadecimal representation of the integer.

```python
def int_to_hex(n):
    if n == 0:
        return "0"

    result = ""

    while n > 0:
        remainder = n % 16

        if remainder < 10:
            ch = chr(ord('0') + remainder)
        else:
            ch = chr(ord('A') + remainder - 10)

        result = ch + result

        n = n // 16

    return result


print(int_to_hex(255))
print(int_to_hex(419))
```

5. Write a function that adds two digit strings in base b, where . Each string may
contain as many as 1,000 digits. Return the sum in a string that uses the same number base.

```python
def char_to_value(ch):
    if '0' <= ch <= '9':
        return ord(ch) - ord('0')
    elif 'A' <= ch <= 'Z':
        return ord(ch) - ord('A') + 10
    elif 'a' <= ch <= 'z':
        return ord(ch) - ord('a') + 10

    return -1


def value_to_char(value):
    if value < 10:
        return chr(ord('0') + value)
    else:
        return chr(ord('A') + value - 10)


def add_base(a, b, base):
    i = len(a) - 1
    j = len(b) - 1

    carry = 0
    result = ""

    while i >= 0 or j >= 0 or carry > 0:

        x = 0
        y = 0

        if i >= 0:
            x = char_to_value(a[i])
            i -= 1

        if j >= 0:
            y = char_to_value(b[j])
            j -= 1

        total = x + y + carry

        digit = total % base
        carry = total // base

        result = value_to_char(digit) + result

    return result
```

6. Write a function that adds two hexadecimal strings, each as long as 1,000 digits. Return a hexadecimal string that represents the sum of the inputs.

```python
def hex_digit_to_value(ch):
    if '0' <= ch <= '9':
        return ord(ch) - ord('0')
    elif 'A' <= ch <= 'F':
        return ord(ch) - ord('A') + 10
    elif 'a' <= ch <= 'f':
        return ord(ch) - ord('a') + 10

    return -1


def value_to_hex_digit(value):
    if value < 10:
        return chr(ord('0') + value)
    else:
        return chr(ord('A') + value - 10)


def add_hex(a, b):
    i = len(a) - 1
    j = len(b) - 1

    carry = 0
    result = ""

    while i >= 0 or j >= 0 or carry > 0:

        x = 0
        y = 0

        if i >= 0:
            x = hex_digit_to_value(a[i])
            i -= 1

        if j >= 0:
            y = hex_digit_to_value(b[j])
            j -= 1

        total = x + y + carry

        digit = total % 16
        carry = total // 16

        result = value_to_hex_digit(digit) + result

    return result


print(add_hex("1A", "2F"))
print(add_hex("FFFF", "1"))
print(add_hex("ABCDEF", "123456"))
```
7. Write a function that multiplies a single hexadecimal digit by a hexadecimal digit string as long as 1,000 digits. Return a hexadecimal string that represents the product.

```python
def multiply_hex_digit(digit, s):
    x = hex_digit_to_value(digit)

    if x < 0 or x > 15:
        return None

    i = len(s) - 1
    carry = 0
    result = ""

    while i >= 0:

        y = hex_digit_to_value(s[i])

        total = x * y + carry

        product_digit = total % 16
        carry = total // 16

        result = value_to_hex_digit(product_digit) + result

        i -= 1

    while carry > 0:
        digit_value = carry % 16
        result = value_to_hex_digit(digit_value) + result
        carry = carry // 16

    return result


print(multiply_hex_digit("A", "1234"))
print(multiply_hex_digit("F", "FFFF"))
print(multiply_hex_digit("2", "ABC"))
```