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
    P(A) = lim_{n -> infinity} frac{m}{n}
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