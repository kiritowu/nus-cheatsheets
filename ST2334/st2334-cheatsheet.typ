#import "@preview/boxed-sheet:0.1.2": *
#import "@preview/cetz:0.4.0"
#import "@preview/cetz-venn:0.1.4": venn2

#set text(font: (
  "Times New Roman",
))

#let homepage = link("https://kiritowu.github.io/")[https://kiritowu.github.io/]
#let author = "Zhao Wu"
#let title = "ST2334 Cheat Sheet, AY26/27 S1"

#show: boxedsheet.with(
  title: title,
  homepage: homepage,
  authors: author,
  write-title: true,
  title-align: left,
  title-number: true,
  title-delta: 2pt,
  scaling-size: false,
  font-size: 5.5pt,
  line-skip: 5.5pt,
  x-margin: 10pt,
  y-margin: 30pt,
  num-columns: 4,
  column-gutter: 2pt,
  numbered-units: false,
)

= Basic Concepts of Probability
// == Experiments, sample spaces, and events
// #concept-block[
//   - *Statistical Experiment* is a procedure that produces an observation.
//   - *Sample Space* is the set of all possible outcomes of a statistical experiment.
//   - *Event* is a subset of the sample space.
//   - *Sample Point* is a single outcome of a statistical experiment.

//   $
//     "Sample Point" subset.eq "Event" subset.eq "Sample Space"
//   $

//   #inline[Sure Event and Null Event]
//   - *Sure Event* = Sample Space, S
//   - *Null Event* = Empty Set / Complement of Sure Event
// ]
// == Event Operations & Relationships
// #concept-block[
//   - *Union* of A and B, ($A union B$)
//   $
//     A union B = {x in U | x in A or x in B}

//   $

//   - *Intersection* of A and B, ($A inter B$)
//   $
//     A inter B = {x in U | x in A and x in B}
//   $

//   - *Difference* of B minus A, ($B - A$)
//   $
//     B - A = {x in U | x in B and x in.not A} = B inter macron(A)
//   $

//   - *Complement* of A ($macron(A)$)
//   $
//     macron(A) = {x in S | x in.not A}
//   $

//   - *Mutually Exclusive or Disjoint* Events
//   $
//     A inter B = emptyset
//   $

//   #inline[Contained and Equivalent]

//   - *Contained $subset$*
//   $
//     A subset B <=> \
//     forall x, x in A => x in B
//   $

//   - *Equivalent $=$*
//   $
//     A = B <=> \
//     A subset B and B subset A
//   $

//   #inline[Subset Relations (Selected)]
//   #align(center)[
//     #table(
//       columns: 3,
//       stroke: 0.25pt + rgb("cccccc"),
//       inset: 3pt,
//       table.header[
//         *No.*
//       ][
//         *Law*
//       ][
//         *Identities*
//       ],

//       [7],
//       [De Morgan's laws],
//       [
//         $
//           & overline(A union B) = overline(A) inter overline(B) \
//           & overline(A inter B) = overline(A) union overline(B)
//         $
//       ],

//       [8],
//       [Absorption laws],
//       [
//         $
//           & A union (A inter B) = A \
//           & A inter (A union B) = A
//         $
//       ],
//     )]
// ]
// == Counting Methods
// #concept-block[
//   #inline[Multiplication and Addition Principles]
//   - *Multiplication Principle*: Sequence of r stages
//   $
//     n_1 times n_2 times dot times n_r = n_1n_2 dots n_r
//   $

//   - *Addition Principle*: k non-overlapping procedures 
//   $
//     n_1 + n_2 + ... + n_k = n_1 + n_2 + ... + n_k
//   $

//   #inline[Factorial, Permutations, and Combinations]
//   - *Factorial* ($n!$)
//   $
//     n! = n(n-1)(n-2)...2 dot 1
//   $

//   - *Permutation* ($P_r^n$):  Selection and arrangement of r objects from n objects
//   $
//     P_r^n = (n!)/((n-r)!)
//   $

//   - *Combination* ($binom(n,r)$): Selection of r objects from n objects
//   $
//     binom(n,r) = (n!)/(r!(n-r)!)
//   $
// ]
== Probability
#concept-block[
  *Probability* of an event A is a measure of the likelihood of the event occurring.

  *Relative frequency* of A, when experiment is repeated $n$ times and event A occurs $m$ times, approaches $P(A)$ as $n -> infinity$:
  $
    P(A) = lim_{n -> infinity} m / n
  $

  $
    0 <= P(A) <= 1
  $
  $
    P(S) = 1
  $
  $
    P(A union B) = P(A) + P(B) - P(A inter B)
  $

  // #inline[Properties of Probability]
  // #align(center)[
  //   #table(
  //     columns: 3,
  //     stroke: 0.25pt + rgb("cccccc"),
  //     inset: 3pt,
  //     table.header[
  //       *Prop.*
  //     ][
  //       *Name*
  //     ][
  //       *Statement*
  //     ],

  //     [1.4],
  //     [Empty set],
  //     [$P(emptyset) = 0$],

  //     [1.5],
  //     [Finite additivity],
  //     [
  //       If $A_i inter A_j = emptyset$ for $i != j$, then
  //       $
  //         P(A_1 union dots union A_n) = P(A_1) + dots + P(A_n)
  //       $
  //     ],

  //     [1.6],
  //     [Complement],
  //     [$P(macron(A)) = 1 - P(A)$],

  //     [1.7],
  //     [Partition of $A$],
  //     [$P(A) = P(A inter B) + P(A inter macron(B))$],

  //     [1.8],
  //     [Inclusion-exclusion],
  //     [$P(A union B) = P(A) + P(B) - P(A inter B)$],

  //     [1.9],
  //     [Monotonicity],
  //     [$A subset B => P(A) <= P(B)$],

  //     [1.10],
  //     [Union bound (Boole's inequality)],
  //     [
  //       $
  //         P(A_1 union dots union A_n) <= P(A_1) + dots + P(A_n)
  //       $
  //     ],
  //   )]
]
== Conditional Probability

#concept-block[
  *Conditional Probability* ($P(A | B)$) is probability of A occurring given that B occurred.

  $
    P(A | B) = P(A inter B) / P(B)= (P(A)P(B|A)) / P(B)
  $

  #inline[Simpson's Paradox]
  Phenomenon where a trend appears in different groups of data but disappears or reverses when the groups are combined. Or formally,
  $
    P(A | B inter C_i) >= P(A | B' inter C_i) forall i
  "but"
    P(A | B ) < P(A | B')
  $

  #inline[Multiplication Rule]
  $
    P(A inter B) = P(A | B) P(B) "if" P(B) > 0
  $
]

== Independence
#concept-block[
  Events A and B are *independent*, $A perp B <=>$ 
  $
    P(A inter B) = P(A) P(B)
  $

  Tautologies:
  - Suppose P(A) > 0 and P(B) > 0, If $A perp B$, then $A$ and $B$ are not mutually exclusive (aka $A inter B != emptyset$)
  - $S perp A$ for all events $A$; $emptyset perp A$ for all events $A$
  - If $A perp B$, then $A perp B'$, $A' perp B$, $A' perp B'$
  - Independence cannot be expressed in terms of venn diagram
]

== Bayes' Theorem
#concept-block[
  $
    P(A | B) = P(A inter B) / P(B) = (P(B | A) P(A)) / (sum^n_{i=1} P(B | A_i) P(A_i)) 
  $

  #inline[Law of Total Probability]

  Suppose $A_1, A_2, ..., A_n$ is a partition of the sample space $S$
  $
  P(B) = sum_{i=1}^n P(B inter A_i) = sum^n_{i=1} P(B | A_i) P(A_i) \
  P(B) = P(A) P(B | A) + P(A') P(B | A')
  $
]

= Random Variable
#concept-block([
*Random Variable* is a function that transform a sample from sample space to a real number.

$
  X: S -> RR : s in S "and" X(s) = x in RR
$

*Range space of X* is set of real numbers that satisfies

$
  R_X = {x | X(s)=x forall s in S} : R_X in RR
$

*Subsets of Sample Space*
$
  {X = x} = {s in S : X(s) = x}, {X=x}in S \
  {X in A} = {s in S : X(s) in A}, {X in A} in S
$
])

== Probability Distribution
#concept-block([
  #inline[Probability Mass Function (pmf)]
  *Discrete random variable* $X_D$, when $R_X = {x_1, x_2, ...}$ is finite or countable.

  *pmf, $f(x)$* for ${X=x}$
  $
    f(x) = cases(P(X=x) | forall x in R_X, 0 | forall x in.not R_X)
  $

  Well-defined pmf for discrete random variable $X$:
  1. $forall x_i in R_X, f(x_i) >= 0$
  2. $forall x_i in.not R_X, f(x_i) = 0$
  3. $sum^infinity_(i=1) f(x_i) = sum_(x_i in R_X) f(x_i) = 1$

  #inline[Probability Density Function (pdf)]

  *Continuous random variable* $X_C$, when $R_X in [a,b]$ is an interval(s).

  *pdf, $P(a<=X<=b)$* for any $a$ and $b$ such that $a<= b$
  $
    P(a <= X <= b) = integral^b_a f(x) d x
  $

  Well-defined pdf for continuous random variable $X$:
  1. $forall x in R_X,  f(x) >= 0$
  2. $forall x in.not R_X,  f(x) = 0$
  3. $integral_(R_X) f(x) d x = 1$

  Other key properties,
  - Specific point is zero: $P(X=x_i) = integral^(x_i)_(x_i) f(x) d x = 0$
  - Endpoint doesn't matter: $P(a <= X <= b) = P(a < X < b)$
])
== Cumulative Distribution Function
#concept-block([
  *Cumulative Distribution Function (cdf), F(x)* for any random variable X is defined as
  $
    F(x) = P(X <= x) = cases(f(0)+f(1)+...+f(x) "if X is discrete", integral_(-infinity)^x f(t) d t "if X is continuous")
  $

  $
    P(a<= X<=b) = P(X<= b) - P(X< a) = F(b) - F(a-) \
    P(X=x) = P(x <= X <= x) = F(x) - F(x-) 
  $

  Let $F(x) = integral^x_(-infinity) f(t) d t$
  $
    f(x) = F'(x) = (d)/(d x) integral^x_(-infinity) f(t) d t
  $
])
== Expectation and Variance
#concept-block([
*Expectations* or mean of X is defined by: ($mu_X $ may not be in $R_X$)
$
  mu_X = E(X) = sum_(x_i in R_X) x_i f(x_i) 
  = integral x f(x) d x
$


Properties of Expectation:
1. $E(a X + b) = a E(X) + b$
2. $E(X + Y) = E(X)+ E(Y)$
3. $E[g(X)] = sum_(x in R_X) g(x) f(x) " or " integral g(x) f(x) d x$
4. $E(x^2) = sum x^2 f(x)$

#inline[Variance]
*Variance* of X is defined as $sigma_X^2$
$
  sigma_X^2 = V(X) = E[(X-mu_X)^2] = E(X^2) - [E(X)]^2\
  = sum_(x in R_X) (x-mu_X)^2 f(x) " or " integral^infinity_(-infinity) (x-mu_X)^2 f(x) d x \
$

*Standard deviation* of X is defined as $sigma_X$
$
  sigma_X = sqrt(V(X))
$

Properties of Variance:
- $V(a X + b) = a^2 V(X)$
])

= Joint Distribution
#concept-block[
 - *n-dimentional random variable, $(X,Y, ...)$* $= (X(s), Y(s), ...) forall s in S$
 - *Range Space* $R_(X,Y) = {(x,y) | x = X(s), y = Y(s), forall s in S}$
 - *Discrete / Continuous* two-dimensional random variable depends if *both* random variable is countable and finite or vice-versa.
]

== Joint, Marginal and Conditional Distribution
#concept-block[
 *Joint probability (mass) function, jpf* is defined by $(x,y) in R_(X,Y)$
 $
   f_(X,Y) (x,y) = P(X=x, Y=y)
 $

 Well-defined jpf $X,Y$ of both discrete and continuous random variable satisfies:
 1. $f_(X,Y) (x,y) >= 0, forall (x,y) in R_(X,Y)$
 2. $f_(X,Y) (x,y) = 0, forall (x,y) in.not R_(X,Y)$
 3. $sum^infinity_(i=1) sum^infinity_(j=1) f_(X,Y) (x_i, y_i) = sum^infinity_(i=1) sum^infinity_(j=1) P(X = x_i, Y =y_j) = integral^infinity_(-infinity) integral^infinity_(-infinity) f_(X,Y) (x,y) d x d y = 1$

#inline[Marginal Probability Distribution]

  *Marginal Probability Distribution* of X is defined as sum of $f(y)$ after fixing $X=x$
  $
    f_X (x) = sum_y f_(X,Y) (x,y) = integral^infinity_(-infinity) f_(X,Y) (x,y) d y
  $

  - $f_X (x)$ satisfies all properties of probability function

  #inline[Conditional probability Function]
  
  *Conditional Probability function* of $Y$ given $X=x$ is defined as
  $
    f_(Y | X) (y | x) = (f_(X,Y) (x, y)) / (f_X (x))
  $

  - $f_(Y | X) (y | x)$ is defined only for $x$ such that $f_X (x) > 0$ 
  - $f_(Y | X) ( y | x)$ is not a probability function and therefore, sum $!=$ 1
  
  Applications:
  - $P(Y <= y | X = x) = integral^y_(-infinity) f_(Y|X) (t|x) d t$
  - Regression function $E(Y | X=x) = integral^infinity_(-infinity) y f_(Y|X) (y|x) d y$
  
]

== Independent Random Variables
#concept-block[
  Random variable $X perp Y$ are *independent* $<=>$
  $
    f_(X, Y) (x,y) = f_X (x) f_Y (y) \
    <=> "both of the following holds"
  $
  1. $R_(X,Y)$ spans *Product Space* $R_(X,Y) = {(x,y) | x in R_X, y in R_Y} =  R_X times R_Y$, when probability function is positive.
  2. $forall (x,y) in R_(X,Y)$
    $
      f_(X,Y) (x,y) = c dot g_1(x) dot g_2(y)
    $
    where $g_1$ depends only on $x$, $g_2$ depends only on $y$, and $c$ is constant

  Let $X perp Y$
  - $P(X in A; Y in B) = P(X in A) P (Y in B)$
  - $P(X <= x ; Y <= y) = P(X <= x) P(Y<=y)$
  - Let $g 1(.), g 2 (.)$ be arbitrary functions, $g 1 (X), g 2 (Y)$ are independent
  - $f_X (x) > 0 => f_(Y | X) ( y | x) = f_Y (y)$
]

== Expectation, Covariance and Correlation Coefficient
#concept-block[
  *Expectation*, $E(g(X,Y))$:
  $
    E(g(X,Y)) = sum_x sum_y g(x,y) f_(X,Y) (x,y) = integral^infinity_(-infinity) integral^infinity_(-infinity) g(x,y) f_(X,Y) (x,y) d y d x
  $

  *Covariance*, $"cov"(X,Y)$
  $
    "cov"(X,Y) = sum_x sum_y (x-mu_x) (y-mu_y) f_(X,Y) (x,y) \
    = E[(X-mu_X) (Y-mu_Y)] = E(X Y) - mu_X mu_Y
  $

  Properties of covariance:
  - $X perp Y => "cov" (X,Y) = 0$, converse is not true
  - $X perp Y => E(X Y) = E(X) E(Y)$
  - $"cov"(a X + b, c Y + d) = a c dot "cov"(X,Y)$
  - $"cov"(X,Y) = "cov"(Y,X)$


  *Correlation Coefficient*, $rho (X,Y)$
  $
    rho (X,Y) = ("cov"(X,Y))/ (sigma_X sigma_Y), 
    -1 <= rho (X,Y) <= 1
  $
  
  Properties of joint-variance:
  - $V(X plus.minus Y) = V(X) + V(Y) plus.minus 2 "cov"(X,Y)$
  - $V(a X + b Y) = a^2 V(X) b^2 V(Y) - 2 a b "cov"(X,Y)$
  - $V(X_1 + X_2 + ... + X_n) = V(X_1) + V(X_2) + ... + V(X_n) + 2 sum_(j>i) "cov"(X_i, X_j)$
]

= Probability Distribution
== Discrete Probability Distribution
#concept-block[

  #block(breakable: false)[
  $q = 1 - p$
  #table(
    columns: (0.85fr, 1.1fr, 1.4fr, 0.85fr),
    inset: (x: 2.5pt, y: 2.5pt),
    align: left + horizon,
    stroke: 0.4pt,
    [Distribution], [pmf], [cdf], [$E(X), V(X)$],
    [Discrete uniform $U(k)$],
    [$ f(x) = 1/k, x in R_x $],
    [$ F(x) = frac(|{x_i <= x}|, k) $],
    [$ E(X) = frac(sum_i x_i, k) \ V(X) = frac(sum_i x_i^2, k) - mu^2 $],
    [Bernoulli \ $X in {0,1}$],
    [$ f(x) = p^x q^(1-x) $],
    [$ F(0)=q, F(1)=1 $],
    [$ E(X)=p \ V(X)=p q $],
    [$"Bin"(n,p)$ \ \# successes],
    [$ f(x) = binom(n,x) \ p^x q^(n-x) $],
    [$ F(x) = sum_(i=0)^x binom(n,i) \ p^i q^(n-i) $],
    [$ E(X)=n p \ V(X)=n p q $],
    [$"NB"(k,p)$ \ \# trials to $k$ successes],
    [$ f(x) = binom(x-1,k-1) \ p^k q^(x-k) $],
    [$ F(x) = sum_(i=k)^x binom(i-1,k-1) \ p^k q^(i-k) $],
    [$ E(X)=k/p \ V(X)=(k q)/p^2 $],
    [$"Geom"(p)="NB"(1,p)$ \ \# trials to 1st success],
    [$ f(x) = q^(x-1) p $],
    [$ F(x) = 1 - q^x $],
    [$ E(X)=1/p \ V(X)=q/p^2 $],
    [$"Poisson"(lambda)$ \ \# events in an interval],
    [$ f(x) = frac(e^(-lambda) lambda^x, x!) $],
    [$ F(x) = sum_(i=0)^x frac(e^(-lambda) lambda^i, i!) $],
    [$ E(X)=lambda \ V(X)=lambda $],
    [Poisson process \ $lambda = alpha T$],
    [same as Poisson],
    [same as Poisson],
    [$ E(X)=alpha T \ V(X)=alpha T $],
  )
  ]

  #inline[Approximate Binomial using Poisson Distribution]
  As $n->infinity$ and $p -> 0$ but $lambda = n p$ remains constant, We may approximate $X ~ "Bin"(n,p)$ with $X~"Poisson"(n,p)$
  $
    lim_(p->0; n->infinity) P(X=x) = (e^(-n p) (n p)^x)/(x!)
  $

  Condition to use:
  $
    n>= 20 and p <= 0.05 "or" n>=100 and n p <= 10
  $
]

== Continuous Probability Distribution
#concept-block[
 #inline[Continuous Uniform Distribution, $X~U(a,b)$]
  $
    f_X (x) = cases(
      1/(b-a) & a<=x<=b,
      0 & "otherwise"),
    quad E(x) = (a+b)/2,
    quad V(X) = (b-a)^2/12
  $

  $
    F_X (x) = cases(0 " "x<a, (x-a)/(b-a) " " a<= x <= b, 1 " "x>b)
  $


 #inline[Exponential Distribution, $X ~ "Exp"(lambda)$]
X be waiting time until the next event when events occur independently at a constant average rate.
For $lambda > 0$, $lambda$ is the average event rate, Mean waiting time is $E(X) = 1/lambda$.
$
  f_X (x) = cases(
    lambda e^(-lambda x) & "if " x >= 0,
    0                     & "if " x < 0,
  ),
  quad E(X) = 1/lambda,
  quad V(X) = 1/lambda^2
$

$
  F_X (x) = P(X <= x)
  = cases(
    1 - e^(-lambda x) & "if " x >= 0,
    0                  & "if " x < 0,
  )
$

Hence, for $x >= 0$,
$
  P(X > x) = e^(-lambda x)
$

Let $mu = 1/lambda$. Then
$
  f_X (x) = cases(
    1/mu e^(-x/mu) & "if " x >= 0,
    0               & "if " x < 0,
  )
$

$
  E(X) = mu,
  quad V(X) = mu^2,
  quad F_X (x) = 1 - e^(-x/mu)
$

 #inline[Normal Distribution, $X~N(mu, sigma^2)$]
 $
   f_X (x) = 1/(sqrt(2 pi ) sigma) e^(-(x-mu)^2/(2sigma^2)), -infinity < x < infinity, E(X) = mu, V(X) = sigma^2 \
   Z = (X-mu)/(sigma) \
   Phi(z) = F_Z (z) = P(Z < z) = integral^z_(-infinity) 1/sqrt(2pi) e^(-t^2/2) d t \ 
   P(x_1 < X < x_2) = Phi((x_2-mu)/sigma) - Phi((x_1-mu)/sigma) \
   P(Z<-z) = P(Z>=z) = 1-Phi(z)
 $
 Quartile $alpha$
 $
   P(Z >= z_alpha) = alpha
 $

 #inline[Approximate Binomial using Normal Distribution]
 As $n -> infinity$ and $p$ is constant, we may approximate binomial distribution using normal distribution.

 $
   Z = (X - E(X))/(sqrt(V(X))) = (X - n p )/ (sqrt(n p (1-p)))
 $

 Use when $n p > 5$ and $n (1 - p) > 5$

 Continuity Correction
  $
P(X = k) approx P(k - 1/2 < X < k + 1/2)
$

$
P(a <= X <= b) &approx P(a - 1/2 < X < b + 1/2) \
P(a < X <= b)  &approx P(a + 1/2 < X < b + 1/2) \
P(a <= X < b)  &approx P(a - 1/2 < X < b - 1/2) \
P(a < X < b)   &approx P(a + 1/2 < X < b - 1/2)
$

$
P(X <= c) = P(0 <= X <= c)
approx P(-1/2 < X < c + 1/2)
$

$
P(X > c) = P(c < X <= n)
approx P(c + 1/2 < X < n + 1/2)
$ 

]

// = Live Session Application Formulas

// // ============================================================
// // WEEK 1
// // ============================================================

// == Week 1: Counting & Probability

// #concept-block[
//   #inline[Problem 1: Knuth's Poker Test]

//   5-digit sequence, $|S| = 10^5 = 100000$. $n$ tested groups, pattern prob. $p$ $=>$ expected count $approx n p$.
//   $
//     P("all diff") = frac(10 dot 9 dot 8 dot 7 dot 6, 10^5) = 0.3024, quad
//     P("one pair") = frac(binom(5,2) dot 10 dot 9 dot 8 dot 7, 10^5) = 0.504 \
//     P("two pairs") = frac(binom(10,2) binom(5,2) binom(3,2) dot 8, 10^5) = 0.108, quad
//     P("3-kind") = frac(binom(5,3) dot 10 dot 9 dot 8, 10^5) = 0.072 \
//     P("full house") = frac(binom(5,3) dot 10 dot 9, 10^5) = 0.009, quad
//     P("4-kind") = frac(binom(5,4) dot 10 dot 9, 10^5) = 0.0045 \
//     P("5-kind") = frac(10,10^5) = 0.0001, quad
//     P("repeat") = 1 - P("all diff") = 0.6976
//   $

//   #inline[Problem 2: Fisher-Yates & Fixed Points]

//   $n$ shuffled elements: $|S| = n!$, $P("one permutation") = 1/n!$. $A_i$: element $i$ stays in its original position (fixed point).
//   $
//     P(A_i) = frac((n-1)!,n!) = frac(1,n), quad
//     P(A_(i_1) inter dots inter A_(i_k)) = frac((n-k)!,n!), quad
//     binom(n,k) frac((n-k)!,n!) = frac(1,k!) \
//     P("fail") = P("at least one fixed point") = sum_(k=1)^n frac((-1)^(k+1),k!)
//     approx 1-frac(1,e) approx 0.6321 "for large" n
//   $

// // #inline[Problem 3: One-Time Pad]

// // Encryption:
// // $
// //   C = X xor K
// // $

// // with fair independent key $K$:
// // $
// //   P(X=x,C=c)
// //   =
// //   frac(1,2) P(X=x)
// // $

// // Hence
// // $
// //   P(C=c)=frac(1,2)
// //   quad "and" quad
// //   X perp C
// // $

// // Reusing the same key:
// // $
// //   C_1 = X_1 xor K,
// //   quad
// //   C_2 = X_2 xor K
// // $

// // $
// //   C_1 xor C_2
// //   =
// //   X_1 xor X_2
// // $
// ]


// // ============================================================
// // WEEK 2
// // ============================================================

// == Week 2: Conditional Probability & Bayes

// #concept-block[
//   #inline[Problem 1: Selection Sampling]

//   $N$: total records; $n$: sample size; $t$: records remaining; $m$: selections still required.
//   $
//     P("keep") = frac(m,t), quad
//     P("skip") = frac(t-m,t), quad
//     P("keep first") = frac(binom(N-1,n-1), binom(N,n)) = frac(n,N) \
//     P("any particular final" n"-subset") = frac(n!(N-n)!, N!) = frac(1,binom(N,n))
//   $

//   #inline[Problem 2: Fair Bits from Biased Input]

//   $P(1)=p$, $P(0)=q=1-p$. Independent raw bits: $P(01)=q p = p q = P(10)$. Accept $A={01,10}$:
//   $
//     P(O=1 | A) = frac(p q,q p+p q) = frac(1,2) = P(O=0 | A), quad
//     P(A)=2p(1-p) \
//     N "raw bits:" E("output bits") = frac(N,2) dot 2p(1-p) = N p(1-p) \
//     "Efficiency:" eta(p) = p(1-p) = frac(1,4) - (p-frac(1,2))^2 <= frac(1,4)
//   $

//   #inline[Problem 3: Demand after Two Studies]

//   $D in {L,M,H}$: demand state; $C$: favourable survey; $T$: successful temporary pop-up. Conditional independence: $P(C inter T | D) = P(C|D)P(T|D)$.
//   $
//     P(D | C inter T) = frac(P(C inter T | D)P(D), P(C inter T)), quad
//     P(C inter T) = sum_(D in {L,M,H}) P(D)P(C inter T | D) \
//     => P(D | C inter T) = frac(P(D)P(C|D)P(T|D), sum_(d in {L,M,H}) P(d)P(C|d)P(T|d))
//   $

//   #inline[Problem 4: Naive Bayes]

//   Class $S$, observed features $E_i$ (e.g. $F,M$), conditional independence $P(F inter M | S) = P(F|S)P(M|S)$. $w_S$: prior $times$ feature likelihoods.
//   $
//     w_S = P(S) product_i P(E_i | S), quad
//     P(S | E) = frac(w_S, sum_c w_c), quad
//     "two classes:" P(S|E) = frac(w_S,w_S+w_(S'))
//   $
// ]


// // ============================================================
// // WEEK 3
// // ============================================================

// == Week 3: Random Variables & Expectation

// #concept-block[
//   #inline[Problem 1: Record Updates in Maximum Search]

//   $R_i$: position $i$ is a new record maximum, $P(R_i)=1/i$, $I_i = 1_{R_i}$. Record updates $X = sum_(i=1)^n I_i$; $H_n$: $n$th harmonic number.
//   $
//     E(X) = sum_(i=1)^n frac(1,i) = H_n, quad
//     ln(n+1) <= H_n <= 1+ln n \
//     "Pairwise indep.:" P(R_i inter R_j) = frac(1,i j) = P(R_i)P(R_j), quad
//     V(X) = H_n - sum_(i=1)^n frac(1,i^2)
//   $

//   #inline[Problem 2: Bit Flips in a Binary Counter]

//   $m$: number of bits; $X$: number of bits changed after adding 1.
//   $
//     P(X=k)=frac(1,2^k) (1 <= k < m), quad
//     P(X=m)=frac(1,2^(m-1)), quad
//     P(X>=k)=frac(1,2^(k-1)) \
//     E(X) = sum_(k=1)^m P(X>=k) = 1+frac(1,2)+frac(1,4)+dots+frac(1,2^(m-1)) = 2-frac(2,2^m)
//   $

//   #inline[Problem 3: Inverse-CDF Sampling]

//   General: $U ~ U(0,1)$, $X = F_X^(-1)(U)$. Pareto $f_X(x)=2/x^3$, $x>=1$:
//   $
//     F_X(x)=1-frac(1,x^2), quad
//     1-frac(1,X^2)=U => X=frac(1,sqrt(1-U)) \
//     E(X)=2 "but" E(X^2)=infinity => V(X)=infinity
//   $

//   #inline[Problem 4: Completing a Collection]

//   $d$ equally likely designs; after $j-1$ designs collected:
//   $
//     p_j = frac(d-j+1,d), quad
//     W_j ~ "Geom"(p_j), quad
//     E(W_j) = frac(1,p_j) = frac(d,d-j+1) \
//     T=sum_(j=1)^d W_j => E(T) = d (1+frac(1,2)+dots+frac(1,d)) = d H_d
//   $
// ]


// // ============================================================
// // WEEK 4
// // ============================================================

// == Week 4: Joint Distributions

// #concept-block[
//   #inline[Problem 1: First & Last Response Times]

//   $U=min(T_1,T_2)$, $V=max(T_1,T_2)$, remaining wait $D=V-U$.
//   $
//     f_T(t) = lambda^2 t e^(-lambda t), t>=0, quad
//     S(t) = P(T>t) = e^(-lambda t)(1+lambda t) \
//     0<u<v: f_(U,V)(u,v) = 2 f_T(u) f_T(v) = 2 lambda^4 u v e^(-lambda(u+v)), quad
//     f_U(u) = 2 f_T(u) S(u) \
//     f_(V|U)(v|u) = frac(f_(U,V)(u,v),f_U(u)) = frac(f_T(v),S(u)), quad
//     E(V|U=u) = u+frac(u+2/lambda,1+lambda u) \
//     E(D|U=u) = frac(1,lambda) (1+frac(1,1+lambda u))
//   $

//   #inline[Problem 2: Runs in a Random Permutation]

//   Descent indicator $D_i = 1_{A_i>A_(i+1)}$; runs $R=1+sum_(i=1)^(n-1) D_i$. Non-adjacent descents have covariance 0.
//   $
//     P(D_i=1)=frac(1,2), V(D_i)=frac(1,4) => E(R)=frac(n+1,2) \
//     P(D_i=1,D_(i+1)=1)=frac(1,6) => "cov"(D_i,D_(i+1)) = frac(1,6)-frac(1,4) = -frac(1,12) \
//     V(R) = (n-1)frac(1,4) + 2(n-2)(-frac(1,12)) = frac(n+1,12)
//   $

//   #inline[Problem 3: One-Time Pad]

//   $C=X xor K$ with fair independent key $K$: $P(X=x,C=c) = 1/2 P(X=x)$ $=>$ $P(C=c)=1/2$ and $X perp C$. Reusing the same key: $C_1=X_1 xor K$, $C_2=X_2 xor K$ $=>$ $C_1 xor C_2 = X_1 xor X_2$.

//   #inline[Problem 4: Sampling Without Replacement]

//   $N$: population size; $n$: fixed sample size; $p=n/N$.
//   $
//     P(I_i=1)=frac(n,N), quad
//     P(I_i=1,I_j=1) = frac(binom(N-2,n-2), binom(N,n)) = frac(n(n-1),N(N-1)) \
//     "cov"(I_i,I_j) = -frac(n(N-n), N^2(N-1)) = -frac(p(1-p),N-1), quad
//     rho(I_i,I_j) = -frac(1,N-1)
//   $
// ]


// // ============================================================
// // WEEK 5
// // ============================================================

// == Week 5: Discrete Distribution Models

// #concept-block[
//   #inline[Problem 1: Choosing a Packet Length]

//   $b$: payload bits; $h$: overhead bits; $q$: per-bit error probability.
//   $
//     "Corrupted bits" X_b ~ "Bin"(b+h,q), quad
//     "success" s_b = P(X_b=0) = (1-q)^(b+h) \
//     "1 packet:" N ~ "Geom"(s_b), E(N)=frac(1,s_b), quad
//     r "packets:" T_r ~ "NB"(r,s_b), E(T_r)=frac(r,s_b) \
//     "Transmitted bits per useful data bit:" C(b) = frac(b+h,b s_b) = frac(1+h/b,(1-q)^(b+h)) \
//     a=-ln(1-q): b^* = frac(sqrt(h^2+4h/a)-h, 2), quad
//     "rare errors:" b_"opt" approx sqrt(frac(h,q))
//   $

//   #inline[Problem 2: Streaming Sample Replacements]

//   Reservoir size $k$; arrival index $i$: $P(I_i=1)=k/i$, $I_i ~ "Bernoulli"(k/i)$. Replacements from $m+1$ through $n$:
//   $
//     R_(m,n) = sum_(i=m+1)^n I_i, quad
//     lambda_(m,n) = E(R_(m,n)) = k sum_(i=m+1)^n frac(1,i) approx k ln frac(n,m) \
//     V(R_(m,n)) = lambda_(m,n) - k^2 sum_(i=m+1)^n frac(1,i^2), quad
//     R_(m,n) approx "Poisson"(lambda_(m,n))
//   $
// ]


// // ============================================================
// // WEEK 6
// // ============================================================

// == Week 6: Continuous Distribution Models

// #concept-block[
//   #inline[Problem 1: Restarting a Task]

//   $X$: fresh attempt duration; $s$: elapsed time. Expected remaining time $r(s) = E(X-s | X>s)$; restart when $r(s)>E(X)$.
//   $
//     X~U(0,b) => r(s)=frac(b-s,2), quad
//     X~"Exp"(lambda) => r(s)=frac(1,lambda) \
//     "Pareto" f_X(x)=2/x^3: r(s)=s, E(X)=2 => "restart when" s>2 \
//     "Repeated timeout" T: m(T) = frac(E(min(X,T)), P(X<=T))
//   $

//   #inline[Problem 2: Uniform Sampling in a Disk]

//   $R_0$: disk radius; $R$: sampled radial distance; independent $U,V~U(0,1)$.
//   $
//     P(R<=r) = frac(r^2,R_0^2), quad
//     R=R_0 sqrt(U), quad theta=2 pi V, quad
//     X=R cos theta, quad Y=R sin theta
//   $

//   #inline[Problem 3: Gaussian Pairs / Box-Muller]

//   Independent $X,Y~N(0,1)$; independent $U,V~U(0,1)$.
//   $
//     f_(X,Y)(x,y) = frac(1,2 pi) e^(-(x^2+y^2)/2), quad
//     P(R>r) = e^(-r^2/2), quad
//     R=sqrt(-2 ln U), quad theta=2 pi V \
//     X = sqrt(-2 ln U) cos(2 pi V), quad
//     Y = sqrt(-2 ln U) sin(2 pi V)
//   $

//   #inline[Problem 4: Benford's Law]

//   Fractional log $U = log_10 X - floor(log_10 X)$, model $U~U(0,1)$. Leading digit $D=d$ iff $log_10 d <= U < log_10(d+1)$:
//   $
//     P(D=d) = log_10(d+1)-log_10 d = log_10 (1+frac(1,d)), d=1,dots,9 \
//     P(D=1) approx 0.301, quad P(D=9) approx 0.046
//   $
// ]
