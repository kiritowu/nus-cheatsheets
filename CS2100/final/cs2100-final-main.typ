#import "cs2100-final-common.typ": *

#show: cheatsheet-layout

= C Programming
== Basic Syntax
#concept-block(
  body: [
    #inline("Variable Assignment and Declaration")
    - Variable declaration: `int a;`
      - Uninitialized automatic (block-scope, non-static) variables have indeterminate values; reading them is undefined behavior.
      - Objects with static storage duration (file-scope objects and `static` objects) are zero-initialized before program start.
    - Assignment: `a = 12;` yields the assigned value (type of the left operand), so:
      ```c
      z = (a = 12); // a becomes 12, z becomes 12
      ```
      - Associates right-to-left: `x = y = z = 42;`
      - Beware: `=` (assignment) vs `==` (comparison) in conditions.
    - Variable scope: identifiers are scoped to the `{ ... }` block where they are declared. Inner declarations shadow outer ones. Using an out-of-scope name is an error.
    - Static variables (in functions): `static int c;` persists across calls.
      - Initialized once; initializer must be a constant expression (or address constant).
      - If no initialization is provided, it’s zero-initialized (numeric 0, null pointer).

    #inline("Control Flow: Switch Statements")
    - `switch` expression and `case` labels are of integer type (including enum); `case` labels must be integer constant expressions.
    - Fall-through by default; use `break` to exit a `case`.
      ```c
      switch (expr) {
        case v1: /* ... */ break;
        case v2: /* ... */ /* fall through */
        default: /* ... */ break; // default is optional
      }
      ```

    #inline("Loops")
    - `while` checks condition before each iteration:
      ```c
      while (condition) { /* body */ }
      ```
    - `do while` runs body once before checking:
      ```c
      do { /* body */ } while (condition);
      ```
    - `for` combines init; condition; update (the init’s scope is the loop):
      ```c
      for (init; condition; update) { /* body */ }
      ```
    - `break` exits the loop (or switch); `continue` skips to next iteration.
    - Infinite loop idiom: `for (;;) { /* ... */ }`
  ],
)

== Pointers and Arrays
#concept-block(body: [
  #inline("Pointers")
  - Pointers hold memory addresses at run time.
  - `&var` returns the address of `var`; `T *p;` declares a pointer to `T`; `*p` dereferences `p`.
  ```c
  double a, *pb;
  pb = &a;        // legal: pb points to a
  double c, *pd;
  *pd = &c;       // ILLEGAL: *pd is a double lvalue, &c is double* (type mismatch), and pd is uninitialized
  double e, f;
  f = &e;         // ILLEGAL: assigning an address to a non-pointer
  double *p = &e; // LEGAL: p points to e
  *p = 3.14;      // stores into e via p
  ```
  - Always initialize pointers before use (e.g., to `NULL` or a valid address). Dereferencing an invalid/uninitialized pointer is undefined behavior.
  - To print a pointer, use `printf("%p\n", ptr)`, which will print the hex value of the address
  - We can have void pointers, `void *ptr` that act as generic pointers (pointing to no particular type, useful for generic functions) but should be type cast to the correct type before use.

  #inline("Pointer Arithmetic")
  - If `ptr` is a `T*`, then `ptr + i` points to address `ptr + i * sizeof(T)`.
  - Increment/decrement moves by whole elements: `int*` moves by `sizeof(int)`, `char*` moves by `sizeof(char)` (1).
  - Subtracting two pointers of the same type gives the element distance: `ptr2 - ptr1` (both must point into the same array, or one past the end).
  - To increment the pointed-to value (not the pointer), use parentheses: `(*ptr)++;`

  #inline("Arrays")
  - Arrays are contiguous, fixed-size sequences of a single type.
  - At declaration, size must be known (statically). Initialization with `{ ... }` is only allowed at declaration.
    ```c
    int arr[2] = {1, 2};
    int arr2[] = {1, 2, 3};      // size inferred
    int some[3] = {1};           // remaining elements zero-initialized: {1, 0, 0}
    // Fill array values with user input
    int numbers[3];
    for (int i = 0; i < 3; i++) {
      scanf("%d", &numbers[i]);
    }
    ```
  - Dynamically allocated array:
    ```c
    // include <stdlib.h>
    size_t n = 100;
    int *dyn = malloc(n * sizeof *dyn); // no cast in C; checks sizeof via the dereferenced pointer
    if (!dyn) { /* handle allocation failure */ }
    /* ... use dyn ... */
    free(dyn);
    ```
  - We can get the length of an array as follows:
    ```c
    int array_length = sizeof(array_name) / sizeof(array_name[0]);
    ```
  - However, once we pass an array as a function argument, it decays to a pointer to the first element and the `sizeof` operator will instead just return the size of the pointer


  #inline("Arrays as Pointers")
  - In most expressions, arrays decay to pointers to their first element; exceptions: `sizeof`, unary `&`, and string literal to array initialization.
  - You cannot assign arrays (`arr1 = arr2;` is illegal), but you can use pointers to elements:
  ```c
  int *second = arr2 + 1;  // &arr2[0] + 1
  ```
  - Indexing `arr[i]` is equivalent to `*(&arr[0] + i)`; also `i[arr]` works but is discouraged.

  #inline("Strings")
  - Strings are `char` arrays terminated by `'\0'`. Without the terminator, string functions are unsafe.
  - The following initializations are equivalent:
    ```c
    char str[] = "hello";
    char str2[] = {'h','e','l','l','o','\0'};
    ```
  - Iteration patterns:
    ```c
    // pointer style (ptr must point to str)
    // this works as '\0' is 0 in ASCII, so evaluates to false
    for (char *p = str; *p; ++p) { /* use *p */ }

    // index style
    for (size_t i = 0; str[i] != '\0'; ++i) { /* use str[i] */ }

    // avoid recomputing strlen in loop condition
    size_t len = strlen(str);
    for (size_t i = 0; i < len; ++i) { /* ... */ }
    ```
  - String I/O
    - Input:
      - `fgets(str, size, stdin)`: reads up to `size - 1` chars or newline (keeps newline if space permits).
      - `scanf("%s", str)`: reads until whitespace; use a width to avoid overflow, e.g., `scanf("%99s", str)`.
    - Output:
      - `puts(str)`: writes `str` then newline.
      - `printf("%s\n", str)`: writes until `'\0'`.
  - Common string functions:
    - `strlen(s)`: number of chars before `'\0'` (terminator not counted).
    - `strcmp(s1, s2)`: returns 0 if equal, $<0$ if `s1 < s2`, >0 otherwise (lexicographic by unsigned char values).
      - Bounded: `strncmp(s1, s2, n)`.
    - `strcpy(dst, src)`: copies `src` into `dst` (requires `dst` large enough).
      - Bounded: `strncpy(dst, src, n)` but beware: it does not always append `'\0'` if truncated.
      - Safer patterns: ensure capacity and terminate manually, or use `strlcpy` where available (non-standard).
])

== Structs and Unions
#concept-block(body: [
  #inline("Structs")
  - A `struct` groups related fields into one object.
  ```c
  struct Point {
    int x;
    int y;
  };

  struct Point p1 = { .x = 10, .y = 20 };   // designated init
  struct Point p2 = { 1, 2 };               // positional init
  ```
  - `typedef` to avoid repeating `struct`:
  ```c
  typedef struct {
    int x, y;
  } Point;

  Point p = { .x = 3, .y = 4 };
  ```
  - Passing/returning structs:
  ```c
  Point make_point(int x, int y) { return (Point){ x, y }; } // compound literal
  void move(Point *p, int dx, int dy) { p->x += dx; p->y += dy; } // pass pointer to modify
  ```
  - Memory allocation: struct members are stored in memory in the order they are declared within the struct definition. Note that if you declare a `char*`, the memory allocated will be only for the pointer, the string itself will be stored somewhere else in memory

  #inline("Partial Initialization")
  - It is possible to partially initialize a struct; any members not explicitly initialized are zero-initialized.
    - Positional initialization fills fields in order; missing trailing fields become zero.
    - You cannot skip a middle field without designators; use designated initializers to name only the members you want.
  ```c
  typedef struct { int a; double b; int c; } S;

  S s1 = { 42 };                 // a=42, b=0.0, c=0
  S s2 = { 1, 2.5 };             // a=1,  b=2.5, c=0
  S s3 = { .c = 7 };             // a=0,  b=0.0, c=7  (designated init)
  S s4 = { .b = 3.14, .a = 9 };  // order of designators can vary; unspecified become zero
  ```

  #inline("Arrow vs Dot Operator")
  - `.` accesses a member of a struct object.
  - `->` accesses a member through a pointer to struct (equivalent to `(*ptr).member`).
  ```c
  Point p = {1, 2};
  Point *pp = &p;

  int a = p.x;      // dot
  int b = pp->y;    // arrow, same as (*pp).y
  ```
  - Parentheses matter when combining with `*`:
  ```c
  *pp.x      // ERROR: '.' binds before '*'; tries to access field on pp (not a struct)
  (*pp).x    // OK
  pp->x      // OK (preferred)
  ```

  #inline("Nested Structs and Arrays/Strings")
  ```c
  typedef struct {
    char name[32];
    Point pos;
  } Sprite;

  Sprite s = { .name = "player", .pos = { .x = 10, .y = 20 } };
  ```

])


== Functions and Parameter Passing
#concept-block(body: [
  #inline("Pass-by-Value vs 'By-Reference'")
  - C passes arguments by value only: a function receives copies of the arguments.
  - To let a function modify a caller’s object, pass the object’s address (pointer). This is often called “pass-by-reference” idiomatically.
  ```c
  // Pass-by-value: does not change caller's x and y
  void swap_bad(int x, int y) {
    int t = x; x = y; y = t;
  }

  // Pass 'by reference': pass addresses so the function can modify caller's ints
  void swap(int *x, int *y) {
    int t = *x; *x = *y; *y = t;
  }

  int a = 1, b = 2;
  swap_bad(a, b);     // a==1, b==2
  swap(&a, &b);       // a==2, b==1
  ```
  - Arrays in parameter lists decay to pointers; the function receives a pointer to the first element, not a full array copy:
  ```c
  void sum(const int *arr, size_t n, long long *out) {
    long long s = 0;
    for (size_t i = 0; i < n; ++i) s += arr[i];
    *out = s;
  }
  ```
  - Use `const` to signal “this pointer points to data I will not modify”: `void f(const int *p);`
  - Distinguish:
    - `const int *p` — pointer to const int (you cannot modify `*p` via `p`).
    - `int * const p` — const pointer to int (the pointer value can’t change, but `*p` can).
    - `const int * const p` — both are const.

  #inline("Passing Structs to Functions")
  - When structs are passed into a function, we actually perform a pass by value, meaning that we copy all the values within the struct
  - This includes arrays, so modifying the array inside a struct within a function does not affect the original array
  - Exception: if the data type is defined as a pointer (e.g using `char *` instead of `char[]`) then the pointer copied over still references the original array

  #inline("Returning multiple values")
  - Return one value directly; return others via pointer parameters or structs:
    ```c
    typedef struct { int min, max; } MinMax;
    MinMax bounds(const int *a, size_t n);
    ```
])



= Data Representation
#concept-block(body: [
  #inline("Data Representation")
  In C, a data type of a variable determines its interpretation from binary.
  #table(
    columns: 4,

    table.header([Type], [Bits], [Min Values], [Max Values]),
    // Booleans
    [\_Bool or bool (if `#include <stdbool.h>`)], [8], [$0$], [$1$],

    // Character types (8-bit bytes)
    [char], [8], [$0$],
    // implementation-defined
    [$2^8$ ; $255$],

    // Short (typically 16-bit)
    [short], [16], [$-2^15$ ; $-32768$], [$2^15-1$ ; $32767$],

    [unsigned short], [16], [$0$ ], [$2^16-1$ ; $65535$],

    // Int (typically 32-bit)
    [int], [32], [$-2^31$ ; $-2147483648$], [$2^31-1$ ; $2147483647$],

    [unsigned int], [32], [$0$], [$2^{32}-1$ ; $4294967295$],

    // Long (LP64: 64-bit; Windows LLP64 is 32-bit)
    [long], [64], [$-2^63$], [$2^63-1$],

    [unsigned long], [64], [$0$], [$2^64-1$],

    // Floating point (IEEE-754; maxima shown; mins are negative maxima)
    // Max finite ≈ (2 − 2^(−p))·2^(e_max); show power-of-two magnitude and decimal max.
    [float], [32], [$-3.4028235 times 10^38$], [$3.4028235 times 10^38$],

    [double], [64], [$-1.79769 times 10^308$], [ $1.79769 times 10^308$],
  )
  ```c
  int number = 70; // 0b01000110

  printf("Represented as Digit %d\n", number); // 70
  printf("Represented as Char %c\n", number); // F
  ```
  #inline("Common Bytes Quantifier")
  - Byte: 8 bits
  - Nibble: 4 bits
  - Word: Architecture-dependent fixed width (MIPS uses 1 word = 32 bits = 4 bytes)

  #inline("Number of Represented Values")
  - $N$ bits represent up to $2^N$ values
  - $ceil(log_2M)$ bits represents $M$ values

  #inline("IEEE 754 Hex → Decimal (Single Precision)")
  - A 32-bit float uses: 1 sign bit, 8 exponent bits (bias 127), 23 fraction bits with an implicit leading 1 for normalized numbers.
  - Exam recipe to convert hex→decimal:
    1. Convert the 32-bit hex to binary; split into sign `s`, exponent `E`, fraction `F`.
    2. Compute sign: $(-1)^s$ and unbiased exponent: $e = E - 127$ (for $0 < E < 255$).
    3. Build mantissa: $M = 1.F$ in binary (hidden leading 1) for normalized values, or $M = 0.F$ if $E = 0$ (denormals).
    4. Value is $x = (-1)^s times M times 2^e$; special cases: $E = 255, F = 0$ → ±∞; $E = 255, F != 0$ → NaN; $E = 0, F = 0$ → ±0.
  - For decimal→hex, reverse the process: choose the sign, normalize the value to $1.F times 2^e$, then store the biased exponent $E = e + 127$ and the lower 23 bits of the fraction field.
])


= Number System
== Weighted Positional Number System
#concept-block(body: [
  - In a *weighted-positional number system* of base $r$ each position holds _multiples_ of _power of radix_.
    - Can have _radix_ number of unique symbols.
    - E.g. Decimal number system is a *weighted-positional* number system, where the Base (aka Radix) is 10.

    $(a_n a_(n-1) \ldots a_0.f_1 f_2 \ldots f_m)_r = (a_n times r^n) + (a_(n-1) times r^(n-1)) + \ldots + (a_0 times r^0) + (f_1 times r^-1) + (f_2 times r^-2) + \ldots + (f_m times r^-m)$


  #inline("Convert Base-R to Decimal")
  - $(1101.101)_2 = 2^3 + 2^2 + 2^(0) + 2^(-1) + 2^(-3) = 13.625_10$
  - $(341.24)_5 = 3 times 5^2 + 4 times 5^1 + 1 times 5^0 + 2 times 5^(-1) + 4 times 5^(-2) = 96.56_10$

  #inline("Convert Decimal to Binary / Base-R")
  - For *Whole Number*, press calculator if you can. Or compute manually through _division-by-base_ method (when dealing with non-conventional bases).
    #align(center)[#table(
        columns: 2,
        [2], [42],
        [2], [21	rem *0* $arrow.l.double "LSB"$],
        [2], [10	rem *1*],
        [2], [5	rem *0* ],
        [2], [2	rem *1* ],
        [2], [1	rem *0* ],
        [0], [rem *1* $arrow.l.double "MSB"$],
      )
      $(42)_10 = (101010)_2$
    ]


  - For *Fractions*, use _multiplication-by-base_ method.
    #align(center)[ #table(
        columns: 2,
        [], [Carry],
        [$0.3125 times 2 = 0.625$], [*0* $arrow.l.double "MSB"$],
        [$0.625 times 2 = 1.25$], [*1*],
        [$0.25 times 2 = 0.5$], [*0*],
        [$0.5 times 2 = 1$], [*1* $arrow.l.double "LSB"$],
      )
      $(0.3125)_10 = (0.0101)_2$
    ]
  - When we cannot fully represent a number in the desired number of fractional bits, we should calculate up to the number of bits we want + 1, then check the LSB to determine if we should round up
  - We may *convert fraction using calculator* by multiplying by a power of smallest exponent, convert, then divide back.

    $(0.0101)_2 = (101)_2 * 2^(-4) = (5)_10 / 2^4 = 0.3125$


  #inline("Binary to Octal / Hexadecimal Conversion")
  - Binary to Octal: Partition in group of 3. Vice-versa.

    $(10 space 111 space 011 space 001 . 101 space 110)_2 = (2731.56)_8$
  - Binary to Hexadecimal: Partition in group of 4. Vice-versa.
    $(101 space 1101 space 1001 . 1011 space 1000)_2 = ("5D9.B8")_16$
  #inline("Base R1 to Base R2 Conversion")
  - In general, for a given base $R$ we can convert to base $R^n$ quickly with the shortcut of grouping into groups of size $n$. For example to convert from base 3 to base 9, we can group the digits into groups of 2 since $9=3^2$
  - For other possible base conversion, we may first convert to decimal, before converting to targeted base.
])
== ASCII
#concept-block(body: [
  - ASCII encodes characters using *7 information bits*; some transports add an optional parity bit as the MSB, but it is not part of the code itself.
    - Even Parity: `number_of_1s == even ? 0 : 1`
    - Odd Parity: `number_of_1s == odd ? 0 : 1`
  - Convert between lower and uppercase thru addition/subtraction of 32.
  ```c
  char uppercase = 'A';
  char lowercase = uppercase + 32;  // Add 32 to convert upper to lower
  ```

  #inline("Even and Odd Bit Parity Scheme")
  - Append 1 parity bit so that total 1-bits (data + parity) is even (even parity) or odd (odd parity).
  - Let `p_even = d0 ^ d1 ^ ... ^ d(n-1)` over the data bits; then `p_odd = !p_even & 1`.
    - Even parity uses `p = p_even`; odd parity uses `p = p_odd`.
  - Example (7-bit data): `1010001` has three 1s →
    - Even parity `p = 1` to make 4 ones total.
    - Odd parity `p = 0` to keep 3 ones total.
  - Placement (MSB/LSB) is protocol-dependent; classic ASCII links often used MSB as parity.
  - Detects any single-bit error by recomputing parity; does not correct errors and can miss some multi-bit flips.
])
== Negative Numbers
#concept-block(body: [

  There are 4 common ways to represent negative numbers:

  1. *Sign-and-Magnitude*

    - *MSB Sign bit*, `0 = Positive, 1 = Negative`.
    - Fixed number of bits as *magnitude*.
    - *Negate* by flipping sign bit.
    - *Range*: $[-(2^(n-1)-1), 2^(n-1)-1]$
    - *Problems*:
      - redundant prefix 0s for small number
      - distinguish between +0 and -0
      - inability to represent large number as limited by number of magnitude bits.
  2. *1s Complement*
    - Aka *Diminished Radix Complement*:
      - 1s complement is the diminished radix-2 complement:
        $(x)_(1s) = (2^n - 1) - x$
      - Or more formally, a diminished radix complement for radix/base = $b$ of $N$-bit whole number, $M$-bit fraction can be represented as:

        $-x = b^n-x-b^m$
    - *Negate* by:
      - Flipping all the bits
      - To find the decimal representation of negative number

        $-x = 2^n-x-1
        \ "e.g." -12 = 2^8-12-1 = 243 = (11110011)_2$
    - *Range*: $[-(2^(n-1)-1), 2^(n-1)-1]$
    - *Arithmetic*:
      - Bitwise addition. If there is a carry out of the MSB, wrap the carry around and add it to the LSB.
      - Example (8-bit):

        $7-3 = (00000111)_2 + (11111100)_2 = (00000011)_2$ with carry $1$
        End-around: $(00000011)_2 + 1 = (00000100)_2 = 4$

    - *Problems*:
      - distinguish between +0 and -0

  3. *2s Complement*
    - Aka *Radix Complement*:
      - 2s complement is the radix-2 complement:
        $(x)_(2s) = (2^n) - x$
      - Or more formally, a radix complement for radix/base = $b$ of $N$-bit can be represented as:

        $-x = b^n-x$
    - *Negate* by:
      - Flipping all the bits and +1.
      - Faster way: from right to left, copy all the bits until the first 1, copy over the 1, then from then on, flip the bits
      - To find the decimal representation of negative number

        $-x = 2^n-x \
        "e.g." -12 = 2^8-12 = 244 = (11110100)_2$
      - Faster way: The MSB will have weight of $-2^(n-1)$
    - *Range*: $[-2^(n-1), 2^(n-1)-1]$
    - *Arithmetic* is the same as 1s Complement, with the exception that we ignore any carry-out from the MSB

  4. *Excess*
    - Represent first $N$ as negatives in Excess-$N$ on $M$-bit.
    - Value $0$ is *encoded* by $0+N=C$, *decoded* by $C-N=0$
    - Easy comparison by looking at bit-values alone.
    - *Negate* by:
      1. In Excess-127 system, #underline[encode] word for (x = 5):

        $C = x + N = 5 + 127 = 132$
      2. #underline[Negated] code:

        $2N - C = 2(127) - 132 = 122$
      3. #underline[Decode] 122:

        $x = C - N = 122 - 127 = -5 = -x$
    - *Range*:
      - For even distribution between +ve and -ve numbers, we compute $N=2^(n-1)$
        - range= $[-2^(n-1), 2^(n-1)-1]$
      - For non-even distribution, range = $[-N, 2^n-N-1]$
    - *Arithmetic*:
      - Bit-wise addition no longer works.
      - Decode to base number, perform arithmetic, convert back.


  #inline("Negative Numbers Shenanigans")
  - Overflow can occur when adding two positive numbers or two negative numbers
    - Positive + Positive = Negative
    - Negative + Negative = Positive
  - This is due to the result being unable to be represented in the given bit width
  - Overflow can be detected by checking if the sign bit is consistent with the operators. Note that overflow cannot happen when adding two numbers of opposite sign.
  - In general, for a 32-bit signed integer represented via two's complement, overflow happens once we exceed the max or min range $[-2^(31), 2^(31) - 1]$, in which case we expect the value to wrap around

  // TODO: Maybe add some trick on how to flip quickly or other BS

])

== Real Numbers
#concept-block(body: [
  There are 2 ways to represent real number:

  1. *Fixed Point Representation*
    - *Fixed number of bits* for _whole_ number and _fraction_.
    - Extension of 1s Complement or 2s Complement.
      - *Negate* in 2s Complement by inverting all bits and adding one unit in the last place (value $2^(-"#fraction bits")$)
    - *Approximation* of real number as could not represent number smaller than $2^(-"#fraction bits")$
    - *Round up the fraction bit* if fraction overflow occurs.
      - E.g. Given 3-bit fraction: $(0.1001)_2 => (0.101)_2$

  2. *Floating Point Representation*
    - IEEE 754 floating-point representation
      - 1-Bit *Sign bit* (`is_positive ? 0 : 1`)
      - 8-Bit *Exponent* (Excess-127)
        $
          "bin"(("exponent"+127)_10)_2
        $
      - 23-Bit *Mantissa* (normalized with implicit leading bit 1)

      $
        "sign" space 1."mantissa" times "base"^"exponent" \
        (6.5)_10 = (110.1)_2 = (1.101) times 2^2; \
        "sign"=0, space "exponent"=(2)_10,space "mantissa"=(101)_2
      $


    - In 32-bit Floating Point (Single-precision)

      #table(
        columns: 3,
        [(1-bit) Sign], [(8-bit) Exponent\ \<excess-127>], [(23-bit) Mantissa],
      )


    - In 64-bit Floating Point (Double-precision)

      #table(
        columns: 3,
        [(1-bit) Sign],
        [(11-bit) Exponent\ \<excess-1023>],
        [(52-bit) Mantissa],
      )


  #inline("Real Numbers Shenanigans")
  - Associativity is not preserved in FP arithmetic as rounding occurs.

    `(A op B) op C = round(round(A op B) op C)`
  - Ranges of Numbers in FP
  #figure(
    image("Number System/fp-range.png", width: 100%),
    caption: [
      FP Range
    ],
  )
])

= Instruction Set Architecture (ISA)
#concept-block(body: [
  - ISA defines the contract between Hardware and the instructions.
  - Same instructions should result in same behavior, regardless of hardware implementation.

  #inline("CISC vs RISC")
  There are two general types of ISA design.
  - *Complex Instruction Set Computer* (CISC)
    - Smaller program size
    - Complex processor implementation, difficult hardware optimization
    - E.g. x86-32, IA32
  - *Reduced Instruction Set Computer* (RISC)
    - Small and simple instruction set, easier to optimise for hardware
    - Burden on software to compile efficiently
    - E.g. MIPS, ARM


  #inline("Data Storage")
  Some major storage architecture in processor includes:
  1. *Stack Architecture*
    - *Implicit* operands on top of the stack.
    - `Push A; Push B; Add; Pop C`
  2. *Accumulator Architecture*
    - *Implicit* operands as stored in the Accumulator (a special register)
    - `Load A; Add B; Store C`
    - E.g. IBM 701, DEC PDP-8
  3. *General-Purpose Register Architecture* (GPR)
    1. *Register-Memory* Architecture
      - *Explicit* Operand. *One operand* can be in *memory*.
      - E.g. Motorola 68000, Intel 80386
      - Typically found in *CISC*.
    2. *Register-Register* Architecture (Load/Store Architecture)
      - *Explicit* Operand. *All operand* must be in *register*.
      - `Load R1, A; Load R2, B; Add R3,R2,R1; Store R3, C;`
      - Typically found in *RISC*.
      - E.g. MIPS, DEC Alpha
  4. *Memory-Memory* Architecture
    - *Explicit* Operand. *All operand* in *memory*.
    - `Add C, A, B`
    - Typically found in *CISC*.
    - E.g. DEC VAX
  #figure(
    image("ISA/07_storage.png", width: 100%),
    caption: [
      Data Storage in Processor
    ],
  )
])

== Memory Addressing mode
#concept-block(body: [
  - Given $k$-bit address, the address space is $2^k$.

  - Each memory transfer consist of one word of $n$-bit.

  #figure(
    image("ISA/07_memory.png", width: 100%),
    caption: [
      Memory Bus
    ],
  )
  #inline("Endianness")

  - Determine relative ordering of bytes in multiple-byte word stored in memory.
  - Does not affect the absolute order of different words.
  - Does not affect relative order of bytes in a single address.
  #table(
    columns: 3,
    [], [Big-Endian], [Little-Endian],
    [Example],
    [`0x DE AD BE EF` is stored as
      #figure(
        image("ISA/07_bigend.png", width: 35%),
        caption: [Big Endian],
      )],
    [`0x DE AD BE EF` is stored as
      #figure(
        image("ISA/07_littleend.png", width: 35%),
        caption: [Little Endian],
      )],

    [Description],
    [MSB is stored in lowest address.],
    [LSB is stored in lowest address.],

    [E.g.],
    [IBM 360/370, Motorola 6800, MIPS, SPARC],
    [Intel 80x86, DEC VAX, DEC Alpha],
  )

  #inline("Addressing Mode")

  #table(
    columns: 3,

    [*Addressing Mode*], [*Example*], [*Meaning*],

    [Register], [`add $t0, $t1, $t2`], [$"$t0" <== "$t1" + "$t2"$],

    [Immediate], [`addi $t0, $t0, 3`], [$"$t0" <== "$t0" + 3$],

    [Base + Offset], [`lw $t0, 100($s1)`], [$"$t0" <== M[100 + "$s1"]$],

    [Register Indirect], [`lw $t0, ($s1)`], [$"$t0" <== M["$s1"]$],

    [Indexed], [`lw $t0, ($s1 + $t2)`], [$"$t0" <== M["$s1" + "$t2"]$],

    [Absolute], [`ADD R1, (1001)`], [$"R1" <== "R1" + M[1001]$],

    [Memory Indirect], [`ADD R1, @R3`], [$"R1" <== "R1" + M[M["R3"]]$],

    [Auto-Increment],
    [`ADD R1, (R2)+`],
    [$"R1" <== "R1" + M["R2"];\ "R2" <== "R2" + d$],

    [Auto-Decrement],
    [`ADD R1, -(R2)`],
    [$"R2" <== "R2" - d;\ "R1" <== "R1" + M["R2"]$],

    [Scaled],
    [`ADD R1, 100(R2)[R3]`],
    [$"R1" <== "R1" + M[100 + "R2" + "R3" times d]$],
  )
])
== Operations in ISA
#concept-block(body: [
  #figure(
    image("ISA/isa-instructions.png", width: 100%),
    caption: [
      Standard ISA Operations
    ],
  )
])
== Instruction Formats
#concept-block(body: [
  Two type of instruction formats:
  1. Variable-Length Instruction
    - Single instruction can have different size
    - Require multi-step fetch and decode
    - Allow for more flexible (but complex) compact instruction set.
  2. Fixed-Length Instruction
    - Every instruction have fixed size
    - Allow for easy fetch and decode
    - Simplify pipelining and parallelism

  #inline("Instruction Fields")
  - An instruction consist of:
    - `Opcode`: Unique code to specify desired operation
    - `Operands`: Zero or more additional information needed for the operation.
  - Typical type and size are as follows:
    - Characters: 8 bits. (1-byte)
    - Half-Word: 16 bits. (2-byte)
    - Word: 32 bits. (4-byte)
    - Single-Precision Floating Point: 1 word.
    - Double-Precision Floating Point: 2 words.
])
== Encoding of Instruction Set
#concept-block(body: [
  - To encode an instruction, we need to include an opcode, and zero or more operands.
  - Number of bits allocated to the opcode determines total number of instruction available in the ISA.
  - There are generally two different ways to store opcode:
    1. Fixed Length Opcode
      - Inefficient as lead to unused opcode.
      - Number of instructions = $2^("#opcode_bits") = 2^6$
      #table(
        columns: 4,
        [Types], [6 Bits], [5 Bits], [5 Bits],
        [A], [opcode], [Operand], [Operand],
        [B], [opcode], [Operand], [unused],
      )
    2. Expanding Opcode
      - Address the issue with Fixed Length Opcode by utilizing all the encoding spaces.
      #table(
        columns: 4,
        [Types], [6 Bits], [5 Bits], [5 Bits],
        [A], [opcode], [Operand], [Operand],
        [B], [opcode], [Operand], [opcode1],
      )

      - This, however, introduce ambiguity on how should we allocate opcode space in first 6-bit to Types A and Types B to result in different number of total instructions.

    #inline("Intuition")
    - To achieve *maximum* number of instructions, we need to minimize `opcode` in A, to get more encoding space in B, that can be multiplied with `opcode1`.
      - Type-A: `opcode=000000`
      - Type-B: `opcode=000001-111111 * opcode2=00000-11111`
        $\#"Instructions"= a+b=1+(2^6-1*2^5)=2017$
    - To achieve *minimum* number of instructions, we need to maximise `opcode` in A, and only allocate one `opcode` space for B.
      - Type-A: `opcode=000000-111110`
      - Type-B: `opcode=111111 * opcode2=00000-11111`
        $\#"Instructions"= a+b = (2^6-1)+2^5=95$

    #inline("Formula Approach")
    - Let $a$, $b$, $c$ be number of instructions for Type A (6-opcode), Type B (8-opcode), Type C (11-opcode).
    $
      a/2^6+b/2^8+c/2^11 = 1 \
      2^(11-6=5)a + 2^(11-8=3)b + c = 2^11 \
      2^5a + 2^3b + c = 2^11 \
    $
    - To obtain minimum number of instructions, we will maximise type with highest coefficient (i.e. a), and set the rest as 1 first.
      $
        2^5a+2^3(1)+1 =2^11 \
        a = 2039/2^5 approx 63.718 = 63 \
        2^5(63) + 2^3(b)+c = 2^11; 8b+c=32;\
        8(3)+(8) = 32; " min(b) while c > 1"\
        therefore a=63;b=3;c=8; \#"instructions"=63+3+8=74
      $

    - To obtain maximum number of instructions, we will maximise type with lowest coefficient (i.e. c), and set the rest as 1 first.
      $
        2^5(1) + 2^3(1) + c = 2^11 \
        c = 2^11-40 = 2008 \
        therefore a=1;b=1;c=2008; \#"instructions"=1+1+2008=2010
      $

])

= MIPS Instruction

#concept-block(body: [
  #inline("R-format")
  - Fields:
    #table(
      columns: 6,
      [opcode (6)], [rs (5)], [rt (5)], [rd (5)], [shamt (5)], [funct (6)],
    )
  - rs is set to 0 for `sll` and `srl` instructions
  - shamt is set to 0 for all non-shift instructions
  - `shamt` is 5 bits because MIPS shifts only use the lower 5 bits of the amount, so immediates (and `sllv`/`srlv`/`srav`) can shift 0–31 positions on a 32-bit word
  - All R-format instructions have an opcode of 0, R-type instructions distinguished by funct
  #inline("I-format")
  - Fields:
    #table(
      columns: 4,
      [opcode (6)], [rs (5)], [rt (5)], [immediate (16)],
    )
  - *Arithmetic I-Type* (e.g addi, slti): immediate represents 16-bit 2's complement
  - *Load/Store I-Type* (e.g lw, sw): immediate represents 16-bit 2's complement used as offset from base address `$rs`
  - *Logical I-Type* (e.g andi, ori): immediate represents 16-bit raw unsigned binary, zero-extended to 32 bits
  - *Branch Instructions* (e.g beq, bne): the immediate value represents the displacement relative to the PC
    - PC-relative addressing:
      - If taken: PC = PC + 4 + (immediate × 4).
      - If not taken: PC = PC + 4.
    - PC-relative addressing can branch $plus.minus 2^15$ words ( $plus.minus 2^17$ bytes) from the PC because the 16-bit immediate is sign-extended, shifted left by two, and added to `PC + 4`.
      - If the hardware did not perform that implicit shift, a raw 16-bit value would only give $plus.minus 2^(13)$ words because instructions are word-aligned.
      - In MIPS the shift always happens for you, so the assembler lets you write the offset in words.
    - Exam tip for encoding: for a branch at address `PC` targeting label at `Target`, the stored immediate is `imm = (Target - (PC + 4)) / 4` (expressed in 16-bit 2’s complement).
  #inline("J-format")
  - Fields
    #table(
      columns: 2,
      [opcode (6)], [address (26)],
    )
  - MIPS will take the 4 MSB from PC + 4, omit 2 LSB since instruction addresses are word aligned (a word is $2^2$ bytes)
  - Maximum Jump Range = current $2^28$ bytes = 256MB region
    - An address is outside of the region if the 4 MSB of the address do not match the MSB of PC + 4
  - To jump further, either use `jr` (jump to address stored in register), or do a `beq $0, $0, L` to jump to the region you want to jump to as intermediate
  - Exam tip for encoding: the 26-bit jump field stores bits [27:2] of the target address; the actual target is formed by concatenating the high 4 bits of `PC + 4`, the 26-bit field, and two 0 LSBs.
])



= MIPS Datapath
#concept-block(body: [
  The basic instruction cycle consists of the following five steps:


  1. Fetch
    - Get instruction from memory.
    - Address stored in the \$PC register (i.e., program counter).

  2. Decode & Operand Fetch
    - Find out the operation required.
    - Get the operand(s) needed for operation.

  3. ALU
    - Execute arithmetic and logical operations on ALU unit.

  4. Memory
    - Read/write from memory.

  5. Writeback (a.k.a. Result Write)
    - Store the result of the operation.


  #figure(image("MIPS/08_basic.png", width: 25%))


  #table(
    columns: 4,
    [Stage], [add \$3, \$1, \$2], [lw \$3, 20(\$1)], [beq \$1, \$2, label],

    [Fetch], [standard], [standard], [standard],

    [Decode], [standard], [standard], [standard],

    [Operand Fetch],
    [
      Read [\$1] as opr1

      Read [\$2] as opr2
    ],
    [
      Read [\$1] as opr1

      Use 20 as opr2
    ],
    [

      Read [\$1] as opr1

      Read [\$2] as opr2
    ],

    [Execute],
    [

      $"result" = "opr1" + "opr2"$
    ],
    [

      $"addr" = "opr1" + "opr2"$

      Use $"addr"$ to read memory
    ],
    [

      $"taken" = ("opr1" == "opr2")$

      $"target" = ("PC" + 4) + ("label" times 4)$
    ],

    [Writeback],
    [

      [\$3] = result
    ],
    [

      [\$3] = mem data
    ],
    [
      if ($"taken"$) then $"PC" = "target"$
    ],
  )
])

== Critical Path
#concept-block(body: [
  #inline("Calculating Critical Path")
  - Critical Path: path taken by slowest instruction through the datapath
  - The total delay of the critical path, which is the sum of the latencies of all the components along the path, determines the minimum clock period $T_c$, and hence the maximum clock frequency $1/T_c$
  #inline("Load Instruction Critical Path")
  - Load instructions are usually the critical path in a single-cycle design as it sequentially uses the five major hardware units and has to access memory twice (instruction + data) and write to register file within a single cycle
  Typical Critical Path:
  1. Instruction Fetch: PC -> Instruction Memory
  2. Register Read: -> Register File
  3. ALU Operation: -> ALU (address calculation)
  4. Memory Access: -> Data Memory (read data)
  5. Write Back: -> MUX (MemToReg) -> Register File (write data)
  #inline("Store Instruction Critical Path")
  - Store instructions are similar to load instructions but do not include the final write-back to the register, and thus are typically faster to execute
    Typical Critical Path:
  1. Instruction Fetch: PC -> Instruction Memory
  2. Register Read: -> Register File
  3. ALU Operation: -> ALU (address calculation)
  4. Memory Access: -> Data Memory (write data)
  #inline("R-type Instruction Critical Path")
  - R-type instructions do not access the data memory
  Typical Critical Path:
  1. Instruction Fetch: PC -> Instruction Memory
  2. Register Read: -> Register File -> MUX (ALUSrc)
  3. ALU Operation: -> ALU
  4. Write Back: -> MUX(MemToReg) -> Register File (write result)

  #inline("Branch Instruction Critical Path")
  - Branch instructions calculates a target address and updates the PC if the condition is met. It does not write to the register file or data memory
  Typical Critical Path:
  1. Instruction Fetch: PC -> Instruction Memory
  2. Register Read: -> Register File -> MUX (ALUSrc)
  3. ALU Operation: -> ALU (subtract register to check for zero)
  4. PC Update: -> AND Gate (Branch & isZero) -> MUX (PCSrc)
])


= MIPS Control Path
== MIPS Control Signals
#concept-block(body: [
  1. RegDst (MUX Before Register File):
    - Select between `rt` [0] and `rd`[1]. Only select rd in R-instructions.
  2. RegWrite (Register File):
    - Determine to write data in `WD` to `WR` [1]
  3. ALUSrc (MUX Before ALU):
    - Select between data from `[rt]`(R-instructions) [0] or arithmetic-signed-extended Immediate values (I-instructions) [1].
  4. ALUControl (ALU)
    - 4-bit control signal to determine what operation ALU should perform
  5. PCSrc (MUX for PC Counter)
    - Determine to increment `PC + 4` [0] or `PC + 4 + instructions * 4` [1] (Branch-Instructions) ⇒ If isZero (from ALU) is True
  6. MemWrite (Data Memory)
    - Asserted for store instructions to write data to memory (stores): [1]
  7. MemRead (Data Memory)
    - Asserted for load instructions to read data from memory (loads): [1]
  8. MemToReg (MUX after Data Memory)
    - Determine to parse ALU Result (R-Instructions) [0] or Memory Read (Read Instructions) result back to WD [1]
])

== ALU Control Signal
#concept-block(body: [
  - 4-Bit control signal to determine how ALU should act according to different function.

  #align(center)[
    #table(
      columns: 2,
      [ALUControl], [Function],
      [`0000`], [and],
      [`0001`], [or],
      [`0010`], [add],
      [`0110`], [sub],
      [`0111`], [slt],
      [`1100`], [nor],
    )
  ]

  #inline("1-Bit ALU")
  - An ALU is a stack of multiple 1-Bit ALU.

  #figure(image("MIPS/1-bit-alu.png", width: 95%))

  #inline("Multilevel Decoding")

  - Intuitively, `ALUControl (4-bit)` depends on both `opcode` and `funct` field. But instead of generating all 4-bits directly, MIPS takes a multilevel decoding approach.
    - `Control(opcode) = ALUop (2-bit)`
    - `ALUControlBlock(ALUop) = ALUControl (4-bit)`
  #figure(image("MIPS/08_ALUop.png", width: 95%))

  #figure(image("MIPS/08_ALUcontrol.png", width: 95%))
  ```
  ALUcontrol3 = 0
  ALUcontrol2 = (F1 . ALUop1) + (ALUop0)
  ALUcontrol1 = !ALUop1 + !F2
  ALUcontrol0 = (F0 + F3) . ALUop1
  ```

  #align(center)[
    #table(
      columns: 4,
      [], [ALUop], [Funct], [ALUcontrol],
      [lw], [0 0], [X X X X X X], [0 0 1 0],
      [sw], [0 0], [X X X X X X], [0 0 1 0],
      [beq], [0 1], [X X X X X X], [0 1 1 0],
      [add], [1 0], [1 0 0 0 0 0], [0 0 1 0],
      [sub], [1 0], [1 0 0 0 1 0], [0 1 1 0],
      [and], [1 0], [1 0 0 1 0 0], [0 0 0 0],
      [or], [1 0], [1 0 0 1 0 1], [0 0 0 1],
      [slt], [1 0], [1 0 1 0 1 0], [0 1 1 1],
    )
  ]
])

== Control Signal In a Nutshell

#concept-block(body: [
  Control Unit turn opcode to control signals as shown in the following table.
  #table(
    columns: 3,
    table.header([Instruction], [opcode], [Ctrl]),

    [R-Format], [`0 0 0 0 0 0`], [`1 0 0 1 0 0 0 1 0`],
    [lw], [`1 0 0 0 1 1`], [`0 1 1 1 1 0 0 0 0`],
    [sw], [`1 0 1 0 1 1`], [`X 1 X 0 0 1 0 0 0`],
    [beq], [`0 0 0 1 0 0`], [`X 0 X 0 0 0 1 0 1`],
  )
  #table(
    columns: 3,
    table.header([Ctrl], [Signal], [Selector]),

    [0], [RegDst], [R-Format],
    [1], [ALUSrc], [lw OR sw],
    [2], [MemToReg], [lw],
    [3], [RegWrite], [R-Format OR lw],
    [4], [MemRead], [lw],
    [5], [MemWrite], [sw],
    [6], [Branch], [beq],
    [7], [ALUop1], [R-Format],
    [8], [ALUop0], [beq],
  )

  See reference for more comprehensive table.
  #figure(
    image("MIPS/08_Control.png", width: 95%),
    caption: [AND gate with collapse NOT gate.\ If `000000`, R-Format = 1, If `100011, lw=1,...`],
  )

  #inline("Exam Tip: Reasoning About Datapath Faults")
  - When a control signal is “stuck” high or low, compare which instruction classes misbehave by reading this table:
    - Example: if R-format and `sw` behave correctly but `addi`/`lw` write the wrong registers, suspect `RegDst` stuck at 1 – the datapath is always selecting `rd` instead of `rt`, which breaks I-type writes but not R-type.
  - More generally, group instructions by which control bits they share; if “all instructions that need X fail, but those that don’t use X work”, X is a good candidate for the faulty signal.
])

== Multicycle & Pipelining

#concept-block(body: [
  #inline("Single-Cycle")
  In single-cycle implementation, everything stage happens within a clock period. Which means clock period depends on the maximum time of instruction completion.
  #figure(image("MIPS/08_clock_period.png", width: 95%))


  #inline("Multi-cycle Implementation")
  - A multi-cycle implementation breaks up instruction execution into steps (Instruction Fetch, Instruction Decode & Operand Fetch, Execute, Memory and Writeback)
  - Typically we just break up into 1 step for each stage, so a instruction can take up to 5 execution steps, where each step is one clock cycle
  - Advantage: each clock cycle is smaller since it can just run at the speed of the slowest stage which is still better than the sum of all the stages, hence for instructions that don't actually require all of the stages (e.g no memory access or no-write back), the instruction will execute faster.
  - If an instruction doesn't need every stage, multi-cycle is faster since we avoid redundant time waiting for irrelevant stages to execute. A single cycle implementation must support the slowest instruction, leading to a long clock cycle for all instructions
  - If an instruction takes every stage:
    - and each stage takes same amount of time to complete: then execution time is same as single-cycle
    - but if some stages take longer, the clock cycle is set by the slowest stage, so the instruction could actually be slower than single-cycle implementation
  - Thus, to determine the clock speed:
    - Single Cycle: find latency of the slowest instruction
    - Multi Cycle: find latency of the slowest stage
    - Clock Speed = 1 / Latency
])


// Part 2 lets go

= Boolean Algebra
#concept-block(body: [
  - *Digital circuits* has two states: High/true/1/asserted, Low/false/0/deasserted
  - *Combinational Circuit*: No memory, output depends on input
  - *Sequential Circuit*: Memory, output depends on input and current state
  #inline("Precedence of Operators")
  - Precedence from highest to lowest
    - Parenthesis to overwrite precedence (e.g. (P+Q)'.R)
    - Not (')
    - And (.)
    - OR (+)
  #inline("Laws of Boolean Algebra")
  #table(
    columns: 3,
    [Law], [SOP], [POS],
    [Identity Laws], [A+0 = 0+A = A], [A.1 = 1.A = A],
    [Inverse/Complement Laws], [A+A' = A'+A = 1], [A.A' = A'.A = 0],
    [Commutative Laws], [A+B = B+A], [A.B = B.A],
    [Associative Laws], [A+(B+C) = (A+B)+C], [A.(B.C) = (A.B).C],
    [Distributive Laws], [A.(B+C) = A.B + A.C], [A+(B.C) = (A+B).(A+C)],
    [Idempotency], [X+X = X], [X.X = X],
    [One Element/Zero Element], [X+1=1+X=1], [X.0=0.X=0],
    [Involution], [(X')' = X], [(X')' = X],
    [Absorption 1], [X+X.Y = X], [X.(X+Y) = X],
    [Absorption 2], [X + X'.Y = X+Y], [X.(X'+Y) = X.Y],
    [DeMorgans'], [(X+Y)' = X'.Y'], [(X.Y)' = X'+Y'],
    [Consensus],
    [X.Y + X'Z + Y.Z = X.Y+ X'.Z],
    [(X+Y).(X'+Z).(Y+Z) = (X+Y).(X'+Z)],
  )
])
== Standard Forms
#concept-block(body: [
  - *Sum-of-Products (SOP)*
    - Product Term or Sum (OR) of several product terms
    - A + B'.C + A.C' + C.D

  - *Product-of-Sums (POS)*
    - Sum Term or Product (.) of several sum terms
    - (A+B+C).D'.(B'+D+E')

  - *Minterm*
    - Product term that consist of n literal terms
    - Result from minterm is 1
    #image("Boolean Algebra/som.png")

  - *Maxterm*
    - Sum term that consist of n literal terms
    - Result from maxterm is 0
    #image("Boolean Algebra/pom.png")
    #table(
      columns: 6,
      [x], [y], [MinT], [Term], [MaxT], [Term],
      [0], [0], [m0], [X'.Y'], [M0], [X.Y],
      [0], [1], [m1], [X'.Y], [M1], [X.Y'],
      [1], [0], [m2], [X.Y'], [M2], [X'.Y],
      [1], [1], [m3], [X.Y], [M3], [X'.Y'],
    )

  #inline("Conversion of Standard Forms")
  To turn a SOP expression to POS expression, Make use of the DeMorgans' Law and Involution Law.
  $F(x,y,z)=sum m(1,4,5,6)= product M (0,2,3) \
  F'= m 0 + m 2+ m 3 \
  F = m 0' . m 2' . m 3'
  = M 0 . M 2 . M 3$
  #image("Boolean Algebra/conv.png")
])


// Should also cover: XOR, XNOR, NAND, NOR and how to identify them
= Logic Circuits
#concept-block(body: [
  #inline("AND")
  #image("Logic Circuits/gate-and.png")
  #inline("OR")
  #image("Logic Circuits/gate-or.png")
  #inline("NOT")
  #image("Logic Circuits/gate-not.png")
  #inline("NAND")
  #image("Logic Circuits/gate-nand.png")
  #inline("NOR")
  #image("Logic Circuits/gate-nor.png")
  #inline("XOR")
  #image("Logic Circuits/gate-xor.png")
  $a xor b = a'.b + a.b'$
  #inline("XNOR")
  #image("Logic Circuits/gate-xnor.png")
  $a xor' b = a.b + a'.b'$
])
== NAND / NOR is all you need
#concept-block(body: [
  Rumours has it that WWF wrote a 6 page pdf on how NAND gate is a universal logic gate because he was bored from grading midterm. Below is everything he has to say, that is relevant to a 2100 kid.
  #image("Logic Circuits/nand-universal.png")
  $
    F = A.B + C'.D + E \
    = (A.B + C'.D + E)'' \
    = ((A.B)' . (C'.D)' . E')' "2-layer nand gate"
  $

])

= Simplification

#concept-block(body: [
  The aim of simplification is to minimize
  1. number of literals (prioritized over number of terms)
  2. number of terms

  Methods to simplify:
  1. Boolean Algebra
  2. Karnaugh Maps
  3. Quine-McCluskey Technique
])

== Gray Codes

#concept-block(body: [
  #inline("Gray Codes")
  - An n-bit Gray code is any sequence of n-bit binary values such that there is only a *single bit change* from one code value to the next
  - It will be a circular sequence that eventually loops back to the first value
  - To construct a Gray code of $k$ bits, we can follow the strategy below:
    1. Start with an all 0 Gray code (e.g 000)
    2. Flip the lowest bit to get the next Gray code (e.g 000 -> 001)
    3. Flip the left bit of the rightmost 1 to get the next Gray code (e.g 001 -> 011)

  #inline("Standard 4-bit Gray Code Sequence")
  #align(center)[
    #table(
      columns: 6,
      [Decimal], [Binary], [Gray Code], [Decimal], [Binary], [Gray Code],
      [0], [0000], [0000], [8], [1000], [1100],
      [1], [0001], [0001], [9], [1001], [1101],
      [2], [0010], [0011], [10], [1010], [1111],
      [3], [0011], [0010], [11], [1011], [1110],
      [4], [0100], [0110], [12], [1100], [1010],
      [5], [0101], [0111], [13], [1101], [1011],
      [6], [0110], [0101], [14], [1110], [1001],
      [7], [0111], [0100], [15], [1111], [1000],
    )
  ]

  #inline("Obtaining Gray Code Sequence Through Mirroring")
  The $k$-bits Gray code can be quickly obtained by mirroring the $k-1$-bits Gray code and adding new bits, as shown in the figure below:

  #image("Logic Circuits/gray-code-mirroring.png")

  #inline("Binary to Gray Conversion")
  To convert a binary value to its corresponding standard Gray code value, we follow this algorithm:
  1. Retain the MSB
  2. From left to right, add each adjacent pair of binary code bits to get the next Gray code bit, discarding the carry.

  Observe that this is equivalent to a XOR operation of each bit with the bit to it's right, hence, we can represent the algorithm mathematically as:

  $G(n) = n xor floor(n/2)$

  // TODO: include link to how gray code is obtained by XOR operation which an half adder implements (see tutorial)

  ```c
  int to_gray_code(int n) {
    return n ^ (n >> 1); // n xor floor(n / 2)
  }
  ```

  #inline("Gray to Binary Conversion")
  The algorithm to convert a standard Gray code value to its corresponding binary value is as follows:
  1. Retain the MSB
  2. From left to right, add each binary code bit generated to the Gray code bit in the next position, discarding the carry

  In general, the $k-i$th bit of the original value can be obtained as follows:

  $n_k = g_k$

  $n_(k-i) = xor.big^(i)_(j=0) g_(k-j)$

  ```c
  int gray_code_to_original_number(int g) {
    int n = 0;
    while (g) {
      n ^= g;
      g >>= 1;
    }
    return n;
  }
  ```

])


== Karnaugh Maps
#concept-block(
  body: [
    #inline("Karnaugh Maps")
    - A K-map is an abstract Venn diagram, organized as a matrix of cells where:
      1. Each cell represents a minterm; and
      2. Adjacent cells differ by just one literal
    - The second property allows the unifying theorem $a + a' = 1$ to be applied
    - In general, an n-variable K-map contains $2^n$ cells, and each cell has $n$ neighbors (including wrap-around neighbors)
    - Columns/rows must follow Gray code
    - There are two main ways to label a K-map:
      1. By variables with implied complements
      2. By 0/1 headers per variable group, using a Gray code

      #inline("Don't Care Conditions")
      - In some cases, the output of a function is not specified for certain input combinations.
      - This sometimes happens because such inputs are invalid or under the assumption that such inputs will never be encountered
      - In such cases, we use the don't care value, usually denoted by $X$ or $d$ in the output
      - In a K-map, we can choose them to act as either 0 or 1 values
      #inline("Reduction Strategy")
      1. Fill the K-maps with 1s from the given function
      2. Form valid groups of adjacent 1s:
        - Group sizes must be in powers of two (e.g 1, 2, 4, 8) and be rectangular (the corners of a K-map do count as a rectangle)
        - Groups may wrap around and may overlap
        - Larger groups yield simpler product terms with fewer literals
        - Include don't care terms if it makes the group larger, but *every* group must contain at least one real 1 (do not form groups of only X’s).

      3. Derive the simplified SOP:
        - Each group yields one product terms
        - Aim for the fewest and largest groups to minimize both the number of terms and the number of literals per term

      - In general,
        - Larger groups = fewer literals in the resulting product term
        - Fewer groups = fewer product terms in simplified SOP expression
        - Always remember that wrap-around exists

      #inline("Prime Implicants and Essential Prime Implicants")
      - Implicant: any product term that covers one or more function minterms
      - Prime Implicant: a product term from the largest possible valid group of adjacent 1s; cannot be expanded further
      - Essential Prime Implicant: a PI that covers at least one minterm not covered by any other PI (i.e uniquely covers some 1s)
      - Strategy to identify PIs and EPIs:
        1. Identify all PIs, go systematically by finding all the largest groups before finding smaller groups
        2. Select all EPIs first (always required) – these *must* be in any minimal SOP
        3. If any 1s remain uncovered, add the minimum number of additional PIs to cover them
      #inline("4-Step Exam Algorithm")
      - When a question asks for “number of PIs/EPIs” or a minimal SOP:
        1. Plot the map with all 1s and don’t-cares (X).
        2. Circle every *maximal* valid group (powers of 2, rectangular, may wrap) that contains at least one 1 → these groups are the PIs; counting them gives the total number of PIs.
        3. For each 1-cell, check which PIs cover it; if exactly one PI covers that 1, that PI is essential (EPI). Mark EPIs; counting them gives the total number of EPIs.
        4. Form the minimal SOP by taking all EPIs, then adding as few remaining PIs as needed to cover any uncovered 1s.
      #inline("Obtaining Product of Sum Terms")
      - To get a product of sum expression from a K-map, do the following
      - Given the truth table of the expression $F$, fill the K-map with the complemented values $F'$
      - Don't care values remain the same, so use them along with the K-map to get the sum of products of $F'$
      - Then, take the complement of the sum of products of $F'$ to get the minimal product of sums of $F$
  ],
)



= Combinational Circuits
#concept-block(body: [
  - In a combinational circuit, each output of the circuit depends entirely on the present input values.

  #inline("Analysis of Circuits")
  To analyze a combinational circuit, we follow this process:
  1. Label the inputs and outputs
  2. Obtain the functions of the intermediate points and the outputs
  3. Draw the truth table
  4. Deduce the functionality of the circuit

  #inline("Gate Level Design")
  Gate-level design is used to build small scale circuits. The process is as follows:
  1. State the problem by providing the specification of the desired circuit
  2. Determine and label the inputs and outputs of the circuit
  3. Fill in the truth table and obtained the Boolean function for each of its outputs. This may involve using K-maps to obtain simplified SOP expressions
  4. From the results in step 3, draw the logic diagram of the circuit
  #inline("Block Level Design")
  For more complex circuits, we may instead use a block-level design method. In general, the strategy depends on which circuit blocks are available to use, but general tips are:
  1. Based on the function/specification, it may be possible to represent the function as an algorithm or formula
  2. We can draw the truth table, and determine if there are any common patterns that can be exploited
  3. Try to break down the problem into smaller sub-problems, then see if these sub-problems can be solved using the available blocks

  #inline("Enable")
  - One-Enable: circuit only activated when $E = 1$
  - Zero-Enable: circuit only activated when $E = 0$

  #inline("Circuits with Negated Outputs")
  - Active-high: logic 0 represents low voltage, logic 1 represents high voltage
  - Active-low: logic 1 represents low voltage, logic 0 represents high voltage
  - Active low signals have labels written in complemented form (e.g E') or is distinguished by a bubble'
  - AND gate in negative (active-low) logic is equivalent to an OR gate in positive logic
])
== SSI Components
#concept-block(body: [
  #inline("Half Adder")
  #image("SSI Components/half-adder.png")
  - Function: add two 1-bit inputs $X, Y$
  - Outputs:
    - $S = X xor Y$
    - $C = X dot Y$
  - Observe that if XOR gate or AND gate is unavailable, we can use the half-adder to implement the same functionality
  #inline("Full Adder")
  #image("SSI Components/full-adder.png")
  #image("SSI Components/full-adder-circuit.png")
  - Function: add three 1-bit inputs $X, Y, Z$ (where $Z$ represents carry-in)
  - Outputs:
    - $S = X xor Y xor Z$
    - $C = X dot Y + X dot Z + Y dot Z = X dot Y + Z dot (X xor Y)$
  #image("SSI Components/full-adder-from-half.png")
  - Observe that we can implement a full-adder by combining two half-adders and an additional OR gate for the carry out

  #inline("4-bit Parallel Adder")
  #image("SSI Components/4-bit parallel-adder circuit.png")

  - Circuit Delay: for an $n$-bit parallel adder where the gate delay is $T$, the delay for the $i$th bit is as follows:
    - Sum, $S_i = (2 i + 2) times T$
    - Carry: $C_(i + 1) = (2i + 3) times T$
  - Drawback: due to propagation delay of the carry bit, the cumulative delay for the adder is high as the number of bits increases
  #inline("BCD to Excess 3 Converter")
  - BCD-to-Excess-3 converter can be implemented by a 4-bit parallel adder, using the equation: $"Excess-3 Code Value = BCD code value +" (0011)_2$
  #inline("16-bit Parallel Adder")
  - A 16-bit parallel adder (an adder that adds two 16-bit numbers) can be created by cascading four 4-bit parallel adders to implement the long addition algorithm
  - We simply connect the carry of the sum of the previous 4 bits to each successive 4-bit parallel adder
  - Since each 4-bit adder has 4 full adders, there are 16 full adders used in the design
  #inline("6 Person Voting Counter")
  #image("SSI Components/6 person voting system.png")
  #inline("Magnitude Comparator")
  #image("SSI Components/magnitude comparator.png")
  #image("SSI Components/magnitude-comparator-circuit.png")
  - When we compare two binary numbers, we start from the MSB and compare bits pair-wise
  - We can observe that for two bits $A_i$ and $B_i$, applying $x = A_i dot.o B = A_i dot B_i + A_i ' dot B_i '$:
    - When $A_i = B_i, x_i = 1$
    - When $A_i < B_i, A_i ' dot B_i = 1$
    - When $A_i > B_i, A_i dot B_i ' = 1$
  #inline("4-bit Adder-cum-Subtractor") // TODO: move to appendix
  #image("SSI Components/4-bit-adder-subtractor.png")
  - Recall that subtraction can be substituted with 2's complement and addition: $X - Y = X + (-Y) = X + ("1's Complement of Y" + 1)$
  - So, the carry in can be used to implement the $+1$ required to turn 1's complement into 2's complement. We can link the carry-in signal to an XOR gate to each bit of $Y$, since $Y_i xor 1 = Y_i '$ and $Y_i xor 0 = Y_i$, such that we only implement the NOT operation when the signal is 1
  #inline("BCD Adder") // TODO: move to appendix
  #image("SSI Components/4-bit BCD adder.png")
  - To add two BCD numbers, recall that BCD numbers are basically decimal numbers, but each digit is represented in binary format
  - So, suppose we want to add two 4-bit BCD numbers (recall a BCD number will range from 0 to 9), if the sum of the two number is less than 10, we can just use a 4 bit parallel-adder
  - But if it is 10 or greater, by observing the truth table, we note that we need to add 0110 (6 in decimal) to the BCD sum and for the carry, the adjustment is $C = K + Z_3 dot Z_2 + Z_3 dot Z_1$
  // #inline("Look-Ahead Carry Adder") // TODO: move to appendix
  // - One flaw of a 4-bit parallel adder is the large circuit delay, since we have to wait for the carry-in of the previous full-adder to be stable.

])

== Circuit Delays
#concept-block(body: [
  #inline("Gate Propagation Delay Model")
  #image("SSI Components/propagation delays.png")
  - Each logic gate experiences some small delay in propagating signals forward, known as *gate delay* or *propagation delay*
  - Three propagation delay times are associated with a logic gate:
  1. $t_("PHL")$: output changing from the high to low level
  2. $t_("PLH")$: output changing from the low to high level
  3. $t_("PD") = (t_("PHL") + t_("PLH"))/2$: average propagation delay
  - Circuit delay: longest time it takes for input signals to propagate to the outputs, and thus the earliest time for output signals to stabilize, assuming input signals are available at time 0
  - In general, given an $n$-input logic gate with delay $T$ and the the inputs of the gates are stable at times $t_1, t_2, dots, t_n$, then the circuit delay is: $max(t_1, t_2, dots, t_n) + T$
])

= MSI Components
#concept-block(body: [
  - Integrated Circuits (IC/Chip/Microchip): set of
  electronic circuits on one small flat piece (or ‘chip’) of semiconductor material.
  - Scale of Integration: number of components fitted into a standard size IC
  #table(
    columns: 5,
    [Name], [Signification], [Year], [\#transistors], [\# logic gates],
    [SSI], [Small-scale integration], [1964], [1-10], [1-12],
    [MSI], [Medium-scale integration], [1968], [10-500], [13-99],
    [LSI], [Large-scale integration], [1971], [500-20k], [100-9999],
    [VLSI], [Very large-scale integration], [1980], [20k-1m], [10k-99999],
    [ULSI], [Ultra large-scale integration], [1984], [>1m], [>100k],
  )
])

== Decoder
#concept-block(body: [
  - Convert binary information from $n$ input to $2^n$ output
  - n-to-m-line decoder, n:m, nxm ($m <= 2^n$)
  - Used to generated $2^n$ minterms of n input variable

  #inline("2x4 Decoder")
  - Truth-table for 2x4 Decoder(X,Y) = F0,F1,F2,F3:
  #align(center)[
    #table(
      columns: 7,
      [X], [Y], [F0], [F1], [F2], [F3], [SOP],
      [0], [0], [1], [0], [0], [0], [m0 = X'.Y'],
      [0], [1], [0], [1], [0], [0], [m1 = X'.Y],
      [1], [0], [0], [0], [1], [0], [m2 = X.Y'],
      [1], [1], [0], [0], [0], [1], [m3 = X.Y],
    )
  ]
  - Circuit Diagram for 2x4 Decoder(X,Y) = F0,F1,F2,F3
  #figure(image("MSI-Components/decoder-2x4.png", width: 60%))

  #inline("3x8 Decoder")
  - We may implement a 3x8 Decoder with a new chip that has 3-input lines and 8-output lines.
  #figure(image("MSI-Components/decoder-3x8.png", width: 100%))

  - Alternatively, we may also implement a 3x8 Decoder using two, 2x4 Decoder with an Enabler control signal.

    - Truth-table for 2x4 Decoder with Enabler(E,X,Y) = F0,F1,F2,F3:
    #align(center)[
      #table(
        columns: 8,
        [E], [X], [Y], [F0], [F1], [F2], [F3], [SOP],
        [1], [0], [0], [1], [0], [0], [0], [m0 = E.X'.Y'],
        [1], [0], [1], [0], [1], [0], [0], [m1 = E.X'.Y],
        [1], [1], [0], [0], [0], [1], [0], [m2 = E.X.Y'],
        [1], [1], [1], [0], [0], [0], [1], [m3 = E.X.Y],
        [0], [X], [X], [0], [0], [0], [0], [E],
      )
    ]
    #figure(image("MSI-Components/decoder-3x8-enabler.png", width: 70%))
  #inline("4x16 Decoder")
  #figure(image("MSI-Components/decoder-4x16-enabled.png", width: 70%))

  #inline("Decoder with Enabler")
  - Enabler is a control signal that activates/deactivates a Decoder.
    - One-Enabled (E): Enable decoder when E=1
    - Zero-Enabled (E'): Enable decoder when E=0
  - With enabler, you may construct larger decoders from couple of smaller ones (See 3x8 decoder above for inspiration).
  - Note the Enable signal effectively acts as an AND operation, allowing us to take the product of the enable signal with the output of the decoder, which may be useful for implementing functions.

  #inline("Decoder for Sum-of-Minterms")
  - One effective use for Decoder is to represent any sum-of-minterm truth table.
  - Take Full-adder example below for instance, where:
    - S(x,y,z) = $sum m (1,2,4,7)$
    - C(x,y,z)) = $sum m (3,5,6,7)$
    - Instead of implementing using traditional XOR and AND gates, we may implement them using just one 3x8 Decoder
      #figure(image(
        "MSI-Components/full-adder-with-decoder-3x8.png",
        width: 100%,
      ))

  #inline("Standard MSI Decoder")
  - To make their life simpler and yours harder, a decoder may have:
    - Zero-enabled: 0=enable
    - Negated-outputs: F(0,1)=0111
  - 74138 (3-to-8 decoder) is a standard chip with One-and-Zero enabled, and Negated outputs.
    #figure(image("MSI-Components/74138-1.png", width: 100%))
    #figure(image("MSI-Components/74138-2.png", width: 100%))

    - When 74138 is not activated, all outputs are 1.
    - To enable 74138, you need G1=H, G2a'+G2b'=0

  #inline("Polymorphism of a Decoder")
  The following table shows different ways to represent function
  $F(Q,X,P) = sum m (0,1,4,6,7) = product M (2,3,5)$
  #table(
    columns: 4,
    [Gate], [Output], [SOP/POS], [Circuit Diagram],
    [OR],
    [Active-high (1)],
    [m0+m1+m4\
      +m6+m7],
    [#figure(image("MSI-Components/or-decoder.png", width: 100%))],

    [NOR],
    [Active-high (1)],
    [(m2+m3+m5)'\ = [M2.M3.M5]],
    [#figure(image("MSI-Components/nor-decoder.png", width: 100%))],

    [AND],
    [Active-low (0)],
    [m2'.m3'.m5'],
    [#figure(image("MSI-Components/and-decoder.png", width: 100%))],

    [NAND],
    [Active-low (0)],
    [(m0'.m1'.m4'\
      .m6'.m7')'],
    [#figure(image("MSI-Components/nand-decoder.png", width: 100%))],
  )

  // TODO: move to appendix
  #inline("Decoder Expansion")
  - To build a $N$ to $2^N$ decoder using only $K$ to $2^K$ decoders, (assuming $N$ is a multiple of $K$), the total number of decoders required = $(2^N - 1)/(2^K - 1)$
  - The general idea is to take your $N$ input bits, and split them into two groups:
    1. Inputs: $K$ LSBs
    2. Enables: $N - K$ MSBs
  - We will need $2^(N-K)$ of the smaller $K$ to $2^K$ decoders, which we will connect the $K$ inputs to the inputs of all $2^(N-K)$ decoders in parallel
  - To select these smaller decoders, we use one $(N-K)$ to $2^(N-K)$ decoder. It is possible that this also needs to be recursively built, as the "Enable Decoder"
  - The inputs to this "Enable Decoder" will be the $N- K$ enable bits, and the outputs are wired to the enable of each of the smaller decoders

  #inline("Reducing Number of Decoders")
  - The idea is to use smaller decoders to split the truth table of a circuit into different sections, each handled by a smaller decoder
  - General strategy:
    1. If no outputs are needed from a second-level decoder, remove the decoder
    2. If all outputs are needed from a second-level decoder, remove the decoder, and connect the corresponding output from the first level decoder to the OR gate
    3. If the set of outputs is the same for two or more decoders at the second level, keep one of the decoders and remove the rest. Add an OR gate to take in the appropriate outputs from the first-level decoder, and connect the output of this OR gate to the enable input of the retained decoder
])
== Encoder
#concept-block(body: [
  - Encode signal from $2^n$ input to $n$ binary information output
  - Valid Input: Only one input line is activated at one time
  #inline("4x2 encoder")
  - Truth-table for 4x2 Encoder(F0,F1,F2,F3) = D1, D0:
  #align(center)[

    #figure(image("MSI-Components/encoder-table-kmap.png", width: 100%))
    #figure(image("MSI-Components/simple-encoder.png", width: 50%))
    $D_0=F 1+ F 3 \ D_1=F 2+F 3$
  ]
  #inline("8x3 encoder")
  #figure(image("MSI-Components/encoder-8x3.png", width: 100%))
  #inline("Priority Encoder")
  - Instead of enforcing only one input pins is activated rules, we consider taking precedence using input with highest priority.
  #figure(image("MSI-Components/priority-encoder.png", width: 80%))
  $
    F = D_2+D_3\
    G = D_3+(D_2 '.D_1)\
    V = D_0 + D_1 + D_2 + D_3\
  $
])
== Demultiplexers
#concept-block(body: [
  - Demultiplexer(data line, control lines): output lines
  - Same implementation as a Decoder with Enable, where enabler is data line, input is control line.
  #figure(image("MSI-Components/demultiplexer-and-decoder.png", width: 80%))
])
== Multiplexers
#concept-block(body: [
  - Multiplexer/Data Selector(data lines, control lines): output line
    #figure(image("MSI-Components/multiplexer.png", width: 80%))
    - Y = I0.S1'.S0' + I1.S1'.S0 + I2.S1.S0' + I3.S1.S0 = I0.m0 + I1.m1 + I2.m2 + I3.m3
  #inline("IC Package")
  - Some IC may have multiplexer in-build.
    #figure(image("MSI-Components/quadrable-multiplexer.png", width: 90%))
  #inline("Constructing Larger Multiplexers")
  - A larger multiplexer may be constructed using a bunch of smaller multiplexer as shown below.
  - Using the truth table, divide it by the input data line of your smaller multiplexer, to determine how many multiplexer you need.
  #figure(image("MSI-Components/multiplexer-2-4x1.png", width: 90%))
  #figure(image("MSI-Components/multiplexer-4-2x1.png", width: 90%))

  #inline("Standard MSI Multiplexer")
  - 74151A 8-to-1 Multiplexer(D0-D7, C,B,A, G') = Y,W
    - D0-D7 is data line
    - C,B,A is control line
    - G' is enabler (Activate-low (0))
  #figure(image("MSI-Components/multiplexer-74151A.png", width: 100%))

  #inline("Implementing Function with Multiplexer")
  - A $2^n$-to-1 multiplexer can implement a Boolean function of $n$ input function (To select which minterm to return)
    - Express in sum-of-minterm form
      - F(A,B,C) = $sum m (1,3,5,6)$
    - Connect $n$ variable to the $n$ selection line
    - Set 1 to data line if it is minterm function, or 0 otherwise.
    #figure(image("MSI-Components/function-with-multiplexer.png", width: 100%))
    F(A,B,C) = I0.m0+I1.m1+I2.m2+I3.m3
    #figure(image(
      "MSI-Components/function-with-multiplexer-1.png",
      width: 100%,
    ))
  #inline("Implementing Function with Smaller Multiplexer")
  #figure(image(
    "MSI-Components/function-with-smaller-multiplexer.png",
    width: 100%,
  ))
  - Assign m input variable as control line, observe how the output pin depends on the n-m variable (LSB), and tweak as you go.

  #inline("8-to-1 MUX Exam Pattern (Shannon Expansion)")
  - For a 4-variable function $F(A,B,C,D)$ implemented with a single 8-to-1 MUX:
    1. Choose three variables as select lines (e.g. $S_2,S_1,S_0 = A,B,C$); the remaining variable ($D$) is used on the data inputs.
    2. For each input line $I_k$ (each combination of $A,B,C$), look at the two minterms that differ only in $D$ (e.g. $A'B'C'D'$ and $A'B'C'D$).
    3. If $F$ is always 0 or 1 for those two minterms, connect $I_k$ to 0 or 1 respectively; if it equals $D$ or $D'$ across the two minterms, connect $I_k$ to $D$ or $D'$.
    4. In MCQ settings where the select mapping is fixed (e.g. $S_2 S_1 S_0 = A B C$), you can “reverse engineer” the required $I_0 dots I_7$ directly from the list of minterms of `F`.
])

= Sequential Logic
#concept-block(body: [
  Two types of sequential circuits:
  - *Synchronous*: output change only at specific time
  - *Asynchronous*: outputs change at any time

  Multivibrator: a class of sequential circuits
  - *Bistable* (2 stable states)
  - *Monostable or one-shot* (1 stable state)
  - *Astable* (no stable state)

  Bistable logic devices
  - Latches and flip-flops
])
=== Memory Element
#concept-block(body: [
  Memory element: device which can remember value and change value accordingly to command from its input.

  #table(
    columns: 3,
    [Command \ (at time t)], [Q(t)], [Q(t+1)],
    [Set], [X], [1],
    [Reset], [X], [0],
    [Memorise/\
      No Change],
    [0/1],
    [0/1],
  )

  #inline("Clock Pulses and Triggering Mechanism")
  Two types of triggering/activation that determine when a memory element changes its state.
  - Pulse-triggered (Latches)
    - ON=1, OFF=0
  - Edge-triggered (Flip-Flops)
    - Positive edge-triggered (ON = from 0 to 1; OFF = other time)
    - Negative edge-triggered (ON = from 1 to 0; OFF = other time)
    #image("Sequential Logic/clock-pulse.png")
])
== Latches and Flip-Flops
#concept-block(body: [
  #inline("S-R Latch/Flip-Flops")
  #image("Sequential Logic/sr-latch.png")
  #align(center)[
    #grid(
      columns: 2,
      gutter: 10%,
      [
        Characteristic Table
        #table(
          columns: 4,
          [S], [R], [CLK], [Q(t+1)],
          [0], [0], [X], [Q(t)],
          [0], [1], [$arrow.t$], [0],
          [1], [0], [$arrow.t$], [1],
          [1], [1], [$arrow.t$], [$?$],
        )],
      [
        Excitation Table
        #table(
          columns: 4,
          [Q], [Q+], [S], [R],
          [0], [0], [0], [X],
          [0], [1], [1], [0],
          [1], [0], [0], [1],
          [1], [1], [X], [0],
        )
      ],
    )
  ]

  #inline("D Latch/Flip-Flops")
  #image("Sequential Logic/d-latch.png")
  #align(center)[
    #grid(
      columns: 2,
      gutter: 10%,
      [
        Characteristic Table
        #table(
          columns: 3,
          [D], [CLK], [Q(t+1)],
          [0], [$arrow.t$], [0],
          [1], [$arrow.t$], [1],
        )],
      [
        Excitation Table
        #table(
          columns: 3,
          [Q], [Q+], [D],
          [0], [0], [0],
          [0], [1], [1],
          [1], [0], [0],
          [1], [1], [1],
        )
      ],
    )
  ]

  #inline("J-K Flip-Flops")
  #image("Sequential Logic/jk-latch.png")
  #align(center)[
    #grid(
      columns: 2,
      gutter: 10%,
      [
        Characteristic Table
        #table(
          columns: 3,
          [J], [K], [Q(t+1)],
          [0], [0], [Q(t)],
          [0], [1], [0],
          [1], [0], [1],
          [1], [1], [Q(t)'],
        )],
      [
        Excitation Table
        #table(
          columns: 4,
          [Q], [Q+], [J], [K],
          [0], [0], [0], [X],
          [0], [1], [1], [X],
          [1], [0], [X], [1],
          [1], [1], [X], [0],
        )
      ],
    )
  ]

  #inline("T Flip-Flops")
  #image("Sequential Logic/t-latch.png")
  #align(center)[
    #grid(
      columns: 2,
      gutter: 10%,
      [
        Characteristic Table
        #table(
          columns: 3,
          [T], [CLK], [Q(t+1)],
          [0], [$arrow.t$], [Q(t)],
          [1], [$arrow.t$], [Q(t)'],
        )],
      [
        Excitation Table
        #table(
          columns: 3,
          [Q], [Q+], [T],
          [0], [0], [0],
          [0], [1], [1],
          [1], [0], [1],
          [1], [1], [0],
        )
      ],
    )
  ]

  #inline("Asynchronous Inputs")
  - S-R, D and J-K inputs are *synchronous inputs*  as data on these inputs are transferred only on the triggered edge of the clock pulse.
  - *Asynchronous inputs* is input line that take precedence of the state of the flip-flop *independent of the clock*;
    - E.g.: preset (PRE) and clear (CLR) [or direct set (SD) and direct reset (RD)].

    #image("Sequential Logic/async-input.png")
    A J-K flip-flop with active-low PRESET and CLEAR asynchronous inputs.
])

== Sequential Circuit Analysis
#concept-block(body: [
  Given a sequential circuit diagram we may analyse its behaviour by deriving *state table*, *state diagram* Which requires *state equations*, *output functions*. A(t)/A to A(t+1)/A+.

  State table of $m$ flip-flop and $n$ inputs requires $2^(m+n)$ rows.

  #inline("State Classifications")
  - *Sink state*: once the circuit enters this state it never exits, so future transitions remain in that state regardless of inputs.
  - *Self-correcting circuit*: if the machine transiently enters an unused or invalid state, the next few transitions will eventually drive it back into a valid state.

  #inline("5-Step FSM Design / Analysis Algorithm")
  - A standard exam recipe for state machines:
    1. *State Diagram / Description*: start from the textual description or given diagram; clearly label states and transitions with inputs/outputs.
    2. *State Table*: choose state variables (e.g. A,B,C) and inputs (e.g. x), and write the table of Present State + Input → Next State (A⁺,B⁺,C⁺) and outputs.
    3. *Excitation Table*: using the flip-flop excitation tables, add columns for each FF input (e.g. $D_A$, $J_B$, $K_B$, …) and fill their required values for every row.
    4. *K-maps*: draw a separate K-map for each FF input, with present-state bits (and inputs) as variables; plot the required input values (using X for don’t-cares).
    5. *Simplify*: derive minimal SOP expressions for each FF input from the K-maps and implement the logic.

  #inline("Self-Correcting Check (Unused States)")
  - To test whether a design is self-correcting:
    1. List all unused/invalid states (combinations of FF bits not part of the intended state set).
    2. For each unused state, plug its bits (and relevant inputs) into your FF input equations to compute the next state.
    3. If every unused state eventually transitions into the valid state set (and never gets stuck in a separate sink), the circuit is self-correcting.

  #inline("Exam Tricks with Flip-Flops")
  - D flip-flop: $D = Q^+$ always, so for any state bit implemented with a D-FF you can directly K-map the next-state function and skip a separate D-excitation table.
  - J-K flip-flop: many excitation entries are X (don’t-care); when K-mapping J and K, freely use these X cells to form larger groups and simplify the expressions.

  #inline("D Flip-flop Example")
  #image("Sequential Logic/seq-circt-ex1.png")
  #align(center)[
    #grid(
      columns: 2,
      gutter: 5%,
      [
        #image("Sequential Logic/seq-circt-ex1-state-table.png")
      ],
      [
        #image("Sequential Logic/seq-circt-ex1-state-table-compact.png")
      ],
    )
    #grid(
      columns: 2,
      gutter: 5%,
      [
        #image("Sequential Logic/seq-circt-ex1-state-diagram.png")
      ],
      [
        State diagram encodes Input/Output. Uses /Output or Input/ if only output/input are present.
      ],
    )
  ]
  #inline("JK Flip-flop Example")
  #image("Sequential Logic/seq-circt-ex2.png")
  - JA = B, KA = B.x', JB = x', KB = A $xor$ x
  #image("Sequential Logic/seq-circt-ex2-state.png")

  #inline("JK Flip-flop Example")
  #image("Sequential Logic/seq-circt-ex3.png")
  #image("Sequential Logic/seq-circt-ex3-state.png")

])

== Memory
#concept-block(body: [
  #inline("Memory Size and Hierarchy")
  Memory stores programs and data.

  - 1 byte = 8 bits
  - 1 word: multiple of bytes (unit of transfer between main memory and register, usually size of register)
  - 1 KB (kilo-bytes) = $2^10$ bytes = 1024 bytes
  - 1 MB (mega-bytes) = $2^20$ bytes = 1024 KB
  - 1 GB (giga-bytes) = $2^30$ bytes = 1024 MB
  - 1 TB (tera-bytes) = $2^40$ bytes = 1024 GB

  #image("Sequential Logic/mem-hierarchy.png", width: 80%)

  #inline("Memory Unit")

  *Data input lines* provide information to be written into memory
  *Data output lines* provide information read from memory
  *Address of $k$ lines* which specify which word ($2^k$) to be selected for reading or writing
  *Control Lines Read and Write* specifies the direction of transfer of the data.

  #image("Sequential Logic/mem-transfer.png", width: 100%)

  #image("Sequential Logic/mem-block-diagram.png", width: 50%)

  #table(
    columns: 3,
    [Memory Enable], [Read/Write'], [Memory Operation],
    [0], [X], [No operation],
    [1], [0], [Write to selected word],
    [1], [1], [Read from selected word],
  )

  #inline("Memory Cell")

  - Static RAM use flip-flop as memory cell
  - Dynamic RAM use capacitor as memory cell (needs refresh)

  #image("Sequential Logic/mem-cell.png", width: 90%)

  #inline("Memory Arrays")

  We may construct a 4x3 RAM with decoder and OR gates.

  #image("Sequential Logic/mem-array-4x3.png", width: 90%)

  Similarly, we may scale this design up to the block level of 4Kx8 RAM, implemented using four 1Kx8 RAM blocks and a 2x4 decoder. Note how we pass the two MSB of the address to the decoder to select which 1Kx8 block to use, and the remaining ten LSB of the address to the 1Kx8 RAM blocks.

  #image("Sequential Logic/mem-4kx8.png", width: 90%)

  Example below shows a 2Mx32 Memory, implemented using (4*4) 512Kx8 Memory blocks and a 2x4 decoder.

  This shows how we may scale up the word size and memory size using smaller memory blocks.

  #image("Sequential Logic/mem-2mx32.png", width: 90%)

])

= Pipeline
== MIPS Pipelining Stages
#concept-block(body: [
  #inline("Motivation")
  - Pipelining refers to process where by breaking down a big task into sub-task, multiple task can then be executed simultaneously by different resources.
  - Benefits:
    - Increase overall throughput of the system (Does not reduce time for each instruction)
  - Possible problems:
    - Pipeline rate limited by slowest pipeline stage
    - Stall for dependencies

  #image("Pipeline/pipeline-illustration.png", width: 90%)
  #inline("MIPS Pipeline Stages (Datapath)")
  - We can achieve similar pipeline speed up in MIPS by breaking down a single instruction into different stages. For each clock cycle, each stages will handle different part of the instruction.
  - *Pipeline registers* (i.e. IF/ID, ID/EX, EX/MEM, MEM/WB) are used to store IO of each pipeline stage.
  #table(
    columns: 3,
    [Name of Stage], [Cached Input], [Cached Output],
    [IF: Instruction Fetch],
    [-],
    [
      - Instruction read from Instruction Memory
      - PC+4
    ],

    [ID: Instruction decode/ \ register file read],
    [
      - Register numbers for reading two register
      - 16-bit immediate offset
      - PC+4
    ],
    [
      - Data values from register file
      - 32-bit sign-extended immediate
      - PC+4
      - Write register number
    ],

    [EX: Execute /\ address calculation],
    [
      - Data values from register file
      - 32-bit sign-extended immediate
      - PC+4
      - Write register number
    ],
    [
      - ALUResult
      - isZero
      - Data Read 2 from Register File
      - (PC+4) + Immediate \* 4
      - Write register number
    ],

    [MEM: Memory access],
    [
      - ALUResult
      - isZero
      - Data Read 2 from Register File
      - (PC+4) + Immediate \* 4
      - Write register number
    ],
    [
      - Result to be written back to register file (if avail)
      - Write register number
    ],

    [WB: Write back],
    [
      - Result to be written back to register file (if avail)
      - Write register number
    ],
    [-],
  )
  Refer to appendix for full MIPS Datapath with pipelining.
  #inline("MIPS Pipeline Stages (ControlPath)")
  - After Control Unit generates the control signal in ID stage, the control signals are grouped and pass down to different stages through the pipeline registers.
    #align(center)[
      #image("Pipeline/mips-datapath-grouping-pipeline.png", width: 85%)
    ]
])
== CPU Implementation and Performance Calculation
#concept-block(body: [
  1. *Single Cycle*
    - One cycle, one instruction
    - Time wasted for instruction with less stage (e.g. `lw`)
    - Cycle Time: $ "CT"_"seq" = max(sum^N_(k=1)T_k) $
      - $T_k$: Time of operation in stage k
      - $N$: Number of stages
    - Execution time for $I$ instruction:
      $
        "Time"_"seq" = I * "CT"_"seq"
      $
  2. *Multi-Cycle*
    - One cycle, one stage
    - Cycle Time: $ "CT"_"multi" = max(T_k) $
      - $T_k$: Time of operation in stage k
    - Execution time for $I$ instruction:
      $
        "Time"_"multi" = I * ("CT"_"multi" * "Average CPI")
      $
      - Average CPI = Average cycle per instruction = 4.6 (given)
  3. *Pipeline*
    - One cycle, multiple stage at same time
    - Cycle Time: $ "CT"_"pipeline" = max(T_k) + T_d $
      - $T_k$: Time of operation in stage k
      - $T_d$: Overhead for pipelining (e.g. pipeline register)
    - Execution time for $I$ instruction:
      $
        "Time"_"multi" = (I + N - 1) * ("CT"_"pipeline")
      $
      - I + N - 1 = \#Cycles for I instruction (Need N-1 cycle to fill up the pipeline)

  #image("Pipeline/cpu-implementations.png")

  #inline("Ideal Speedup")
  - Assuming for ideal case:
    - Every stage take same amount of time
      $
        sum^N_(k=1)T_k = N * T_k
      $
    - No pipeline overhead
      $
        T_d = 0
      $
    - Number of instructions more than number of stages
      $
        I >> N
      $
    $
      "Speedup"_"pipeline" = frac("Time"_"seq", "Time"_"pipeline") \
      = frac(
        I times sum^N_(k=1)T_k,
        (I+N-1) times (max(T_k) + T_d)
      ) = frac(
        I times N times T_1,
        (I+N-1) times T_1
      ) \
      approx frac(
        I times N times T_1,
        I times T_1
      ) ("When I is much greater than N")\
      = N ("Number of stages in an instruction")
    $

  #inline("Amdahl's Law for CPI Improvements")
  - Amdahl's Law says overall speedup is limited by the fraction of time affected: $S = frac(1, (1 - f_"improved") + f_"improved" / S_"improved")$.
  - For instruction classes, compute the baseline average CPI: $("CPI")_"avg" = sum_i (f_i * "CPI"_i)$ where $f_i$ is the fraction of instructions of type $i$.
  - If Type A instructions improve from $("CPI")_(A, "old")$ to $("CPI")_(A, "new")$, then $S_A = ("CPI")_(A, "old") / ("CPI")_(A, "new")$ and $f_"improved" = f_A * ("CPI")_(A, "old") / ("CPI")_"avg"$.
  - New overall CPI is $("CPI")' = f_A * ("CPI")_(A, "new") + f_B * ("CPI")_B + dots$ and the speedup relative to the old CPI is $S = ("CPI")_"avg" / ("CPI")'$; use this to answer questions like “what speedup occurs if only Type A CPI is improved?”.

])
== Pipelining Hazard
#concept-block(body: [
  #inline("Hazard")
  - Problem that causes pipeline not be able to achieve maximum speed up as hypothesized ($"Speedup"_"pipeline"=5$ in MIPS since have 5 components)
  #inline("Timing Diagram Exam Recipe")
  - To compute cycles for a given code snippet:
    1. List instructions in order as rows; draw columns for cycles 1,2,3,… and cells for stages (F, D, E, M, W).
    2. Fill the ideal schedule assuming one new instruction enters at each cycle (diagonals of F/D/E/M/W).
    3. Apply hazard rules: insert bubbles/stalls when data is not yet available or a branch is unresolved, shifting later stages to the right.
    4. Count total cycles when the last instruction finishes W; with full forwarding, remember that a `lw` followed immediately by a dependent ALU op *still* incurs a 1-cycle stall (the classic load–use hazard).
  #inline("Structural Hazard")
  - Two instruction access same hardware component at same time.
    - E.g. Two instruction requires RegisterFile to load and store data into the register
  - Solution:
    - Stall the execution of new instruction until the resource is ready.
    - Split the memory register to instruction memory and result memory.
    - Split cycle into half; first half on writing, second half on reading (in this order if `sw` goes before `lw`).
  #inline("Data Hazard")
  - Two instruction read/write to same register at same time, therefore the order of operation should strictly follow order of instruction for program accuracy.
  1. Write-after-Read dependency (no hazard)
  2. Write-after-Write dependency (no hazard)
  3. *Read-After-Write dependency (RAW)* (hazard)
    ```mips
    i1: add $1, $2, $3. # write to $1
    i2: sub $4, $1, $2. # reads from $1
    i3: add $5, $1, $2. # reads from $1
    ```
    - Solution:
      1. Forwarding Technique
        - Forward the computed value directly to the ALU of next stage, without writing into register yet
        - Only works if the data produced before it is needed by other instruction
        - Note that Split cycle is implicitly assumed for RegFile conflict in `RB` and `IF` stage
        #image("Pipeline/pipeline-hazard-foward.png")
    2. Stall Technique (For `lw` instruction only)
      - Similar with forwarding technique, but delay operation of a stage by one cycle, so that data is always produced before it is needed
        #image("Pipeline/pipeline-hazard-stall.png")

  #inline("Control Hazard")
  - In example below, execution of subsequent instructions depends on value of `$1` and `$3` to be evaluated, to decide if branch instruction is taken. This introduce a control-dependency issue.
    ```
    beq $1, $3, 7    >-|
    and $12, $2, $5 <-|
    or $13, $6, $2    |
    add $14, $2, $2.  |
    .........         |
    lw $4, 5($7)    <-|
    ```
  - Branching result is only available at `MEM` stage, with the AND-gate deciding whether to override the PC with (PC+4) OR (PC+4) + 4\*Immediate.

  Solutions:
  0. *Naive Pipeline Stall*
    - Introduce 3 delay cycles
    - Problematic as 20% of instruction are branch instructions
    #image("Pipeline/pipeline-control-delay.png")
  1. *Early Branch Decision*
    - Move branch decision calculation from `MEM` to `ID` stage by adding a new `Zero?` circuit
    - Introduce just 1 delay cycle (in theory, but look at the problem below)
      #image("Pipeline/pipeline-control-hazard-early-branch-prediction.png")
      #image("Pipeline/pipeline-hazard-control-early-branch-cycle.png")
    - Problem:
      - RAW data dependencies introduce extra delay because the operands must be ready before we can resolve the branch.
        - +1 clock delay for R-type instructions
        - +2 clock delay for `lw` instructions (=3, same as naive stalling)
        #image("Pipeline/pipeline-hazard-control-early-problems.png")
  2. *Branch Prediction*
    - Assume the branch instruction is not taken to save a cycle; if the assumption is wrong, squash the speculative instruction by inserting bubbles.

    - Example:
      ```
            addi $s0, $zero, 10
      Loop: addi $s0, $s0, -1
            bne $s0, $zero, Loop
            sub $t0, $t1, $t2
      ```
      Given a 5-stage pipeline with the branch decision ready in the `ID` stage, how many cycles are required?

      1. Total instructions executed: $I = 1$ (setup `addi`) $+ 2 * 10$ (loop body) $+ 1$ (`sub`) $= 22$ instructions.
      2. Ideal pipeline cycles: $I + N - 1 = 22 + 5 - 1 = 26$ cycles.

      3. Without Branch Prediction
  #{
    show table.cell: set text(size: 5.3pt)
    table(
      columns: 11,
      align: center,
      [Inst], [1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
      [addi], [IF], [ID], [EX], [MEM], [WB], [], [], [], [], [],
      [addi], [], [IF], [ID], [EX], [MEM], [WB], [], [], [], [],
      [bne], [], [], [IF], [X], [ID], [EX], [MEM], [WB], [], [],
      [addi], [], [], [], [X], [IF], [ID], [EX], [MEM], [WB], [],
      [bne], [], [], [], [], [], [IF], [X], [ID], [EX], [MEM],
    )
  }
  - The `bne` instruction incurs one delay cycle because `$s0` is only ready after the `EX` stage.
  - The final `addi` introduces another delay because the zero check completes in the `ID` stage.

  - $therefore$ Total execution cycles $=$ Ideal cycles $+$ Total delay $= 26 + 2 * 10 = 46$ cycles.

    4. With Branch Prediction (assume branch is not taken)
    #{
      show table.cell: set text(size: 5.3pt)
      table(
        columns: 11,
        align: center,
        [Inst], [1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
        [addi], [IF], [ID], [EX], [MEM], [WB], [], [], [], [], [],
        [addi], [], [IF], [ID], [EX], [MEM], [WB], [], [], [], [],
        [bne], [], [], [IF], [X], [ID], [EX], [MEM], [WB], [], [],
        [sub], [], [], [], [IF], [X], [X], [X], [X], [], [],
        [addi], [], [], [], [], [], [IF], [ID], [EX], [MEM],
      )
    }
  - The `bne` still experiences one delay cycle because `$s0` becomes ready only after `EX`.
  - The `sub` executes speculatively 9 times because the branch is assumed not taken and is wrong for those iterations.
  - In the final iteration the prediction is correct, saving one cycle relative to the always-stall case.

  $therefore$ Total execution cycles $=$ Ideal cycles $+$ Total delay $= 26 + 1 * 10 + 1 * 9 = 45$ cycles.
  3. *Delayed Branching*
    - Move non-control dependent instructions into the branch-delay slot (i.e. time when delay happens)
      ```
      or $8, $9, $10 (Non-control dependent)
      add $1, $2, $3
      sub $4, $5, $6
      beq $1, $4, Exit
      (non-control or nop)
      xor $10, $1, $11
      ```

    // TODO: Move to appendix
    #inline("NOPs and Bubbles")
    - NOP: no-operation, a real MIPS instruction (usually `sll $0, $0, 0`) that uses a pipeline slot but has no effect
    - Bubble: hardware method of creating a NOP on the fly to handle stalls. Created by Hazard Unit, which zeroes out the control signals for the instruction in the ID/EX pipeline register (so nothing is written)
    - Stall: a two part process managed by Hazard Unit. First the PC and IF/ID register are prevented from being updated to hold the current instruction in the IF stage, and the conflicting instruction in the ID stage. Then a bubble is inserted into the ID/EX register.

    #inline("Forwarding Unit")
    #image("Pipeline/forwarding-unit.png")
    - Forwarding Unit: prevent stalls from RAW data hazards by implementing forwarding to either EX/MEM or MEM/WB
  ```
  // Detect EX Hazard
  if (EX/MEM.RegWrite
  and (EX/Mem.RegisterRd != 0)
  and (EX/MEM.RegisterRd = ID/EX.RegisterRs)
  ) ForwardA = 10

  if (EX/MEM.RegWrite
  and (EX/Mem.RegisterRd != 0)
  and (EX/MEM.RegisterRd = ID/EX.RegisterRt)
  ) ForwardB = 10

  // Detect MEM Hazard
  if (MEM/WB.RegWrite
  and (MEM/WB.RegisterRd != 0)
  and not(EX/MEM.RegWrite and (EX/MEM.RegisterRd != 0)
    and (EX/MEM.RegisterRd != ID/EX.RegisterRs))
  and (MEM/WB.RegisterRd = ID/EX.RegisterRs)) ForwardA = 01

  if (MEM/WB.RegWrite
  and (MEM/WB.RegisterRd != 0)
  and not(EX/MEM.RegWrite and (EX/MEM.RegisterRd != 0)
    and (EX/MEM.RegisterRd != ID/EX.RegisterRt))
  and (MEM/WB.RegisterRd = ID/EX.RegisterRt)) ForwardB = 01
  ```

  #table(
    columns: 3,
    [MUX Control], [Source], [Explanation],
    [ForwardA=00],
    [ID/EX],
    [The first ALU operand comes from the register file],

    [ForwardA=10],
    [EX/MEM],
    [The first ALU operand comes from the prior ALU result],

    [ForwardA=01],
    [MEM/WB],
    [The first ALU operand is forwarded from data memory or an earlier ALU result],

    [ForwardB=00],
    [ID/EX],
    [The second ALU operand comes from the register file],

    [ForwardB=10],
    [EX/MEM],
    [The second ALU operand comes from the prior ALU result],

    [ForwardB=01],
    [MEM/WB],
    [The second ALU operand is forwarded from data memory or an earlier ALU result],
  )

  #inline("Hazard Detection Unit")
  #image("Pipeline/hazard-detection-unit.png")
  - Hazard Detection Unit operates in the *ID* stage of the pipeline and is used to insert stall bubbles in the case where:
    1. Load instruction is trying to read from memory to write data into a register
    2. Next instruction is trying to read from that register. But the data is still being read from memory while the ALU is performing the operation, so the pipeline needs to be stalled before the result from the MEM stage can be forwarded

  ```
  if (ID/EX.MemRead and
    (ID/EX.RegisterRt = IF/ID.RegisterRs) or
      (ID/EX.RegisterRt = IF/ID.RegisterRt))
        stall the pipeline
  ```

  #inline("Multiple Issue Processors")
  - Multiple Issue Processors: Multiple instructions in every pipeline stage
  - Static Multiple Issue: Compiler specifies the set of instructions that execute together in a given clock cycle. Simpler hardware but more complex compiler. (e.g EPIC, VLIW processors)
  - Dynamic Multiple Issue: superscalar processor, most common today, hardware decides which instructions to execute together. Complex hardware but simpler compiler
    - E.g for a 2-wide superscalar pipeline, a maximum of two instructions per cycle can be completed

])



= Cache
== Caching Fundamentals
#concept-block(body: [
  #inline("SRAM vs DRAM")
  - DRAM (dynamic RAM): higher density, slow access latency (~50-70ns), lower cost, used for main memory
    - Double Data Rate (DDR), Synchronous Dynamic RAM
    - Delivers memory on the positive and negative edge of a clock (double rate)
  - SRAM (static RAM): lower density, faster (~0.5–5 ns), higher cost; used for cache
    - Uses S-R flip flops
  // Memory Hierarchy
  #inline("Memory Hierarchy")
  - Layered design to balance speed, capacity, and cost: registers (fastest, smallest, most expensive), cache (SRAM, fast, small), main memory (DRAM, slower, larger), storage (disk, slowest, largest, cheapest)
  - Goal: make the slow large memory feel fast by serving most accesses from faster, smaller layers
  #inline("Principle of Locality")
  - Temporal Locality: recently accessed items are likely to be accessed again soon (e.g instructions to increment a pointer in a for loop)
  - Spatial Locality: items near recently accessed ones are likely to be accessed soon (e.g sequential code, array traversal)
  - Working Set: set of locations accessed in a time period

  #inline("Structure of a Cache")
  - Cache is a small, fast SRAM between CPU and main memory, managed by the hardware
  - Cache stores the following:
    - Data block (line)
    - Tag of the memory block
    - Valid indicating whether the cache line contains valid data
  - Cache Hit: valid and tag obtained from memory address matches tag in the cache
  - There are three main ways to map addresses to cache lines/blocks:
    - Direct Mapped Cache
    - N-Way Set Associative Cache
    - Fully Associative Cache

  #inline("Cache Misses")
  #image("Cache/block-size-tradeoff.png")
  - Compulsory/Cold Miss: happens when the cache block is empty. Associativity does not affect the rate of cold miss.
  - Conflict Miss: happens when there is already an existing memory block occupying the cache block (collision) and hence there is a need to evict the memory block and pull in the new memory block from main memory. Rate goes down with increasing associativity, down to 0 for fully associative cache.
  - Capacity Miss: occurs when there are no more locations to place the memory block; the larger the cache size, the lower the chance of a capacity miss. Associativity does not affect the rate of capacity misses.
  #inline("Cache Hierarchy")
  - Multi-level cache:
    - Primary cache: smaller, focus is on minimizing hit time to yield a shorter clock cycle or fewer pipeline stages
    - Secondary cache: larger, focus is on minimizing miss rate to reduce the penalty of long memory access times
      - Hence, usually has higher associativity than primary cache
])
== Cache Metrics
#concept-block(body: [
  #inline("Basic Metrics")
  - Hit Rate, $H$: fraction of accesses that hit
  - Hit Time, $t_h$: time to access cache
  - Miss Rate: $1 - H$
  - Miss Penalty, $t_m$: time to replace cache block + hit time
  #inline("Average Memory Access Time")
  $
    "Average Access Time" = \
    "Hit rate" times "Hit time" + (1-"Hit rate") times "Miss penalty"
  $

  #inline("Measuring Cache Performance")
  $"CPU time" &= "(CPU execution clock cycles" \ &+ "Memory-stall clock cycles)" \ &times "Clock cycle time"$
  $"Memory-stall clock cycles" &= "Memory Accesses Per Program" \ &times "Miss Rate" \ &times "Miss Penalty" \ &= "Instructions per program" \ &times "Misses per instruction" \ &times "Miss Penalty"$

  #inline("Speedup of Multi-Level Cache")
  For a two-level cache, total CPI is the sum of the stall cycles from both levels of cache and the base CPI:

  $"Total CPI" &= "Base CPI" \ &+ "Primary stalls per instruction" \ &+ "Secondary stalls per instruction"$
])
== Direct Mapped Cache
#concept-block(body: [
  #image("Cache/dm-cache.png")
  - Number of Bits in Address (if byte-addressed): $log_2("Total Number of Memory Bytes")$
  - Number of Cache Blocks: $2^M$
  - Size of 1 Cache Block: $2^N$ bytes
  - Number of Bits in Cache: $"Number of Blocks" times ("Block Size in bits" + "Tag Size" + "Valid Field Size") = 2^M times (8 times 2^N + ("Number of Bits in Address" - M - N) + 1)$
  - Break memory address into: block number and offset
  - Offset gives byte offset within the cache block, $N$ bits to represent (think unit number of HDB flat)
  - Block number can be further broken down into:
    - Tag: unique tag to identify the data when there are collisions ($"Number of Bits in Address" - N - M$ bits)
    - Index: the cache index that identifies which block in the cache to store the data in, last $M$ bits of the block number
  // Words (couple of bytes)
  // Block (couple of words)

  // Each block is addressed in Block Number
  // Each cache is addressed in Cache Index, M
  - Mapping Function: $"Cache Index" = "Block Number" mod "Number Of Cache Blocks"$
  - Cache Hit: At the cache index, valid bit is set (i.e cache actually has valid data) AND tag matches (use a comparator)
  // Block Number = Tag + Cache Index
  // Memory Address = Tag + Cache Index + Block Offset

  // Last M bit of Block Number (Not Memory Address) is the Cache Index
  // Bits before M bit is the Tag

  // Cache Index = Mapping Function(BlockNumber % NumberOfCacheBlocks)
  // Tag = Block number / Number of Cache Blocks

  // Access a Cache
  // - Valid bit to indicate whether cache line have valid data
  // - Tag of memory block is same
  // Cache Hit = [Tag Matches] && Valid

  // Image Pg 30


])
== Set Associative Cache
#concept-block(body: [

  #inline("N-Way Set Associative Cache")
  #image("Cache/4-way-set-associative-cache.png")
  - Instead of mapping directly to cache blocks: map memory blocks into a set that can contain $N$ cache blocks
  - Within the set, a memory block can be placed in any of the $N$ cache blocks in the set
  - Pros: Less chance of conflict miss since we are less likely to need to evict previous cached data when there is a collision
  - Cons: Need to search $N$ cache blocks in the set to find the memory block, so need $N$ comparators to search for same tag in parallel
  - Rule of Thumb: A direct-mapped cache of size $N$ has about the same miss rate as a 2-way set associative cache of size $N/2$
  - Mapping function is the same as direct mapped cache, just that the Cache index now refers to an $N$ way set


  #inline("Fully-Associative Cache")
  - A special case of a set associative cache where the $N$ equals the number of cache blocks
  - Pros: there are no conflict misses
  - Cons: expensive in hardware and energy because every access compares the requested tag against all valid cache entries, which also lengthens access time
  - Memory Address: only tag (which will just be the block number), and offset (imagine instead of HDB flat, we have Landed Property where the address/tag directly maps to the house, there is no chance of a collision, except when there are not enough space in the address book and we need to remove an item from the address book.)
  - If there are $2^N$ bytes in a cache block, then the number of offset bits is just $N$ and number of tag bits is $32-N$
  #inline("T/I/O Bit Cheat Sheet")
  - Let $B$ = block size in bytes, $C$ = total cache capacity in bytes, $N$ = associativity (number of ways), assuming 32-bit byte addresses:
    - Offset bits: $O = log_2 B$ (bytes within a block).
    - Number of sets: $S = C / (B times N)$.
    - Index bits: $I = log_2 S$ (for fully associative, $S = 1$ so $I = 0$).
    - Tag bits: $T = 32 - I - O$.
])
== Cache Policy
#concept-block(
  body: [
    #inline("Block Replacement Policy")
    - For set and fully associative caches, we need to decide which block to evict if a set is full
    - Least Recently Used (LRU): exploit temporal locality by evicting the block which has not been accessed for the longest time
      - Cons: Hard to keep track if there are many choices, cost rises with associativity
    - Other policies: FIFO, Random Replacement, Least Frequently Used (requires counters)

    #inline("Write Consistency Policies")
    - Write-Through: on a write, update both cache and main memory
      - Pros: simple, consistent
      - Cons: slow
      - Mitigation: write-buffer to decouple CPU from slow memory writes
    - Write-Back: On a write, update cache only, and only update main memory upon eviction from cache
      - Pros: Faster (fewer memory writes)
      - Cons: More complex
      - Requires each block to have a dirty bit:
        - On write: set dirty=1
        - On eviction: if dirty, write the block back to memory
    #inline("Write Miss Policies")
    - Write-Allocate: Fetch the block into cache, and then perform the write in cache
    - Write-Around: Bypass the cache and write directly into main memory without loading the block into cache
  ],
)

== Cache Performance Analysis
#concept-block(
  body: [
    #inline("Determining the Final State of a Cache")
    - Work backwards from the end of the access trace:
      - Cache holds the most recent references; earlier entries would have been evicted.
      - Populate lines/sets (with `tag`, data words/bytes) as you go back.
    #inline("Determining the Hit/Miss Rate")
    - Work forwards to follow actual execution order and warm-up effects.
    - Steps:
      1. Identify the repeating pattern per loop iteration (addresses and block alignment).
      2. Handle special cases: the first iteration (cold start/warm-up) and the last iteration (loop exit path).
      3. Multiply the steady-state pattern by the number of iterations; add the special-case adjustments.
    - Instruction caches:
      - Instruction addresses typically increment by 4 (word-aligned).
      - Initialization code can “pollute” the cache before the loop begins; account for warm-up passes.
    - Data caches:
      - Loads and stores both consult the cache.
      - Policies (write-through/write-back) may matter, but default treatment here is that both are cache-relevant.
    - Pattern nuances:
      - Some loops produce a repeating hit/miss pattern every 2 iterations (or another period) due to block reuse; adjust counts accordingly (e.g., divide by 2).
    #inline("Detecting Thrashing Patterns")
    - In a direct-mapped cache, two arrays that share the same index bits (after discarding offset bits) will constantly evict each other if a loop alternates between them (e.g. `A[i]`, then `B[i]` every iteration).
    - A quick exam test: compute Tag/Index/Offset for the base addresses of A and B; if their indices are equal and the loop repeatedly touches both, expect a near 0% hit rate from pure conflict misses.
  ],
)
