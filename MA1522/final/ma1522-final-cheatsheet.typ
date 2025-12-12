#import "@preview/boxed-sheet:0.1.0": *

#set text(font: (
  "Times New Roman"
))

#let homepage = link("https://kiritowu.github.io")[kiritowu.github.io]
#let author = "Zhao Wu"
#let title = "MA1522 | Final Cheet Sheet"

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
== Linear Independence
#concept-block(body: [
  - *Linearly independent* refers to a set ${u 1, u 2, u 3...}$ where *trivial solution* is the *only solution* for homogeneous linear system (aka det(S) = 0)
  $
  c_1 u_1 + c_2 u_2 + c_3 u_3 + ... = 0 | c_1 = c_2 = c_3 = 0
  $
  - Else, system is linearly dependent where >= 1 vector is redundant, and can be expressed as linear combination of other vectors.
  - In another words, $S = {u 1, u 2, ..., u k}$ is linearly independent $<=> "rref"(S)$ has no non-pivot columns.

  - Geometrically, a set is linearly dependent if we can go back the origin by taking linear combination of the sets, where the coefficients $!=0$.

  - Any subset of linearly independent set of vector is linearly independent.

  #inline("Special Cases")
  - ${0}, 0 in RR^n$ is always linearly dependent
  - $"If" v != 0, {v} in RR^n$ is linearly independent
  - ${v 1, v 2}$ is linearly dependent $<=>$ one is scalar multiple of other. $alpha v 1 = v 2$
  - Empty Set ${} = emptyset$ is linearly independent (vacuously true since no vector to check)

  #inline("Problem Solving Takeaway")
  - When we see a zero vector, $0 in RR^n$ in set, the set is always linearly dependent, as we can find non-trivial solution for the linear combination.
])

== Basis and Coordinates
#concept-block(body: [
  - *Basis* refers to set $E = {e_1, e_2, e_3}$ where any vector in $R^n$  OR subspace can be uniquely written as linear combination of vectors in E (i.e. coordinates are unique).

  - More formally, Let $V$ be subspace of $RR^n$, Set $S={u_1...u_k}subset.eq V$ is *basis* of V$<=>$
    1. S spans V, span(S) = V
    
      Since every vector $v in V$ needs to be written as LC of all vectors in S
    2. S is linearly independent 
    
      Since the coefficient is unique

  #inline("Basis for Solution Space of Homogenous System")
  - Basis for Solution Set of Homogenous System
    - Let solution space $V = {u | A u=0}$, $S = {u_1, u_2, ..., u_k}$ is basis for subspace V $<=> s_1u_1+ s_2u_2+...+s_k u_k, s_1,s_2,s_3 in RR$

    $
    V = {mat(x;y;z)|y-z=0} ("implicit") \
    = {mat(0, 1, -1)mat(x;y;z)=mat(0;0;0)} ("explicit") \
    = {s mat(1;0;0) + t (0;1;1) | s,t in RR}\
    = "span"{mat(1;0;0),mat(0;1;1)} "is Basis of V"
    $ 

    $
    V = {mat(a+b;a+c;c+d;b+d) | a,b,c,d in RR} \
    = {a mat(1;1;0;0) + b mat(1;0;1;0) + c mat(0;0;1;1) + d mat(0;1;0;1) | a,b,c,d in RR}  \
    = "span"{ mat(1;1;0;0) , mat(1;0;1;0) , mat(0;0;1;1) , mat(0;1;0;1) } "is Basis of V"
    $

  #inline("Basis for Zero Space")
  - Since ${0}$ is subspace, basis for ${0}$ is ${} "or" emptyset$
    - Since zero space is smallest subspace containing the empty set, span of empty set is zero space.

  #inline("Basis for $R^n$ and invertibility")
  - Let $A in R^(n times n)$, $A^-1$ exists 
      - $<=>$ columns/rows spans $RR^n$ 
      - $<=> "rref"(A)$ has no non-pivot column/rows
      - $<=>$ columns/rows are linearly independent

  #inline("Coordinates Relative to a Basis")
  - Let $S = {u_1, u_2, ..., u_k}$ be basis for V, a subspace of $RR^n$
    $
  v = c_1u_1 + c_2u_2 + ... + c_k u_k, c_1, c_2, c_3 != 0 \
  
  [v]_s = mat(c_1; c_2; ...; c_k)
  $
  Where $[v]_s$ is *coordinates of v relative to basis S*.

  - Let $E = {e_1, e_2, ..., e_n}$ be standard basis for $R^n$, For any $w=(w_i) in RR^n$,
    $
    w=w_1e_1+w_2e_3+...+w_n e_n => [w]_E = w 
    $

  - $dim([v]_s) = k <=> S "has" k "vectors"$
  - $[v]_s$ is unique $<=>$ S is linearly independent
  - $[v]_s$ depends on ordering of the basis.

  #inline("Problem Solving Takeaway")
  - Given a subspace $V = {mat(x_1;x_2;x_3;x_4) | x_1+2x_2-x_3+x_4}$ and $S = {u_1 = mat(1;0;1;0), u_2=mat(0;0;1;1)}$ where $S subset V$, To find a $v = mat(x_1;x_2;x_3;x_4)$ where $S union {v}$ is basis of V, we need to satisfy the following:
    - S is linearly independent
    - As $v in V therefore v = mat(-2x_2+x_3+x_4;x_2;x_3;x_4)$
    - $v in.not "span"{S}$, i.e. $mat(u_1, u_2, v)$ is inconsistent (*takeaway: to find a vector that is not in a span, we find the condition such that LS is inconsistent*)
])

== Dimensions
#concept-block(body: [
  - *Dimension* of V, $dim(V)$ refers to number of vectors in any basis of V.
  - In other words, $V$ is $k$-dimensional $<=>$ $V$ identifies with $R^k$ using coordinates relative to any basis B of V.
    - Let $B$ be basis for $V$, a subspace of $RR^n$. Suppose $B$ has $k$ vectors, $|B| = k$. Let $v_1, v_2, ..., v_m$ be vectors in $V$. Then:
  
      1. $v_1, v_2, ..., v_m$ is linearly independent $<=>$ $[v_1]_B, [v_2]_B, ..., [v_m]_B$ are linearly independent (Coordinates of $v_i$ relative to Basis B)
      2. ${v_1, v_2, ..., v_m}$ spans $V <=> {[v_1]_B, [v_2]_B, ..., [v_m]_B}$ spans $RR^k$
  
      3. If $S = {v_1, v_2, ..., v_m}$ is subset of $V$ with $m>k$, then S is linearly dependent. (too much info)
      3. If $S = {v_1, v_2, ..., v_m}$ is subset of $V$ with $m<k$, then S cannot spans V. (not enough info)
    - Let $S = {u_1, u_2, ..., u_k}$ and $T = {v_1, v_2, ..., v_m}$ are bases for subspaces $V subset.eq RR^n$, Then:
      - k = m

  #inline("Dimension of Zero Space {0}")
  - Geometrically, think of *dimension* as *degree of freedom of movement*.
    - Since Zero Space ${0} in RR^n$ has no degree of movement, its dimension is 0, therefore, its basis is ${} "or" emptyset$ since it cannot consist any vectors.

  #inline("Dimension of Solution Space")
  - Dimension of a solution space ${V = {u in RR^n | A u = 0}}$ is number of non-pivot columns in $"RREF"(A)$
    1. Recall basis of a homogenous system is formed from the general solution.
    2. Number of parameter in general solution is the number of non-pivot columns in rref.
    3. Number of non-pivot columns is number of vector in basis.
    4. Number of vectors in basis determines the dimension.

  #inline("Spanning Set Theorem")
  - Let $S = {u_1, u_2, ..., u_k} subset RR^n$, and $V = "span"(S)$. Suppose V is not zero space, there must be a subset of S that is basis of V.

  #inline("Linear Independence Theorem")
  - Let V be subspace of $RR^n$ and $S = {u_1, u_2, ..., u_k}$ a linearly independent subset of V, $S subset.eq V$. There must be a set T, containing S, $S subset.eq T$ such that T is a basis of V.

  #inline("Dimension and Subspaces")
  Ways to check for a basis:
  #table(columns: 3,
  [Definition], [B1], [B2],
  [(1) span(S) = V \
  (2) S is Linearly Independent
], [
  (1) |S| = dim(V) \
  (2) $S subset.eq V$ \
  (3) S is linearly independent \
  (Dont need to check that span(S) = V)
], [
  (1) |S| = dim(V) \
  (2) $V subset.eq "span"(S)$ \
  (Dont need to check that S is linearly independent) 
])
])

== Transition Matrices
#concept-block(body: [
  - *Transition Matrix* is a square matrix that translate from one basis $T -> S$ where $S = {u_1, ..., u_k}, T = {v_1, ..., v_k}$ are bases for subspace V.
    $
    P_(T->S) = mat([v_1]_S, [v_2]_S, ..., [v_k]_S) \
    [w]_S = P [w]_T
    $

  - Example: $
  v_1 = u_1 \
  v_2 = u_1 + u_2 \
  v_3 = u_1 + u_2 + u_3 \
  [v]_S = mat(d_1; d_2;d_3), [v]_T = mat(c_1;c_2;c_3) \
  \
  d_1 u_1 + d_2 u_2 + d_3 u_3 = w = c_1 v_1 + c_2 v_2 + c_3 v_3 \
  = c_1 u_1 + c_2 (u_1 + u_2) + c_3 (u_1 + u_2 + u_3) \
  = (c_1 + c_2 + c_3) u_1 + (c_2 + c_3) u_2 + c_3 u_3\
  \
  mat(1, 1, 1;
, 1, 1;
,,1) mat(c_1; c_2; c_3) = mat(d_1; d_2; d_3) \
[w]_S = mat(1, 1, 1;
0, 1, 1;
0,0,1) [w]_T \
[v_1]_S = mat(1;0;0), [v_2]_S = mat(1;1;0), [v_3]_S = mat(1;1;1) \
[w]_S = mat([v_1]_S, [v_2]_S, [v_3]_S) [w]_T \
    $

    #inline("Algorithm to find Transition Matrix")

    $
    ("S" | "T") = (u_1, u_2, u_k | v_1, v_2, v_k) ->"rref" mat(I_k |, P_(T->S); 0_(n-k)times k|, 0_(n-k)times k)
    $
    (Remember to kris-cross the direction)

    #inline("Inverse of Transition Matrix")
    Let $P_(S->T)$, $P^(-1)$ be transition matrix $P_(T->S)$. Note that $P^(-1)$ may not always exists.

    #inline("Problem Solving Takeaway")
    - Transition matrix is always a square matrix with the size represents the dimension of the corresponding subspace.
    - Pre-multiplying transition matrices allow us to convert coordinates across different bases. $[v]_T=P_(S->T)P_(U->S)[v]_U$
])
= Subspaces Associated to a Matrix
== Column Space, Row Space and Null Space
#concept-block(body: [
  - *Row space* refers to the subspace spans by the rows of a matrix A.
  - *Column space* refers to the subspace spans by the columns of a matrix A.

  - Note that the column vectors on its own might not be the basis of the column space.

  #inline("Row Operations Preserve Row Space")
  - Let A and B be row equivalent matrices. The row space of A is equal to row space of B, regardless of ERO.
  - Row operation does not preserve linear relations between the rows.

  #inline("Basis for Row Space")
  - Finding basis of row space is the spaning set of non-zero rows of R where R is in RREF.
  - For any matrix A, the non-zero rows of RREF of A forms a basis for the row space of A.

  #inline("Row Operations Preserve Linear Relations between Columns")
  - Recall that we may use RREF to find the linear dependency between column vectors. This shows that
  $
  A = mat(a_1,a_2,a_n), B = mat(b_1, b_2, b_n) \
  c_1 a_1 + c_2 a_2 + c_3 a_n = 0 =
  c_1 b_1 + c_2 b_2 + c_3 b_n \
  ("Note the coefficients are preserved")
  $

  - Row operation does not preserve column space.

  #inline("Basis for Column Space")
  - Suppose matrix R is RREF of matrix A. *Columns of A* corresponding to the pivot columns in R form a basis for the column space of A.
  - In another words, looking at the RREF alone does not tell us the basis for column space, it just reveals the location in the original matrix.

  #inline("Column Space and Consistency of Linear System")
  - A vector $v$ is $in "Col"(A) <=> {A x = v}$ is consistent where $
  x = mat(c_1;c_2;c_n) \
  A x = mat(u_1, u_2, ..., u_k) mat(c_1; c_2; ...; c_k) = c_1u_1 + c_2u_2 + ... + c_k u_k = v
  $
  - Use a transpose to check if vector is in row space.

  #inline("NullSpace")
  - *Nullspace* of $m times n$ matrix $A$ refers to solution space to the homogeneous system $A x=0$
  $
  "Null"(A) = {v in RR^n | A v = 0} perp "Row"(A)
  $
  - *Nullity* refers to dimension of nullspace of A.
  $
  "nullity"(A) = "dim"("Null"(A))
  $
])
== Rank
#concept-block(body: [
  - *rank(A)* refers to dimension of its column or row space, which is also equal to:
    - rank(A)
    - dim(Col(A))
    - dim(Row(A))
    - \# pivot columns in RREF of A
    - \# leading entries in RREF of A
    - \# non zero rows in RREF of A

    #inline("Properties of Rank")
    - Let $A in RR^(m times n)$, $B in RR^(n times p)$, Column space of product $A B$ is subspace of column space A.
  $
  "Col"(A B) = "span"{A b_1, A b_2, A b_p} subset.eq "Col"(A)
  $

  - rank(AB) $<=$ min(rank(A), rank(B))
  #inline("Rank Nullity Theorem")
  $
  A in RR^(m times n) \
  "rank"(A) + "nullity"(A) = n \
  "# pivot columns" + "# non-pivot columns"
  $

  #inline("Full Rank")
  - *Full rank* matrix when its rank is equal to either number or columns or rows, whichever is smaller.
  $
  "rank"(A) = "min"{m,n} = "full rank"
  $
  - If a square matrix is full rank, it is invertible as the rref is Identity.

  #inline("Full Rank Equals Number of Columns")
  Following statements are equal for $A in RR^(m times n)$:
  - A is full rank where rank(A) = n (\# columns)
  - rows of A spans $RR^n$, Row(A) = $RR^n$
  - Columns of A are linearly independent
  - Ax=0 has only trivial solution, Null(A) = {0}
  - $A^T A$ is an invertible matrix of order n
  - $A$ has a left inverse (e.g. ($(A^T A)^(-1) A^T$)A)
  - Least square solution is unique
  - A is QR factorizable
  - Linear transformation T defined by A is injective

  #inline("Full Rank Equals Number of Rows")
  Following statements are equal for $A in RR^(m times n)$:
  - A is full rank where rank(A) = m (\# rows)
  - Columns of A spans $RR^m$, Cow(A) = $RR^m$
  - Rows of A are linearly independent
  - Linear system Ax=b is consistent for every $b in RR^m$
  - $A A^T$ is an invertible matrix of order m
  - $A$ has a right inverse (e.g. A ($A^T (A A^T)^(-1)$))
  - Linear transformation T defined by A is surjective
])
= Orthogonality and Least Square Solution
== Orthogonality
#concept-block(body: [
  - Two vectors $u,v$ are *orthogonal* if
    $
    u dot v = 0
    $
      - Which means either $u$ = 0 or $v$ = 0 (zero vector)
      - $
      cos(theta) = (u dot v)/(||u|| ||b||) = 0 => theta= pi/2 => "u and v are prependicular"
      $

  #inline("Orthogonal and Orthonormal Sets")
  - *Orthogonal Sets* refers to a set $S = {v_1, v_2, ..., v_k} in RR^n$ where $v_i dot v_k = 0 forall i != j$, that is vectors in S are pairwise orthogonal.
  - *Orthonormal Sets* refers to a set that is orthogonal, with norm be zero (aka all vectors are unit vector $hat(v)$)
    $
    v_i dot v_k = cases(
      0 "if" i!=j,
      1 "if" i = j
    )
    $
  - Note that a set consisting a zero vector may be orthogonal, but cannot be normalised to orthonormal set as zero vector cannot be normalised.
  - Geometrically, an orthonormal matrix rotates a vector away from the standard basis.

  #inline("Orthogonal to Subspace")
  - Vector $n$ is *orthogonal* to subspace $V in RR^n$  if $forall v in V, n dot v = 0$. This is denoted as $n perp V$ (*i.e. w is orthogonal for all vector*)
    $
    n perp V <=> n dot v = 0 forall v in V
    $
    - Zero vector $0 perp V$ for any subspace.
  - Vector $n$ is *orthogonal* to subspace $V in RR^n$ if $S={u_1, u_2, u_k} "spans" V$ and *$w dot u_i = 0 forall i=1, ..., k$* (*i.e. w is orthogonal to for all spanning set*)
    $
    S = {u_1 = mat(1;1;1;1), u_2 = mat(0;1;-1;0)}, n = mat(n_1;n_2;n_3;n_4)\
    n perp V <=> n dot u_1 = 0 "and" n dot u_2 = 0 \
    mat(1,1,1,2;0,1,-1,0,) -> "rref" mat(1,0,2,2;0,1,-1,0) \
    n = "span" {mat(-2;1;1;0),mat(-2;0;0;1)}
    $
  - Vector $n$ is *orthogonal* to subspace $V in RR^n$ if $S={u_1, u_2, u_k} "spans" V$ and *$w in "Null"(A^T)$*
    $
    w perp V <=> w in "Null"(A^T) \
    A^T w= mat(u_1,u_2)^T w = mat(u_1^T; u_2^T)w = mat(u_1^T w; u_2^T w) = mat(0;0)
    $
    `n = null(sym(A'))`
  - A hyperplane $V in RR^n$ can be defined with a non-zero orthogonal vector, normal n where
    $
    V = {v | v dot n = 0} "for some" n!=0
    $
    

  #inline("Orthogonal Complement")
  $V^perp$ is *Orthogonal Complement* if it is the set of all vectors orthogonal to V
  $
  V^perp = {w in RR^n | w dot v = 0 forall v in V} = "Null"(A^T)
$

  Orthogonal Complement for Implicit Homogenous LS is the multiple of its coefficient.
  $
  V^perp = {mat(x;y;z) |2x-y+3z =0 } = {mat(x;y;z) |mat(2;-1;3)dot mat(x;y;z) = 0}
  $

])

== Orthogonal and Orthonormal Bases
#concept-block(body: [
  #inline("Orthogonal Set and Linear Dependence")
  - *Not all orthogonal sets are linearly independent* (because of zero vector)
  - All *orthonormal sets are linearly independent*

  #inline("Orthogonal and Orthonormal Basis")
  - A set S is an *orthogonal/orthonormal basis* for V if:
    - S is basis of V
    - S is orthogonal/orthonormal set

  #inline("Coordinates Relative to an Orthogonal Basis")
  - Let $S = {u_1, u_2, u_k}$ be orthogonal basis of subspace V, let $v in V$
  $
  v = c_1 u_1 + c_2 u_2 + ... + c_k u_k \

  "Since S is orthogonal" \
  u_i dot v = u_i dot (c_1 u_1 + c_2 u_2 + ... + c_k u_k) \
  = c_1 (u_i dot u_1), + ... + c_i (u_i dot u_i) + ...+c_k u_i dot u_k \
  = c_1(0) + ... c_i ||u_i||^2 + c_k(0) \
  = c_i||u_i|| ^2 \



  therefore c_i = (u_i dot v)/(||u_i||^2) forall i=1,...,k \
  

v = ( (u_1 dot v)/(||u_1||^2))u_1 + ((u_2 dot v)/(||u_2||^2))u_2 + ... + ((u_k dot v)/(||u_k||^2))u_k\

therefore [v]_S = mat(
    (u_1 dot v)/(||u_1||^2);
    (u_2 dot v)/(||u_2||^2);
...;
    (u_k dot v)/(||u_k||^2);

)\
  $

  - If S is *orthonormal basis* then
  $
  v = (u_1 dot v)u_1 + (u_2 dot v)u_2 + ... + (u_k dot v)u_k\

therefore [v]_S = mat(
    u_1 dot v;
    u_2 dot v;
...;
    u_k dot v;

)\
  $

  - If E is *standard orthonormal basis*
  $
  v= mat(v_1;v_2;...;v_n) in RR^n
  e_i dot v = v_i \
  [v]_E = mat(
    e_1 dot v;
    e_2 dot v;
...;
    e_k dot v;
) = mat(v_1;v_2;...;v_n)=v
  $

  #inline("Orthogonal Matrices")
  - *Orthogonal Matrices* is a square, $n times n$ matrix $A$ where $A^T = A^(-1)$, and therefore 
    - $A^T A = I = A A^T$
    - Columns of A form an orthonormal basis for $RR^n$
    - Rows of A form an orthonormal basis for $RR^n$
    - $"det"(A) = plus.minus 1 \ (1 = det(I) = det(A^T A) = det(A^T) det(A)=det(A)^2) $

  $
  Q^T Q = mat(u_1^T; u_2^T)mat(u_1,u_2) = mat(u_1^T u_1, u_1^T u_2;u_2^T u_1, u_2^T u_2) = mat(u_1 dot u_1, u_1 dot u_2; u_2 dot u_1, u_2 dot u_2) \
  therefore Q^T Q= cases(I <=>" S is orthonormal set", "diag" <=>" S is orthogonal set")
  $

  - NOTE: *orthonormal matrix* is not defined in this course.
])

== Orthogonal Projection
#concept-block(body: [
  #inline("Orthogonal Projection for a Vector")
  Let $u_p$ be orthogonal projection of vector u in direction of v,
  
  $
  cos(theta) = (u dot v) / (||u|| ||v||) = (||u_p||)/(||u||) (cos = "len(adjacent)"/"len(hypothenus)") \
  u_p = ||u_p|| dot hat(v)=(||u|| cos(theta)) v/(||v||) =||u||(u dot v)/(||u||||v||) v/(||v||) \
  u_p = (u dot v)/(v dot v) v
  $

  #inline("Orthogonal Projection to a Subspace")

  Let $V$ be subspace in $RR^n$, every vector $w in RR^n$ can be *uniquely decomposed* as sum or $w_p in V$ and $w_n perp V$
  $
  w= w_p + w_n \
  "where" w_p = (w dot u_1) / (u_1 dot u_1) u_1 + (w dot u_2) / (u_2 dot u_2) u_2 + ... + (w dot u_n) / (u_n dot u_n) u_n \
  w_p = "Orthogonal Projection of "w " into subspace "V \
  w_n = w - w_p
  $

  #inline("Best Approximation Theorem")
  Let $w in.not V$ and $v in V$, then $w_p$ is vector in V closest to W for all v in V.
  $
  ||w_n||  = ||w - w_p|| <= ||w - v||
  $

  #inline("Grand-Schmidt Process")
  GS-Process converts $S$, a basis for subspace $V$ to an orthogonal/orthonormal basis T.

  Here is the basic idea:
  1. Since there exists more than one basis that spans a subspace, we may find a basis with each vector is orthogonal to each other.
  2. How we do so is that for every i-th vector in basis, we find the normal vector to the previous subspace.
    $v_(i+1) = u_(i+1)-u_(p, i+1)$

  $
  S = {u_1, u_2, ...,u_k} "be linearly indendent set," \
  v_1 = u_1  \
   v_2 = u_2 - (v_1 dot u_2)/(v_1 dot v_1) v_1 \
  ... \
  v_k = u_k - (v_1 dot u_k) / (v_1 dot v_1) v_1 - (v_2 dot u_k) / (v_2 dot v_2) v_2-...-(v_(k-1) dot u_k) / (v_(k-1) dot v_(k-1)) v_(k-1)
  $

  - To obtain an orthonormal set, we will then normalize each vector, $v_i$ or using matlab `normalize(V, "norm")`

  - Let $S = {u_1, u_2, u_3}$, after GS-Process, $v_3 = 0, v_2 eq.not 0$, $v_3$ is linearly dependent to S.
])

== QR Factorization
#concept-block(body: [
  #inline("Inspiration from GS-Process")
  - Recall that in GS Process, we turned any basis, $S = {a_1, a_2, ..., a_n}$ into orthornormal set $Q = {q_1, q_2, ..., q_n}$.
  - Most importantly, since the span of both basis is the same subspace, we can describe $a_1$ as linear combination of $Q$
  $
  a_i = r_(1j) q_1 + r_(2j) q_2, + ... + 0 q_(j+1) = mat(q_1, ..., q_j, ..., q_n) mat(r_(1j);...;r_(j j); 0;...;0)\
  therefore A = mat(a_1, a_2, ..., a_n) \
  = mat(q_1, q_2, ..., q_n)mat(r_(11), r_(12), ..., r_(1n);
0, r_(22), ..., r_(2n);
..., ...,...,...;
0,0,0,r_(m n)
)  
  $

  #inline("QR Factorization")
  - *QR Factorization* refers to the decomposition process for a $m times n$, *linearly independent* matrix A:
    - $Q in RR^(m times n)$ such that $Q^T Q = I_n$ (i.e. orthogonal matrix)
    - $R in RR^(n times n)$ such that R is invertible upper triangular matrix with positive diagonal entries.

    $
    A = Q R\
    (Q^T) A = (Q^T) Q R = Q^T A = R \
    R = mat([u_1]_T, [u_2]_T, ..., [u_n]_T)
    $

  #inline("Algorithm to QR Factorization")
  1. Perform GS on columns of A to obtain orthonormal set ${q_1, q_2, ..., q_n}$
  2. $Q = {q_1, q_2, ..., q_n}$
  3. $R = Q^T A = Q^(-1)A$
  `[Q R] = qr(sym(A), "econ")`

  - Last n-th column in full QR is orthogonal basis for the orthogonal complement of $"Col"(A)$
])

== Least Square Approximation
#concept-block(body: [
  - Let $A in RR^(m times n)$ and $b in RR^M$ such that $A x = b$ is consistent.
  $
  "Col"(A) = {b in RR^m | A x = b "is consistent"}
  $

  - If $A x = b$ is inconsistent, $b in.not "Col"(A)$
  - Therefore, there exists $b'$ where $b' in "Col"(A)$ and $b'$ is closest to b.
  
  #inline("Least Square Solution")
  - $u in RR^n$ is *least square solution* of $A x = b <=> || A u - b || <= || A v - b || forall v in "Col(A)"$

    Note:
    - Least square solution is only unique when A has linearly independent column, else $u$ is infinitely many.
    - If u is solution of Ax=b, u is always least square solution

    Therefore:

    - $A u$ is *unique projection* of $b$ to Col(A), $therefore A u = b'$
    - $u$ is solution to $A x = b <=>$ u is solution for $ A^T A x= A^T b$

    - IF $A^T A$ is invertible, $u = (A^T A)^(-1)A^T b$

  - Least Square solution can be solved using* QR factorization* where
  $
  u = R^(-1) Q^T b
  $

  #inline("Problem Solving Takeaway")
  - `N=fliplr(vander(x))` to generate a n-th degree Vandermonde matrix (T8, q4)
  
])

= Eigenanalysis
== Eigenvalues and Eigenvectors
#concept-block(body: [
  - Let $A in RR^(n times n)$ square matrix, *eigenvalue, $lambda$* of A exists if there is nonzero vector $v$ such that
  $
  A v = lambda v, v != 0
  $

  - Geometrically, eigenvector is vector that is being "stretched" at its original direction after multiplying with A.
  - Note that only $v != 0$, $lambda in RR in 0$.

  #inline("Chracteristic Polynomial")
  - *Characteristic Polynomial*, char(A) is degree n polynomial where
  $
  "char"(A) = det(x I - A)
  $

  - Eigenvalue $lambda$ of A exists $<=>$ it is the root of the characteristic polynomial
  $
  lambda ="eigenvalue of A" <=> lambda = "root"("char"(x I - A)) 
  $
    `root(char(x*eye(3) - A))`

  #inline("Eigenvalue and Invertibility")
  - $A^(-1)$ exists $<=> lambda  = 0$  is not eigenvalue of A.
    - IF $lambda = 0$ is eigenvalue of A, $A v = 0 v = 0$.
    - This shows that there exist a non-trivial solution for Ax=0
    - This shows that A is singular (i.e. not-invertible)
    - Therefore, A is invertible when $lambda!=0$

  #inline("Eigenvalues of Triangular Matricies")
  - Eigenvalue of triangular matrix are the diagonal entries.
  - Algebraic multiplicity of eigenvalue is number of times it appeals as diagonal entry of A.

  #inline("Algebraic Multiplicity")
  - *Algebraic Multiplicity*, $r_lambda$ of $lambda$ is largest integer such that
  $
  det(x I - A) = (x - lambda)^(r_lambda) p(x)
  $
  - If $det(x I - A)$ can be factorize into linear factors completely, 
  $
  det(x I - A) = (x - lambda_1)^(r_1)(x-lambda_2)^(r_2)...(x-lambda_k)^(r_k) \
  r_1 + r_2+...+r_k = n
  $

  #inline("Eigenspace and Geometric Multiplicity")
  - *Eigenspace* associated to eigenvalue $lambda$ of A is
  $
  E_lambda = {v in RR^n | A v = lambda v} = "Null"(lambda I - A)
  $

  - *Geometric multiplicty* of eigenvalue $lambda$ is dimension of the eigenspace
  $
  dim(E_lambda) = "nullity"(lambda I- A)
  $
])
== Diagonalization
#concept-block(body: [
  - A square matrix $A in RR^(n times n)$ is *diagonalizable* if there exists $P$ such that
    $
    P^(-1) A P = D \
    A = P D P^(-1)
    $
    - D is diagonal matrix with each diagonal entries representing eigenvalue of A
    - P is *linearly independent* set of eigenvector associated to eigenvalue of its entries
    - $P^(-1)$ is inverse of P
    `[P D] = eig(A); P=sym(P); D=sym(D);`

  #inline("Diagonalizability")
  - A square matrix is *diagonalizable* $<=>$ A has n linearly independent eigenvectors.

  $
  P = mat(u_1, u_2, ..., u_n), D = mat(mu_1, 0, ..., 0; 0, mu_2, ..., 0; ...,...,...,...;0,0,...,mu_n) \
  A mu_i = mu_i u_i \
  P^(-1) "exists" <=> {u_1, u_2, ..., u_n} "is basis for" RR^n
  $

  #inline("Not Diagonalizable")
  - A square matrix is not diagonalizable if the algebraic multiplicity $r_lambda$ > its. geometric multiplicity $dim(E_lambda)$.
  $
  1 <= dim(E_lambda) <= r_lambda
  $
  - Using this property, we may only check for the $dim(E_lambda)$ for the eigenvalue with $r_lambda > 1$ while verifying for diagonalizability.
  - To show that A is not diagonalizable, we show:
    - $det(x I - A)$ cannot split into linear factors
    - there exists eigenvalue $lambda$ that $dim(E_lambda)< r_lambda$

  #inline("Eigenspaces are linearly independent")
  - Let $E_1$ be eigenspace associated to $lambda_1$ and $E_2$ be eigenspace associated to $lambda_2$ where $lambda_1 != lambda_2$,  $E_1$ and $E_2$ are linearly independent.

  #inline("Equivalent Statements for Diagnalizability")
  $A in RR^(n times n)$ is diagonalizable $<=>$:
    - There exists basis ${u_1, u_2, ..., u_n}$ of $RR^n$ of eigenvectors of A (implies P is invertible)
    - The characteristic polynomial of A splits into linear factors
    $
    det(x I - A) = (x - lambda_1)^(r_lambda_1)(x-lambda_2)^(r_lambda_2)...(x-lambda_n)^(r_lambda_k)
    $
    where the geometric multiplicty = algebraic multiplicity $forall lambda_i$

  #inline("Problem Solving Takeaway")
  - $lambda$ is eigenvalue of $A <=> lambda$ is eigenvalue of $A^T$ (T9, 5a)
  - $lambda^k$ is eigenvalue associated to $A^k forall k in NN \\ {0}$ (T9, 5c)
  - Square matrix is nilpotent ($A^k = 0$) if 0 is the only eigenvalue (T9, 5e)
  - Square matrix with one eigenvalue is diagonalizable only when it is scalar matrix (T9,5f)
  - Using characteristic polynomial, we may find inverse of matrix using Caley-Hamilton Theorem $X (X^n + ...) = I$
  - $det(A) = product^n_(i=0) lambda_i$ (product of eigenvalues, counted with multiplicity) (ps10,3)
  - Square matrix $A, B in RR^(m times m)$ are similar if $A = P B P^(-1)$ (ps10,2)
    - A and B have same eigenvalues $det(lambda I − A) = det(lambda I - B)$
    - $det(A) = det(B)$
  
])
== Orthogonally Diagonalizable
#concept-block(body: [
  - Square matric $A in RR^(n times n)$ is *orthogonally diagonalizable* if 
  $
  A = P D P^T
  $
  where $P$ is an orthogonal matrix, $P^(-1) = P^T$

  #inline("Spectral Theorem")
  - A is orthogonally diagonalizable $<=>$ A is symmetric.
  $
  A^T = (P D P^T)^T= (P^T)^T D^T P^T = P D P^T = A
  $

  #inline("Equivalent Statement for Orthogonally Diagonalizable")
    $A in RR^(n times n)$ is orthogonally diagonalizable $<=>$:
    - There exists *orthonormal* basis ${u_1, u_2, ..., u_n}$ of $RR^n$ of eigenvectors of A (implies P is invertible and $P^(-1)=P^T$)
    - A is symmetric matrix

  #inline("Eigenspaces of Symmetric Matrix are Orthogonal")
  -  Let $v_1$ be eigenvector associated to $lambda_1$ and $v_2$ be eigenvector associated to $lambda_2$ where $lambda_1 != lambda_2$,  $v_1$ and $v_2$ are orthogonal to each other.

  #inline("Algorithm to Orthogonal Diagnalization")
  1. Compute characteristic polynomial $"char"(A)$
  2. For each eigenvalue $lambda_i$, find basis $S_lambda_i$ which is $"null"(lambda I - A)$
  3. Apply GS process to each basis $S_lambda_i$ to obtain an orthonormal basis $T_lambda_i$
  4. Put everything together to form $A = P D P^T$
])

== Application of Diagonalization: Markov Chain
#concept-block(body: [
  #inline("Powers of Diagonalizable Matrix")
  $
  A^m = P D^m P^(-1), D^m = mat(d^m,0,0;
0,d^m, 0; 0,0,d^m)
  $

  #inline("Markov Chain")
  - *Probability Vector*, $v$ is vector with *non-negative* coordinates that adds up to 1. $sum^n_(i=1)v_i = 1$
  - *Stochastic Matrix*, $P$ is *square* matrix where columns are probability vectors.
  - *Markov Chain* is sequence of probability vectors, together with stochastic matrix such that
  $
  x_1 = P x_0, x_2 = P x_1, ..., x_k = P x_(k-1)
  $

  - *State vector*, $x_i$ is probability of outcome of a discrete case.

  $
  mat(0;0.4;0.6)=P mat(1;0;0), mat(0.5;0;0.5) = P mat(0;1;0), mat(0.6;0.4;0) = P mat(0;0;1) \ 
  => P = mat(0,0.5, 0.6; 0.4,0,0.4;
0.6,0.5,0) "which is diagonalizable" \
P = mat(1,-1,1;0.8,0,-2;1,1,1) mat(1,0,0;0,-0.6,0;0,0,-0.4) mat(1,-1,1;0.8,0,-2;1,1,1)^(-1) \
x_3 = P^3 x_0= A D^3 A^(-1) x_0 \
x_infinity = P^infinity x_0 =  A D^infinity A^(-1) x_0 "0.* -> infin = 0"
  $

  - *steady-state vector* or *equilibrium vector* for stochastic matrix P is probability vector that is an eigenvector associated to eigenvalue 1.

  #inline("PageRank Algorithm")
  - Let S be square adjacency matrix where
  $
  a_(i j) = cases(1 "if site j has outgoing link to site i",
0 "if site j has NO outgoing link to site i"
) \


A = (s_1, s_2, s_3, s_4) "where" s_1 "denotes cite with outgoing links to"
  $

  - Let P be probability transition matrix by dividing each entry of A by the sum of the entries in the same column, which means probability that one may click into another cite given all the links available.

  $
  p_(i j) = a_(i j)/ sum^n_(k=1) a_(k j)
  $
  - Notice that P is a stochastic matrix. Therefore, we may diagonalize P and use markov chain process to simulate the outcome in the long run.
  - The equilibrium vector is then used to determine the ranking of the sites with higher ranking for higher probability.

  #inline("Regular Stochastic Matrix")
  - A stochastic matrix is *regular* if for $k in RR > 0$, $P^k$ has positive values.
  - A regular stochastic matrix will always converge to a *unique equilibrium vector*.

  #inline("Compute Equilibrium Vector")
  - Find eigenvector $u$ associated to $lambda = 1$, that is find $"null"(I - P)$
  - "normalize" $v$ where $
  v = 1 / (sum^n_(k=1) u_k) u
  $

  #inline("Problem Solving Takeaway")
  - 1 is always eigenvalue of stochastic matrix as $A mat(1;1) = mat(1;1;)$ (t10, e1)
])

== Application of Diagonalization: Singular Value Decomposition
#concept-block(body: [
  Any non-square matrix $A in RR^(m times n)$ can *singular value decomposed*
    $
    A = U Sigma V^T
    $
    Where:
    - $U$ is $RR^(m times m)$ orthogonal matrix
    - $V$ is $RR^(n times n)$ orthogonal matrix wrt to Sigmas
    - $Sigma$ is $RR^(m times n)$ matrix in form
    $
    Sigma. = mat(D, 0_(r times (n-r)); 0_((m-r) times r), 0_((m-r) times (n-r)))
    $
    `
    [P D] = eig(A'*A)
    "rearrange D in descending order, >0"
    [P R] = qr(P)
    U = (1/sigma1 * A* P(:,1) 1/sigma2 * A* P(:,2) )
    [U R] = qr(U)
    `

  #inline("Sigular Values")
  - Let $A in RR^(m times n)$, $A^T A in RR^(n times n)$ is symmetric matrix that is orthogonally diagonalizable.

  - let $mu_i$ be eigenvalue associated to ${v_1, v_2, ..., v_m}$, an orthonormal basis for $RR^n$, consisting of eigenvectors of $A^T A$

  - Reordering the eigenvalues by descending order, singular values of A are
  $
  mu_1 >= mu_2 >= ... > mu_n > 0 \
  sigma_i >= sigma_2 >= ... > sigma_n > 0 \
  sigma_i = sqrt(mu_i) \

  Sigma = mat(D, 0_(r times (n-r)); 0_((m-r) times r), 0_((m-r) times (n-r))), \
  "where" D = mat(sigma_1, 0, ..., 0;
0, sigma_2, ..., 0; ...,...,...,...; 0,0,...,sigma_r) \
V = mat(v_1, v_2,..., v_r) "where" v_i "eigenvector of " sigma_i
  $

    - If V is not sufficient, we may extend V with orthogonal complement of span{v1, v2}
  `[V R]=qr([v1 v2])`
  - Using $Sigma$ and $V$, we may define $U$ where
  $
  u_i = 1/sigma_i A v_i
  $
  - Note that ${u_1, ..., u_r}$ form an orthonormal basis for column space of A, and rank(A) = r

  - Let $u_i = 1/sigma_i A v_i$, extend ${u_1, ..., u_r}$ to an orthonormal basis ${u_1, ..., u_r}$.
    - If U is not sufficient, we may extend U with its orthogonal complement ${u_r+1, ..., u_m}$ by solving $"null"(A^T)$
])

= Linear Transformation
== Introduction to Linear Transformation
#concept-block(body: [
  #inline("Intuition")
  Square matrix, $A in RR^(m times n)$ maps vector from $RR^n -> RR^m$
  - $mat(1,0;0,1;0,0)$ maps $mat(x;y) in RR^2$ to $mat(x;y;0) in RR^3$
  - Zero matrix $A in 0_(m times n)$ maps and $RR^n$ to $0 in RR^m$

  #inline("Linear Transformation")

  - Function $T: RR^n -> RR^m$ is linear transformation for $u,v in RR^n, alpha, beta in RR$
  $
  T(alpha u + beta v) = alpha T(u) + beta T(v)
  $

    - Domain: $RR^n$ (Input)
    - Codomain: $RR^m$ (Output)
    $
    A |-> T_A; \
    T_A(u) = A u forall u in RR^n
    $

    $
    T: RR^2 -> RR^3, T(mat(x;y)) = mat(x;y;0) \
    T(alpha mat(x_1; y_2)+ beta mat(x_2;y_2)) = T(mat(alpha x_1 + beta x_2; alpha y_1 + beta y_2)) \
    = mat(alpha x_1 + beta x_2; alpha y_1 + beta y_2; 0) \
    = alpha T(mat(x_1; y_2))+ beta T(mat(x_2;y_2))
    $

  #inline("Not a Linear Transformation")
  - A mapping $T: RR^n -> RR^m$ is not linear transformation if any of the following holds:
    1. T does not map zero vector to zero vector, $T(0) != 0$
    2. There is $alpha in RR, u in RR^n$ such that $T(alpha u)!= alpha T(u)$
    3. There are $u,v in RR^n$ such that $T(u+v) != T(u) + T(v)$
    $
    T: RR^2 -> RR^3, T(mat(x;y)) = mat(x;y;1) \
    T(mat(0;0)) = mat(0;0;1) != mat(0;0;0) \

    \
    T: RR^2 -> RR^3, T(mat(x;y)) = x y \
    T(2* mat(1;1)) = T(mat(2;2)) = 4 != 2(1) = 2 T(mat(1;1))
    $

    #inline("Standard Matrix")

*    Standard matrix/matrix representation* $A in RR^(m times n)$ is a linear mapping $T: RR^n -> RR^m <=>$ 
    $
    T(u) = A u, forall u in RR^n \
    "where"
    A = mat(T(e_1), T(e_2), ..., T(e_n)) \
    E = {e_1, e_2, ..., e_n} "is standard basis for "RR^n
    $

$
T(mat(x;y)) = mat(2x - 3x;x;5y) = x mat(2;1;0) + y mat(-3;0;5) \ 
= mat(2, -3; 1,0; 0,5) mat(x;y) \
A_T = mat(2, -3; 1,0; 0,5)
$

#inline("Linear Transformation with Respect to a Basis")
- *Representation of T with respect to basis S*, $[T]_S$ for $T : RR^n -> RR^m$ and $S = {u_1, u_2, ..., u_n}$ be basis for $RR^n$

$
[T]_S = mat(T(u_1), T(u_2), ..., T(u_n)) \

T(v) = [T]_S [v]_S \

A = [T]_E \
$
Moreover, $P_(E->S)$ is *transition matrix* from standard basis E to basis S, then
$
T(v) = [T]_S P v
 \ A = [T_S]P
 $
Proof: 
$
v = c_1 u_1 + c_2 u_2, [v]_S = mat(c_1; c_2) \
T(v) = c_1T(u_1) + c_2 T(u_2) = mat(T(u_1), T(u_2)) mat(c_1;c_2)=[T]_S [v]_S \
P, P v = [v]_S
$

Example:
$
T(mat(1;2;1)) = mat(2;6;6), T(mat(1;1;0)) = mat(4;8;2), T(mat(0;2;0))=mat(6;6;6) \
[T]_S = mat(T(u_1), T(u_2), T(u_3)) = mat(2,4,6;6,8,6;6,2,6) \
S = {mat(1;2;1), mat(1;1;0),mat(0;2;0) } = {[u_1]_E,[u_2]_E, [u_2]_E} \

P_(S -> E) = mat([u_1]_E, [u_2]_E, [u_3]_E), \
P_(E -> S) = P_(S -> E)^(-1) = mat(1,1,0;2,1,2;1,0,0)^(-1) \
A = [T]_S P =  mat(2,4,6;6,8,6;6,2,6) mat(1,1,0;2,1,2;1,0,0)^(-1) = mat(1,3,-5;5,3,-5;-1,3,1) \
T(mat(x;y;z)) = mat(x+3y-5z; 5x+3y-5z; -x+3y+z)
$

Parametrized Example:
$
T(mat(1;0;0)) = mat(1;2;1), T(mat(0;1;0))=mat(0;1;1), T(mat(1;1;0)) = mat(1;3;2) \
"Since" u_3 = u_1 + u_2, "i.e. linearly dependent" \
T(mat(x;y;z)) = mat(1,0,a;2,1,b;1,1,c)mat(x;y;z) = mat(x+a z; 2x + y + b z; x+y+c z)
$
])
== Range and Kernel of Linear Transformation
#concept-block(body: [
  #inline("Range of Linear Transformation")
  - *Range* of T, $R(T)$ is subspace, Column space of standard matrix A
  $
  R(T) = T(RR^n) = {v in RR^m | v = T(u) "for some" u in RR^n} \
  = {v = T(u) | u in RR^n} = {v = A u | u in RR^n} = "Col"(A)
  $

  - *Rank* of T is *dimension* of range of T
  $
  "rank"(T) = dim(R(T)) = dim("Col"(A)) = "rank"(A)
  $

  #inline("Kernel of Linear Transformation")
  - *Kernel* of T, $ker(T)$ is Null space of standard matrix A
  $
  ker(T) = {u in RR^n | T(u) = 0} \
  = {u in RR^n | A u = T(u) = 0} = "Null"(A)
  $

  - *Nullity* of T is dimension of the kernel of T
  $
  "nullity"(T) = dim(ker(T)) = dim("Null"(A)) = "nullity"(A)
  $

  #inline("Injectivity of Linear Transformation")

  - T in *injective, or one-to-one*, if for every $v in R(T)$, there is a unique $u in RR^n, T(u) = v$
  
  $
  T(u_1) = T(u_2) => u_1 = u_2 \
  T "is injective" <=> ker(T) = {0} \
  "A is full rank which is equals to number of columns"
  $

  #inline("Surjectivity of Linear Transformation")

  - T in *subjective or onto*, if for every $v in RR^m$ in codomain (output), there exists $u in RR^n$ such that T(u) = v

  $
  T "is surjective" => R(T) = RR^, "rank"(T) = m \
  "A is full rank which is equal to number of rows"
  $

  #inline("Bijective")
  - T is bijective if it is both injective and surjective
])

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
  - Columns/Rows of A are linearly independent
  - Columns/Rows of A spans $RR^n$
  - $"rank"(A) = n$ (A has full rank)
  - $"nullity"(A) = 0$
  - 0 is not eigenvalue of A
  - Linear transformation T defined by $A$ is injective
  - Linear transformation T defined by $A$ is surjective
  - Linear transformation T defined by $A$ is bijective  
])
== Full Rank Equals Number of Columns
#concept-block(body: [
  Following statements are equal for $A in RR^(m times n)$:
  - A is full rank where rank(A) = n (\# columns)
  - rows of A spans $RR^n$, Row(A) = $RR^n$
  - Columns of A are linearly independent
  - Ax=0 has only trivial solution, Null(A) = {0}
  - $A^T A$ is an invertible matrix of order n
  - $A$ has a left inverse (e.g. ($(A^T A)^(-1) A^T$)A)
  - Least square solution is unique
  - A is QR factorizable
  - Linear transformation T defined by A is injective
])
== Full Rank Equals Number of Rows
#concept-block(body: [
  Following statements are equal for $A in RR^(m times n)$:
  - A is full rank where rank(A) = m (\# rows)
  - Columns of A spans $RR^m$, Cow(A) = $RR^m$
  - Rows of A are linearly independent
  - Linear system Ax=b is consistent for every $b in RR^m$
  - $A A^T$ is an invertible matrix of order m
  - $A$ has a right inverse (e.g. A ($A^T (A A^T)^(-1)$))
  - Linear transformation T defined by A is surjective
])
