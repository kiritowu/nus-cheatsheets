#import "@preview/boxed-sheet:0.1.0": *

#set text(font: (
  "Times New Roman"
))

#let homepage = link("https://kiritowu.github.io")[kiritowu.github.io]
#let author = "Zhao Wu"
#let title = "MA1522 | Midterm Cheet Sheet"

#import "@preview/muchpdf:0.1.0": muchpdf

#show: cheatsheet.with(
  title: title,
  homepage: homepage,
  authors: author,
  write-title: true,
  title-align: left,
  title-number: true,
  title-delta: 2pt,
  scaling-size: false,
  font-size: 7pt,
  line-skip: 5.5pt,
  x-margin: 10pt,
  y-margin: 30pt,
  num-columns: 4,
  column-gutter: 2pt,
  numbered-units: false
)

= Linear Systems
== Introduction to Linear Systems
#concept-block(
 body: [
 Linear Equation has Standard Form

 $ a_1x_1 + a_2x_2 + ... + a_n x_n = b $ 
 
 Where:
 - $a_1$ : Coefficient
 - $x_1$ : Variable
 - $b$ : Constant
 
 #inline("Sysmtem of Linear Equations")
 
- A Linear system in standard form is written as:

  $
  cases(
    a_{11}x_1 + a_{12}x_2 + ... + a_{1n} x_n = b_1,
    a_{21}x_1 + a_{22}x_2 + ... + a_{2n} x_n = b_2,
    ...,
    a_{"m1"}x_1 + a_{"m2"}x_2 + ... + a_{"mn"} x_n = b_m
  )
  $


- Homogeneous Linear System $<=> b_1 = b_2 = ... = b_m = 0 $
- Solution to Linear System satisfies all equations in the system after substituting the values of variables.

  - General Solution: All possible solutions to the system.
  - Linear System is Consistent $ <=> S in.not nothing$
  - Linear System is Inconsistent $ <=> S in nothing$
 ]
)

== Solving Linear System and Row-Echelon Form
#concept-block(
 body: [
 - Augmented Matrix express a linear system in matrix form.

 $
 mat(a_11, a_12, ..., a_1n, b_1; 
     a_21, a_22, ..., a_2n, b_2; 
     ..., ..., ..., ..., ...;
     a_"m1", a_"m2", ..., a_"mn", b_m; augment: #4)
 $

 - Zero Row: A row in which all entries are zero.
 - Leading Entry: The first nonzero entry in a nonzero row from left.

 #inline("Row-Echelon Form (REF)")

 1. Zero rows are at the bottom of the matrix, if exist.
 2. The leading entry of each nonzero row is to the right of the leading entry


 #inline("Reduced Row-Echelon Form (RREF)")
  3. Leading entry in each nonzero row is 1.
  4. In each pivot column, all other entries, except the leading entry is 0.


 - Pivot Column: A column that contains a leading entry.
 - Non-Pivot Column: A column that does not contain a leading entry. (May be whole zero column or full of entries)

 #inline("Number of Solutions from REF")
 
 1. No Solution:
  - Leading Entry is in rightmost column.
  $
  mat(1,0,1;
      0,0,a eq.not 0; augment: #2)
  $
 2. Unique Solution:
  - Every column is a pivot column, except rightmost column.
  $
  mat(1,0,b;
      0,1,b; augment: #2)
  $
 3. Infinitely Many Solutions:
  - At least one non-pivot column and no leading entry
  $
  mat(1,0,b;
      0,0,0; augment: #2)
  $
 ]
)

== Elementary Row Operations
#concept-block(
  body: [
  There are 3 types of ERO:
  #align(center)[
  #table(
  columns: 3,
  [Operation], [Reverse Operation], [Condition],
  [$R_i <-> R_j$], [ $R_i <-> R_j$], [],
  [$R_i = c R_i$], [$R_i = 1/c R_i$], [$c eq.not 0$],
  [$R_i = R_i + c R_j$], [$R_i = R_i - c R_j$], [$i eq.not j, c in RR$]
  )
  ]


  - Row Equivalent Matrices $<=>$ Both linear system have same solution set.
  ]
)

== Gaussian Elimination and Gauss-Jordan Elimination
#concept-block(
  body: [
  - Gaussian Elimination(augmented matrix): REF.
      1. Locate the leftmost column that does not consist entirely of zeros.
      2. Interchange the top row with another row, if necessary, to bring a nonzero entry to the top of the column found in Step 1.
      3. For each row below the top row, add a suitable multiple of the top row to it so that the entry below the leading entry of the top row becomes zero.
      4. Now cover the top row in the augmented matrix and begin again with Step 1 applied to the submatrix that remains. Continue this way until the entire matrix is in row-echelon form.

  - Gauss-Jordan Elimination(augmented matrix): RREF.
      5. Multiply a suitable constant to each row so that all the leading entries become 1.
      6. Beginning with the last nonzero row and working upward, add suitable multiples of each row to the rows above to introduce zeros above the leading entries.
  ]
)

== More on Linear System
#concept-block(
 body: [
 #inline("Homogeneous Linear System")
 - Always consistent
 - Always has trivial solution, $x_1 = x_2 = 0$
 - Non-trivial solution exists $<=>$ $>= 1$ non-pivot column in RREF $<=>$ Infinitely many solutions

 #inline("Linear System with Unknown Variables")
 - If square matrix, use `det(A)` to quickly check for unique solution (`det(A) eq.not 0`) or edge cases (`det(A) = 0`
 - Use ERO to find RREF where:
  - $R_i <-> R_j$ : Legal
  - $R_i + a R_j$ : Legal (Even if $a = 0$)
  - $R_i + 1/a R_j$ : Illegal if $a = 0$, Check for edge cases
  - $1/a R_i$ : Illegal if $a = 0$, Check for edge cases
 ]
)

= Matrix Algebra
== Definition and Special Types of Matrices
#concept-block(
 body: [
  Matrix $in RR ^(m times n)$, Entries: $a_(i j) in RR$
  $
  A = mat(a_(11), a_(12), ..., a_(1n); 
          a_(21), a_(22), ..., a_(2n); 
          ..., ..., ..., ...;
          a_("m1"), a_("m2"), ..., a_("mn"))
    = (a_(i j))_(m times n)
  $

  #inline("Special Types of Matrices")
  - Vector: row vector $in RR^(1 times n)$; column vector $in RR^(m times 1)$ 
  - Zero Matrix $in 0 forall a_(i j)$
  - Square Matrix $in m = n$
    - Diagonal Entries: $a_(i i), i in NN $
    - Diagonal Matrix: $in forall a_(i j) = 0, i eq.not j$
    - Scalar Matrix: $in forall a_(i j) = cases(c "if" i = j , 0 "if" i eq.not j)$
    - Identity Matrix: $in forall a_(i j) = cases(1 "if" i = j , 0 "if" i eq.not j)$
    `Identity <: Scalar <: Diagonal <: Square`

  #table(
   columns: 4,
   [Upper Triangle], [Strict Upper Triangle], [Lower Triangle], [Strict Lower Triangle],
   [$mat(
    *, *, *;
    0, *, *;
    0, 0, *
   )$], [$mat(
    0, *, *;
    0, 0, *;
    0, 0, 0
   )$], [$mat(
    * ,0 ,0;
    * ,* ,0;
    * ,* ,*
   )$], [$mat(
    0, 0, 0;
    *, 0, 0;
    *, *, 0
   )$]
   )
 ])

 == Matrix Algebra
#concept-block(
 body: [
 #inline("Matrix Addition and Scalar Multiplication")
 #table(
  columns: 2,
  [Cummulative], [$A + B = B + A$],
  [Associative], [$A + (B + C) = (A + B) + C$],
  [Additive Identity], [$A + 0 = A$],
  [Additive Inverse], [$A + (-A) = 0$],
  [Distributive law], [$c(A + B) = c A + c B$],
  [Scalar Addition], [$(c + d)A = c A + d A$],
  [Associative] , [$c d A = c (d A)$],
  [Zero], [If $a A = 0 _(m times n)$, $a=0$ or $A = 0$]
)

 #inline("Matrix Multiplication")
 
 #table(
  columns: 2,
  [Associative], [$A(B C) = (A B)C$],
  [Left Distributive], [$A(B + C) = A B + A C$],
  [Right Distributive], [$(A + B)C = A C + B C$],
  [Commute with Scalar], [$c(A B) = (c A)B = A(c B)$],
  [Multiplicative Identity], [$A I = I A = A$],
  [Non-Zero Divisor], [$A B = 0_(m times n)$ does not imply $A=0$ or $B=0$],
  [Zero Matrix], [$A 0 = 0 = 0 A $],
  [Power of Matrix], [$A^0 = I; A^n = A times A^(n-1)$]
  )

  #inline("Transpose of Matrix")

  - $(A^T)^T = A$
  - $(A + B)^T = A^T + B^T$
  - $(c A)^T = c A^T$
  - $(A B)^T = B^T A^T$
  - $(A B C)^T = C^T B^T A^T$

  To check if a matrix is *symmetric*, check if $A^T = A$
 ]
)

== Linear System and Matrix Equation
#concept-block(
  body: [

  Matrix Equation
  $ 
  A x = b = mat(a_(11), a_(12), ..., a_(1n); 
                  a_(21), a_(22), ..., a_(2n); 
                  ..., ..., ..., ...;
                  a_("m1"), a_("m2"), ..., a_("mn")) 
      mat(x_1; x_2; ...; x_n) = mat(b_1; b_2; ...; b_m)
  $

  - $A$ : Coefficient Matrix
  - $x$ : Variable Vector
  - $b$ : Constant Vector


  Vector Equation
  $
  x_1 mat(a_(11); a_(21); ...; a_("m1")) +
  x_2 mat(a_(12); a_(22); ...; a_("m2")) +
  ... +
  x_n mat(a_(1n); a_(2n); ...; a_("mn")) =
  mat(b_1; b_2; ...; b_m) \
  =x_1 a_1 + x_2 a_2 + ... + x_n a_n = b
  $

  - $a_i$ : Column Vector for variable $x_i$

  #inline("Block Multiplication")
  $
  cases(
  a_(11)x_1 + a_(12)x_2 + ... + a_(1n)x_n = b_1k, 
  a_(21)x_1 + a_(22)x_2 + ... + a_(2n)x_n = b_2k,
  ...,
  a_("m1")x_1 + a_("m2")x_2 + ... + a_("mn")x_n = b_(m k)
  )\ = mat(a_(11), a_(12), ..., a_(1n), b_(11), b_(12), ..., b_(1k); 
           a_(21), a_(22), ..., a_(2n), b_(21), b_(22), ..., b_(2k); 
           ..., ..., ..., ..., ..., ..., ...;
           a_("m1"), a_("m2"), ..., a_("mn"), b_("m1"), b_("m2"), ..., b_("mk");
           )
  $

  When solving block multiplication where coefficient matrix and variable vector has different size, parametrize last few columns as $s_1, s_2 in RR$
  ])


== Inverse of Matrix
#concept-block(
  body: [
  - $A^(-1) "exists" <=> A A^(-1) = I_n = A^(-1) A$
  - Non-invertible Matrix: $A^(-1)$ does not exist, Singular Matrix.
  - Inverse is unique if exists.

  $
  A^(-1) = 1/(a d-b c) mat(d, -b; -c, a) "for" A = mat(a, b; c, d) "and" a d-b c eq.not 0
  $


  #inline("Cancellation Law for Matrices")
  - If $A^-1$ exists:
    - $A X = A Y => A^(-1) A X = A^(-1) A Y => X = Y$
    - $X A = Y A => X A A^(-1) = Y A A^(-1) => X = Y$

  #inline("Finding Inverse of Matrix using ERO")
  - `rref([A  I]) = [I  A^(-1)]`


  #inline("Properties of Inverse with Linear System")
  - If $A^(-1)$ exists
    - $<=> A x=b$ has unique solution $x = A^(-1) b$ 
    - $<=> A x = 0$ has only trivial solution $x = 0$

  #inline("Properties of Inverse and Equivalence Statement")
  - The following statements are equivalent:
    1. $A^(-1)$ exists
    2. $(A^(-1))^(-1) = A$
    3. $(A^T)^(-1) = (A^(-1))^T$
    4. $(a A)^(-1) = 1/a A^(-1)$
    5. $(A B)^-1 = B^(-1) A^(-1)$
    6. $A^(-n) = (A^(-1))^(n)$
    7. `rref([ A I]) = [ I A^(-1)]`
    8. $(A_1 A_2 A_k) ^(-1) = A_k^(-1) A_2^(-1) A_1^(-1)$
    9. $A^(-1) = E_k E_2 E_1 I$ where $E_i$ are elementary matrices such that $E_k E_2 E_1 A = I_n$
    10. $A x = b$ has unique solution for every $b in RR^n$
    11. $A x = 0$ has only trivial solution
    12. `det(A) eq.not 0` (if $A$ is square)

  #inline("Problem Solving Takeaway")
  - Uses `syms a,b,c,d; AB-BA = 0` to compute general solution for $B$ given $A$
  - Uses Block-Multiplication to find out the right-inverse.
  $
  mat(A, I_2) ->("rref") = mat(1,0,1,1/3,2/3; 0,1,1,1/3,-1/3) \
  B = mat(1/3-s_1,2/3-s_2;
  1/3-s_1,-1/3-s_2;
  s_1,s_2)
  $
  - For non-square matrix:
    - One-sided inverse (if exists) is not unique as they are parametrized.
    - Have at most one one-sided inverse
    - Left-inverse $eq.not$ Right-inverse
  - When given two solutions for non-homogenous solution, we may find a solution for homogenous by taking the difference as
  $
  A(v_1-v_2) = A(v_1) - A(v_2) = b - b = 0 \
  therefore v_1-v_2 "is solution when b=0"
  $
  - When given two solutions for homogenous solution, we may find the general solution by (Let A rank 3)$
  S = v_0 + s_1 v_1 + s_2 v_2 forall s_1, s_2 in RR \
  A(v_0) = b; A(v_1) = 0; A(v_2) = 0
  $
  - When given 3 linear system, we can deduce the invertibility of $A$ from $B$
  $
  A x = mat(1;0;1); A x = mat(0;1;1); A x = (1;1;0) \
  A x = mat(1, 0, 1; 0, 1, 1; 1, 1, 0) = B \
  "Since" B^-1 "exists, " A^-1 "exists"
  $
  ])

== Elementary Matrices
#concept-block(
  body: [
  Elementary Matrix: $I -> E$ (by single ERO)
  #align(center)[
  #table(
  columns: 3,
  [$R_1 + c R_2$], [$a R_1$], [$R_1 <-> R_2$],
  [$mat(1,0; c,1)$], [$mat(a,0; 0,1)$], [$mat(0,1; 1,0)$]
  )
  ]

  $
  A ->(r) E A \
  A ->("r1") ->("r2") ... ->("rk") B \
  B = E_k ... E_2 E_1 A
  A = E_1^(-1) E_2^(-1) ... E_k^(-1) B \
  $
  ])

== LU Factorization
#concept-block(
  body: [

- `[L U] = lu(sym(A))`
- $A = L U$
  - $L$ : Lower Triangular Matrix with all diagonal entries = 1
  - $U$ : Upper Triangular Matrix, REF(A)

$
A ->("r1","r2","r3",...,"rk") U \
E_k ... E_2 E_1 A = U \
A = E_1^(-1) E_2^(-1) ... E_k^(-1) U \
A = L U \
$

- To find L quickly, we may do the following:
  - $E = R_i + c R_j forall i > j$ (Take top kill bottom)
  - Read off $L = E_1^(-1) E_2^(-1) ... E_k^(-1)$

- To solve $A x = b$ using LU Factorization:
$
A x = L U x = b \

"Let" y = U x \
L y = b \
U x = y \
$

#inline("Problem Solving Takeaway")
- Once $L$ is computed from the Coefficient Matrix, we can use that to multiply with B and solves the LS easily. $A x = b; L U x = L b; U x=b$ (PS4, 2b)
- If $A$ is invertible, $L$ and $U$ is invertible too. (PS4, 1a)
- If $A$ is LU-factorable, it doesnt say anything about invertibility of $A$ (T3, E1a)
- If $A$ is not LU-factorable, there exists a permutation matrix, $P_(R_i <-> R_j)$ such that $P A$ is LU-factorable. (T3, E1b)
  ])


== Determinant
#concept-block(
    body: [
  #inline("By Cofactor Expansion")
  - *Only defined for square matrix*.
  $
  det(A) = a_(1 1) A_(i l) + a_(1 2) A_(1 2) + ... + a_(1 n) A_(1 n) = sum_(k=1)^(n) a_(i k) A_(i k) \

  "where" A_(i k) = (-1)^(i+k) det(M_(i k))
  $

  - $A_(i k)$ : Cofactor of entry $a_(i k)$
  - $M_(i k)$ : Minor Matrix, delete $i$-th row and $k$-th column of $A$

- Determinant of transpose: $det(A^T) = det(A)$
- Determinant of Triangular Matrix: Product of diagonal entries.


  #inline("By Reduction")
  - Every Elementary Matrix has known determinant:
  $
  det(E_(R_i + c R_j)) = 1 \
  det(E_(a R_i)) = a \
  det(E_(R_i <-> R_j)) = -1 \
  $

  - Let $R$ be RREF of $A$ after $k$ EROs, then
  $
  det(R) = d_1 d_2 ... d_k "since R is upper triangular" \
   = det(E_k)...det(E_2)det(E_1)det(A) \

  therefore det(A) = d_1 d_2 ... d_k/ (det(E_1) det(E_2) ... det(E_k)) \

  $

  #inline("Properties of Determinant")
  $
  det(A B) = det(A) det(B) \
  det(A^(-1)) = 1/det(A) \
  det(A^T) = det(A) \
  det(c A) = c^n det(A) "for" A in RR^(n times n) \
  $

  #inline("Deeper Understanding of Determinant")
  - If two rows / columns are the same, the matrix is not invertible
  $
  "Let" A = mat(a, b, c; d, e, f; g, h, i) \
  $

  Performing ERO on A, det(A) changes by (1),(-1),(a)
$
  "IF a=d, e=b, c=f: " \
  A = mat(a, b, c; a, b, c; g, h, i) ->mat(1, 0, 0; -1 , 1, 0; 0, 0, 1) mat(a, b, c; 0, 0, 0; g, h, i) = A' \
  det(A) = det(E_(R_2-R_1)) * det(A') = 1*0 = 0 \
  therefore det(A) "can be derived through ERO"
  $
  ])

== Adjoint
#concept-block(
  body: [
  - Adjoint of Matrix $A$ is $"adj"(A) = (A_(j i))_(n times n)^T$
  $
  "adj"(A) = mat(A_(11), A_(12), ..., A_("1n"); 
                  A_(21), A_(22), ..., A_("2n"); 
                  ..., ..., ..., ...;
                  A_("n1"), A_("n2"), ..., A_("nn"))^T \
  A_(i j) : "Cofactor of entry" a(i j)
  $

  $
  A times "adj"(A) = det(A)  I \
  A^(-1) = 1/det(A) "adj"(A) "if" det(A) eq.not 0
  $

  #inline("Cramer's Rule")
  - If $A^(-1)$ exists, the unique solution to $A x = b$ is given by:
  $
  x = A^(-1) b \
  = 1/"det"(A) "adj"(A) b \
  = 1/"det"(A) mat(det(A_1(b)); det(A_2(b)); ...; det(A_n(b));)
  $
  (T3, 7)

  #inline("Problem Solving Takeaway")
  - If two rows/columns are the same, the adjoint is not invertible. Prove with matlab (PS3, 3b).
  - If $A$ is not invertible, $"adj"(A)$ is the solution to homogeneous solution $A x = 0 "as" A times "adj"(A) = det(A) I = 0$ (PS3, 3c)
  
  ])

= Euclidean Vector Space
== Euclidean Vector Spaces
#concept-block(
 body: [
  $RR^n = {v = mat(x_1; x_2; ...; x_n) | x_i in RR}$
  - $RR^n$ Euclidean N-space
  - $v = (x_1, x_2, ..., x_n)$ : Vector in $RR^n$

  - All matrix algebraic operation is valid in vector
 ]
)


== Dot Product, Norm, Distance
#concept-block(
 body: [
  - *Dot-Product: *
  $
  u . v = u_1 v_1 + u_2 v_2 + ... + u_n v_n = sum_(i=1)^(n) u_i v_i=u^T v
  $
  - *Norm / Length / Magnitude:*
  $
  ||u|| = sqrt(u . u) = sqrt(u_1^2 + u_2^2 + ... + u_n^2)
  $
  
  - Properties of *Inner Product and Norm*:
  $
  u. v = v . u \
  c u . v = (c u) . v = u . (c v) \
  u . (a v + b w) = a (u . v) + b (u . w) \
  u . u >= 0 "and" u . u = 0 <=> u = 0 \
  ||c u|| = |c| ||u|| \
  $

  - *Unit Vector*
  $
  ||u|| = 1 \
  hat(u) = u/(||u||)
  $


  - Distance between two vectors
  $
  d(u, v) = ||u - v|| = sqrt((u_1 - v_1)^2 + (u_2 - v_2)^2 + ... + (u_n - v_n)^2) \
  = sqrt((u - v) . (u - v)) \
  $

  - Angle between two vectors
  $
  cos(theta) = (u . v)/(||u|| ||v||) \
  theta = arccos((u . v)/(||u|| ||v||)) \
  0 <= theta <= pi \
  $
 ]
)

== Linear Combination and Linear Spans
#concept-block(
  body: [
- Geometrically, Span $"span"{u_1, u_2, ...}$ is all the position that one can reach by taking a linear combination of $u_1, u_2$ where ${c_1 u_1 + c_2 u_2 | c_1, c_2 in RR}$
$
"span"{u_1, u_2, ..., u_k} = {c_1 u_1 + c_2 u_2 + ... + c_k u_k | c_1, c_2, ..., c_k in RR}
$

- Check if Vector $v in "span"(S)$
$
"span"{u_1, u_2, ...} <=> v = c_1u_1 + c_2u_2 + ... + c_k u_k \
<=> A x = v "is consistent"
$

  - To check if span(S) is the whole euclidean n-space:
$
"span"(S) = R^n \
    <=> "rref(S) has non-zero rows" \
    <=> A x=v "is consistent"
$ (PS5, 2)
#inline("Properties of Linear Span")
span(S) has following properties:
1. $0 in "span"(S)$
2. $u+v in "span"(S)$
3. $alpha u in "span"(S)$

#inline("Equivalence of Span")
- To check if linear spans are equal by:
$
"Let" S={v_1, v_2}, T = {u_1,u_2} \
"span"(S) subset.eq "span"(T) <=> mat(u_1 u_2 | v_1 | v_2) "is consistent" \
"span"(S) = "span"(T) <=> "span"(S) subset.eq "span"(T) and "span"(T) subset.eq "span"(S) \
$    
  ]
)

== Subspaces
#concept-block(
  body: [
    -  Subspace is a subset of a euclidean-vector space that is itself a vector space under the same operations of addition and scalar multiplication as the larger space. (Similar idea with linear span)
    
    Let $V$ be Solution Set to linear system which can be express:
    - Implicitly (use to test if set/span in V)
    $
    V = { u in RR ^n | A u = b}
    $
    - Explicitly (use to test if V in span)
    $
    V = {u + s_1 v_1 + s_2 v_2 | s_1, s_2 in RR}
    $

    #inline("Subspace")
    $V subset.eq RR^n$ is subspace if:
    1. $0 in V$
    2. For any $v in V$, $alpha v in V$
    3. For any $u,v in V$, $u+v in V$

    OR (Either one)
    - Find linear span where $V = "span"{v_1, v_2}$
    - Solution set, $S "for LS "A u = 0$ (Homogenous Linear System)

    #inline("Subspace of R^2")
    1. Zero space
    2. Lines
    3. Whole $RR^2$

    #inline("Subspace of R^3")
    1. Zero space
    2. Lines
    3. Planes
    4. Whole $RR^3$

    #inline("Affine Space")
    $
    W = {u + v | A(u+v) = b} = u+v := {u+v | A v = 0}
    $

    #inline("Problem Solving Takeaway")
    - When seeing a Solution Set with unparametrized vector, we cannot determine if V is not a subspace until we are sure that the unparametrized vector is not linearly dependent on the other vectors.
      $
      V={mat(4;-3;9;1) + s_1mat(6;6;8;2) + s_2mat(6;3;7;1) + s_3mat(-2;3;-4;0) | s_1, s_2, s_3 in RR} \
      "BUT"
      "rref"(u_1, u_2, u_3, v) = mat(1,0,0,1;0,1,0,-1;0,0,1,-2) \
      therefore v = u_1 - u_2 -2 u_3 "and" V "is subspace"
      
      $
    - If an implicit solution set cannot be reduced to linear system, it is not subspace. (T4,6f)
      $
      S = {mat(a;b;c;d) | a b = c d} \
      mat(1;0;1;0) + mat(0;1;1;0) = mat(1;1;2;0) in.not S
      $ 
  ]
)

= Equivalent Statements
== Invertibility
#concept-block(body: [
  - $A^(-1)$ exists
  - $A^T$ is invertible
  - (left inverse), There exists $B$ such that $B A = I$
  - (right inverse), here exists $B$ such that $A B = I$
  - RREF of $A$ is $I$
  - $A$ is expressed as product of elementary matrices, $A = E_1^(-1) E_2^(-1) E_k^(-1) I$
  - $A x = 0$ has only trivial solution
  - $A x = b$ has unique solution
  - $det(A) != 0$
])