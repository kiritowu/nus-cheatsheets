#import "@preview/boxed-sheet:0.1.1": *
#import "@preview/cetz:0.4.0"
#import "@preview/cetz-venn:0.1.4": venn2

#set text(font: (
  "Times New Roman",
))

#let homepage = link("https://kiritowu.github.io/")[https://kiritowu.github.io/]
#let author = "Zhao Wu"
#let title = "CS1231S | Cheat Sheet"

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

= Proof
== Statements and Logical Equivalence
#concept-block(body: [
  #inline("Statement / Proposition")

  *Statement* (or *Proposition*) is a sentence, that is either *True or False, but not both*.

  - A sentence with open ended variable (e.g. $x^2 +2 = 11$) is not a statement as its truth value depends on $x$.


  #inline("Compound Statements")
  *Compound statement* (or boolean expression) is a statement, constructed from *statement variables* by using *negation* (not), *conjunction* (and) and *disjunction* (or).

  - *Negation Statement*, "Not", ($~ \/ not$)
  $
    ~ p "is" cases(
      "true if" p "is false",
      "false if" p "is true"
    )
  $

  - *Conjunctive Statement*, "And / But / Neither-nor", ($and \/ inter$)
  $
    p and q "is" cases(
      "true if" p "is true and" q "is true",
      "false if otherwise (either p or q is false)"
    )
  $
  - *Disjunctive Statement*, "Or / Either-or", ($or \/ union$)

  $
    p or q "is" cases(
      "true if" p "is true or" q "is true",
      "false if otherwise (p and q are false)"
    )
  $
  *Order of operation for Logical Operators*
  1. $~$
  2. $and, or$ are co-equal in order of operations
  3. $=>, <=>$ are co-equal in order of operations

  #inline("Logical Equivalence")
  Statement $P$ and $Q$ are *logically equivalent ($P equiv Q$)*  $<=>$ they have the same truth values for all substitution of statements for their statement variables.

  To show nonequivalence, construct a truth-table with a sentence of explanation where the truth values of both statements are not the same.

  #inline("Tautologies, t and Contradictions, c")
  *Tautology, $t$* is statement that is *always true* regardless of truth values of individual statement variables.

  *Contradiction, $c$* is a statement that is *always false* regardless of the truth values of individual statement variables.

  === Theorem: Logical Equivalences
  #align(center)[
    #table(
      columns: 3,
      stroke: 0.25pt + rgb("cccccc"),
      table.header[
        *No.*
      ][
        *Law*
      ][
        *Equivalences*
      ],
      [1],
      [Commutative laws],
      [
        $
          & p and q equiv q and p \
          & p or q equiv q or p
        $
      ],

      [2],
      [Associative laws],
      [
        $
          & p and (q and r) equiv (p and q) and r \
          & p or (q or r) equiv (p or q) or r
        $
      ],

      [3],
      [Distributive laws],
      [
        $
          & p and (q or r) equiv (p and q) or (p and r) \
          & p or (q and r) equiv (p or q) and (p or r)
        $
      ],

      [4],
      [Identity laws],
      [
        $
          & p and bold(t) equiv p \
          & p or bold(c) equiv p
        $
      ],

      [5],
      [Negation laws],
      [
        $
          & p or ~p equiv bold(t) \
          & p and ~p equiv bold(c)
        $
      ],

      [6],
      [Double negative law],
      [
        $~(~p) equiv p$
      ],

      [7],
      [Idempotent laws],
      [
        $
          & p and p equiv p \
          & p or p equiv p
        $
      ],

      [8],
      [Universal bound laws],
      [
        $
          & p or bold(t) equiv bold(t) \
          & p and bold(c) equiv bold(c)
        $
      ],

      [9],
      [De Morgan's laws],
      [
        $
          & ~(p and q) equiv ~p or ~q \
          & ~(p or q) equiv ~p and ~q
        $
      ],

      [10],
      [Absorption laws],
      [
        $
          & p or (p and q) equiv p \
          & p and (p or q) equiv p
        $
      ],

      [11],
      [Negation of true and false],
      [
        $
          & ~bold(t) equiv bold(c) \
          & ~bold(c) equiv bold(t)
        $
      ],
    )]
])

== Conditional Statements
#concept-block(body: [

  #inline("Conditional Statement")
  *Conditional statement* is a compound statement that denote the causal relationship between a *hypothesis* $p$, and *conclusion* $q$.

  $
    p -> q; " if p then q; p only if q"
  $

  #align(center)[
    #table(
      columns: 3,
      [$p$], [$q$], [$p -> q$],
      [T], [T], [T],
      [T], [F], [F],
      [F], [T], [T],
      [F], [F], [T],
    )
  ]

  NOTE: For last 2 rows, since hypothesis $p$ is false, the overall conditional statement $p -> q$ is *vacuously true* (aka *true by default*).

  $
    p -> q equiv ~ p or q \
    ~ (p -> q) equiv ~(~ p or q) "(De Morgan's Law)" equiv p and ~ q
  $

  - Variations of if/then statements:
    - *If* p *then* q: $p -> q$
    - p *only if* q: $p -> q$
    - p *if* q: $q -> p$
    - p *if and only if* q: $p <-> q$

  #inline("Converse, Inverse, Contrapositive")

  Given conditional statement $p -> q$, there are a few notable variant:
  - *Conditional*, $p -> q$ $equiv$ *Contrapositive*: $~ q -> ~ p$
  - *Converse*: $q -> p$ $equiv$ *Inverse*: $~ p -> ~ q$

  #inline("Biconditional Statement")

  *Bidirectional Statement*, if and only if, is true only when both $p$ and $q$ has the same truth values.
  $
    p <-> q; " p if and only if q"
  $

  #align(center)[
    #table(
      columns: 3,
      [$p$], [$q$], [$p <-> q$],
      [T], [T], [T],
      [T], [F], [F],
      [F], [T], [F],
      [F], [F], [T],
    )
  ]

  $
    p <-> q equiv (p -> q) and (q -> p)
  $

  #inline("Necessary and Sufficient Conditions")
  $r$ is *Necessary Condition* for $s$ means if not r then not s ($not r -> not s$)

  $r$ is *Sufficient Condition* for $s$ means if r then s ($r -> s$)



])
== Valid and Invalid Arguments
#concept-block(body: [
  #inline("Definition of Valid Argument, Premise, Conclusion")
  - *Argument*: sequence of statements.
  - *Argument Form*: sequence of statement forms.
  - *Premise / Assumptions / Hypothesis*: all statements in an argument except the final one.
  - *Conclusion*: final statement in an argument, normally preceded with $therefore$.
  - *Valid Argument*: For all statement variables substituted to its premises, the resulting premises are all true and conclusion is also true. ($forall x in union, P(x) and C(x)$).
  - *Invalid Argument*: Exists at least one premise, where after substituted to its statement variable, its conclusion is not true ($exists x in union, P(x) and ~C(x)$).
  - *Critical Row*: Row in truth-table where all premises are true but conclusion is false.

  #inline("Modues Ponens and Modus Tollens")

  - *Modus ponens* "method of affirming":
  $
    p -> q "(If its raining, ground is wet)"\
    p "(It is raining)"\
    therefore q "(Ground is wet)"
  $
  - *Modus tollens* "method of denying":
  $
    p -> q "(If its raining, ground is wet)"\
    ~q "(Ground is not wet)"\
    therefore ~p "It is not raining"
  $
  #inline("Rule of Inference")
  === Theorem: Valid Argument Form
  #align(center)[


    #table(
      columns: 4,
      stroke: 0.25pt + rgb("cccccc"),
      inset: 3pt,
      table.header(
        table.cell(
          [
            *Rule of Inference*
          ],
          colspan: 4,
        ),
      ),
      [Modus Ponens],
      [
        $
          & p -> q \
          & p \
          & therefore q
        $
      ],

      [Modus Tollens],
      [
        $
          & p -> q \
          & ~q \
          & therefore ~p
        $
      ],

      [Generalization],
      [
        $
          & p | q \
          & therefore p or q
        $
      ],

      [Specialization],
      [
        $
          & p and q \
          & therefore p | q
        $
      ],

      [Conjunction],
      [
        $
          & p \
          & q \
          & therefore p and q
        $
      ],

      [Elimination],
      [
        $
          & p or q \
          & ~q | ~p \
          & therefore p | q
        $
      ],

      [Transitivity],
      [
        $
          & p => q \
          & q => r \
          & therefore p => r
        $
      ],

      [Proof by division\ into cases],
      [
        $
          & p or q \
          & p -> r \
          & q -> r \
          & therefore r " "(x^2 > 0)
        $
      ],

      [Contradiction rule],
      [
        $
          & ~p -> "false" \
          & therefore p
        $
      ],
    )
  ]

  #inline("Fallacies")
  - *Converse Error*
  $
    p -> q \
    q \
    therefore p "(Invalid as p may be true or false)"
  $
  - *Inverse Error*
  $
    p -> q \
    ~p \
    therefore ~q "(Invalid as q may be true or false)"
  $


])

== Predicates and Quantification
#concept-block(body: [
  #inline("Predicates")
  *Predicates, (P(x), Q(x,y))* is a sentence with a finite number of predicate variables, that become a statement when its value is substituted.

  *Domain* of predicate variable is set of all values that may be substituted in place of the variable.

  *Truth set* of P(x) is set of all element in domain $D$ where $P(x)$ is true.
  $
    {x in D | P(x)}
  $

  #inline("Universal and Existential Quantifier")
  - *Universal Statement*:"_for every_", ($forall x in S$)
    - *Universal Conditional Statement*:
      - E.g. _#underline[For every]_ animal $a$, #underline[_if_] $a$ is a dog, #underline[_then_] $a$ is a mammal
      - Which can also be written purely conditional or universal:
        - #underline[_If_] an animal $a$ is a dog, #underline[_then_] $a$ is a mammal
        - #underline[_For every_] dog $a$, $a$ is a mammal
    - *Universal Existential Statement*:
      - E.g. #underline[_There exists_] additive inverse #underline[_for every_] real number / #underline[_Every_] real number #underline[_has an_] additive inverse
    - *Existential Statement*: "there exist", ($exists x in S$)

  #inline("Equivalent Forms of Universal and Existential Statements")

  $
    forall x in U, P(x) -> Q(x) \
    equiv forall x in U, ~Q(x) -> ~P(x) "(By Contraposition)" \
    equiv forall x in D, Q(x) "where" D = {x in U | P(x)}
  $

  #inline("Implicit Quantification")

  - $P(x) => Q(x)$ suggests every element in truth set of P(x) is in truth set of Q(x),
    $equiv forall x, P(x) -> Q(x)$

  - $P(x) <=> Q(x)$ suggest P(x) and Q(x) has identical truth sets, $equiv forall P(x) <-> Q(x)$

  #inline("Proving and Negation of Quantifier")

  #align(center)[
    #table(
      columns: 3,
      stroke: 0.25pt + rgb("cccccc"),
      inset: 3pt,
      [], [True], [False],
      [$forall$], [Exhaustive List], [Counter-example],
      [$exists$], [Example], [Exhaustive List],
    )
  ]

  $
    ~(forall x in D, Q(x)) equiv exists x in D, ~Q(x) \
    ~(exists x in D, Q(x)) equiv forall x in D, ~Q(x)
  $

  #inline("Quantified Rules of Inference")

  #align(center)[
    #table(
      columns: 2,
      stroke: 0.25pt + rgb("cccccc"),
      inset: 3pt,
      table.header(table.cell([*Quantified Rule of Inference*], colspan: 2)),
      [Universal Instantiation],
      [
        $
          & forall x in D, P(x) \
          & a in D \
          & therefore P(a)
        $
      ],

      [Universal Generalization],
      [
        $
          & P(a) "for every" a in D \
          & therefore forall x in D, P(x)
        $
      ],

      [Existential Instantiation],
      [
        $
          & exists x in D, P(x) \
          & therefore P(a) "for some" a in D
        $
      ],

      [Existential Generalization],
      [
        $
          & P(a) "for some" a in D \
          & therefore exists x in D, P(x) \
        $
      ],

      [Universal Modus Ponens],
      [
        $
          & forall x (P(x) => Q(x)) \
          & P(a) "for a particular" a \
          & therefore Q(a)
        $
      ],

      [Universal Modus Tollens],
      [
        $
          & forall x (P(x) => Q(x)) \
          & ~Q(a) "for a particular" a \
          & therefore ~P(a)
        $
      ],

      [Universal Transitivity],
      [
        $
          & forall x (P(x) => Q(x)) \
          & forall x (Q(x) => R(x)) \
          & therefore forall x (P(x) => R(x))
        $
      ],
    )
  ]

  #inline("One-to-One and On-To")

  - *One-to-one* function, $f: X -> Y <=> forall x_1, x_2, x_1 = x_2 -> f(x_1) = f(x_2)$
  (i.e. same input, same output)

  - *Onto* function, $f: X -> Y <=> forall y in Y, exists x in X "where" y = f(x)$
  (i.e. every output has an input)

  #inline("Well-Ordering Principle")
  - Let $S$ be nonempty set of integers
  - If there exists integer $ZZ$ smaller than all integer in S, then there is an integer in S that is smaller or equal to all integers in S.
])

== Mathematical reasoning
#concept-block(body: [
  #inline("Direct Proof")
  - *Question*: Proof that Sum of any two even integers is even

  - *Formal Restatement* $forall m in ZZ, n in ZZ "Even"(m) and "Even"(n) -> "Even"(m+n)$

  - *Starting Point*: Suppose $m$ is even and $n$ is even
  - By definition of even number, m = 2j, n = 2k for some integer j, k.
  - $
      m+n = 2j + 2k \
      2 (j+k)
    $
  - Let $t = j+k$, $t$ is integer as it is sum (and products) of integers.
  - $therefore m+n = 2t$ and by definition, m + n is even [`Q.E.D.; quod erat demonstratdum`]

  #inline("Proof by Cases")
  - Divide the statement to prove into smaller cases that are more easily provable, then show that the statement is true for each case, hence since the cases cover the complete domain, the statement must be true.

  #concept-block(
    body: [
      #inline("Example")
      Prove: The only divisors of 1 are 1 and -1

      Proof by division into cases:
      1. Suppose $m$ is any number that divides 1
        1. Then there exists an integer $k$ such that $1 = m k$ (by definition of divisibility)
        2. Since $m k$ is positive, either both $m$ and $k$ are positive, or both are negative
        3. Case 1: Both $m$ and $k$ are positive.
          1. Since $m | 1, m <= 1$ (by Theorem 4.4.1)
          2. Then $m = 1$
        4. Case 2: Both $m$ and $k$ are negative
          1. Then $-m$ is a positive divisor of 1, i.e. $-m|1$
          2. Then by the same reasoning in 1.3.1 and 1.3.2, $-m=1$, or $m=-1$
      2. Therefore, the only divisors of 1 are 1 and -1
    ],
  )

  #inline("Proof by Exhaustion")
  - If our domain is finite or when only a finite number of elements satisfy $P(x)$, we may prove the statement by the method of exhaustion (i.e. listing out all possible cases, thus an extension of proof by cases)

  #inline("Proof by Contraposition")
  - In proving the contrapositive of the statement, you indirectly prove the statement itself as the two are equivalent.
  - If you prove by contraposition, you start with the negation of the conclusion, and end with the negation of the hypothesis.

  #concept-block(
    body: [
      #inline("Example")
      Prove: Let $n$ be an integer. Show that if $n^2$ is even, then $n$ is also even

      Proof by contraposition:
      1. Contrapositive statement: If n is odd, then $n^2$ is odd
      2. Let $n$ be a particular but arbitrarily chosen odd integer
      3. Then, $exists k in ZZ$ such that $n = 2k+1$ (by definition of odd integers)
      4. Then, $n^2 = (2k+1)^2 = 2(2k^2 + 2k) + 1$ (by basic algebra)
      5. Note that $2k^2 + 2k in ZZ$ (by closure of integers under addition and multiplication)
      6. Therefore, $n^2$ is an odd integer (by definition of odd integers)
      7. Since if $n$ is odd, then $n^2$ is odd, therefore, if $n^2$ is even, then $n$ is also even
    ],
  )

  #inline("Proof by Contradiction")
  - If we want to show that $p => q$ is true, we can also show that $~(p => q)$ is false
  - Note that $~(p => q) equiv p and ~q$
  - Hence, we start with the antecedent and the negation of the consequent, and we end with any contradiction (i.e. show that $p and ~q$ is false)

  #concept-block(
    body: [
      #inline("Example")
      Prove: Suppose $x$ and $y$ are real numbers. If $x y=0$, then $x=0$ or $y=0$

      Proof by contradiction:
      1. Suppose the claim is false, that is, $exists x, y in RR$ such that $x y=0$ but $x != 0$ and $y != 0$
      2. Since $x != 0$, we can divide both sides of $x y =0$ by $x$ (By Epp, Appendix A, T7)
      3. Therefore, $y=0$ (by basic algebra)
      4. But this contradicts $y != 0$
      5. Therefore, the assumption is false, and the claim is true
    ],
  )

  #inline("Proof by Mathematical Induction (1PI)")
  - To prove a statement of the form, "For all integers $n >= a$, a property $P(n)$ is true":
    1. Show that $P(a)$ is true
    2. Show that for all integers $k>=a$, if $P(k)$ is true, then $P(k + 1)$ is true. To do this, suppose that $P(k)$ is true for some arbitrarily chosen $k >= a$ (called the Inductive Hypothesis), then show that $P(k+1)$ is true

  #concept-block(
    body: [
      #inline("Example")
      For all integers $n >= 1$, show $1 + 2 + 3 + dots + n = (n(n+1))/2$

      Proof by Induction:
      1. Let $P(n) equiv (1 + 2 + dots + n = (n(n+1))/2), forall n in ZZ^+$
      2. *Basis Step*:
        - 1 = $(1(1+1))/2$, therefore $P(1)$ is true
      3. *Inductive Hypothesis*:
        - Assume $P(k)$ is true for some $k>=1$, that is, $1+2+ dots + k = (k(k+1))/2$
      4. *Inductive Step*:
        - $1 + 2 + dots + k + (k+1) = (k(k+1))/2 + (k+1) = ((k+1)((k+1) + 1))/2$
        - Therefore, $P(k+1)$ is true
      5. Therefore, by PMI, $P(n)$ is true for all $n in ZZ^+$
    ],
  )

  #inline("Proof by Strong Mathematical Induction (2PI)")
  - Let $P(n)$ be a property that is defined for integers $n$, and let $a$ and $b$ be fixed integers with $a <= b$. Then, we can prove that $P(n)$ is true for all integers $n >= a$ as follows:
  1. Show $P(a), P(a+1), dots, P(b)$ are are true
  2. Show that for any integer $k >= b$, if $P(i)$ is true for all integers $i$ from $a$ through $k$, then $P(k+1)$ is true

  - Another variation of strong induction is to show that:
  1. $P(a)$ is true
  2. For every $k >= a$, $( P(a) and P(a+1) and dots and P(k) ) => P(k+1)$

  #concept-block(
    body: [
      #inline("Example 1")
      Prove for all integers $n>= 12$, $n = 4a + 5b$ for some $a, b in NN$

      Proof by 2PI:
      1. Let $P(n) equiv (n = 4a + 5b)$, for some $a, b in NN, n >= 12$
      2. *Basis Step*: Show that $P(12), P(13), P(14), P(15)$ hold.
        1. (Steps Omitted)
      3. Assume $P(i)$ holds for $12 <= i <= k$, given some $k >= 15$
      4. *Inductive Step*: To show $P(k+1)$ is true
        1. $P(k-3)$ holds (by induction hypothesis), so $k - 3 = 4a + 5b$ for some $a, b in NN$
        2. $k+1 = (k - 3) + 4 = (4a + 5b) + 4 = 4(a + 1) + 5b$
        3. Hence, $P(k+1)$ is true
      5. Therefore, $P(n)$ is true for $n >= 12$

      #inline("Example 2")
      Prove that any integer greater than 1 is divisible by a prime number

      Proof by 2PI:
      1. Let $P(n) equiv (n "is divisible by a prime")$, for $n>1$
      2. *Basis Step*: $P(2)$ is true since 2 is divisible by 2
      3. *Inductive Step*: To show that for some $k>=2$, if $P(i)$ is true for all integers $i$ from 2 through $k$, then $P(k+1)$ is also true
        1. Case 1 ($k+1$ is prime): In this case $k+1$ is divisible by a prime number which is itself
        2. Case 2 ($k+1$ is not prime): In this case, $k+1 = a b$ where $a$ and $b$ are integers with $1 < a < k + 1$ and $1 < b < k + 1$
          1. Thus, in particular, $2 <= a <= k$, and by the inductive hypothesis, $a$ is divisible by a prime number $p$
          2. Furthermore, since $k + 1 = a b$, $k+1$ is divisible by $a$
          3. By *transitivity of divisibility*, $k+1$ is divisible by a prime $p$
      4. Therefore, any integer greater than 1 is divisible by a prime

    ],
  )
  #inline("Other Conjecture, Proof and Disproof")
  - *Fermat's last theorem* (_Proved_)
    $
      exists x, y, z in ZZ , n >= 3 -> x^n + y^n = z^n
    $
    - `"I have discovered a truly remarkable PROOF of this theorem which this margin is too small to contain, Fermat"`

    - Fermat's last theorem (Conjecture) was not rigorously proven, until it was done so, by transforming it into Taniyama-Shimura Conjecture, which is then proved by Andrew Wiles in 1995.
  - *Goldbach Conjecture* (Not yet proven)
    $
      forall k in "even integer", k = m + n "where m and n are prime numbers"
    $

  - *Euler Conjecture* (Disproved)
    $
      forall a,b,c,d in RR , a^4 + b^4 + c^4 = d^4 "has nontrivial whole number solution" \
      "disproved with " 95800^4 + 217518^4 + 414560^4 = 422481^4
    $


])

== Elementary Number Theory
#concept-block(body: [
  #inline("Integers:  Even and Odd Parity")
  $"Let" n in ZZ$
  #align(center)[
    #table(
      columns: 2,
      stroke: 0.25pt + rgb("cccccc"),

      [*Predicate*], [*Definition*],
      [Even(n)], [$exists k in ZZ, n = 2k$],
      [Odd(n)], [$exists k in ZZ, n = 2k + 1$],
    )
  ]
  #concept-block(
    body: [
      #inline("Theorem 4.1.1 Sum of Two Even Integers is Even (p 169)")"

      Prove: If two integers are even, then their sum is even. That is,
      $
        forall x, y in ZZ ("Even"(x) and "Even"(y) => "Even"(x + y))
      $

      Proof:
      1. Let $m, n in ZZ$ be two particular but arbitrarily chosen integers
      2. Suppose $m$ is even and $n$ is even (antecedent)
        1. Then, $exists j in ZZ$ such that $m = 2j$ (by definition of even integers)
        2. Then, $exists k in ZZ$ such that $n = 2k$ (by definition of even integers)
        2. $m + n = 2j + 2k = 2(j + k)$ (by basic algebra)
        3. $j + k in Z$ (by closure of integers under subtraction)
        4. Hence $m+n$ is even (by definition of even integers)
      3. Therefore if two integers are even, their sum is even. `[Q.E.D]`
    ],
  )



  #inline("Integers: Prime and Composite Numbers")
  $"Let" n in ZZ$
  #align(center)[
    #table(
      columns: 2,
      stroke: 0.25pt + rgb("cccccc"),

      [*Predicate*], [*Definition*],
      [Prime(n)],
      [$forall r, s in ZZ,
      (n > 1) and (n = r s) \ -> (r=1 and s=n) or (r=n and s=1)$],

      [Composite(n)],
      [$exists r, s in ZZ,
      (n > 1) and (n = r s) \ -> 1 < r < n$],
    )
  ]

  #inline("Rational Numbers")
  #align(center)[
    #table(
      columns: 2,
      stroke: 0.25pt + rgb("cccccc"),

      [*Symbol*], [*Definition*],
      [$r in QQ$], [$exists a in ZZ, b in ZZ, r = a/b and b != 0$],
    )
  ]
  #concept-block(
    body: [
      #inline("Example: Repeating digits")
      Prove: 0.1212121212... is rational number.

      Proof:
      1. Let $x = 0.12121212...$, Then $100x = 12.1212121...$
      2. Thus $100x-x = 12.121212... - 0.12121212 = 12$
      3. But also $100x - x = 99x$
      4. Hence, $99x = 12$
      5. and so $x = 12/99$
      6. $therefore 0.121212... = 12/99$ which is ratio of two nonzero integers and thus, is a rational number.
      #inline("Theorem 4.3.1: Every integer is a rational number (p185)")
      Prove: $forall x in RR x in ZZ -> x in QQ$

      Proof:
      1. Assume $x in ZZ$
      2. $x = x/1$
      3. $x/1 in QQ$ as $x in ZZ and 1 in ZZ and 1 != 0$ and thus by definition, x is Rational
      #inline(
        "Theorem 4.3.2: The sum of any two rational numbers is rational (p186)",
      )
    ],
  )


  #inline("Divisibility")
  #align(center)[
    #table(
      columns: 2,
      stroke: 0.25pt + rgb("cccccc"),

      [*Symbol*], [*Definition*],
      [d divides n, $d | n$], [$exists k in ZZ, n = k d and d != 0$],
    )
  ]

  The following statements are equivalent:
  - $n$ is divisible by $d$
  - $d$ is factor of $n$
  - $d$ is divisor of $n$
  - $d$ divides $n$
  #inline("Absolute Number")
  #align(center)[
    #table(
      columns: 2,
      stroke: 0.25pt + rgb("cccccc"),

      [*Symbol*], [*Definition*],
      [absolute value of x, $|x|$], [$|x| = cases(x "if" x>=0, -x "if" x<0)$],
    )
  ]
  #inline("Floor and Ceiling")
  #align(center)[
    #table(
      columns: 2,
      stroke: 0.25pt + rgb("cccccc"),

      [*Symbol*], [*Definition*],
      [floor x, $floor(x)$], [$floor(x)=n <=> n <= x < n+1$],
      [ceiling x, $ceil(x)$], [$ceil(x)=n <=> n-1 < x <= n$],
    )
  ]
])
= Relations

== Set Theory
#concept-block(body: [
  $
    A = {x in S. | P(x)}
  $

  - $A, S$ are sets.
  - $x$ is element of $S$.
  - $emptyset in.not S$
  - $P(x)$ is property that element S may or may not suffice.

  #inline("Subset, Proper Subset, Equal Set")

  - *Subset $subset.eq$*
  $
    A subset.eq B <=> \
    forall x, x in A => x in B
  $

  - *Not Subset (Negation) $subset.not.eq$*
  $
    A subset.not.eq B <=> \
    exists x, x in A => x in.not B
  $

  - *Proper Subset $subset.neq$*
  $
    A subset.neq B <=> \
    A subset.eq B and exists x, x in B => x in.not A
  $

  - *Equal Set $=$*
  $
    A = B <=> \
    A subset.eq B and B subset.eq A
  $

  #concept-block(body: [
    #inline[Example: Proof of Subset]

    $
      A = {m in ZZ | m = 6r + 12 "for some" r in ZZ} \
      B = {n in ZZ | n = 3s "for some" s in ZZ}\
    $

    Proof that $A subset.eq B$
    1. Suppose $x in ZZ$, and $x in A$
    2. By definition of A, there is integer $r$, that $x = 6r+12$
    3. Let $s = 2r + 4$
    4. $s$ is an integer because product and sums of integers are integers.
    5. Also $3s = 3(2r+4) = 6r + 12 = x$
    6. $therefore$ By definition of $B$, x is an element of B
  ])

  #inline[Relations among Sets of Number]

  $
    ZZ subset.eq QQ subset.eq RR
  $

  #inline[Sets Operations]

  Let $U$ be the *universal set*.

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
    macron(A) = {x in U | x in.not A}
  $

  #inline[Empty Set, Disjoint Set, Power Set]

  - *Empty Set* ($emptyset, {}$)
  $
    emptyset={forall x in U, x in emptyset}
  $

  - *Disjoint Sets*, A and B are disjoint

  $
    A inter B = emptyset
  $

  - *Power Sets* ($cal(P)(A)$) is set of all subsets of A
  $
    cal(P)({x,y}) = {emptyset, {x}, {y}, {x,y}} \
    cal(P)(A) union cal(P)(B) subset.eq cal(P)(A union B) ", Tut 5, 8(i)" \
    cal(P)(A union B) subset.eq.not cal(P)(A) union cal(P)(B) ", Tut 5, 8(ii)"
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
  #inline[Set Identities]
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
      [Inclusion of Intersection],
      [
        $
          & A inter B subset.eq A \
          & A inter B subset.eq B
        $
      ],

      [2],
      [Inclusion in Union],
      [
        $
          & A subset.eq A union B \
          & B subset.eq A union B
        $
      ],

      [3],
      [Transitive Property of Subsets],
      [
        $
          A subset.eq B and B subset.eq C => A subset.eq C
        $
      ],

      [4],
      [Tutorial 3, Q5 (iii)],
      [
        $
          A subset.eq B -> A inter C subset.eq B inter C
        $
      ],

      [5],
      [Tutorial 3, Q5 (iv)],
      [
        $
          B subset.eq A <-> A inter B = B
        $
      ],
    )
  ]
])


== Relations
=== Ordered Pair, Cartesian Product, Relation
#concept-block(body: [
  #inline[Ordered Pair, Cartesian Product]
  - *Ordered Pair*: $(a,b)$ consist of the element $a$ (first element) and $b$ (second element)
    $
      (a,b) = (c,d) <-> (a = c) and (b = d)
    $
  - *Cartesian Product* of set $A_1, A_2, ..., A_n$ denoted $A_1 crossmark A_2 crossmark ... crossmark A_n$, is set of ordered n-tuples $(a_1, a_2, ..., a_n)$ where $a_1 in A_1, a_2 in A_2, ..., a_n in A_n$

  $
    A_1 crossmark A_2 crossmark ... crossmark A_n = {(a_1, a_2,...,a_n) | a_1 in A_1, a_2 in A_2, ..., a_n in A_n}
  $

  #concept-block(body: [
    #inline[Example: Cartesian Products]

    Let $A = {x,y}, B = {1,2,3}, C= {a,b}$

    $
      A crossmark B = {(x,1), (y,1), (x,2), (y,2), (x,3), (y,3)} \
      B crossmark A = {(1,x), (1,y), (2,x), (2,y), (3,x), (3,y)} \
      A^2 = A crossmark A = {(x,x), (x,y), (y,x), (y,y)} \
      (A crossmark B) crossmark C = {(u,v) | u in A crossmark B and v in C} = {((x,1),a), ((x,2), a), ...} \
      A crossmark B crossmark C = {(u,v,w) | u in A and v in B and w in C} \
      emptyset crossmark A = {(u,v) | u in emptyset and v in A} = emptyset
    $
  ])

  #inline[Relation and Arrow Diagram]
  - *Relation, R from A and B* $subset.eq$ $A crossmark B$.

  Given ordered pair $(x,y) in A crossmark B$

  $
    x R y <-> (x,y) in R \
    x cancel(R) y <-> (x,y) in.not R
  $

  Where set $A$ is *domain* of R, set $B$ is *co-domain*

  - *Arrow Diagram* describes a relation from Domain to Codomain, where
  $
    x -> y <=> x R y <=> (x,y) in R
  $

  #inline[Composite and Inverse Relation]

  - *Composite Relation, $R' dot R$* where $R$ and $R'$ be binary relations that map X to Y and Y to Z.

  $
    R' dot R = R'(R(x))= {(x,z) in X crossmark Z | exists y in Y, (x,y) in R and (y,z) in R'}
  $

  - *Inverse Relation, $R^(-1)$*
  $
    {(y,x) in Y crossmark X | (x,y) in R} \
    forall x in X, forall y in X, (y,x) in R^(-1) <=> (x,y) in R
  $

  - *Inverse Composite Relation $(R' dot R)^(-1)$*
  $
    (S dot R)^(-1) = R^(-1) dot S^(-1)
  $

  #concept-block(body: [
    #inline[Example: Prove for Composition is Associative for Relation]

    Let $A,B,C,D$ be sets and $R subset.eq A crossmark B, S subset.eq B crossmark C, T subset.eq C crossmark D$

    Prove $T dot (S dot R) = (T dot S) dot R$

    $
      T dot (S dot R) = (T dot S) dot R <=> \
      T dot (S dot R) subset.eq (T dot S) dot R and (T dot S) dot R subset.eq T dot (S dot R)
    $

    $"Case 1: " T dot (S dot R) subset.eq (T dot S) dot R$

    $
      "Suppose " (a,d) in T dot (S dot R) \
      exists c in C "such that" (a,c) in S dot R and (c,d) in T \
      exists b in B "such that" (a,b) in R and (b,c) in S and (c,d) in T \
      "Therefore" (a,b) in R and (b,d) in T dot S ,therefore (a,d) in (T dot S) dot R \
      T dot (S dot R) subset.eq (T dot S) dot R
    $

    $"Case 2: " (T dot S) dot R subset.eq T dot (S dot R)$

    $
      "Suppose " (a,d) in (T dot S) dot R \
      exists b in B "such that" (a,b) in R and (b,d) in T dot S \
      exists c in C "such that" (a,b) in R and (b,c) in S and (c,d) in T \
      "Therefore" (a,c) in S dot R and (c,d) in T, therefore (a,d) in (S dot R) dot T \
      (T dot S) dot R subset.eq T dot (S dot R)
    $

    $
      therefore (T dot S) dot R = T dot (S dot R)
    $
  ])

])

=== Graph
#concept-block(body: [
  #inline[Directed Graph]

  - *Directed Graph* is a 2-tuple $(V,D)$ where:
    - $V$ is an *non-empty set*, and $v in V$ v is a node / vertices
    - $D$ is a *binary relation* on V, and $(x,y) in D$ is an edge from $x$ to $y$
    - edge $(x,x)$ is also called a *loop*.

    #image("images/directed-graph.jpeg")

  - *Undirected Graph* is a 2-tuple $(V,E)$ where:
    - $V$ is an *non-empty set*, and $v in V$ v is a node / vertices
    - $E$ is set of elements of form ${u}, {u,v}$ where $u,v in V$ and $u eq.not v$. Element of E is called an edge.
    - edge ${u} in E$ is a loop
])

=== Equivalence Relation and Classes
#concept-block(body: [
  #inline[Reflexive, Symmetric, Transitive, Equivalence]

  - *Reflexive* binary relation $R$ on $X$ (Each element is related to itself)
  $
    R "is reflexive" <=> forall x in X, x R x <=> forall (x_1,x_2) in X crossmark X, (x_1,x_2)in R \
    i.e. "Check" (x,x) in R \/ forall x in X, x R x
  $

  - *Symmetric* binary relation $R$ on $X$  (Each element has back-and-forth connection)

  $
    R "is symmetric" <=> "if" (x,y) in R -> (y,x) in R \
    i.e. "Check" (x,y) in R and (y,x) in R \/ x R y -> y R x
  $

  - *Transitive* binary relation $R$ on $X$ (There is always direct connection connecting two pair of relation)

  $
    R "is transitive" <=> forall x R z , x R y and y R x \
    <=> R dot R subset.eq R \
    i.e. "Check" y R z dot x R y -> x R z
  $

  - *Equivalence Relation* is relation that is reflexive, symmetric and transitive.
    - i.e. groups things that look different but actually the same
    - rational number are really just equivalence classes
      - $(a,b) R (c,d) <=> a d = b c ; therefore 1/2 = (-1)/(-2) = 2/4 = 3/6 = ...$

  #align(center)[
    #image("images/equivalence-relation.png", width: 80%)
  ]

  #concept-block(body: [
    #inline[Example of Equivalence Relation]
    Let $R_("4") = {(m,n) in ZZ^+ crossmark ZZ^+ | 4 "divides" m-n}$

    *Proof of Reflexive*

    $
      x R_4 x\
      equiv x-x = k 4 \
      equiv 0 = k 4 \
      "Since" exists k=0 in ZZ "where" x-x= k(4), forall x in ZZ^+, \
      therefore R_4 "is reflexive"
    $

    *Proof of Symmetric*

    $
      "Let" x in ZZ^+ ,y in ZZ^+ \
      x R_4 y \
      equiv (x-y) = k 4 \
      equiv (x-y) = (-k) 4 \
      equiv (y-x) = k 4 \
      equiv y R_4 x \
      therefore R_4 "is symmetric"
    $

    *Proof of Transitive*
    $
      "Let" x in ZZ^+, y in ZZ^+ y in ZZ^+ \
      x R_4 y and y R_4 z \
      equiv exists k in ZZ x-y = k 4 and exists h in ZZ y-z = h 4 \
      equiv exists k in ZZ and h in ZZ, x - (z + h 4) = k 4 \
      equiv exists k in ZZ and h in ZZ, x - z = 4 (k-h) \
      equiv exists p in ZZ, x-z = 4 p \
      equiv x R_4 z \
      therefore R_4 "is transitive"
    $

    *Proof of Equivalence*

    $R_4$ is equivalence as it is reflexive, transitive and symmetric
  ])

  #inline[Partition, Equivalence Class]

  - *Partition, A* of $X$ is a set in form of ${A_1, A_2, ...}$ where all the following conditions are satisfied:
  1. $A_1, A_2, ...$ be non-empty subsets of $X$
  2. $A_1 union A_2 union ... = X$
  3. $A_i inter A_j = emptyset, "for" A_i eq.not A_j$ ("aka pairwise disjoint")

  - *Equivalence Class [a]* of a under R, equivalence relation on X, $a in X$ and $ [a]_R = {x in X | x R a} \
    forall x in X, x in [a] <=> x R a <=> (x,a) in R $


  - Lemma 8.3.2 (pg 513)
    - Suppose R is equivalence relation on A (_If a is related to be, a and b belongs to same equivalence class_)
  $
    a R b => [a] = [b]
  $

  - Lemma 8.3.3 (pg 514) (_Equivalence class can only be either the same or disjoint_)
  $
    U = [a] union [b] = emptyset or [a] = [b]
  $

  - *Relation Induced by Partition, $Pi$* is a partition
  $
    forall (x,y) in A_i, x R y \
    equiv Pi = {[b]_R in cal(P)(X) | b in X}
  $
])
=== Partial Order Relations
#concept-block(body: [
  #inline[Anti-Symmetry, Partial Order, Total Order]

  - *Anti-Symmetry* binary relation $R$ on $X$

  $
    R "is anti-symmetry" <=> x R y and y R x -> x = y \
    i.e. "No reverse line, only loop"
  $

  - *Partial Order Relation* is relation that is reflexive, antisymmetric and transitive.
  #concept-block(body: [
    #inline[Hasse Diagram]

    - Named after Helmet Hasse.
    - Given any *partial order relation* defined on a *finite set*, it is possible to draw *directed graph* in a way that the following properties are satisfied / eliminated
      1. Remove all loops at all the vertices
      2. Remove all arrows whose existence is implied by transitive property
      3. Remove direction indicators on the arrows

      #image("images/hasse-diagram.png")

  ])



  - *Total Order Relation, R* $ <=> (R "is partial order relation") and forall a, b in A, a R b or b R a $

    - Hasse diagram for total order relation forms a chain.



  #concept-block(body: [
    #inline[Well-Ordering Principles for Integers (WOP)]

    - Y is *bounded below (aka lowerbound)* by b $<=> b <= x forall x in Y$. Let $Y subset.eq RR and b in RR$

    - Suppose $S subset.eq ZZ, S != emptyset$ and S is bounded below by an integer. Then S contains a smallest integer.

    #inline[Topological Sorting]
    Let $prec.eq$ be partial order relation on a nonempty finite set A, Topological Sort sorts element into a chain given the relation.

    1. Pick any minimal element $x in A$
    2. Set $A'$ = A - {x}
    3. While $A' != emptyset$
      1. Pick minimal element $y in A$
      2. Append $x prec.eq.curly y$
      2. $A' := A' - {y}$

    Example:
    - Let A = {2,3,4, 6, 18, 24}, Relation is divide relation $|$
    - Total Order: $3 prec.eq 2 prec.eq 6 prec.eq 18 prec.eq 4 prec.eq 24$
  ])


])

== Function
#concept-block(body: [
  - *Function* from set X to set Y, denoted $f: X -> Y$ is a relation with *domain X* and *co-domain Y* that satisfies the following two properties:
    1. Every element in X is related to Y
      $
        forall x in X, exists y in Y "such that" (x,y) in F
      $
    2. no element in X is related to more than one element in Y, {one, many}-to-one
      $
        (x,y) in F and (x,z) in F -> y = z
      $
  - *Range of f* or *Image of X under Y*
  $
    {y in Y | y = f(x) "for some" x in X}\
    "Range" subset.eq "Codomain"
  $
  - *Inverse image of y* or *Preimage of y*
  $
    {x in X | f(x) = y}
    "Inverse Image" subset.eq "Domain"
  $


  #inline[Boolean Function]
  $
    f : {T,F}^n -> {T,F}
  $

  #inline[Identity Function]
  $
    i_X : X -> X \
    i_X = f^(-1) compose f \
    f compose i_X = f
  $


  #inline[Equality of Function]
  Let  $f: X-> Y$ and $g : X -> Y$,
  $
    f = g <=> forall x in X, f(x) = g(x)
  $

  #inline[Composition of Function]
  Let  $f: X-> Y$ and $g : Y -> Z$,
  $
    g compose f : X -> Z <=> \
    forall x in X, (g compose f) (x) equiv g(f(x))
  $

  - Corollary 2.9
  $
    f : X -> Y \
    (i_Y compose f = f) and (f compose i_X = f)
  $
])

=== One-to-One, Onto, and Inverse Functions
#concept-block(body: [
  #inline[One-to-One Function (Injective)]
  $
    F "is one-to-one" <=> F(x_1) = F(x_2) -> x_1 = x_2 <=> x_1 != x_2 -> F(x_1) != F(x_2) \
    F "is not one-to-one" <=> exists x_1, x_2 in X, F(x_1) = F(x_2) and x_1 != x_2
  $

  Aka same output imply same input

  #concept-block(body: [
    #inline[Example of Composite 1-1 Proof]

    Suppose $f: X->Y$ and $g:Y->Z$ are both one-to-one function, shows that $g compose f$ is one-to-one function.

    $
      (g compose f) (x) = (g compose f) (x') \
      g(f(x)) = g(f(x')) \
      "Since g is one-to-one" f(x) = f(x') \
      "Since f is one-to-one" x = x' "#QED"
    $
  ])


  #inline[Onto Function (Surjective)]

  $
    F "is onto" <=> forall y in Y, exists x in X, F(x) = y \
    F "is not onto" <=> exists y in Y, forall x in X, F(x) != y \
  $

  #concept-block(body: [
    #inline[Example of Composite onto Proof]

    Suppose $f: X->Y$ and $g:Y->Z$ are both onto function, shows that $g compose f$ is onto function.

    $
      "Let" z "be any" Z, \
      "Since g is onto", forall z in Z, exists y in Y, z=g(y)\
      "Since f is onto", exists x in X, f(x) = y \
      therefore exists x in X "such that" (g compose f)(x) = g(f(x)) = g(y) = z "#QED"
    $
  ])

  Aka every output has its input

  #inline[Bijective Function]

  Function that is both one-to-one and onto.

  - A bijective function always has bijective inverse
  - Composition of bijective functions is bijective

  #inline[Inverse Function]

  Let F be bijective function, then there exists $F^(-1): Y -> X$
  $
    F^(-1) (y) = x <=> y = F(X)
  $


  #concept-block(body: [
    #inline[Example of Cardinality of Equivalence Classes]

    Define $equiv_k$ be equivalence relation such that ${(m,n) in RR^2 | k "divides m-n"}$. Proof that its equivalence classes have same cardinality.

    Let $[b]_(equiv_k)$ and $[c]_(equiv_k)$ be equivalence classes.

    To prove that both classes have same cardinality, there exists *bijective* function, $ f: [b]_(equiv_k) -> [c]_(equiv_k) $

    Let $x in RR$, by definition,
    $
      [b]_(equiv_k) = {x in RR | k "divides" x - b} \
      = {x in RR | exists z in ZZ, x-b = z k} = {x in RR | exists z in ZZ, x= z k + b}
    $

    Let $y in RR$, by definition,

    $
      [c]_(equiv_k) = {y in RR | k "divides" x - c} \ = {y in RR | exists z in ZZ, y-c = z k } = {y in RR | exists z in ZZ, y= z k + c}
    $

    Therefore, f is defined as follows,
    $
      f(x) = y \
      f(z k + b) = z k + c \
      (z k + b) - b + c = z k + c \
      f(x) = x - b + c
    $

    Prove that f is 1-1:
    $
      f(x) = f(x') => x -b + c = x' -b + c => x = x' "#QED"
    $

    Prove that f is onto:
    $
      "For any" y in [c]_(equiv_k) \
      y = f(x) = x - b + c \
      x = y + b - c "(define x based on y)" \
      f(x) = (y+b-c) - b + c = y "(demonstrate f(x) = y)" \
      therefore exists x in [b]_(equiv_k), forall y in [c]_(equiv_k), f(x) = y "#QED"
    $


    Thus, f is bijective and so $[b]$ and $[c]$ has same cardinality.
  ])

])


= Counting

== Countability and Un-countability
#concept-block(body: [

  #inline[Cardinality and Equivalence]
  - *Cardinality* refers to the size of a set, $|A| = n$. (i.e. what is the maximum n such that I can list all the elements one-by-one exhaustively)

  - For any A and B be any (finite/infinite) sets, A and B has *same cardinality* $ <=> exists "bijection" f: A ->^"1-1"_"onto" B $

  - Set A is *finite set*
  $
    <=> (A = emptyset) or (exists "bijection" f : {1,2,...,n} in ZZ^+ -> A) \
    "Size A" = |A| = n
  $

  - Set B is *countably infinite*
  $
    <=> A != emptyset and "same cardinality as " ZZ^+ \
    "OR (relaxed condition)" exists "surjection" f: NN ->^"onto" A
  $


  - Set is *countable*

  $
    <=> "Set is finite" or "Set is countably infinite" \
    "else, set is uncountable"
  $

  #concept-block(body: [
    #inline[Theorem 3.1: Pigeonhole Principle (pg 605)]

    Suppose $n,k in ZZ^+, X={x_1,x_2, ..., x_n}, Y = {y_1, ..., y_k}$
    1. If $n>k$, there is no 1-1 function $f: X-> Y$
    2. If $n<k$ there is no onto function $g: X -> Y$
    3. $n=k <=>$ there is a bijection $h: X-> Y$


    Proof:
    1.
      - Proof by contradiction. Suppose $n>k$ and there exists 1-1 function $f:X->Y$
      - For any $x, x' in X$, suppose $x != x'$, there is no guarantee that $F(x) = F(x')$ as there must be a box with two or more domain
      - Thus, this contradicts with the definition of 1-1 function
      - $therefore$ by contradiction, there is no 1-1 function $f:X->Y$
    2.
      - Suppose $n < k$, by definition of range of function, $"range"(f) subset.eq "codomain"$
      - so $|"range"(g)| <= |X| = n < k = |Y|$
      - Since $|"range"(g)| < |Y|$, $"range"(y) subset.neq Y$, and therefore $exists y in Y, forall x in X, f(x) != y$ and function $g$ is not onto
    3.
      1. $=>$ Suppose n=k, define $h: X -> Y$ such that $H(x_i) = y_i forall i$
        - Show 1-1. Suppose $x_i, x_j in X$ and $x_i != x_j$, $H(x_i) = y_i != y_j = H(x_j)$
        - Show Onto. Suppose for any $y_i in Y$, $x_i in X$, $F(x_i) = y_i$
        - $therefore exists "bijection" h: X -> Y$
      2. $<=$ Suppose exists bijection $h:X->Y$
        - By properties of bijection:
          - h is 1-1, By contraposition of 3.1.1 $n<=k$
          - h is onto, by contraposition of 3.1.2 $n>=k$
        $therefore n <=k and n>= k => n = k$

  ])

  #inline[Properties of Cardinality]

  Cardinality is an *equivalence relation*.
  Therefore, for any two sets A and B, its cardinality is:
  - *reflexive*: A has same cardinality as A,
    - $|A| = |A|$
  - *symmetric*: If A has same cardinality as B, then B has the same cardinality as A
    - $|A| = |B| -> |B| = |A|$
  - *transitive*: If A has same cardinality as B and B has same cardinality as C, A has same cardinality as C, )
    - $(|A| = |B|) and (|B| = |C|) -> |A| = |C|$

  #inline[$ZZ^+$,$NN$ and $ZZ$ has same cardinality]
  $
    "Even though " ZZ^+ subset.neq NN subset.neq ZZ, \
    |ZZ^+| = |NN| = |ZZ| = "countably infinite"\
  $

  #concept-block(body: [
    #inline[Theorem 3.2: $NN$ and $ZZ$ has same cardinality]

    For $NN$ and $ZZ$ to has same cardinality, we need to show that $exists$ bijection $F: NN -> ZZ$

    Define:
    $
      F(n) = cases(n/2 | "n is even", -(n+1) / 2 | "n is odd") \
      F(0) = 0, F(1) = 1, F(2) = -1, F(3) = 2, F(4) = -2 ,...
    $

    Show that $f$ is 1-1:
    - Suppose $f(b) = f(c) = k$, for $b,c in NN$
      - Case $k$ is even:

        $2f(b) = 2(b/2) = b = c = 2(c/2) = 2f(c)$
      - Case $k$ is odd:

        $1-2f(b) = 1- 2(-b+1) / 2 = b = c = 1-2(-c+1/2) = f(c)$
      - $therefore f(b) = f(c) => b = c$
    Show that $f$ is onto:
    - For any $k in ZZ$:
      - Case $k>= 0$
        - Let $x = 2k$, $f(x) = f(2k) = 2k/2 = k$
        - $exists x = 2k, forall k in ZZ "for some" k >=0, f(x)=k$
      - Case $k <0$
        - Let $x=-2k-1$, $f(x) = (-x+1)/2 = k$
        - $exists x = -2k-1, forall k in ZZ "for some k"<0, f(x)=k$
      $therefore f$ is onto

    Since, $f:NN ->^("1-1")_("onto") ZZ$, $therefore NN$ and $ZZ$ have the same cardinality. $"#QED"$

  ])

  #concept-block(body: [
    #inline[Theorem 3.3: $NN crossmark NN$ is countable]

    For $NN crossmark NN$ is countable, there exists $f: N ->^"1-1"_"onto" NN crossmark NN$.

    Define $f(n) = p_n$ where $p_n$ refers to element in first quadrant of (x,y)-plane.

    #align(center)[
      #image("images/nxn-walk.png", width: 50%)
    ]

    Show that $f$ is 1-1:
    - Suppose $f(j) = f(k) = p$, since square walk visits every point exactly once, $p$ is therefore only visited once
    - $therefore f(j)=f(k) => j=k$, $f$ is 1-1

    Show that $f$ is onto:
    - Consider any $(x,y) in NN^2$,
    - Point $(x,y)$ will be eventually visited in the $k$-th step.
    - $therefore (x,y) = p_k = f(k)$, $f$ is onto


    Since, $f:NN ->^("1-1")_("onto") NN crossmark NN$, $therefore NN crossmark NN$ is countable. $"#QED"$
  ])

  #concept-block(body: [
    #inline[Theorem 3.4: ${0,1}^*$ is countable]

    For ${0,1}^*$ is countable, there exists $f: N ->^"1-1"_"onto" {0,1}^*$.

    $f(0) = emptyset, f(1) = 1, f(2) = 10, f(3)=11,...$
  ])


  - $|QQ|$, Exists bijection $G: ZZ^+ -> QQ^+$ where G list the numbers diagonally.
  #align(center)[
    #image("images/rational-countable-function.png", width: 25%)
  ]

  $
    g(1) = 1/2, g(2) = 1/2, g(3) = 2/1, g(4) = 3/1, g(5) =1/3 ("skip " 2/2) ...
  $

  #inline[Countability of Subset for Countable (Infinite) Set]

  #concept-block(body: [
    #inline[Theorem 3.5: Subset of countable set is countable (pg 480)]
    Let $A$ be countable set and $B subset.eq A$, Proof that $A$ is countable $-> B$ is countable

    For B to be countable set, B is either:

    1. Case B is finite set:
      - By definition, a finite set is countable set.
      - $therefore$ B is countable set that is subset of A, another countable set.
    2. Case B is infinite set:
      - Since B is infinite set, A is also infinite set.
      - Since $A$ is countable, elements of A can be enumerated $A = {A_1, A_2, ...}$
      - Since $B subset.eq A$, $B = {A_(i_0), A_(i_1), ...}$ for some $i_0 < i_1$.
      - Define $f : NN -> B, f(n) = A_i_n$
      - Show that $f$ is 1-1:
        - Let $b,c in NN$. Suppose $b != c$,
        $
          b < c "(Since b != c)" \
          => i_b < i_c \
          => A_b < A_c "(Given that X is countable)" \
          => f(b) != f(c)
        $
        - $therefore "By contraposition" f(b) = f(c) => b = c " (#QED)"$

      - Show that f is onto:
        - For any $b in B$.
        - Then $y = A_i_k$ for some $k$ (By definition of subset)
        - $y = A_i_k = f(k)$

        $therefore exists k in NN, forall b in B, f(k) = b$

      - Since $f:NN ->^"1-1"_"onto" B$, $therefore$ B is countable set.

  ])


  #concept-block(body: [
    #inline[Theorem 3.6: subset of infinite set is countable]

    Let $X$ be infinite set and $A subset.eq X$.  Show that A is countably infinite.

    - For A to be countably infinite, A is countable.
    - For A to be countable, exists bijection $f: NN -> A$
    - Define f as follows:
      - n := 0
      - A := $emptyset$
      - repeat:
        - Choose any y = X - A
        - a_n := y
        - A := $A union {a_n}$
        - n := n+1
      - end
    - Proof f is 1-1
      - Suppose $n_1 != n_2$
      - $n_1 < n_2$
      - $a_n_2 in X - {a_0, ..., a_n_1, ..., a_(n_2-1)}$
      - $a_n_1 != a_n_2$
      - $f(n_1) != f(n_2)$
    - Proof f is onto
      - For any $y in A$
      - $y = a_k$ for some k
      - $y = f(x)$
    $therefore$ f is bijective and A is countably infinite

  ])

  #inline[Uncountable Set]

  #concept-block(body: [
    #inline[Theorem 3.7: A countably infinite set has uncountable many subset]

    i.e. $X "is countably infinite set." => cal(P)(X) "is uncountable"$.

    Proof by Cantor Diagonalization:

    - Let $X$ be countably infinite, and therefore, $f : NN ->^("1-1")_"onto" X, f(i) = x_i$.
    - $({x_0}, {x_1}, {x_2}) subset.eq X, in cal(P)(X)$
    - *Suppose* $cal(P)(X)$ *is countably infinite*, there exists bijection $g: NN ->^"1-1"_"onto" cal(P)(X))$
    - Since $f$ is bijection, $f^(-1) : X -> NN$ is bijection
    - Since $f^(-1)$ and $g$ is bijection, $g compose f^(-1): X -> cal(P)(X)$ is bijection
    - Define bijection $h= g compose f^(-1)$ and h maps an element to a particular subset.
    - Arranging ${x_0, x_1, ...} crossmark {h(x_0), h(x_1),...}$ in a 2D-grid, define
      $
        e_(i j) = cases(
          1 "if" x_i in h(x_j),
          0 "if" x_i in.not h(x_j)
        )
      $

    - Define diagonal set $D = {x_i in X | e_(i i) = 0} = {x_i in X | x_i in.not h(x_i)}$
    - Since $h$ is onto, $exists x_k in X$ such that $h(x_k) = D$
    - $x_k in D$?
      - Suppose $x_k in D$
        $e_(k k) = 0 => x_k not in h(x_k) => x_k not in D$ (contradiction)
      - Suppose $x_k not in D$
        $x_k not in h(x_k) => e_(k k) = 0 => x_k in D$ (contradiction)

    - This contradiction proves that $cal(P)(X)$ is *not countably infinite*.

  ])


  - $RR$ is uncountable (Cantor Diagonalization Theorem)
    - See textbook pg480 for detailed proof. But tldr, there always exists new number that is not in the list of decimal numbers. Therefore, set of all number 0 and 1 is uncountable.

  - Any set with uncountable subset is uncountable, Corollary 7.4.4 (pg 481)
])

== Counting of Disjoint Sets
#concept-block(body: [
  Let $A$, $B$ be finite, disjoint set. (i.e. $A inter B = emptyset$)

  - *Addition Rule*, Lemma 3.9.1
  $
    |A union B| = |A| + |B| in RR
  $

  - *Difference Rule*, when $B subset.eq A$ Lemma 3.9.2
  $
    |A - B| = |A| - |B|
  $
  - *Union(s) of finite sets is finite*, Theorem 3.10

  - *Inclusion / Exclusion Rule for 2 and 3 sets*, Theorem 3.11

  $
    |A union B| = |A| + |B| - |A inter B| \
    |A union B union C| = |A| + |B| + |C| - |A inter B| - |B inter C| - |A inter C| + |A inter B inter C|
  $


  Useful set manipulation identities:
  $
    X inter (Y - X) = X inter (Y inter X') = (X inter X') inter Y = emptyset inter Y = emptyset \
    X union (Y-X) = X union (Y inter X') = (X union Y) inter (X union X') = (X union Y) inter U = X union Y
  $

  #concept-block(body: [
    #inline[Proof that $A union B$ is countable]

    Let $A$ and $B$ be countable and disjoint set.

    For $A union B$ be countable set, $A union B$ are either finite or countably infinite.

    Case $A$ is finite and $B$ is finite.
    - Then $A union B$ are finite, as $|A union B| = |A| + |B|$ by addition rule
    - $therefore A union B$ is countable.

    Case $A$ is finite and $B$ is countably infinite.
    - If $A = emptyset$
      - $A union B = emptyset union B = B$, which is countable
    - If $A != emptyset$
      - A can be arranged as $A = {a_0, ..., a_(k-1)}$
      - Since B is countable, there exist bijection $f : NN -> B$
      - Define $g: NN -> A union B$ where
        $
          g(n) = cases(a_k | n <k, f(n-k) | n >= k)
        $
      - g is 1-1
        - Suppose $n != n'$
          - Case $n<k$ and $n'<k$: $g(n) = a_k != a_(k') = g(n')$
          - Case $n<k$ and $n'>=k$: $g(n) in A, g(n') in B$
            - Since $A inter B = emptyset$, $g(n) != g(n')$
          - Case $n>=k$ and $n' >= k$: $g(n)= f(n) != f(n') = g(n')$
      - g in onto
        - Let $x in A union B$
          - If $x in A$, $x = a_n = g(n)$ for some $0 <= n < k$
          - If $x in B$, $x = f(m)$, $x=g(m+k)$
    Case $A$ and $B$ is countably infinite
    - There exists bijections $f:NN -> A, g:NN -> B$
    - Define $h -> ZZ -> A union B$ where
    $
      h(n) = cases(f(n) | n>=0, g(n) | n <0)
    $
    - h is 1-1
      - Suppose $n != n'$
        - Case $n<0$ and $n'<0$: $g(n) = h(n) != h(n') = g(n')$
        - Case $n>=0$ and $n' >= 0$: $g(n)= f(n) != f(n') = g(n')$
        - Case $n<0$ and $n'>=0$: $g(n) in A, g(n') in B$
          - Since $A inter B = emptyset$, $g(n) != g(n')$
    - h is onto
      - Let $x in A union B$
      - If $x in A$, $x in f(n)$ for some $x in NN$, $x = h(n)$
      - If $x in B$, $x in g(m)$ for some $m in NN$, let n = (-m+1)
        - Then $n<0$, so $h(n) = g(-n-1) = g(m) = x$
    - Since h is bijective, $A union B$ has same cardinality as $ZZ$ which is countable, so $A union B$ is also countable.

  ])

  #inline[Multiplication Rule]

  - *Multiplication Rule*
  $
    |A crossmark B| = |A||B|
  $

  #concept-block(body: [
    #inline[Theorem 3.12: $|A_1 crossmark A_2 crossmark ... crossmark A_n| = |A_1||A_2|...|A_n|$ for any $n>=2$]

    By 1PI on $n$

    Basis:
    - Let $n=2$, $|A_1 crossmark A_2| =\ |A_1| |A_2|$ (by multiplication rule)

    Induction Hypothesis:
    - Assume claim is true for $n=k$ for some $k>= 2$

    Induction Step:
    - Consider case $n=k+1$
    - Then $ |A_1 crossmark ... crossmark A_k crossmark A_(k+1)| = |{(a_1, a_2, ..., a_k, a_(k+1) | a_1 in A_1 and ... a_(k+1) in A_(k+1))}| \
      = |{(a_1, a_2, ..., a_k, a_(k+1) | a_i in A_i}| \
      = |D crossmark A_(k+1)| "Let" D=A_1crossmark ... crossmark A_k\
      = |D| |A_(k+1)| "by multiplication rule" \
      = |A_1| ... |A_k| |A_(k+1)| "by inductive hypothesis" $
    - $therefore$ claim is true for $n=k+1$

    By 1PI, the claim is true for $n>=2$
  ])

  - $A = A_1 = ... = A_n => |A^n| = |A_1 crossmark ... crossmark A_n| = |A|^n$

])

== Combinations
#concept-block(body: [

  - r-combination of s
  $
    n C r = (n!)/(r!(n-r)!)
  $

  - r-permutation of s
  $
    n P r = (n!)/((n-r)!)
  $

  - Tutorial 10, qn1
  $
    n C r + n C (r-1) = (n+1) C r
  $

  - Binomial Theorem, Tutorial 10, qn3
  $
    (x+y)^n = n C 0 x^n y^0 + n C 1 x^(n-1)y^1 + ... + n C r x^(n-r) y^r + ... n C n x^0 y^n
  $

])

= Graph
== Graph, Paths, Cycles

#concept-block(body: [
  Let $G$ be *undirected graph* $G = (V,E)$, where $V$ is nonempty set of *vertices*, and $E$ is *edges*.

  Let $G'$ be *directed graph*, $G' = (V,E)$ consists of two finite sets, where $V$ is nonempty set of vertices and $D$ of directed edge, $e=(u,w)$. $e$ is therefore the directed edge from $v$ to $w$.

  Degree of vertices, $deg(v)$ equals number of edges that are incident on v, with an edge that is a loop counted twice.

  #inline[Countability of Graph]
  - G is *trivial* $<=> |V| = 1$ (i.e. only 1 vertices)
  - G is *finite* if V is *finite*
  - G is *infinite* if V is *infinite*

  #inline[Subgraph, Proper Subgraph]
  $H$ is *subgraph* of $G$
  $
    <=> (V_H subset.eq V_G) and (E_H subset.eq E_G)
  $

  $H$ is *proper subgraph* of $G$
  $
    <=> (H "is subgraph of " G) and (H != G)
  $

  #inline[Path, Connectedness, Cycle]

  Let $x_1, x_p$ be *vertices* in graph $G$ and $p in NN >= 2$. A *path between $x_1$ and $x_p$ in G* is a subgraph defined as:

  $
    "path" = ({x_1, ..., x_p}, {{x_1, x_2}, {x_2, x_3}}, ..., {x_(p-1), x_p}), \
    |"path"| = p-1
  $


  An undirected graph G is *connected*
  $
    <=> (G "is trivial") or (forall "vertices" v, w in V_G, exists "path," p "from" v "to" w )
  $


  #inline[Edge as a Relation]

  Let *$R$ be a binary relation*, describe an edge connecting two distinct vertices.

  $
    R = {(b,c) in V crossmark V | b!= c and {b,c} in E}
  $

  *$R_n$ is defined as:*, for $n in ZZ^+$
  $
    R_n = cases(
      R | n=1,
      R compose R_(n-1) | n>= 2
    )
  $

  *$R_+$ transitive closure* is defined as (aka fking long chain)
  $
    R_+= union^infinity_(n=1) R_n
  $


  #concept-block(body: [
    #inline[Theorem 4.1.1: There is path of length $n$ between $x$ and $y$, then $(x,y) in R_n$]

    Proof by 1PI on $n$:

    Base Case: Let $n=1$.
    - Suppose there is a path of length $n$ between $x$ and $y$, by definition of path, there exists subgraph $G_1 = ({x,y}, {{x,y}})$.
    - Since $x!=y$ and $(x,y) in E_G_1$, $(x,y) in R$ by definition of relation

    Induction Hypothesis: Suppose claim is true for $n=k>=1$, then $(x_1,x_k) in R_k$

    Induction Step: Let n = k+1
    - Suppose there is a path of length $k+1$ between $x_1$ and $x_(k+1)$, by definition of path, there exists subgraph $G_(k+1) = ({x_1, ..., x_k, x_(k+1)}, {{x_1, x_2}, ..., {x_k, x_(k+1)}})$

    - Since $x_k != x_(k+1)$ and ${x_k, x_(k+1)} in E_G_(k+1)$, $(x_k, x_(k+1)) in R$

    - By I.H., $(x_1, x_k) in R_k$, and $(x_k, x_(k+1)) in R$, $(x_1, x_(k+1)) in R compose R_k = R_(k+1) "#QED"$

    #inline[Theorem 4.1.2: If $(x,y) in R_n$, there is path of length at most $n$ between $x$ and $y$]

    Proof by 1PI on $n$

    Base Case: Let $n=1$.
    - Suppose $(x,y) in R_1$, $x!=y$ and $(x,y) in E_G_1$, $(x,y) in R$ by definition of relation.
    - Since there exists subgraph $G_1 = ({x,y}, {{x,y}})$, there is a path of length $1$ between $x$ and $y$.

    Induction Hypothesis: Suppose claim is true for $n=k>=1$, then there is path of length at most $k$ between $x$ and $y$

    Induction Step: Let n = k+1
    - Suppose $(x,z) in R_(k+1) = R compose R_k = y R z and x R_(k) y$
    - For $(y,z) in R$, there is an edge of length 1 between $y$ and $z$.
    - By I.H., since $x R_k y$, there is a path of length at most $k$ between $x$ and $y$
    - $therefore$ length of path between $x$ and $z$ = length of path between $x$ and $y$ + length of path between $y$ and $z$ $<= k+1 "#QED"$
  ])


  #concept-block(body: [
    #inline[Corollary 4.2: G is connected $<=> forall x, y in V, x!=y => (x,y) in R_+$]

    $=>$ Suppose G is connected.
    - By definition of connected, for any $x,y in V$, there exists a path from $x$ to $y$ for length n.
    - By theorem 4.1.1, $(x,y) in R_n$ for some $n$
    - By definition of transitive closure, $(x,y) in R_+$ since $n in ZZ$.

    $"<="$ Suppose $forall x, y in V, x!=y => (x,y) in R_+$
    - $R_+= union^infinity_(n=1) R_n$.
    - By theorem 4.1.2, there is a path between $x$ and $y$ of at most length $n$, for any $x,y in V$
    - By definition of connected graph, $G$ is connected.

  ])


  #inline[Loop, Cycle, Cyclic and Acyclic]


  A *cycle* exists in undirected graph with $|V| >= 3$
  $
    <=> exists "path" p = ({x_1, x_2, ..., x_n}, {{x_1,x_2}, {x_2,x_3}, ..., {x_n, x_1})
  $

  An undirected graph is *cyclic* if it consists a loop or cycle.

  An undirected graph is *acyclic* if no cycle is found.

  *Theorem 4.3*: Let G be undirected graph with *no loop*, G is *cyclic*
  $
    <=> exists u, v in V "with more than 1 path between them"
  $

  #inline[Connected Component]
  H be *connected component* of G $<=>$

  1. $H$ is subgraph of $G$
  2. $H$ is connected
  3. no connected subgraph of G has H as a subgraph and contains vertices or edges that are not in H.

  (Saitama's official definition:) G does not contain another connected subgraph H', such that H is a proper subgraph of H'

  (Theorem 4.4) Let $x,y$ be distinct node in G.

  #concept-block(body: [
    #inline[Theorem 4.4:  There is a *path in G between* $x$ and $y <=>$ $x$ and $y$ are in the *same connected component* in G]

    <= Suppose $x$ and $y$ are in the same connected component $H$ of G.
    - By definition of connected component, $H$ is connected
    - By definition of connected, there is a path between $x$ and $y$ in H
    - Since H is a subgraph of G, there is a path between $x$ and $y$ in G


    => By contraposition, $x$ and $y$ are not in same connected component => there is no path in $G$ between $x$ and $y$

    - To prove by contradiction, suppose $x$ and $y$ are not in same connected component, we need to show there is a path in $G$ between $x$ and $y$.
    - Since $x$ and $y$ are not in the same connected component, $x$ and $y$ are not connected
    - By definition of connected, there is no path between $x$ and $y$, which contradicts with the claim that there is a path in $G$ between $x$ and $y$.
    - By contradiction, $x$ and $y$ are not in same connected component => there is no path in $G$ between $x$ and $y$
  ])

  #concept-block(body: [
    #inline[Corollary 4.5: $x$ and $y$ are in the *same equivalence class* under R $<=>$ $x$ and $y$ are in the *same connected component* in $G$]

    Let $A$ be nonempty set, $R$ an equivalence relation on $A$, $G$ be undirected graph representing $R$

    => Suppose $x$ and $y$ are in the *same equivalence class* under R.
    - $x in [b]_R and y in [b]_R$
    - $x R b, y R b$
    - Since R is symmetric, $y R b => b R y$
    - Since R is transitive, $x R b and b R y => x R y$, $(x,y) in R$
    - By theorem 4.1.1, there exists path between $x$ and $y$ in G.
    - By theorem 4.4, $x$ and $y$ are in the same connected component

    <= Suppose $x$ and $y$ are in the *same connected component* in $G$.
    - There is a path between $x$ and $y$ in G of length $n$ for some $n$
    - By theorem 4.1.1, $(x,y) in R_n$
    - $x R y = x in [y]_R$
    - Since R is equivalence class, R is reflexive, $y R y$, $y in [y]_R$
    - Since $x in [y]_R and y in [y]_R$, $x$ and $y$ are in the same equivalence class.
  ])
])

== Tree
#concept-block(body: [
  *Tree* is a connected, acyclic, undirected graph.

  *Forest* is an acyclic graph (that might not be connected)

  (Theorem 4.6) *Tree Theorem*: the following statement on an undirected graph is equivalent:

  1. $G$ is a tree
  2. removing any edge disconnect $G$
  3. $|E| = |V| - 1$

  #inline[Spanning Tree]
  *Spanning Tree, $T(V,H)$*, is a subgraph of $G(V,E), H subset.eq E$, that is a tree, and consist of all nodes in G.

  (Theorem 4.7) Every finite connected undirected graph has a spanning tree

  #inline[Rooted Tree]

  A *rooted tree, T* is tree with distinguished node called root, $r$.

  *Level* of node $x$ is number of (unique) path from $r$ to $x$
  - Level(r) = 0

  *Height* is maximum level of any node in T.

  For any $x$ and any $y$, $x!= y$ and $y$ in path between $x$ and $y$:

  - $y$ is *ancestor* of $x$
  - $y$ is ancestor of $x =>$ $x$ is *descendant* of $y$

  If $x$ is descendent of $p$ and $"level"(x)= "level"(p) + 1$
  - $p$ is called the *parent* of x
  - $x$ is called *child* of p

  A node with child is called *internal node*
  A node with no child is called a *leaf*

  *Binary Tree* is a rooted tree in which every node has at most 2 children.

  #concept-block(body: [
    #inline[Theorem 4.8: For any binary tree with $m$ leaves and height $h$,$m <= 2^h$]

    Proof by 2PI on h.

    Base Case: Let h = 0.
    - When height = 0, the tree only has root node, and 1 leave
    - $therefore m = 1 <= 2^0 = 1$

    Inductive Hypothesis: Assume the claim is true for all $h <= k$ and $h > 0$

    Inductive Step: Proof the claim is true for $h=k+1$

    - For h = k+1, a new root node is added on the top of the tree. There are two possible cases, for the root node:

    - Case 1 Children:
      - Since new tree only has 1 children, number of leaves for new tree is the same as number of leaves for the tree with height of $k$

      - By I.H, $m <= 2^k = 2^(k+1)$

    - Case 2 Children:
      - Since new tree has 2 children, number of leaves for new tree is sum of number of leaves for both of the children.
      $
        m = m_l + m_h <= 2^k + 2^k <= 2^(k+1)
      $

    - $therefore m <= 2^(k+1)$

    - By 2PI, claim is true for $h>=0$.
  ])



  #concept-block(body: [
    #inline[
      Theorem 4.9: Consider binary tree T, and every parent has 2 children. If $T$ has $m$ leaves, then it has $m-1$ parents
    ]

    Proof by 2PI on $p$

    Base Case. Let $p=0$
    - For $p=0$, the tree has no parent, and no children, and number of leaves 1
    - $therefore p = 0 = 1-1 = m-1$

    Inductive Hypothesis. Assume claim is true, for $p <= k$ for some $k >= 0$

    Inductive Step: Proof claim is true for $p = k+1$
    - For $p=k+1$, a new root node is added to the previous tree with exactly 2 children.

    - Number of leaves, $m$ is addition of number of leaves from left tree, $m_l$ and number of leaves from right tree, $m_r$.

    - Similarly, number of parents $p = p_l + p_r + 1$ where 1 is the newly added root.

    - By I.H, $p_l = m_l - 1$, $p_r = m_r - 1$
    - $p = p_l + p_r +1 = (m_l - 1) + (m_r - 1) + 1 = m_l + m_r + 1= m + 1$

    - $therefore$ claim is true for $p=k+1$

    - $therefore$ By 2PI, claim is true for all $p>=0$.
  ])

])
