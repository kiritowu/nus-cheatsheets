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

  #inline[Subset Relations (Selected)]
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
  - *Multiplication Principle*: Sequence of r stages
  $
    n_1 times n_2 times dot times n_r = n_1n_2 dots n_r
  $

  - *Addition Principle*: k non-overlapping procedures 
  $
    n_1 + n_2 + ... + n_k = n_1 + n_2 + ... + n_k
  $

  #inline[Factorial, Permutations, and Combinations]
  - *Factorial* ($n!$)
  $
    n! = n(n-1)(n-2)...2 dot 1
  $

  - *Permutation* ($P_r^n$):  Selection and arrangement of r objects from n objects
  $
    P_r^n = (n!)/((n-r)!)
  $

  - *Combination* ($binom(n,r)$): Selection of r objects from n objects
  $
    binom(n,r) = (n!)/(r!(n-r)!)
  $
]
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
  - $V(a X + b Y) = a^2 V(X) b^2 V(Y) + 2 a b "cov"(X,Y)$


  *Correlation Coefficient*, $rho (X,Y)$
  $
    rho (X,Y) = ("cov"(X,Y))/ (sigma_X sigma_Y), 
    -1 <= rho (X,Y) <= 1
  $
  
  Properties of joint-variance:
  - $V(X+Y) = V(X) + V(Y) + 2 "cov"(X,Y)$
  - $V(X plus.minus Y) = V(X) + V(Y)$
  - $V(X_1 + X_2 + ... + X_n) = V(X_1) + V(X_2) + ... + V(X_n) + 2 sum_(j>i) "cov"(X_i, X_j)$
  - $V(X_1 plus.minus X_2) = V(X_1) + V(X_2)$
]

= Probability Distribution
== Discrete Probability Distribution
#concept-block[

  #table(columns: 5,
  [Distribution Name], [X], [pmf], [E(x)], [V(x)],
  [Discrete uniform distribution, U(k)], [none], [$f(x) = cases(1/k forall x in R_x, 0 "otherwise")$], [$1/k sum^k_(i=1) x_i$], [$(1/k )sum^k_(i=1)x_i^2 - mu_X^2$],
  [Bernoulli Trial], [$X=cases(1 "if boleh", 0 "if fail")$], [$f(x) = p^(x) (1-p)^(1-x)$], [$p$], [$p q = p(1-p)$],
  [Binomial Distribution, $"Bin"(n,p)$], [X=Number of success], [$f(x) = binom(n,x) p^x q^(n-x)$], [$n p$], [$n p q$],
  [Negative Binomial Distribution, $"NB"(k,p)$], [X=Number of trial], [$f(x) = binom(x-1, k-1) p^k q^(x-k)$], [$k/p$], [$((1-p)k)/p^2$],
  [Geometric Distribution, $"Geom"(p) = "NB"(1,p)$], [X=Number of trial till 1st success], [$f(x)=(1-p)^(x-1)p$], [$1/p$], [$(1-p)/p^2$],
  [Poisson Distribution, $"Poisson"(lambda)$], [X=Number of event occured in fixed time, $lambda=$Expected number of occurence], [$f(x) = (e^(-lambda) lambda^x)/x!$], [$lambda$], [$lambda$],
  [Poisson Process, $"Poisson"(alpha T)$], [X=Number of event occured in fixed time], [$f(x) = (e^(-(alpha T)) (alpha T)^x)/x!$], [$alpha T$], [$alpha T$]
  )

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
    f_X (x) = cases(1/(b-a) a<=x<=b, 0 "otherwise"),
    quad E(x) = (a+b)/2,
    quad V(X) = (b-a)^2/12
  $

  $
    F_X (x) = cases(0 " "x<a, (x-a)/(b-a) " " a<= x <= b, 1 " "x>b)
  $


 #inline[Exponential Distribution, $X ~ "Exp"(lambda)$]
Model the waiting time until the next event when events occur independently at a constant average rate.
For $lambda > 0$, $lambda$ is the average event rate, Mean waiting time is $E(X) = 1/lambda$.
$
  f_X(x) = cases(
    lambda e^(-lambda x) & "if " x >= 0,
    0                     & "if " x < 0,
  ),
  quad E(X) = 1/lambda,
  quad V(X) = 1/lambda^2
$

$
  F_X(x) = P(X <= x)
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
  f_X(x) = cases(
    1/mu e^(-x/mu) & "if " x >= 0,
    0               & "if " x < 0,
  )
$

$
  E(X) = mu,
  quad V(X) = mu^2,
  quad F_X(x) = 1 - e^(-x/mu)
$

 #inline[Normal Distribution, $X~N(mu, sigma^2)$]
 $
   f_X (x) = 1/(sqrt(2 pi ) sigma) e^(-(x-mu)^2/(2sigma^2)), -infinity < x < infinity, E(X) = mu, V(X) = sigma^2 \
   Z = (X-mu)/(sigma) \
   phi(z) = f_Z (z) =1/sqrt(2pi) exp(-z^2/2) \ 
   P(x_1 < X < x_2) = phi((x_2-mu)/sigma) - phi((x_1-mu)/sigma) \
   P(Z<z) = P(Z>=-z) = 1-phi(-z)
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