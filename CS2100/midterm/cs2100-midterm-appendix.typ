#import "cs2100-midterm-common.typ": *

#page(margin: 0%)[
  #figure(
    image("Appendix/mips_processor_diagram.png", width: 100%),
    caption: [MIPS Control Path],
  )
  #muchpdf(
    read("Appendix/MIPS Instruction Set[256].pdf", encoding: none),
    scale: 2.0,
  )

]

#page(flipped: true, margin: 0%)[
  #figure(
    box(
      image("Appendix/ASCII Table.svg", width: 100%),
    ),
    caption: [
      ASCII Table
    ],
  )
]

#pagebreak()

#show: cheatsheet-layout

= Appendix A: Shenanigans
== C Programming
#concept-block(body: [
  #inline("Preprocessor Directives")
  In C, the preprocessor processes the source code before it is compiled by compiler into assembly code.

  Here are some key directives:
  1. File Inclusion: `#include <filename>` (search standard directory)  or `#include "filename"` (search source directory)
  2. Macros: `#define MACRO_NAME SUB_VALUE`, tells preprocessor to find all instances of `MACRO_NAME` and replace with `SUB_VALUE`. Note this works recursively:
  ```c
  #define A B B B
  #define B C C
  #define C printf("Hello\n");

  int main(void) {
    A // recursively expands to B B B => C C C C C C => printf("Hello\n"); x 6
  }
  ```
  3. Macros with Arguments: `#define AREA(l, b) (l * b)` works similarly to passing arguments to a function. We can use the token pasting operator `##argument_name` to join different macros:
  ```c
  #include <stdio.h>
  #define paster( n ) printf_s( "token" #n " = %d", token##n )
  int token9 = 9;

  int main()
  {
     paster(9); // expands to printf_s( "token9 = %d", token9 );
  }
  ```

  4. Conditional Compilation: We can use directives to include or exclude parts of the code depending on certain conditions
  ```c
  #include <stdio.h>

  // Defining a macro for PI
  #define PI 3.14159

  int main(){

  // Check if PI is defined using #ifdef
  #ifdef PI
      printf("PI is defined\n");

  // If PI is not defined, check if SQUARE is defined
  #elif defined(SQUARE)
      printf("Square is defined\n");

  // If neither PI nor SQUARE is defined, trigger an error
  #else
      #error "Neither PI nor SQUARE is defined"
  #endif

  // Check if SQUARE is not defined using #ifndef
  #ifndef SQUARE
      printf("Square is not defined");

  // If SQUARE is defined, print that it is defined
  #else
      printf("Square is defined");
  #endif

      return 0;
  }
  ```
  #inline("Function Prototypes")
  - The following are valid ways to define function prototypes
  ```c
  int foo(int);
  int bar(int a);

  int sumArray(int []);
  int sumArray(int arr[]);
  int sumArray(int *);
  int sumArray(int arr[4]); // size is ignored but still valid (same goes if size is declared in function definition)
  ```
  - Purpose of function prototypes:
    - Let you place the function definition after any caller (C does not automatically hoist function bodies).
    - Allows compiler to verify function calls are made with the correct number and types of arguments
    - Header files (e.g `stdio.h`) generally contain function prototypes

  #inline("C Operator Precedence")
  #table(
    columns: 3,
    table.header([Precedence], [Operator(s)], [Associativity]),
    [1], [`exp++`, `exp--`, `func()`, `arr[i]`, `.`, `->`], [Left-to-Right],
    [2],
    [`++exp`, `--exp`, `&var`, `*ptr`, `+num`, `-num`, `!bool`, `~bits`, `(typecast)`, `sizeof`],
    [Right-to-Left],

    [3], [`a * b`, `a / b`, `a % b`], [Left-to-Right],
    [4], [`a + b`, `a - b`], [Left-to-Right],
    [5], [`a << b`, `a >> b`], [Left-to-Right],
    [6], [`a < b`, `a <= b`, `a > b`, `a >= b`], [Left-to-Right],
    [7], [`a == b`, `a != b`], [Left-to-Right],
    [8], [`a & b`], [Left-to-Right],
    [9], [`a ^ b`], [Left-to-Right],
    [10], [`a | b`], [Left-to-Right],
    [11], [`a && b`], [Left-to-Right],
    [12], [`a || b`], [Left-to-Right],
    [13], [`cond ? e1 : e2`], [Right-to-Left],
    [14],
    [`=`, `+=`, `-=`, `*=`, `/=`, `%=` , `<<=`, `>>=`, `&=`, `^=`, `|=`],
    [Right-to-Left],

    [15], [`,`], [Left-to-Right],
  )
  - Parentheses `()` override precedence—use them when in doubt.
  - `++i/--i` (prefix) yields the updated value; `i++/i--` (postfix) yields the old value.
  - `sizeof` yields `size_t` and does not evaluate most expressions.

  #inline("Mixed-Type Arithmetic")
  Note that in C, division between integers will perform floor division
  ```c
  int m = 10 / 4;     // m = 2 (integer division)
  int n = 10 / 4.0;   // 10/4.0 is 2.5 (double); assigning to int truncates to 2
  float p = 10 / 4;   // 10/4 is 2, then promoted to 2.0f
  float q = 10 / 4.0; // fully floating-point division: 2.5f
  ```

  #inline("Type Casting")
  We can cast between compatible types in C
  ```c
  int ii = 5; float ff = 15.34;
  float a = (float) ii / 2; // a = 2.5
  float b = (float) (ii / 2); // b = 2.0, integer division happens before the cast
  int c = (int) ff / ii; // c = 3
  ```

  #inline("Format Specifiers")
  The following table shows the types of placeholders available for use for the `printf` and `scanf` functions.

  #table(
    columns: 3,
    [*Placeholder*], [*Variable Type*], [*Function Use*],
    [`%c`], [`char`], [`printf`, `scanf`],
    [`%d`], [`int`], [`printf`, `scanf`],
    [`%f`], [`float`, `double`], [`printf`],
    [`%f`], [`float`], [`scanf`],
    [`%lf`], [`double`], [`scanf`],
    [`%e`], [`float`, `double`], [`printf` (scientific notation)],
    [`%p`], [`type*`], [`printf`],
    [`%zu`], [`size_t`], [`printf`],
  )

  - When printing, we can also specify the width and number of digits to display (does not work for `scanf`)
  - `%5d`: integer, width of 5, right justified
  - `%8.3f`: float with width of 8, 3 decimal place, right justified
  #inline("Multi-Dimensional Arrays")
  - Memory is 1D; multidimensional arrays are linearized.
  - For a multi-dimensional array `int arr[N][M][..]`, we can linearize it into a one-dimensional array using either row-major or column-major order.
  - C uses row-major order: store a full row, then proceed to the next row.
  - Given a multi-dimensional array of type `T`, `T a[D1][D2]...[Dn]`, where $D_j$ is the size of dimension $j$, $A_0$ is the address of the first element `a[0][0]...[0]`, and $S$ is the size (in bytes) of one element of `T`, the address of element $a[i_1][i_2]...[i_n]$ is

  $
    A_0 + S sum_(k=1)^n (i_k product_(m=k+1)^n D_m)
  $
  (by convention the empty product equals 1).

  #inline("Unions")
  - A `union` reuses the same memory for all its members; its size is the max of its members’ sizes;
  - Purpose: To save memory by allowing different data types to use the same storage space at different times (like a generic variable).
  - Only one member can hold a value at any given time. Assigning a value to one member overwrites the values of all other members.
  ```c
  typedef union {
    int    i;
    float  f;
    void  *p;
  } Cell;

  Cell c = { .i = 42 }; // initialize the 'i' member
  c.f = 3.14f;          // now the active interpretation is 'f'
  ```
  #inline("Enums")
  - An `enum` is a C type that represents a group of (integer) constants
  ```c
  enum EnumName {
      CONSTANT1 = 1, // if value not specified, default to 0
      CONSTANT2, // auto increments to 1 + 1 = 2
      CONSTANT3 // auto increments to 2 + 1 = 3
  };
  ```
  #inline("Static Global Variables and Function")
  - A static global function is only visible and callable within the source file where it is defined. It cannot be called by functions in other source files.
  - A static global variable is only visible and accessible within the source file where it is defined. It cannot be accessed by functions or variables in other source files, even if those files are linked together in the same program.

  #inline("C Quirks")
  - In C, `%` is the remainder operator, so `-10 % 4` yields `-2` (it keeps the sign of the dividend).
  - Any nonzero integer or non-null pointer is treated as `true`; `_Bool`/`bool` values print as `0` or `1`.
  - Strings cannot be used as a case for a switch statement
  - The following are equivalent: `arr[3]` and `3[arr]` due to the commutativity of the de-referencing `*` operator
  - Arrays initialized with string literals (e.g., `char str[] = "Hello";`) are modifiable, while pointers to string literals (e.g., `char *str = "Hello";`) point to read-only memory and should not be modified.
  - Prefixes: `0` for octal, `0x` for hex; `0b` for binary is a GCC/Clang extension
  - C is statically typed but not strongly typed—implicit conversions happen frequently, so the compiler will not catch every type-mismatch bug for you.
  - Declaring a pointer does not allocate the storage for the pointee; even `char *p = "hi";` merely points at existing (read-only) storage
  - Global variables exist for the full program and are unique application-wide (linker detects duplicates across files).
  - You can have a pointer to a pointer
  #inline("Unexpectedly Testable C Facts")
  - *Partial aggregate initialization*: you can list fewer initializers than members; the remaining fields zero-initialize.
  ```c
  struct Triple { int x, y, z; };
  struct Triple t = { .y = 7 };  // x and z become 0 automatically
  int arr[5] = { 1, 2 };         // remaining slots set to 0
  ```
  - *Designated initializers can appear out of order* as long as each field is named once; handy for sparse structs.
  - *Compound literals have block scope lifetime* (static if at file scope, automatic if inside a function). Borrowing their address after the full expression ends is UB.
  ```c
  int *p = (int[]){ 1, 2, 3 }; // array storage disappears right after the statement
  ```
  - *`sizeof` never evaluates its operand* (unless the operand has VLA type), so `sizeof(i++)` does not increment `i`. The result type is `size_t`.
  - *`char` signedness is implementation-defined*. Guard code that depends on negative `char` values with explicit `signed char`.
  - *Order of evaluation of function arguments and most subexpressions is unspecified*. Expressions like `f(i++, i++)` are undefined behavior because `i` is modified twice without a sequence point.
  - *Pointer dereference vs. increment precedence*: postfix `++` binds tighter than unary `*`, so `*p++` means `*(p++)` (use value, then advance pointer), while `*++p` means `*(++p)` (advance first, then read). Parenthesize `(*p)++` if you intend to increment the pointee instead of the pointer. The same rules apply to `--`.
  - *Flexible array members* (`struct Foo { size_t len; int data[]; };`) must be the last member, cannot have an initializer, and require over-allocation via `malloc(sizeof(Foo) + len * sizeof(int))`.
  - *Static locals retain state across calls* and zero-initialize once: useful but also a test favorite.
])
// Inside MIPS Green Card
== Number Systems and Data Representation
#concept-block(body: [
  #inline("IEEE 754 Reserved Values")
  The IEEE 754 standard reserves certain exponent values to represent special numbers

  #table(
    columns: 3,
    [*Exponent*], [*Mantissa*], [*Represents*],
    [255], [0], [Infinity ($plus.minus infinity$)],
    [255], [$!= 0$], [Not a Number (NaN)],
    [0], [0], [Zero ($plus.minus 0$)],
    [0], [$!=0$], [Denormalized Number],
  )
  - Denormalized is used for very small values with fixed exponent

  #inline("IEEE 754 Rounding")
  - During operations, the hardware keeps 3 extra bits beyond the stored fraction:
    - G (guard), R (round), S (sticky), these are the 3 bits immediately to the right of the mantissa bits
    - Rounding is used when the number cannot be fully represented in IEEE 754, so we need to round up or down to the nearest representable number
    ```c
    if (GUARD == 1) {
      if (ROUND == 1 || STICKY == 1) {
        // Round Up
        return ROUND_UP(X);
      }

      // Invoke LSB (bit 23) as tie-breaker
      if (LSB == 1) {
        return ROUND_UP(X);
      }
    }
    // Default is
    return ROUND_DOWN(X);
    ```
  - Implication: floating point numbers are not associative in practice
    #inline("Max/Min Without a Hidden Bit")
  Consider a floating-point format with 1 sign bit, 6 exponent bits, and 9 stored mantissa bits (no hidden bit). The exponent bias is

  $B = 2^5 - 1 = 31$

  Assuming every 6-bit exponent pattern is used for normalized numbers, the largest and smallest exponents are

  $E_max = (2^6 - 1) - B = 32$ and $E_min = 0 - B = -31$

  The largest positive finite value sets every mantissa bit to 1:

  $max = 0.111111111_2 times 2^32 = 2^32 - 2^23 = 111111111_2 times 2^23 = 4286578688$

  The smallest positive normalized value uses the smallest mantissa and exponent:

  $min_{>0} = 0.100000000_2 times 2^{-31} = 2^{-32}$

  The most negative finite value is $-max$.

  IEEE 754 *does* use a hidden bit, so its mantissa is interpreted as $"sign"(1."fraction")_2 times 2^"exponent"$. In this custom format without the hidden bit, we instead evaluate mantissa bits directly as $"sign"("mantissa")_2 times 2^"exponent"$.

  #inline("Binary Coded Decimal")
  - Encodes each decimal digit separately using a 4-bit binary pattern (`0000`..`1001`). Patterns `1010`–`1111` are invalid and often treated as error indicators.
  - Useful when decimal digit boundaries must be preserved (e.g., financial data) because scaling by powers of ten only requires shifting by nibbles, not reinterpreting the binary magnitude.

  #inline("84-2-1 Code")
  - A weighted self-complementing code whose bit positions carry weights $8, 4, -2, -1$. Valid combinations still cover decimal digits 0–9, but the negative weights force unused bit patterns to show up as invalid digits.
  - Because the code is self-complementing, the 9's complement of a digit can be obtained by flipping every bit, which simplifies subtraction hardware.

  #inline("2421 Code")
  - Another self-complementing weighted code with weights $2, 4, 2, 1$. Most digits have two different legal encodings; designers usually pick the canonical one that yields even parity.
  - As with 84-2-1, taking the bitwise complement immediately yields the 9's complement of the digit.

  #inline("Biquinary Code")
  - Represents each decimal digit with two fields: a 2-of-5 field that marks which group (0–4 or 5–9) we are in, and a 1-of-5 field that encodes the position within that group.
  - The redundancy (two bits set in every code word) allows single-bit error detection—any pattern with the wrong number of ones is invalid.

  #inline("Parity Bit")
  - Append one bit so the total number of ones is even (even parity) or odd (odd parity). The receiver recomputes the parity and flags an error if it disagrees.
  - Detects any single-bit error but cannot correct it and may miss multi-bit flips that preserve parity.

  #inline("Hamming Code")
  - Adds multiple parity bits whose positions are powers of two (1, 2, 4, 8, …). Each parity bit covers a unique subset of data bits.
  - When a code word is read back, the parity bits form a binary syndrome that identifies the bit position that flipped, allowing single-bit error correction and double-bit error detection.

])



== MIPS

#concept-block(body: [
  #inline("Facts")
  - MIPS registers are untyped—any 32-bit pattern can be interpreted as an integer, pointer, or float depending on the instruction that reads it.
  - MIPS: Microprocessor without Interlocked Pipelined Stages
  - MIPS has 32 general-purpose registers, each 32 bits wide.
  - Memory is byte-addressed with 32-bit addresses: $2^32$ bytes total = $2^30$ words (a word is 4 bytes).
  - Endianness is implementation-specific; classic MIPS systems were big-endian, but many embedded cores are little-endian. Know which mode your simulator uses.
  - `$at` register: usually used by assembler to store values for pseudo-instructions, hence not recommended to use in your own code
  - Labels don't count as instructions. When used in MIPS code, the assembler internally converts labels to either the actual memory address (for jump instructions) or as offset (for branch instructions)

  #inline("Instructions")
  - `srl` vs `sra`: `srl` will fill the new MSB with 0, while `sra` does sign extension, so it will fill with `1` for negative numbers
  - `andi`, `xori` and `ori` performs zero-extension of the 16 bit immediate. Note that if you perform `andi` against a value that has bits in the upper 16 bits, then it will override those bits with 0
  - `addi` and `slti` performs sign extension of the 16-bit immediate
  - `lb` and `sb` are commonly used when processing strings, since `char`s are single byte in size. When processing strings, we should take care not to increment our iterator by 4. If we use `lw` to process strings, we will load every 4 characters instead.
  - lw/sw require word-aligned addresses (address % 4 == 0). Unaligned lw/sw cause exceptions.
  - Pseudo-instructions for unaligned word access expand into sequences of real instructions (e.g., using lb/sb); avoid them when possible.
    - `ulw` and `usw` (unaligned load word and unaligned store word)
  - Other memory instructions:
    - `lh` and `sh`: load halfword and store halfword
    - `lwl`, `lwr`, `swl`, `swr`: load/store word left/right
  - `addi` traps on signed overflow while `addiu` does not. Signed compare instructions (`slt`, `slti`) treat operands as signed; the `u` variants (`sltu`, `sltiu`) perform unsigned comparisons even though immediates are still sign-extended.
  - `jal` writes `PC + 8` (the address of the instruction after the delay slot) into `$ra`; `jr $ra` therefore returns to the instruction *after* the delay slot.
])
=== Common MIPS Patterns
#concept-block(body: [
  #inline("Loading 32 Bit Constants")
  1. Use `lui` to set the upper 16 bits (e.g `lui $t0, 0xAAAA`)
  - `lui` will fill the lower bits with 0s as it is a pseudo-instruction that first loads then shifts the value left
  2. Use `ori` to set the lower-order bits (e.g `ori $t0, $t0, 0xF0F0`)

  #inline("Implementation of NOT operation")
  - We can implement NOT operation using either `NOR` or `XOR` operations
    - `nor $t0, $t0, $zero`
    - `xor $t0, $t0, $t1` assuming `$t1` is an all ones mask (requires loading a 32 bit constant with all ones e.g `addi $t1, $zero, -1`)

  #inline("Modulo of Power of 2")
  - Suppose we want to calculate the modulo of a power of 2, $x mod 2^n$, we can use the formula $x mod 2^n = x and (2^n - 1)$
  ```
  # Assume $s0 holds the number (e.g., 45)
  li   $t1, 15        # Create the bitmask (16-1=15, or 0b00001111)
  and  $t0, $s0, $t1  # $t0 = $s0 AND 15 (45 & 15 = 13)
  ```

  #inline("Checking for Word Alignment")
  - An address is word aligned if the value of the address modulo the word size is 0
  - So, if we assume that our word size is a power of 2, we can take the bitwise and with the word size - 1 and check if the result is 0
  - Recall a word is 4 bytes, so we can just do `andi $t1, $a0, 3 # 4 - 1 = 3`

  #inline("Indexing Based Iteration of Arrays")
  - Idea: use an index variable, and calculate the exact memory address (base address + offset) inside the loop during each iteration
  1. Store the index variable $i$ and base address in a register, set $i=0$
  2. Within each iteration, calculate the offset $i times 4$: `sll $t1, $t0, 2$`
  3. Calculate the address of the current element by adding the base address: `add $t2, $a0, $t1`
  4. Access element $A[i]$: `lw $s3, 0($t2)`
  5. Increment the index: `addi $t0, $t0, 1`

  #inline("Pointer Based Iteration of Arrays")
  - Idea: Avoid repeated multiplication and addition inside the loop by maintaining a register that holds the current memory address, which is incremented directly by the size of the data type
  - This results in more efficient code due to less instructions per iteration
  1. Initialize the pointer $p$: `addi $t0, $a0, 0`
  2. Calculate the end address:
    - `sll $t1, $a1, 2` (size x 4)
    - `add $t2, $a0, $t1` (t2 stores end address)
  3. Within the loop body:
    - Access element $A[i]$ (dereferencing): `lw $s3, 0($t0)`
    - Increment pointer $p$: `addi $t0, $t0, 4`
    - Check loop condition (blt):
      - `slt $t3, $t0, $t2`
      - `bne $t3, $zero, Loop`

  #inline("Jumping Across Jump Range")
  - We can use branch instructions to allow for jumps across the 256MB memory region
  ```mips
        beq  $t0, $t1, MidBranch      # If $t0 == $t1, go to MidBranch.

        # Code that runs if the branch is NOT taken ($t0 != $t1).
        addi $s0, $s0, 1              # Increment a counter.
        sub  $s1, $s1, $s0            # Perform some other work.

        # Prevent accidental execution of bridge
        # This is an unconditional jump. It's always true ($zero == $zero).
        # It acts as a "fence" to hop over the special MidBranch code.
        beq  $zero, $zero, AfterFix   # Always jump to the 'AfterFix' label.

  # --- Fenced-Off Area ---
  # This code can now ONLY be reached if the first beq instruction
  # explicitly jumps to it. It will never be executed by "falling through".
  MidBranch:
        j    FarLabel                 # The "connecting flight".
  # -----------------------

  AfterFix:
        # Normal program execution continues here.
        # ... more code ...

  # ... lots of other instructions ...

  FarLabel:
        # ... code at the final destination ...
  ```
])

=== Conversion Strategies
#concept-block(body: [
  #inline("MIPS-to-C Translation (Loop Blocks)")
  - When given MIPS and asked for C:
    1. Identify the *prologue* that sets up base addresses, loop bounds, and accumulators; these become variable declarations and initializations.
    2. Locate the main loop: the label, the conditional branch that exits, and the jump back; reconstruct a `for`/`while` with the same condition and update.
    3. Recognise address patterns: sequences like `sll $t1,$t0,2` then `add $t2,$s0,$t1` then `lw $t3,0($t2)` correspond to `A[i]`.
    4. Rewrite the body as clean C using array notation and structured control flow, not a literal line-by-line translation.

  #inline("C-to-MIPS Translation (Loop Template)")
  - When given C and asked for MIPS:
    1. Map long-lived variables (loop bounds, pointers, counters) to `$s` registers; use `$t` registers for temporaries.
    2. For `for (i = 0; i < n; i++)` loops, use a standard pattern:
      - Initialize `i` (`add $t0, $zero, $zero`), compare with `n` via `slt`, and use `beq`/`bne` to exit.
    3. Implement `A[i]` / `B[i]` with the scale–index–add pattern: `sll` (by 2 for words) → add base → `lw`/`sw`.
    4. Keep the loop structure obvious: test at the top, fall through into the body, then perform the increment and jump back to the loop label.

  #inline("Use of Temporary Registers")
  - C expressions involving more than two operands must be broken down into multiple smaller statements

  ```
  # a = b + c - d;
  add $t0, $s1, $s2
  sub $s0, $t0, $s3
  ```
  #inline("Inversion of Branch Conditions")
  - To make the MIPS code shorter, we often invert the condition in a branch condition
  - For an `if` statement:
  ```c
  if (i == j) {
    // then
  }
  // else
  ```

  ```mips
  bne $s3, $s4, Else
  # then
  Else:
  ```
  - For a `while` loop:
  ```c
  while (j == k) {
  }
  ```
  ```
  Loop:
    bne $s4, $s5, Exit
    # then
    j Loop
  Exit:
  ```




  #inline("Handling Inequalities")
  - Inequalities are handled using the Set on Less Than `slt` instruction
  - The `slt $rd, $rs, $rt` sets register `$rd` to 1 if `$rs < $rt` and 0 otherwise
  - We can then use this to implement pseudo-instructions like `blt`, `ble`, `bgt`, `bge`

  #table(
    columns: 3,
    [*C Code*], [*Pseudo-instruction*], [*MIPS Instruction*],

    [`if (i < j)`],
    [`blt $rs, $rt, L`],
    [`slt $t0, $rs, $rt` `bne $t0, $zero, L`],

    [`if (i >= j)`],
    [`bge $rs, $rt, L`],
    [`slt $t0, $rs, $rt` `beq $t0, $zero, L`],

    [`if (i <= j)`],
    [`ble $rs, $rt, L`],
    [`slt $t0, $rt, $rs` `beq $t0, $zero, L`],

    [`if (i > j)`],
    [`bgt $rs, $rt, L`],
    [`slt $t0, $rt, $rs` `bne $t0, $zero, L`],

    [`if (i == j)`], [`beq $rs, $rt, L`], [`beq $rs, $rt, L`],
    [`if (i != j)`], [`bne $rs, $rt, L`], [`bne $rs, $rt, L`],
  )

  #inline("MIPS Swap Procedure")
  ```mips
  # code to swap k with k + 1
  swap:
    sll $2, $5, 2 //  k * 4
    add $2, $4, $2 // add base addr to get arr[k]
    lw $15, 0($2) // load arr[k]
    lw $16, 4($2) // load arr[k + 1]
    sw $16, 0($2)
    sw $15, 4($2)
  ```
])


== Tracing Strategies
#concept-block(body: [
  #inline("Counting Number of Instructions with Loops")
  - Suppose $A$ is the number of instructions before the loop, $B$ is the number of instructions and $n$ is the number of iterations
  - Then the number of instructions executed will be $A + "Bn"$
  - Note that for conditional branches with `BNE`, the branch instruction executes $n$ times, but branches are taken $n-1$ times
  #inline("Counting Number of Unique Bytes Read")
  ```mips
         addi $t1, $t0, 10
         add  $t2, $zero, $zero
  Loop:  ulw  $t3, 0($t1) # ulw: unaligned lw
         add  $t2, $t2, $t3
         addi $t1, $t1, -1
         bne  $t1, $t0, Loop
  ```
  - `ulw` loads 4 bytes at a time, but the pointer is incremented by 1 each iteration, meaning each load overlaps with the previous one, except for the first.
  - The first `ulw` accesses 4 unique bytes; each subsequent iteration only reads one additional unique byte.
  - So if there are `n` iterations, we read only $4 + (n - 1)$ unique bytes.
])


== Procedure Calls
#concept-block(body: [
  #inline("Stack Operation in MIPS")
  #image("MIPS/mips_stack_memory.png")
  - In MIPS, the stack grows from a high memory address towards a lower memory address
  - The *stack pointer register* `$sp` always points to the top-most valid data item on the stack (the lowest memory address currently in use by the stack)
  - Push Operation (Allocating Space): to allocate space, decrement the stack pointer, then perform a store operation with the stack pointer as the base address
  - Pop Operation (Deallocating Space): to deallocate space, increment the stack pointer by the number of bytes you want to deallocate (e.g `addi $sp, $sp, 8` frees 8 bytes)
  #inline("Stack Frame in MIPS")
  #image("MIPS/mips_stack_frame.png")
  - When a function is called, it creates a *stack frame* on the stack. This is a block of memory used for its arguments, saved registers, and local variables.
  - Frame Pointer (`$fp`): points to the start of the frame, acting as a stable reference point for accessing local variables and arguments, even as the stack pointer moves to accommodate further nested calls
  - Return Address (`$ra`): contains the address in the caller's code to which the callee should return. In the event that a function recursively calls other functions, the callee function should save a copy of the original return address as recursive calls will override the return address (assuming using `jal` instruction)
  - Saved Registers: Locations to store the original values of any callee-saved (`$s0-$s7`) registers that the callee intends to modify
  #inline("jal and jr Instructions")
  - `jal label` (jump and link) does the following:
    - Saves the address of the instruction immediately following the `jal` (i.e PC + 4) into `$ra`
    - Jumps to the instruction located at `label`
  - `jr $rs` (jump register): Jumps to the address specified in the specified register `$rs`. Usually this is used at the end of a function to `jr $ra`, to transfer control of the function back to the caller, completing the procedure call

  #inline("Procedure Calls in MIPS")

  ```mips
  myfunc:
      # Prologue: Setup the stack frame
      addiu $sp, $sp, -<frame_size>   # Allocate space for the frame
      sw $ra, <offset>($sp)          # Save return address if not a leaf procedure
      sw $s0, <offset>($sp)          # Save any callee-saved registers ($s0-$s7)
      # ...

      # Procedure Body
      # ...
      jal some_other_proc            # Call another procedure
      # ...

      # Epilogue: Tear down the stack frame and return
      lw $s0, <offset>($sp)          # Restore callee-saved registers
      lw $ra, <offset>($sp)          # Restore return address
      addiu $sp, $sp, <frame_size>   # Deallocate the frame
      jr $ra                         # Return to caller
  ```
])

== ISA

#concept-block(
  body: [
    - Programmer writes program in high-level language like C -> Compiler translates to assembly -> Assembler translates to machine code -> Processor executes machine code
    - Stored-program (von Neumann) model: instructions and data are both just bits stored in memory; CPU fetches/executes in program order logically, even though real CPUs may execute out-of-order internally.
    #inline("Instruction Format Gotchas")
    - R-format opcodes are all zero in MIPS, so decoding relies entirely on `funct`; control logic must still look at both fields in case a future ISA revision reuses opcodes.
    - Logical immediates (`andi`, `ori`, `xori`) zero-extend while arithmetic immediates (`addi`, `slti`) sign-extend. Mixing them up silently corrupts the upper 16 bits.
    - Jump-format targets keep the upper 4 bits of `PC + 4`; if your destination crosses a 256 MB boundary you must stitch together two jumps (e.g., `lui` + `jr`) or the hardware will land in the wrong segment.

    #inline("ISA Metric Curveballs")
    - CPI questions often hide different instruction mixes: `CPI = Σ (frequency × cycles per instruction)`. A small number of slow instructions can dominate if their latency is high, so recompute CPI whenever the mix changes.
    - Structural hazard questions love the single-memory assumption: a unified memory shared between instruction fetch and data access automatically produces a structural hazard unless you add a Harvard split or insert stalls.
  ],
)

== Misc Fun Facts
// SMLJ?
- Lectures held at: UT-AUD2
- TOTO Example (Recitation 1)
- Stage floor not even (Recitation 6)
- Pentium 4 has 22 pipeline stages

#figure(
  image("Appendix/trinity.png", width: 95%),
)
