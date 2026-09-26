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
== Experiments, sample spaces, and events
#concept-block[
  - *Statistical Experiment* is a procedure that produces an observation.
  - *Sample Space* is the set of all possible outcomes of a statistical experiment.
  - *Event* is a subset of the sample space.
  - *Sample Point* is a single outcome of a statistical experiment.

  $
    "Sample Point" subset.eq "Event" subset.eq "Sample Space"
  $

  #inline[Sure Event and Null Event]
  - *Sure Event* = Sample Space, S
  - *Null Event* = Empty Set / Complement of Sure Event
]
== Event Operations & Relationships
#concept-block[
  - *Union* of A and B, ($A union B$)
  $
    A union B = {x in U | x in A or x in B}

  $

  - *Intersection* of A and B, ($A inter B$)
  $
    A inter B = {x in U | x in A and x in B}
  $

  - *Difference* of B minus A, ($B - A$)
  $
    B - A = {x in U | x in B and x in.not A} = B inter macron(A)
  $

  - *Complement* of A ($macron(A)$)
  $
    macron(A) = {x in S | x in.not A}
  $

  - *Mutually Exclusive or Disjoint* Events
  $
    A inter B = emptyset
  $

  #inline[Contained and Equivalent]

  - *Contained $subset$*
  $
    A subset B <=> \
    forall x, x in A => x in B
  $

  - *Equivalent $=$*
  $
    A = B <=> \
    A subset B and B subset A
  $

  #inline[Subset Relations]
  #align(center)[
    #table(
      columns: 3,
      stroke: 0.25pt + rgb("cccccc"),
      inset: 3pt,
      table.header[
        *No.*
      ][
        *Law*
      ][
        *Identities*
      ],

      [1],
      [Commutative laws],
      [
        $
          & A union B = B union A \
          & A inter B = B inter A
        $
      ],

      [2],
      [Associative laws],
      [
        $
          & (A union B) union C = A union (B union C) \
          & (A inter B) inter C = A inter (B inter C)
        $
      ],

      [3],
      [Distributive laws],
      [
        $
          & A union (B inter C) = (A union B) inter (A union C) \
          & A inter (B union C) = (A inter B) union (A inter C)
        $
      ],

      [4],
      [Identity laws],
      [
        $
          & A inter U = A \
          & A inter emptyset = emptyset \
          & A union U = U \
          & A union emptyset = A
        $
      ],

      [5],
      [Complement laws],
      [
        $
          & overline(overline(A)) = A \
          & A inter overline(A) = emptyset \
          & overline(U) = emptyset
        $
      ],

      [6],
      [Idempotent laws],
      [
        $
          & A union A = A \
          & A inter A = A
        $
      ],

      [7],
      [De Morgan's laws],
      [
        $
          & overline(A union B) = overline(A) inter overline(B) \
          & overline(A inter B) = overline(A) union overline(B)
        $
      ],

      [8],
      [Absorption laws],
      [
        $
          & A union (A inter B) = A \
          & A inter (A union B) = A
        $
      ],
    )]
]
== Counting Methods
#concept-block[
  #inline[Multiplication and Addition Principles]
  - *Multiplication Principle*

    A sequence of r stages with n_1, n_2, ..., n_r choices has n_1n_2...n_r outcomes.
  $
    n_1 times n_2 times dot times n_r = n_1n_2 dots n_r
  $

  - *Addition Principle*

    k non-overlapping procedures with $n_1, n_2, ..., n_k$ outcomes have $n_1 + n_2 + ... + n_k$ outcomes in total.
  $
    n_1 + n_2 + ... + n_k = n_1 + n_2 + ... + n_k
  $

  #inline[Factorial, Permutations, and Combinations]
  - *Factorial* ($n!$)


  $
    n! = n(n-1)(n-2)...2 dot 1
  $

  - *Permutation* ($P_r^n$)

    Selection and arrangement of r objects from n objects, where order matters.
  $
    P_r^n = (n!)/((n-r)!)
  $

  - *Combination* ($binom(n,r)$)

    Selection of r objects from n objects, where order does not matter.
  $
    binom(n,r) = (n!)/(r!(n-r)!)
  $
]
== Probability
#concept-block[
  Probability of an event A is a measure of the likelihood of the event occurring.

  #inline[Relative Frequency]

  Suppose an experiment is repeated n times and event A occurs m times. The relative frequency of A is given by:
  $
    P(A) = lim_{n -> infinity} m / n
  $

  As n increases, the relative frequency of A approaches the probability of A.

  #inline[Axiomatic Definition of Probability]

  A probability function P is a function that assigns a number P(A) to each event A in the sample space S, such that:
  $
    0 <= P(A) <= 1
  $
  $
    P(S) = 1
  $
  $
    P(A union B) = P(A) + P(B) - P(A inter B)
  $

  #inline[Properties of Probability]
  #align(center)[
    #table(
      columns: 3,
      stroke: 0.25pt + rgb("cccccc"),
      inset: 3pt,
      table.header[
        *Prop.*
      ][
        *Name*
      ][
        *Statement*
      ],

      [1.4],
      [Empty set],
      [$P(emptyset) = 0$],

      [1.5],
      [Finite additivity],
      [
        If $A_i inter A_j = emptyset$ for $i != j$, then
        $
          P(A_1 union dots union A_n) = P(A_1) + dots + P(A_n)
        $
      ],

      [1.6],
      [Complement],
      [$P(macron(A)) = 1 - P(A)$],

      [1.7],
      [Partition of $A$],
      [$P(A) = P(A inter B) + P(A inter macron(B))$],

      [1.8],
      [Inclusion-exclusion],
      [$P(A union B) = P(A) + P(B) - P(A inter B)$],

      [1.9],
      [Monotonicity],
      [$A subset B => P(A) <= P(B)$],

      [1.10],
      [Union bound (Boole's inequality)],
      [
        $
          P(A_1 union dots union A_n) <= P(A_1) + dots + P(A_n)
        $
      ],
    )]
]
== Conditional Probability

#concept-block[
  - *Conditional Probability* ($P(A | B)$)
  Probability of event A occurring given that event B has occurred.

  #inline[Definition of Conditional Probability]
  $
    P(A | B) = P(A inter B) / P(B)
  $

  #inline[Simpson's Paradox]
  A phenomenon where a trend appears in different groups of data but disappears or reverses when the groups are combined. Or formally,
  $
    P(A | B inter C_i) >= P(A | B' inter C_i) forall i
  "but"
    P(A | B ) < P(A | B')
  $

  #inline[Multiplication Rule]
  $
    P(A inter B) = P(A | B) P(B) "if" P(B) > 0 \
    "or" P(A inter B) = P(B | A) P(A) "if" P(A) > 0
  $

  #inline[Inverse Probability Formula]
  $
    P(A|B) = (P(A)P(B|A)) / P(B)
  $
]

== Independence
#concept-block[
  Events A and B are independent, $A perp B <=>$ 
  $
    P(A inter B) = P(A) P(B)
  $

  Tautologies:
  - Suppose P(A) > 0 and P(B) > 0, If $A perp B$, then $A$ and $B$ are not mutually exclusive (aka $A inter B != emptyset$)
  - Suppose P(A) > 0 and P(B) > 0, If $A$ and $B$ are mutually exclusive, then $A cancel(perp) B$.
  - $S perp A$ for all events $A$
  - $emptyset perp A$ for all events $A$
  - If $A perp B$, then $A perp B'$, $A' perp B$, $A' perp B'$
  - Independence cannot be expressed in terms of venn diagram
]

== Law of Total Probability
#concept-block[
  Suppose $A_1, A_2, ..., A_n$ is a partition of the sample space $S$
  $
  P(B) = sum_{i=1}^n P(B inter A_i) = sum^n_{i=1} P(B | A_i) P(A_i) \
  P(B) = P(A) P(B | A) + P(A') P(B | A')
  $
]
== Bayes' Theorem
#concept-block[
  $
    P(A | B) = P(A inter B) / P(B) = (P(B | A) P(A)) / (sum^n_{i=1} P(B | A_i) P(A_i)) 
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

Set of all sample such that the result of its random variable is $x$.
$
  {X = x} = {s in S : X(s) = x}, {X=x}in S
$

Set of all sample such that the result of ites random variable is in $A$.
$
  {X in A} = {s in S : X(s) in A}, {X in A} in S
$
])

== Probability Distribution
#concept-block([
  #inline[Probability Mass Function (pmf)]
  *Discrete random variable*, the number of $R_X = {x_1, x_2, ...}$ is finite or countable.

  *pmf, $f(x)$* is defined as probability for ${X=x}$
  $
    f(x) = cases(P(X=x) | forall x in R_X, 0 | forall x in.not R_X)
  $

  Well-defined pmf for discrete random variable $X$:
  1. $forall x_i in R_X, f(x_i) >= 0$
  2. $forall x_i in.not R_X, f(x_i) = 0$
  3. $sum^infinity_(i=1) f(x_i) = sum_(x_i in R_X) f(x_i) = 1$

  Let $B in R_X$
  $
    P(X in B) = sum_(x_i in B and R_X) f(x_i)
  $

  #inline[Probability Density Function (pdf)]

  *Continuous random variable*, $R_X in [a,b]$ is an interval or a collection of intervals

  Well-defined pmf for continuous random variable $X$
  1. $forall x in R_X,  f(x) >= 0$
  2. $forall x in.not R_X,  f(x) = 0$
  3. $integral_(R_X) f(x) d x = integral^infinity_(-infinity) f(x) d x = 1$
  
  For any $a$ and $b$ such that $a<= b$
  $
    P(a <= X <= b) = integral^b_a f(x) d x
  $

  Consequently,
  - $P(X=x_i) = integral^(x_i)_(x_i) f(x) d x = 0 forall x_i$: Specific point is zero
  - $P(a <= X <= b) = P(a < X < b)$: Endpoint doesn't matter
])
== Cumulative Distribution Function
#concept-block([
  *Cumulative Distribution Function (cdf), F(x)* for any random variable X is defined as
  $
    F(x) = P(X <= x) = cases(f(0)+f(1)+...+f(x) "if X is discrete", integral_(-infinity)^x f(t) d t "if X is continuous")
  $

  Let $a<b, x in R_x$
  $
    P(a<= X<=b) = P(X<= b) - P(X< a) = F(b) - F(a-) \
    P(X=x) = f(x) = P(x <= X <= x) = F(x) - F(x-) 
  $

  Let $F(x) = integral^x_(-infinity) f(t) d t$
  $
    f(x) = F'(x) = (d)/(d x) integral^x_(-infinity) f(t) d t
  $
])
== Expectation and Variance
#concept-block([
#inline[Expectations]
Expectations or mean of X is defined by
$
  mu_X = E(X) = sum_(x_i in R_X) x_i f(x_i) 
  = integral x f(x) d x
$

- $mu_X $ may not be in $R_X$

#inline[Properties of Expectation]
1. $E(a X + b) = a E(X) + b$
2. $E(X + Y) = E(X)+ E(Y)$
3. $E[g(X)] = sum_(x in R_X) g(x) f(x) " or " integral g(x) f(x) d x$

#inline[Variance]
Variance of X is defined as $sigma_X^2$
$
  sigma_X^2 = V(X) = E[(X-mu_X)^2] = E(X^2) - [E(X)]^2\
  = sum_(x in R_X) (x-mu_X)^2 f(x) " or " integral^infinity_(-infinity) (x-mu_X)^2 f(x) d x \
$

Standard deviation of X is defined as $sigma_X$
$
  sigma_X = sqrt(V(X))
$

#inline[Properties of Variance]
- $V(a X + b) = a^2 V(X)$
])

= Joint Distribution
#concept-block[
 - *Two/n-dimentional random variable, $(X,Y)$* $= "Given " s in S, (X(s), Y(s), ...)$
 - *Range Space* $R_(X,Y) = {(x,y) | x = X(s), y = Y(s), forall s in S}$
 - *Discrete / Continuous* two-dimensional random variable depends if both random variable is countable and finite or not
 
 #inline[Joint Probability Function]

 *Joint probability (mass) function, jpf* is defined by $(x,y) in R_(X,Y)$
 $
   f_(X,Y) (x,y) = P(X=x, Y=y)
 $

 Well-defined jpf $X,Y$ of both discrete and continuous random variable satisfies:
 1. $f_(X,Y) (x,y) >= 0, forall (x,y) in R_(X,Y)$
 2. $f_(X,Y) (x,y) = 0, forall (x,y) in.not R_(X,Y)$
 3. $sum^infinity_(i=1) sum^infinity_(j=1) f_(X,Y) (x_i, y_i) = sum^infinity_(i=1) sum^infinity_(j=1) P(X = x_i, Y =y_j) = integral^infinity_(-infinity) integral^infinity_(-infinity) f_(X,Y) (x,y) d x d y = 1$
 4. $P((X,Y) in A) = sum sum_((x,y) in A) f_(X,Y) (x,y) = integral integral _((x,y) in D) f_(X,Y) (x,y) d y d x$ 
]

== Marginal and Conditional Distribution
#concept-block[
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

  Properties:
  - $f_(Y | X) (y | x)$ is defined only for x such that $f_X (x) > 0$ 
  - $f_(Y | X) ( y | x)$ is not a probability function and therefore, does not need to satisfy requirement of sum = 1
  
  Applications:
  - $P(Y <= y | X = x) = integral^y_(-infinity) f_(Y|X) (t|x) d t$
  - $E(Y | X=x) = integral^infinity_(-infinity) y f_(Y|X) (y|x) d y$ aka regression function
]

== Independent Random Variables
#concept-block[
  Random variable $X$ and $Y$ are independent
  $
    X perp Y <=> f_(X, Y) (x,y) = f_X (x) f_Y (y) \
    <=> "both of the following holds"
  $
  - $R_(X,Y)$ is a *Product Space* when probability function is positive $R_(X,Y) = {(x,y) | x in R_X, y in R_Y} =  R_X times R_Y$
  - $forall (x,y) in R_(X,Y)$
    $
      f_(X,Y) (x,y) = c dot g_1(x) dot g_2(y)
    $
    where $g_1$ depends only on $x$, $g_2$ depends only on $y$, and $c$ is constant

  Suppose $X,Y$ are independent variable:
  - $P(X in A; Y in B) = P(X in A) P (Y in B)$
  - $P(X <= x ; Y <= y) = P(X <= x) P(Y<=y)$
  - Let $g 1(.), g 2 (.)$ be arbitrary functions, $g 1 (X), g 2 (Y)$ are independent
  - $f_X (x) > 0 => f_(Y | X) ( y | x) = f_Y (y)$
]

== Expectation and Covariance
#concept-block[
  Expectation:
  $
    E(g(X,Y)) = sum_x sum_y g(x,y) f_(X,Y) (x,y) = integral^infinity_(-infinity) integral^infinity_(-infinity) g(x,y) f_(X,Y) (x,y) d y d x
  $

  *Covariance*, $"cov"(X,Y)$
  $
    "cov"(X,Y) = sum_x sum_y (x-mu_x) (y-mu_y) f_(X,Y) (x,y) \
    = E[(X-mu_X) (Y-mu_Y)] = E(X Y) - mu_X mu_Y
  $

  Properties:
  - $X perp Y => "cov" (X,Y) = 0$, converse is not true
  - $X perp Y => E(X Y) = E(X) E(Y)$
  - $"cov"(a X + b, c Y + d) = a c dot "cov"(X,Y)$
  - $"cov"(X,Y) = "cov"(Y,X)$
  - $V(a X + b Y) = a^2 V(X) b^2 V(Y) + 2 a b "cov"(X,Y)$

  Correlation Coefficient $rho (X,Y)$
  $
    rho (X,Y) = ("cov"(X,Y))/ (sigma_X sigma_Y) \
    -1 <= rho (X,Y) <= 1
  $
  
  Properties:
  $V(X+Y) = V(X) + V(Y) + 2 "cov"(X,Y)$
  - $V(X plus.minus Y) = V(X) + V(Y)$
  - $V(X_1 + X_2 + ... + X_n) = V(X_1) + V(X_2) + ... + V(X_n) + 2 sum_(j>i) "cov"(X_i, X_j)$
  - $V(X_1 plus.minus X_2) = V(X_1) + V(X_2)$
]