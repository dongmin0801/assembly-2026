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
1. Write a function that receives a string containing a 16-bit binary integer. The function must
return the string’s integer value.
2. Write a function that receives a string containing a 32-bit hexadecimal integer. The function
must return the string’s integer value.
3. Write a function that receives an integer. The function must return a string containing the
binary representation of the integer.
4. Write a function that receives an integer. The function must return a string containing the
hexadecimal representation of the integer.
5. Write a function that adds two digit strings in base b, where . Each string may
contain as many as 1,000 digits. Return the sum in a string that uses the same number base.
6. Write a function that adds two hexadecimal strings, each as long as 1,000 digits. Return a
hexadecimal string that represents the sum of the inputs.
7. Write a function that multiplies a single hexadecimal digit by a hexadecimal digit string as
long as 1,000 digits. Return a hexadecimal string that represents the product.