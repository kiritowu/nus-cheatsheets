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
    P_r^n = frac{n!}{(n-r)!}
  $

  - *Combination* ($binom(n,r)$)

    Selection of r objects from n objects, where order does not matter.
  $
    binom(n,r) = frac{n!}{r!(n-r)!}
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
  #inline[Probability Function (pf) or Probability Mass Function (pmf)]

  *Probability Function (pf), $f(x)$* is defined as probability for ${X=x}$ if $x in R_X$
  $
    f(x) = cases(P(X=x) | forall x in R_X, 0 | forall x in.not R_X)
  $


  #inline[Discrete Random Variable]

  *Discrete random variable*, the number of $R_X$ is finite or countable. $R_X = {x_1, x_2, ...}$
  
  A well defined pf for a discrete random variable X satisfies all the following condition:
  1. $f(x_i) >= 0, forall x_i in R_X$
  2. $f(x_i) = 0, forall x_i in.not R_X$
  3. $sum^infinity_(i=1) f(x_i) = 1$ or $sum_(x_i in R_X) f(x_i) = 1$

  Let $B in R_X$
  $
    P(X in B) = sum_(x_i in B and R_X) f(x_i)
  $

  
  #inline[Continuous Random Variable]

  *Continuous random variable*, $R_X$ is an interval or a collection of intervals

  A well defined  pf for a continuous random variable X satisfies all the following condition:

  1. $f(x) >= 0 forall x in R_X$ and $f(x) = 0 forall x in.not R_X$
  2. $integral_(R_X) f(x) d x = integral^infinity_(-infinity) f(x) d x = 1$


  For any $a$ and $b$ such that $a<= b$
  $
    P(a <= X <= b) = integral^b_a f(x) d x
  $
])
== Cumulative Distribution Function
#concept-block([
  *Cumulative Distribution Function, F(x)* for any random variable X is defined as
  $
    F(x) = P(X <= x) = cases(f(0)+f(1)+...+f(x) "if X is discrete", integral_(-infinity)^x f(t) d t "if X is continuous")
  $

  Let $a<b$
  $
    P(a<= X<=b) = P(X<= b) - P(X< a) = F(b) - F(a-) \
    F(a-) = lim_(x->a+) F(x) \
    f(x) = F(x) - F(x-)
  $

  $
    F(x) = integral^x_(-infinity) f(t) d t \
    f(x) = (d)/(d x) F(x) \
    F(b) - F(a) = P(a < x < b)
  $
])
== Expectation and Variance
#concept-block([
#inline[Expectations]
Expectations or mean of X is defined by
$
  mu_X = E(X) = sum_(x_i in R_X) x_i f(x_i) \
  = integral_(x in R_X) x f(x) d x
$

$mu_X $ may not be in $R_X$

#inline[Properties of Expectation]
1. $E(a X + b) = a E(X) + b$
2. $E(X + Y) = E(X)+ E(Y)$
3. $E[g(X)] = sum_(x in R_X) g(x) f(x) = integral_(R_X) g(x) f(x) d x$

#inline[Variance]
Variance of X is defined as $mu_X^2$
$
  mu_X^2 = V(X) = E[(X-mu_X)^2]\
  = sum_(x in R_X) (x-mu_X)^2 f(x) \
  = integral^infinity_(-infinity) (x-mu_X)^2 f(x) d x \
 = V(X) = E(X^2) - [E(X)]^2 \
  "where" E(X^2) = sum_(x_i in R_X) x_i^2 f(x_i)
$

Alternatively,
$
$

Standard deviation of X is defined as $sigma_X$
$
  sigma_X = sqrt(V(X))
$

Properties of Variance
- $V(a X + b) = a^2 V(X)$
])