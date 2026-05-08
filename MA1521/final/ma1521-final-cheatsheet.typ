#import "@preview/boxed-sheet:0.1.2": *
//#import "../src/lib.typ": *

#set text(font: (
  "Times New Roman",
))


#let homepage = link("https://kiritowu.github.io/")[https://kiritowu.github.io/]
#let author = "Zhao Wu"
#let title = "MA1521 Cheat Sheet, AY25/26 S2"

#let my-colors = (
  rgb(190, 149, 196),
  rgb("#f39f71"),
  rgb(102, 155, 188),
  rgb(229, 152, 155),
  rgb("6a4c93"),
  rgb("E0A500"),
  rgb("#934c84"),
  rgb("#934c5a"),
)

#show: boxedsheet.with(
  title: title, // Title of document
  homepage: homepage, // Homepage of author
  authors: author, // Author Name
  write-title: true, // Writes Title on the first page
  title-align: left, // Position of titles in concept box
  title-number: true, // Whether to numbered the title (Default = true)
  title-delta: 2pt, // Fonts delta for title scaling (Default = 1pt)
  scaling-size: false, // Whether to scale the titles (Default = false)
  font-size: 5.5pt, // Size of font (Default = 5.5pt)
  line-skip: 5.5pt, // Size of line-skip (Default = 5.5pt)
  x-margin: 10pt, // Margin on x-axis (Default = 30pt)
  y-margin: 30pt, // Margin on y-axis (Default = 0pt)
  num-columns: 4, // Number of columns (Default = 5)
  column-gutter: 2pt, // Space between columns (Default = 4pt)
  numbered-units: false, // Numbering of units (Default = false)
  color-box: my-colors, // Color scheme of boxes
)

= Mathematical Formulae
== Algebra
#concept-block[
  #inline("Factoring Formulae")
  $
    a^2-b^2 = (a+b) (a-b) \
    a^3 + b^3 = (a+b) (a^2-a b+b^2) \
    a^3 - b^3 = (a-b) (a^2 + a b + b^2) \
  $

  #inline("Quadratic Formulae")
  *Number of roots* of quadratic function
  $
    b^2 - 4a c = 0 "one-root", >0 "two-root", <0 "no-root"
  $

  *Inflection point* of quadratic function:
  $
    x = -b / (2 a)
  $

  *Completing the square* formula:
  $
    a x^2 + b x + c = a(x + b/(2a))^2 + (c - b^2 /(4a))
  $
]

== Trigonometry
#concept-block[
  #inline[Definitions]
  #columns(2)[
    $
      sec x = 1/(cos x) \
      csc x = 1/(sin x) \
    $
    #colbreak()
    $
      tan x = (sin x)/(cos x) \
      cot x = (cos x) / (sin x)
    $]

  #inline[Basic Identities]
  #columns(2)[
    $
      sin (-x) = - sin x \
      cos(-x) = cos x \
      tan(-x) = - tan x \
    $
    #colbreak()
    $
      sin^2x + cos^2x = 1 \
      1 + tan^2x = sec^2x\
      1 + cot^2x = csc^2x
    $
  ]

  #inline[Compound Angle Formulae]
  #columns(2)[
    $
      sin (x+y) = sin x cos y + cos x sin y \
      sin(x-y)=sin x cos y - cos x sin y \
      cos(x+y) = cos x cos y - sin x sin y \
      cos (x - y) = cos x cos y + sin x sin y \
    $
    #colbreak()
    $
      tan (x + y )= (tan x. + tan y) / (1 - tan x tan y) \
      tan (x-y) = (tan x - tan y) / (1 + tan x tan y)
    $
  ]

  #inline[Double Angle Formulae]
  #columns(2)[
    $
      sin 2x = 2sin x cos x \
      tan 2x = (2 tan x) / (1 - tan^2 x)
    $
    #colbreak()
    $
      cos 2x = cos^2x - sin^2x \
      =2 cos^2 x - 1 \
      =1 - 2 sin^2 x \
    $
  ]


  #inline[Formulae for Reducing Power]
  #columns(2)[
    $
      sin^2x = (1-cos 2x)/2 \
      cos^2x = (1+cos 2 x) / 2
    $
    #colbreak()
    $
      sin^3 x = 1/4 (3 sin x + sin 3 x) \
      cos^3 x = 1/4(3 cos x+ cos 3 x)
    $
  ]
  #inline[Hyperbolic Functions]
  #columns(2)[
    $
      sinh x = 1/2 (e^x - e^(-x)) \
      cosh x = 1/2 (e^x + e^(-x)) \
      tanh x = (sinh x) / (cosh x) \
    $
    #colbreak()
    $
      cosh^2 x - sinh^2 x = 1 \
      1-tanh^2 x = sech^2 x \
      coth^2 x - 1 = csch^2 x
    $
  ]
]

== Differentiation
#concept-block[
  #inline[Standard Derivatives]
  #columns(2)[
    $
      d/(d x)(x^n) = n x^(n-1) \
      d/(d x)(ln x) = 1/x \
      d/(d x)(a^x) = a^x ln a \
      d/(d x)(e^x) = e^x \
      d/(d x)(sin x) = cos x \
      d/(d x)(cos x) = - sin x \
      d/(d x)(tan x) = sec^2 x \
      d/(d x)(cot x) = -csc^2 x \
    $
    #colbreak()
    $
      d/(d x)(sec x) =sec x tan x \
      d/(d x)(csc x) = -csc x cot x \
      d/(d x)(sin^(-1)x) = 1/(sqrt(1-x^2)) \
      d/(d x)(cos^(-1)x) = -1/(sqrt(1-x^2)) \
      d/(d x)(tan^(-1)x) = 1/(1+x^2) \
      d/(d x)(sinh x) = cosh x \
      d/(d x)(cosh x) = sinh x \
      d/(d x)(tanh x) = sech^2 x \
    $
  ]
  #inline[Rules of Differentiation]
  Let $u= u(x), v = v(x), y=y(u)$

  #columns(2)[
    - *Sum Rule*
    $
      d/(d x) (u+v) = u'+ v'
    $
    - *Product Rule*
    $
      d/(d x) (u v) = u'v + v' u
    $
    #colbreak()
    - *Quotient Rule*
    $
      d/(d x) (u/v) = (u'v - v'u)/v^2
    $

    - *Chain Rule*
    $
      (d y) / (d x) = (d y) / (d u) dot (d u) / (d x)
    $
  ]

]

== Integrations
#concept-block[
  #inline[Standard Integrals]
  #columns(2)[
    $
      integral x^n d x = (x^(n+1))/(n+1) + C\
      integral 1/x d x = ln|x| + C\
      integral a^x d x = a^x / (ln a) + c\
      integral e^x d x = e^x + C\
      integral sin x d x -cos x + C\
      integral cos x d x = sin x + C\
      integral tan x d x = - ln | cos x | + C\
      integral cot x d x = ln | sin x | + C \
      integral sec x d x = ln | sec x + tan x | + C\
      integral csc x d x = - ln | csc x + cot x | + C\
      integral sec^2 x d x = tan x + C\
    $
    #colbreak()
    $
      integral csc^2 x d x = - cot x + C\
      integral sec x tan x d x = sec x + C\
      integral csc x cot x d x = -csc x + C\
      integral 1/(x^2 + a^2)d x = 1/a tan^(-1) x/a + C\
      integral 1/(x^2 - a^2)d x = 1/(2a) ln |(x-a)/(x+a)|+C\
      integral 1/sqrt(a^2 - x^2)d x = sin^(-1)(x/a) + C \
      integral 1/sqrt(a^2 + x^2)d x = ln abs(x+sqrt(x^2+a^2))+C \
      = sinh^(-1)(x/a)\
      integral 1/sqrt(x^2 - a^2)d x = ln abs(x+sqrt(x^2-a^2)) + C\
      cosh^(-1)(x/a) + C \
      integral 1/(x sqrt(x^2 - a^2))d x = 1/a sec^(-1)|x/a| + C \
    $
  ]
]

= Limits
#concept-block[
  (Two-sided) Limit $L$ is defined as the value of $f$ as $x -> x_0 ("but "x != x_0)$

  $
    lim_(x->x_0) f(x) = L "where" L in {RR , infinity, -infinity} \
    <=> lim_(x->a^-) f(x) = lim_(x->a^+) f(x) = L
  $
]
== Continuity and Discontinuity
#concept-block[

  $f(x)$ is *continuous* at $x=x_0$ when
  $
    lim_(x->x_0) f(x) = f(x_0)
  $

  Else, the function is says to be discontinuous for one of the following reasons:
  - *Removable Discontinuity*
    $
      lim_(x->x_0) f(x) = lim_(x->x_0^+) f(x) = lim_(x->x_0^-) f(x) != f(x_0)
    $
    E.g. $(sin x) / x$ is undefined at $x=0$, but its $lim$ exists at $x=x_0$
  - *Jump Discontinuity*
    $
      lim_(x->x_0^+) f(x) != lim_(x->x_0^-) f(x)
    $
  - *Infinite Discontinuity*
    $
      lim_(x->x_0^+) f(x) = plus.minus infinity or lim_(x->x_0^-) f(x) = plus.minus infinity
    $
  - *Other (ugly) discontinuities*

    Limit does not exists when the function changes every tiny bit of changes in x (e.g. wiggle swigging line)


    #concept-block[
      === Theorem: Differentiable Implies Continuous

      If $f$ is differentiable at $x_0$, then $f$ is continuous at $x_0$.
    ]
]
== Techniques for Evaluating Limits
#concept-block[
  #inline[Limits of Trigonometry]

  $
    lim_(x -> 0) (sin x)/x = 1, lim_(x -> infinity) (sin x)/x = 0 \
    lim_(x-> 0) (1-cos theta)/ theta = 0
  $

  #inline[Limits of Exponential Functions]

  $
    lim_(n -> infinity) (1+1/n)^n = e \
    lim_(n -> infinity) (1+2/n)^(5n) = lim_(m -> infinity) (1+ 2/(2m))^(5 dot 2m) = e^10
  $

  #inline[L'Hôpital's Rule]
  - Simplify limits in indeterminate form (i.e. $0/0 or infinity / infinity$)
  $
    lim_(x->a) f(x) /g(x) = (f'(a)) / (g'(a))
  $
]


= Differentiation

#concept-block[

  #inline[First Principles of Differentiation]
  Derivative of $f$ evaluated at $x=x_0$:
  $
    lim_(Delta x -> 0)(Delta f)/(Delta x) = lim_(Delta x -> 0) (f(x_0 + Delta x)- f(x_0)) /(Delta x)
  $
]



== Methods of Differentiation
#concept-block[
  #inline[Implicit Differentiation]
  - By differentiating w.r.t. $x$ on both LHS and RHS, we may find $f'(x)$ without isolating the function (which is hard sometimes).

  $
    y^n = x^m <=> n y^(n-1) (d y)/(d x) = m x^(m-1) <=> (d y)/(d x) = (m x^(m-1)) / (n y^(n-1))
  $

  #inline[Exponential Function]

  $
    d/(d x)(x^x) = d/(d x)(e^ln(x^x)) = d/(d x)( e^(x ln(x))) = x^x (1+ln x)
  $

  #inline[Differentials]
  $
    d y = f'(x) d x; (d y)/(d x) = f(x) / g(x); g(x) d y = f(x) d x ; integral g(x) d y = integral f(x) d x
  $

]

== Applications of Differentiation
#concept-block[
  #inline[Optimization of Functions / Min-Max Problems]
  Given function $f$, $x$ is *critical point*(s) of a function when *$f'(x) = 0$*
  - Critical point is *minimum when $f''(x) > 0$* ; *maximum when $f''(x) < 0$*

  #inline[Second derivative test]
  Given $f(x,y)$, compute the determinant of *Hessian Matrix* to determine *properties of critical points*.

  $
    "Hessian Matrix" = det(mat(f_(x x), f_(x y); f_(y x), f_(y y))) \
    =cases(
      < 0 | "saddle",
      >0 | f_(x x) > 0 -> "local min" \, f_(x x) < 0 -> "local max",
      =0 | "undetermined"
    )
  $

  #inline[Newton's Methods]
  Iteratively, we may *approximate the root of the function*, through finding the *x-intercept of tangent line*.
  $
    y-f(x_n) = f'(x_n) (x_(n+1) - x_n) " (Eqn of Tangent Line)"\
    (0) -f(x_n) = f'(x_n) (x_(n+1) - x_n) "(At x-intercept, y=0)"\
    x_(n+1) = x_(n) - f(x_(n))/ (f'(x_(n)))
  $

  #inline[Mean-Value Theorem]
  If $f$ is differentiable on $(a,b)$, and continuous on $[a,b]$, then

  $
    (f(b)- f(a))/(b-a) = f'(c), "(for some c", a<c<b ")"
  $

  Gradient of tangent line (c) = Gradient of secant line (a,b)

  We may use MVT to approximate values of a function
  $
    f(x) = f(a) + f'(c)(x-a), a<c<x
  $

  Or Proof an inequalities where f'>0 means an increasing function.

  #inline[Tangent Plane]
  Given $f_x$ and $f_y$ are slopes function of two lines tangent to the graph.

  Equation of the tangent plane to the graph is
  $
    (z-z_0) = f_x (x_0, y_0) (x-x_0) + f_y (x_0, y_0) (y-y_0)
  $

  #inline[Lagrange Multipliers]
  Given functions $f, g$, where $g(x,y,z) = C$ and $f(x,y,z)$ attains maximum / minimum, there exists $lambda in RR$

  $
    nabla f = mat(f_x; f_y; f_z) = lambda mat(g_x; g_y; g_z) = lambda nabla g
  $

]


= Integrations
#concept-block[
  #inline[Anti-Derivatives]
  $
    F(x) = integral f(x) d x
  $

  Where $F$ is anti-derivative of $f$, or in another words $F'(x) = f(x)$

  #inline[Definite Integrals and Riemann Sum]

  $
    integral^b_a f(x) d x = lim_(n -> infinity) sum^n_(k=1) f(x_k) Delta x = lim_(n -> infinity) sum^n_(k=1) f(a + k ((b-a)/n)) (b-a) / n
  $

  #inline[Fundamental Theorem of Calculus]

  *Part 1: (The Antiderivatives)* If $f$ is continuous on $[a,b]$, $F(x) = integral^x_a f(t)d t$ is continuous on $[a,b]$ and differentiable on $(a,b)$, and its derivative is $f(x)$

  $
    F'(x) = d/(d x) integral^x_a f(t) d t = f(x)
  $

  *Part 2: (The Evaluation Theorem)* If $f$ is continuous over $[a,b]$ and $F$ is antiderivative of $f$ on $[a,b]$, then
  $
    integral^b_a f(x) d x = F(b) - F(a)
  $

  *Example FTC1:*
  $
    F(x) = integral^(x^2)_0 sqrt(t) sin t d t , "Let " G(u) := integral^(u)_0 sqrt(t) sin t d t , F(x) = G(u=x^2) \
    F'(x) = G'(u) * 2x = 2 x * sqrt(u) sin u = 2 x^2 sin(x^2)
  $

  #inline[Improper Integrals]
  $
    integral^infinity_a f(x) d x = lim_(M -> infinity) integral^M_a f(x) d x
  $
]

== Methods of Integration
#concept-block[
  #inline[Method of Substitution]
  *Substituting* the complicated expression with $u$ to simplify integration problem.

  $
    u = x^4 + 2 ; d u = 4x^3 d x, d x = 1/(4x^3) d u\
    integral x^3 (x^4+2)^5 d x = 1/4 integral u^5 d u = u^6 / (4(6)) = u^6/24
  $

  #inline[Integration By Parts]
  $
    integral u v' d x = u v - integral u' v d x
  $

  Simplify integration involving *product of two function*, where:
  - $u$ simplifies after differentiating
  - $v'$ is known after integrating


  #inline[Partial Fraction & Long Division]

  *Rational function*, defined ratio of polynomials $P(x)$, $Q(x)$.

  *When degree P < degree Q*, rational functions turns into *partial fractions*

  - With Q factorized to $(x-a)...(x-b)$ with $a,...,b$ are distinct:
    $
      (P(x))/(Q(x)) = (P(x))/((x-a)...(x-b)) = c_a/(x-a) + ... + c_b / (x-b)
    $
    1. To find $c_a$, multiply both side with $(x-a)$ and take $lim x-> a$
      $
        lim_(x->a)(x-a)(P(x))/((x-a)...(x-b)) =lim_(x->a)(x-a) (P(x))/(...(x-b)) = (P(x))/(...(x-a)) = c_a
      $

  - With Q factorized to $(x-a)^n (x-b)$ with $a,b$ distinct
    $
      (P(x))/(Q(x)) = (P(x))/((x-a)^n (x-b)) = c_a_1/(x-a) + c_a_2/(x-a)^n... + c_b / (x-b)
    $

    1. To find $c_a_2$, multiply both side with $(x-a)^n$ and take $lim x-> a_2$
      $
        lim_(x->a_2)((x-a)^n (P(x))/((x-a)(x-a)^n...(x-b)) =(P(x))/((x-a)...(x-b))) = c_a_2
      $
    2. Find $c_b$ using same cover-up method as above
    3. Find $c_a_1$ by substituting $x=0$ (or other dummy x to evaluate)

  *When degree P $>=$ degree Q*, we may use *long division* to split the polynomials into form of 1 + quotient polynomial.

  Example:
  $
    (x^2+x+1)/(x^2 +8x) = (1*(x^2+8x) + (-7x+1))/(x^2 +8x) = 1 + (-7x+1)/(x^2 +8x)
  $

  #align(center)[
    #table(
      columns: 2,
      stroke: none,
      [], [1],
      table.hline(),
      [x^2+8x],
      table.vline(),
      [x^2+x+1],
      table.hline(),
      [], [-7x+1],
    )
  ]

  $$

]

== Applications of Integration
#concept-block[
  #inline[Area under curve]
  Area bounded between f(x) and g(x) from a to b.
  $
    A = integral^(x=b)_(x=a) f(x) - g(x) d x
  $


  #inline[Volume of Solids of Revolution]
  $
    V = integral^(x=b)_(x=a) A(x) "(area)" d x "(width)" \
    "By x-axis"
    V_x = integral^(x=b)_(x=a) pi y^2 d x = integral^(y=d)_(y=c) 2 pi y f(y) d y\
    "By y-axis: " V_y = integral^(y=d)_(y=c) pi x^2 d y = integral^(x=b)_(x=a) 2 pi x f(x) d x
  $

  #inline[Average Value]
  Average value of $y_"avg"$ over interval $(a,b)$ is evaluated as:
  $
    y_("avg") = 1/(b-a)integral^b_a y d x
  $

  #inline[Arc length]

  Arc length of curve $y=f(x)$ from point $A = (a,f(a))$ to point $B = (b, f(b))$ is evaluated as:
  $
    L = sum_i sqrt((Delta x_i)^2 + (Delta y_id)^2) = integral^(x=b)_(x=a) sqrt(1+(f'(x))^2)d x = integral^(t=c)_(t=d) sqrt(x'(t)^2 + y'(t)^2) d t
  $

  #inline[Surface area revolved around axis]

  Area of surface generated by revolving graph of $y=f(x)$ about x-axis is
  $
    S_x = integral^b_a 2 pi f(x) sqrt(1+(f'(x))^2) d x = integral^(t=b)_(t=a) 2 pi y(t) sqrt(x'(t)^2 + y'(t)^2) d t
  $
  and surface generated about y-axis is
  $
    S = integral^d_c 2 pi x sqrt(1+(g'(y))^2) d y
  $
]
== Techniques for Double-Integrals
#concept-block[
  #inline[Exchanging order of integration]
  Double integral may be easier by integrating in different order. Sketch the region, then reverse the limits by finding the new endpoints from the diagram.

  When both endpoint are constant, direct swapping is possible.

  $
    integral^(x=1)_(x=0) integral^(y=sqrt(x))_(y=x) e^y/y d y d x = integral^(y=1)_(y=0) integral^(x=y)_(x=y^2) e^y/y d x d y
  $

  #inline[Change of Variables]
  To simplify a double integral for integrand or bounds of integration, after taking account Scale Factor, J.

  $
    "Jacobian, "J = (partial(u, v))/(partial(x, y)) = det |mat(u_x, u_y; v_x, v_y)| \
    therefore d x d y = 1/(|J|) d u d v .
  $

  #inline[Area, Volume, Mass]
  $
    "Area of Region R" = integral integral_R 1 d A = integral integral_R sqrt(1 + z_x^2 + z_y^2) d x d y \
    "Mass per unit area, M" = integral integral_R delta d A (delta "is density") \
    "Average value of f over R" = 1/"Area" integral integral f d A \
    "Center of Mass" = (#overline[x], #overline[y]) = (1/"mass" integral integral_R x delta d A,...)
  $

  #inline[Polar Coordinates]
  Polar coordinates $P(r, theta)$ are useful to represents circles, where $theta$ is angle from x-axis, and $r$ is its radius. Useful for circles.
  $
    x = r cos theta, y = r sin theta \
    r = sqrt(x^2 + y^2), tan theta = y/x \
    d A_((x,y)) = r A_((r, theta))
  $

  #inline[Cylindrical coordinates]

  Cylindrical coordinates $P(r, theta, z)$ is extension of polar-coordinate, with $z$ as third coordinates. Useful for cylinder.

  $
    d V_((x,y,z)) = r V_((r, theta,z))
  $

  #inline[Spherical Coordinates]

  Spherical coordinates $P(rho, theta, Phi)$ where $rho$ is length from origin, $theta$ is angle in x-y plane, from x-axis. $Phi$ is angle from +ve z-axis. Useful for sphere.

  $
    z = rho cos(Phi); r = rho sin(Phi) \
    d V_((x,y,z)) = rho^2 sin Phi V_((rho, theta, Phi))
  $



]

= Infinite Series and Convergence Tests

== Geometric and Harmonic Series
#concept-block[
  #inline[Geometric Series]
  $
    S = lim_(n -> infinity) sum_(i=1)^n a r^(i-1) = a + a r + a r^2 + a r^3 + ... \
    r (a + a r + a r^2 + a r^3 + ...) = a r + a r^2 + a r^3 + ... = r S \
    (a + a r + a r^2 + a r^3 + ...) - (a r + a r^2 + a r^3 + ...) = S - r S = a\
    therefore S "converges to" a / (1-r) "iff" −1 < a < 1 "else diverges"
  $


  #inline[P-Series / Harmonic Series]
  $
    S = sum^infinity_(n=1) 1/n^p \~= integral^infinity_0 1/x^p d x \
    "Converges:" \
    "When p>1 :" = lim_(a->infinity) integral^a_0 1/x^p d x = lim_(a->infinity)(x^(-p+1))/(-p + 1) |^(x=a)_(x=0) = 1/(p-1) "as -p+1<1"\
    "Diverges:" \
    "When p=1 :"
    = lim_(a-> infinity) integral^a_0 1/x d x = lim_(a-> infinity) ln a = infinity \
    "When p<1 :"= lim_(a->infinity) integral^a_0 1/x^p d x = lim_(a->infinity)(x^(-p+1))/(-p + 1) |^(x=a)_(x=0) = infinity "as -p+1>1"
  $
]
== Convergent Tests
#concept-block[
  #inline[Divergent Test]

  $
    lim_(n -> infinity) a_n != 0 or infinity => "Series Diverge", "else unknown (further test required)"
  $

  #inline[Ratio Test]

  Determine if a function converges absolutely by comparing the ratio of the current term and next term.
  $
    p=lim_(n ->+ infinity)|(a_(n+1))/(a_n)|, p = cases(
      "converge absolutely" | p < 1,
      "diverge" | p > 1,
      "unknown" | p = 1 " (further test required)"
    )
  $

  #inline[Comparison Test]
  Given two series $a_n$, $b_n$ where $forall n, a_n <= b_n$
  - If $b_n$ converges absolutely, $a_n$ converges
  - If $a_n$ diverges, $b_n$ diverges

  $
    S_a := sum_(k=1)^infinity 1/(n+1), S_b := sum^infinity_(k=1) n/(n+1) \
    "Since" a_n < b_n "and" S_a "diverges", "thus" S_b "diverges by Comparison Test"
  $

  #inline[Integral Test]
  $
    f >= 0 "decreasing " and f(n) = a^n \
    integral^infinity_1 f(x) d x "converge" => sum^infinity_(n=1) a_n "converge" \
    integral^infinity_1 f(x) d x "diverge" => sum^infinity_(n=1) a_n "diverge"
  $


  #inline[Alternating Series Test]
  - By Leibniz Alternating series test, an alternating series ($(-1)^k$) converges when:
    - $|a_n|$ decreases monotonically, (i.e. $|a_(n+1)| < |a_n|$) and
    - $lim_(n->infinity)a_n = 0$
    $
      1-1/2+1/3-1/4 +... -> " converges"
    $
  #inline[Absolute and Conditional Convergence]
  - Series converges absolutely if $sum |a_k|$ converge
  - Series converges conditionally if $sum a_k$ converge but $sum |a_k|$ diverge


]

== Taylor's series and Power Series
#concept-block[
  #inline[Power Series]
  - *Power Series* consist of powers of variable $x$ in the form
  $
    sum^infinity_(k=0) c_k x^k = c_0 + c_1 x + c_2 x^2 + ...
  $

  - *Radius of Convergence, R* for power series refers to value of $x$ such that the power series converge when $x in (-R,R)$.
    - If the series diverge, Radius of Convergence is 0.



  #inline[Taylor's Series]
  - *Taylor's Series* approximates a function by finding the relevant coefficient to the power series polynomials.
  $
    f(x) = sum^infinity_(n=0) a_n x^n = a_0x^n + a_1x_1 + ... + a_n x_n + ...\
    "where" a_n = (1/n!)f^((n))(0)
  $
  - Taylor Series at x=a
  $
    f(x) = f(b) + (f'(b))/1! (x-b) + (f''(b))/2! (x-b)^2 + ...
  $
]

== Common Taylor Series
#concept-block[
  $
    1/(1-x) = sum^infinity_(k=0) x^k = 1 + x + x^2 + x^3 + ... ; -1 < x < 1 \
    1/(1+x^2) = sum^infinity_(k=0) (-1)^k x^(2k) = 1 - x^2 + x^4 - x^6 + ... ; -1 < x < 1 \
    e^x = sum^infinity_(k=0) (x^k) / (k!) = 1 + x + (x^2)/(2!) + (x^3)/(3!) + ... ; -infinity < x < + infinity\
    sin x = sum^infinity_(k=0) (-1)^k (x^(2k+1))/(2k+1)! = x - (x^3)/(3!) + (x^5) / 5! - (x^7)/(7!) + ... ; -infinity < x < + infinity \
    cos x = sum^infinity_(k=0) (-1)^k (x^(2k))/(2k)! = 1 - x^2/(2!) + x^4/(4!) - x^6/(6!) + ...; -infinity < x < + infinity \
    ln (1+x) = sum^infinity_(k=1) (-1)^(k+1) x^k/k = x - x^2/2 + x^3/3- x^4/4 + ...; -1<x<=1 \
    tan^-1(x) = sum^infinity_(k=0) (-1)^k (x^(2k+1))/(2k+1) = x - (x^3)/3 + (x^5)/5 - (x^7)/7 + ...; -1 <= x <= 1 \
    sinh (x) = sum^infinity_(k=0) (x^(2k+1))/ (2k+1)! = x + x^3/(3!) + x^5/(5!) + ...; -infinity < x < +infinity \
    cosh (x) = sum^infinity_(k=0) (x^(2k))/ (2k)! = 1 + x^2/(2!) + x^4/(4!) + ...; -infinity < x < +infinity \
    (1+x)^m = 1 + sum^infinity_(k=1) (m (m-1) ... (m-k+1))/(k!) x^k; -1<x<1
  $

]
