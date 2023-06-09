### A Pluto.jl notebook ###
# v0.19.19

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ e93c5882-1ef8-43f6-b1ee-ee23c813c91b
begin
	# import Pkg
	# Pkg.activate(mktempdir())
	# Pkg.add([
	# 	Pkg.PackageSpec(name="ImageIO", version="0.5"),
	# 	Pkg.PackageSpec(name="ImageShow", version="0.3"),
	# 	Pkg.PackageSpec(name="FileIO", version="1.9"),
	# 	Pkg.PackageSpec(name="CommonMark", version="0.8"),
	# 	Pkg.PackageSpec(name="Plots", version="1.16"),
	# 	Pkg.PackageSpec(name="PlotThemes", version="2.0"),
	# 	Pkg.PackageSpec(name="LaTeXStrings", version="1.2"),
	# 	Pkg.PackageSpec(name="PlutoUI", version="0.7"),
	# 	Pkg.PackageSpec(name="Pluto", version="0.14"),
	# 	Pkg.PackageSpec(name="SymPy", version="1.0"),
	#   	Pkg.PackageSpec(name="HypertextLiteral", version="0.7"),
	# 	Pkg.PackageSpec(name="ImageTransformations", version="0.8")
	# ])

	using CommonMark, ImageIO, FileIO, ImageShow
	using PlutoUI
	using Plots, PlotThemes, LaTeXStrings, Random
	using SymPy
	using HypertextLiteral
	using ImageTransformations
	using Dates
	using PrettyTables
end

# ╔═╡ 69d7b791-2e69-490c-8d10-10fa433f0a72
@htl("""
<script src="//unpkg.com/alpinejs" defer></script>
<style>
.img-container {
	display:flex;
	align-items:center;
	flex-direction: column;
}
blockquote {
  background: #0e08bf;
  border-left: 10px solid #0e08bf;
  margin: 1.5em 10px;
}
blockquote:before {
  color: #0e08bf;
  content: open-quote;
  font-size: 3em;
  line-height: 0.1em;
  margin-right: 0.25em;
  vertical-align: -0.4em;
}
blockquote p {
  display: inline;
}
blockquote > ol {
  list-style: none;
  counter-reset: steps;
}
blockquote > ol li {
  counter-increment: steps;
}
blockquote > ol li::before {
  content: counter(steps);
  margin-right: 0.5rem;
  margin-top: 0.5rem;
  background: #ff6f00;
  color: white;
  width: 1.2em;
  height: 1.2em;
  border-radius: 50%;
  display: inline-grid;
  place-items: center;
  line-height: 1.2em;
}
blockquote > ol ol li::before {
  background: darkorchid;
}
</style>
""")

# ╔═╡ ad045108-9dca-4a61-ac88-80a3417c95f2
TableOfContents(title="MATH102 - TERM 222")

# ╔═╡ 1e9f4829-1f50-47ae-8745-0daa90e7aa42
md""" # Chapter 5 

## Section 5.2

"""

# ╔═╡ 9ce352ac-f374-4eb1-9a76-524ffd8a7306
cm"""
> __Objectives__
> 1. Use sigma notation to write and evaluate a sum.
> 2. Use sigma notation to write and evaluate a sum.
> 3. Approximate the area of a plane region.
> 4. Approximate the area of a plane region.

"""

# ╔═╡ 254d027d-ab13-4928-89b5-916dbf5f0044
md"""
### Sigma Notation
The sum of ``n`` terms  ``a_1, a_2, \cdots, a_n`` is written as
```math
\sum_{i=1}^n a_i = a_1+ a_2+ \cdots+ a_n
```
where ``i`` is the __index of summation__, ``a_i`` is the th __``i``th term__ of the sum, and the upper and lower bounds of summation are ``n`` and ``1``.
"""

# ╔═╡ 0edc99ec-c39d-4a9e-af0d-c9778c6b4211
begin 
	hline = html"<hr>"
md"""
####  Summation Properties

```math

\begin{array}{lcl}
 \displaystyle\sum_{i=1}^n c a_i &=& c\sum_{i=1}^n  a_i \\
\\
 \displaystyle\sum_{i=1}^n (a_i+b_i) &=& \sum_{i=1}^n  a_i+\sum_{i=1}^n  b_i \\
\\
\displaystyle\sum_{i=1}^n (a_i-b_i) &=& \sum_{i=1}^n  a_i-\sum_{i=1}^n  b_i \\
\\
\end{array} 
```

#### Summation Formulas

```math
\displaystyle
\begin{array}{ll}
(1) & \displaystyle\sum_{i=1}^n c = cn, \quad c \text{ is a constant} \\
\\
(2) & \displaystyle\sum_{i=1}^n i = \frac{n(n+1)}{2} \\
\\
(3) &\displaystyle \sum_{i=1}^n i^2 =  \frac{n(n+1)(2n+1)}{6} \\
\\
(4) & \displaystyle\sum_{i=1}^n i^3 = \left[\frac{n(n+1)}{2}\right]^2 \\
\\
\end{array} 
```



$hline

"""
end

# ╔═╡ 164b1c78-9f7b-4f9d-a6a6-fbe754cdb43e
md"""
__Example__

Evaluate ``\displaystyle \sum_{i=1}^n\frac{i+1}{n}`` for ``n=10, 100, 1000`` and ``10,000``.

"""

# ╔═╡ b048a772-05c3-4cd0-97ae-5cf825127584
md""" 
### Area 


In __Euclidean geometry__, the simplest type of plane region is a rectangle. Although people often say that the *formula* for the area of a rectangle is
```math
A = bh
```
it is actually more proper to say that this is the *definition* of the __area of a rectangle__.

For a triangle ``A=\frac{1}{2}bh``

$(Resource("https://www.dropbox.com/s/sfsg0d4ha1m2gc6/triangle_area.jpg?raw=1", :width=>300))
"""

# ╔═╡ f16cb891-26d7-41c9-9747-f7d6cd054bc7
md"""
### The Area of a Plane Region

__Example__

Use __five__ rectangles to find two approximations of the area of the region lying between the graph of
```math
f(x)=5-x^2
```
and the $x$-axis between $x=0$ and $x=2$.
"""

# ╔═╡ 8ad65bee-9135-11eb-166a-837031c4bc45
f(x)=5-x^2

# ╔═╡ e7a87684-49b0-428c-9fef-248cf868cf33
begin 
	ns = @bind n  Slider(2:4000,show_value=true, default=4)
	as = @bind a  NumberField(0:1)
	bs = @bind b  NumberField(a+2:10)
	lrs = @bind lr Select(["l"=>"Left","r"=>"Right","m"=>"Midpoint","rnd"=>"Random"])
	
	md"""
	n = $ns  a = $as  b = $bs method = $lrs
	
	"""
end

# ╔═╡ 74f6ac5d-f974-4ea6-801c-b88fe3346e55
@bind showPlot Radio(["show" => "✅", "hide" => "❌"], default="hide")

# ╔═╡ c894d994-a7fc-4e07-8941-e9f9aa89fef0
begin 
	if showPlot=="show"
	Δx =(b-a)/n
	xx1 =a:0.1:b
	
	# plot(f;xlim=(-2π,2π), xticks=(-2π:(π/2):2π,["$c π" for c in -2:0.5:2]))
	
	# recs= [rect(sample(p,Δx),Δx,p,f) for p in partition]
	# pp1=plot(xx1,f.(xx1);legend=nothing)
	pp1 = plot(xx1, f.(xx1), fillrange = zero, fillalpha = 0.35, c = :blue, framestyle=:origin, label=nothing)
	anck1 = (b-a)/2
	anck2 = f(anck1)/2
	annotate!(pp1,[(anck1,anck2,L"$S$",12)])
	annotate!(pp1,[(anck1,f(anck1),L"$y=%$f(x)$",12)])
	end
end

# ╔═╡ 2da325ba-48cc-44b3-be34-e0cb46e33068
@bind showConnc Radio(["show" => "✅", "hide" => "❌"], default="hide")

# ╔═╡ 8436d1b3-c03e-42e6-bbff-e785738e0f89
(showConnc=="show") ? md"""
$$A=\lim_{n\to \infty} R_n =\lim_{n\to \infty} L_n =\frac{22}{3}$$
""" : ""

# ╔═╡ d00038ba-98e9-45db-91df-dc75cb8ec101
begin
	findingAreaP = plot(0.2:0.1:4, x->0.6x^3-(10/3)*x^2+(13/3)*x+1.4, fillrange = zero, fillalpha = 0.35, c = :red, framestyle=:origin, label=nothing,ticks=nothing)
	plot!(findingAreaP,-0.1:0.1:4.1, x->0.6x^3-(10/3)*x^2+(13/3)*x+1.4,c=:green,label=nothing)
	annotate!(findingAreaP, [
			(0.1,4,text(L"y",14)),
			(4.1,0.1,text(L"x",14)),
			(0.2,-0.1,text(L"a",14)),
			(4,-0.1,text(L"b",14)),
			(3.9,4,text(L"f",14))
	])
cm"""
### Finding Area by the Limit Definition

__Find the area of the region is bounded below by the ``x``-axis, and the left and right boundaries of the region are the vertical lines ``x=a`` and ``x=b``.__

$findingAreaP

$(Resource("https://www.dropbox.com/s/hnspiptmyybneqn/area_with_lower_and_upper.jpg?raw=1",:width=>400))
"""
end

# ╔═╡ ef203912-b238-40a7-9d1b-4ed9b86ccbd2
cm"""
__Example__
Find the upper and lower sums for the region bounded by the graph of ``f(x)=x^2`` and the ``x``-axis between ``x=0`` and ``x=2``.
"""

# ╔═╡ 614c0f82-523a-40a6-9b57-d8b16d2b2860
cm"""
__Theorem__ *Limits of the Lower and Upper Sums*

Let ``f`` be continuous and nonnegative on the interval ``[a,b]``. The limits as ``n\to\infty`` of both the lower and upper sums exist and are equal to each other. That is,
```math
\displaystyle \lim_{n\to\infty}s(n)=
\displaystyle \lim_{n\to\infty}\sum_{i=1}^nf(m_i)\Delta x
=\displaystyle \lim_{n\to\infty}\sum_{i=1}^nf(M_i)\Delta x
=\displaystyle \lim_{n\to\infty}S(n)
```
‍
‍
where  
```math
\Delta x = \frac{b-a}{n}
```
and ``f(m_i)`` and ``f(M_i)`` are the minimum and maximum values of ``f`` on the ``i``th subinterval.

"""

# ╔═╡ abd37588-b86f-4e99-8728-5a362ce5f34f
cm"""
__Definition of the Area of a Region in the Plane__
Let ``f`` be continuous and nonnegative on the interval ``[a,b]``.  The area of the region bounded by the graph of ``f`` , the ``x``-axis, and the vertical lines ``x=a`` and ``y=b`` is 
```math
\textrm{Area} = \displaystyle \lim_{n\to\infty}\sum_{i=1}^nf(c_i)\Delta x
```
where 
```math
x_{i-1}\leq c_i\leq x_i\quad \textrm{and}\quad \Delta x =\frac{b-a}{n}.
```
See the grpah
<div class="img-container">

$(Resource("https://www.dropbox.com/s/a3sjz8m9vspp5ec/area_def.jpg?raw=1"))

</div>
"""

# ╔═╡ 1081bd99-7658-4c32-812c-14235bd82596
begin
	cm"""
	__Example__
	
	Find the area of the region bounded by the graph of ``f(x)=x^3`` , the ``x``-axis, and the vertical lines ``x=0`` and ``x=1``.

	"""
end

# ╔═╡ c97d5915-7f1f-4fd6-80d3-aecb256ea0de
cm"""
__Example__

Find the area of the region bounded by the graph of ``f(y)=y^2`` and the ``y``-axis for ``0\leq y\leq 1``.

"""

# ╔═╡ 55084c2d-6f81-4e55-946c-703245a6bb86
cm"""
__Midpoint Rule__

```math
\textrm{Area} \approx \sum_{i=1}^n f\left(\frac{x_{i-1}+x_i}{2}\right)\Delta x.
```
__Example__

Use the Midpoint Rule with ``n=4`` to approximate the area of the region bounded by the graph of ``f(x)=\sin x`` and the ``x``-axis for ``0\leq x\leq \pi``, 
"""


# ╔═╡ 30b561dd-6e6b-4719-abc0-9938099d5487
md""" ## Section 5.3 
### Riemann Sums and Definite Integrals

> __Objectives__
> 1. Understand the definition of a Riemann sum.
> 2. Evaluate a definite integral using limits and geometric formulas.
> 3. Evaluate a definite integral using properties of definite integrals.

"""

# ╔═╡ d854d0ea-c5dd-4efa-9f46-83807339e163
g(x)=√x

# ╔═╡ bceda6d4-b93f-4282-8f03-fc44132ea1bb
begin 
	ns2 = @bind n2  Slider(2:2000,show_value=true, default=4)
	as2 = @bind a2  NumberField(-10:10, default=0)
	bs2 = @bind b2  NumberField(a+1:10)
	lrs2 = @bind lr2 Select(["l"=>"Left","r"=>"Right","m"=>"Midpoint", "rnd"=>"Random"])
	md"""
	n = $ns2  a = $as2  b = $bs2 method = $lrs2
	
	
	"""
end

# ╔═╡ 7a4f6354-3d0c-4814-8c4c-2d2200568545
md"__Use unequal Widths__"

# ╔═╡ 94b4f73a-ee55-405a-be50-bb92048f4eb2
md"""
__Definition of Riemann Sum__
Let ``f`` be defined on the closed interval ``[a,b]``, and let ``\Delta`` be a partition of ``[a,b]`` given by

```math
a=x_0 < x_1 <x_2<\cdots<x_{n-1}<x_n=b
```

where ``\Delta x_i`` is the width of the th subinterval

```math
[x_{i-1},x_i]\quad \color{red}i\textrm{{th subinterval}}
```

‍
‍
If ``c_i``  is any point in the th subinterval, then the sum

```math
\sum_{i=1}^n f(c_i)\Delta x_i, \quad x_{i-1}\leq c_i\leq x_i
```
is called a __Riemann sum__ of ``f`` for the partition ``\Delta``.
"""

# ╔═╡ 9f9345b8-a29a-41fe-a41b-3dcef2e1a366
cm"""
__Remark__

The width of the largest subinterval of a partition ``\Delta`` is the __norm__ of the partition and is denoted by ``\|\Delta\|``. 

- If every subinterval is of equal width, then the partition is __regular__ and the norm is denoted by
```math
\|\Delta\| = \Delta x =\frac{b-a}{n} \quad \color{red}{\textrm{Regular partition}}
```

- For a general partition, the norm is related to the number of subintervals of ``[a,b]`` in the following way.
```math
\frac{b-a}{\|\Delta\|}\leq n \quad \color{red}{\textrm{General partition}}
```

- Note that
```math
\|\Delta\|\to 0 \quad \textrm{implies that}\quad n\to \infty.
```

"""

# ╔═╡ ae6ea7e0-f6f3-4d82-a45d-2c5ed299b223
cm"""
### Definition of Definite Integral
If ``f`` is defined on the closed interval ``[a,b]`` and the limit of Riemann sums over partitions ``\Delta`` 
```math
\lim_{\|\Delta\|\to 0}\sum_{i=1}^nf(c_i)\Delta x_i
```
‍
exists, then ``f`` is said to be __integrable__ on ``[a,b]`` and the limit is denoted by
```math
\lim_{\|\Delta\|\to 0}\sum_{i=1}^nf(c_i)\Delta x_i = \int_a^b f(x) dx.
```
‍
‍The limit is called the __definite integral__ of ``f`` from ``a`` to ``b``. The number ``a`` is the __lower limit__ of integration, and the number ``b`` is the __upper limit__ of integration.
"""

# ╔═╡ fd726227-f911-4383-90a7-aaab504b68ef
cm"""
__Theorem__ *Continuity Implies Integrability*

If a function ``f`` is continuous on the closed interval ``[a,b]``, then ``f`` is integrable on ``[a,b]``. That is, 

```math
\int_a^b f(x) dx \quad \textrm{exists}.
```

"""

# ╔═╡ d76afcb0-4b38-463d-add1-a58dd6acbbc0
cm"""
__Theorem__ *The Definite Integral as the Area of a Region*

If ``f`` is continuous and nonnegative on the closed interval ``[a,b]``, then the area of the region bounded by the graph of ``f``, the ``x``-axis, and the vertical lines ``x=a`` and ``x=b`` is
```math
\textrm{Area} = \int_a^b f(x) dx
```
‍
‍
"""

# ╔═╡ e7ea2eb7-b394-4ce6-b0a9-31d229e69787
cm"""
__Example__

Evaluate each integral using a geometric formula.

- ``\int_1^3 4 dx``
- ``\int_0^3 (x+2) dx``
- ``\int_{-2}^2 \sqrt{4-x^2} dx``
```
"""

# ╔═╡ 0a344b61-a226-49ee-ba19-f618390db269
md"""
* The definite integral  is a **number**; it does not depend on ``x``. In fact, we could use any letter in place of ``x`` without changing the value of the integral:

```math
\int_a^b f(x) dx = \int_a^b f(y) dy =\int_a^b f(w) dw =\int_a^b f(😀) d😀 
```
"""

# ╔═╡ 4d72f4f3-1dbc-49b9-894f-a521a24e2531
md""" 
* The sum ``\sum_{i=1}^n f(x_i^*)\Delta x`` is called **Riemann Sum**.
"""

# ╔═╡ e427ab16-9d5a-4200-8d96-8e49ec0da312
begin
	f2(x) = sin(x)+2 
	theme(:wong)
	x = 1:0.1:5
	y = f2.(x)
	p3=plot(x,y, label=nothing)
	plot!(p3,x,y/2,ribbon=y/2, linestyle=:dot,linealpha=0.1, framestyle=:origin, xticks=(1:5,[:a,"","","",:b]), label=nothing, ylims=(-1,4))
	annotate!(p3,[(3.5,2.5,L"y=f(x)"),(5.2,0,L"x"),(0.2,4,L"y")])
	# annotate!(p2,[(4,0.51,(L"$\sum_{i=1}^{%$n2} f (x^*_{i})\Delta x=%$s2$",12))])
	
	md""" * If ``f(x)\ge 0``, the integral ``\int_a^b f(x) dx`` is the area under the curve ``y=f(x)`` from ``a`` to ``b``.	
	
	$p3
	"""

end

# ╔═╡ 4e0ef31d-05e7-4974-9282-fa4579e16328
md""" * ``\int_a^b f(x) dx`` is the net area

$(load(download("https://www.dropbox.com/s/ol9l38j2a53usei/note3.png?raw=1")))
"""

# ╔═╡ 2bef2339-7afe-427d-bdc5-19b9e9b43878
begin 
	s52q1Check = @bind s52q1chk Radio(["show"=>"show","hide"=>"hide"],default="hide")
	q1Img = download("https://www.dropbox.com/s/7esby3czioyzk26/q1.png?dl=0")
md""" 
**Question 1:** 

$(load(q1Img))

where each of the regions ``A, B`` and ``C`` has area equal to 5, then the area between the graph and the x-axis from ``x=-4`` to ``x=2`` is

$(s52q1Check)
	
"""

end

# ╔═╡ 0f3814d4-6ee7-4242-88ea-5ecc7bf752bf
md" the nswer is = **$((s52q1chk ==\"show\") ?  15 : \"\")**" 

# ╔═╡ 05eb2a4e-2552-4bed-9523-d4f4c8760c94
begin 
	s52q1Check1 = @bind s52q1chk1 Radio(["show"=>"show","hide"=>"hide"],default="hide")
	
md""" 
**Question 2:** 

$(load(q1Img))

where each of the regions ``A, B`` and ``C`` has area equal to 5, then 
	``\int_{-4}^2 f(x) dx = `` 

$(s52q1Check1)
	
"""

end

# ╔═╡ 311050cc-9f52-43e0-afca-66d225c837d2
md" the nswer is = **$((s52q1chk1 ==\"show\") ?  -5 : \"\")**" 

# ╔═╡ f5f43417-abcd-4b20-a9ff-be06157b4a02
html"<hr>"

# ╔═╡ e6f0b66d-9efa-4d2d-93a7-0d0d82c7948a
md""" **Theorem**
If ``f`` is continuous on ``[a,b]``, or if ``f`` has only a finite number of jump discontinuities, then ``f`` is integrable on ``[a,b]``; that is, the definite integral ``\int_a^b f(x)dx`` exists.

"""

# ╔═╡ 784142ee-1416-4ccb-a341-0497422009b6
html"<hr>"

# ╔═╡ a42d6141-e2e3-4725-ab00-4183c16461e3
md""" **Theorem**

If ``f`` is integrable on ``[a,b]``, then
```math 
\int_a^b f(x) dx = \lim_{n\to \infty} \sum_{i=1}^n f(x_i)\Delta x 
```
where
```math
\Delta x = \frac{b-a}{n}
```
and
```math
x_i = a+i\Delta x
```
"""



# ╔═╡ 67a805bd-640d-4d88-8d61-8fef8bb23940
md"""
**Question**

What do we mean when we say that a function $f$ is _integrable_?
##### (A) $f$ is continuous.
##### (B) $f$ is differentiable.
##### (C) $f$ has area.
##### (D) $f$ is discotinuous.
##### (E) none of the above.
"""


# ╔═╡ 843fec4c-3a4a-4cb2-881c-9a4e3df6a5bb
cm"""
### Properties of Definite Integrals
- If ``f``  is defined at ``x=a``, then ``\displaystyle \int_a^a f(x) dx =0``.
- If ``f``  is integrable on ``[a,b]``, then ``\displaystyle \int_b^a f(x) dx =- \int_a^b f(x) dx``.
- If ``f`` is integrable on the three closed intervals determined by ``a, b`` and ``c``, then
```math
\int_a^b f(x) dx = \int_a^c f(x) dx + \int_c^b f(x) dx.
```
- If ``f``  and ``g`` are integrable on ``[a,b]`` and ``k`` is a constant, then the functions ``kf`` and ``f\pm g`` are integrable on ``[a,b]``, and
 	1. ``\displaystyle \int_a^b kf(x) dx = k \int_a^b f(x) dx``.
	2. ``\displaystyle \int_a^b \left[f(x)\pm g(x)\right] dx = \int_a^b f(x) dx\pm \int_a^b g(x) dx``.
- If ``f`` is integrable and nonnegative on the closed interval ``[a,b]``, then
```math
0\leq \int_a^b f(x) dx.
```
- If ``f`` and ``g`` are integrable on the closed interval ``[a,b]`` and ``f(x)\leq g(x)`` for every ``x`` in ``[a,b]`` , then
```math
\int_a^b f(x) dx \leq \int_a^b g(x) dx.
```
"""

# ╔═╡ 09383e0f-2b37-459e-aeb3-b8eb4f194ddd
md"""
### Evaluating Definite Integrals

1. Using the definition
2. Using a Computer Algebra System
3. Interpreting as areas
4. Approximating
5. Using integration techniques (tricks)

"""

# ╔═╡ 0cfb00ed-60fe-4ebb-b5e2-6182ace7a719
begin 
	xx = symbols("xx",real=true) 
	sol = integrate(exp(xx),(xx,1,3))
md"""
#### 2. Using a Computer Algebra System

**Example:**

1. Set up an expression for $\int_1^3 e^x dx$ as a limit of sums. 
2. Use a computer algebra system to evaluate the expression
	
**Solution:**
1. In class
"""

end

# ╔═╡ bfd46851-772d-43d4-8875-7d5c5dfb1155
integrate(exp(xx),(xx,1,3))

# ╔═╡ 19b11522-d11c-4fe1-8f74-5dc975d82bc0
md"""
#### 3. Interpreting as areas
**Example:**
Evaluate the following integrals by interpreting each in terms of areas

(i) $\int_0^3  \sqrt{9-x^2} dx$  

(ii) $\int_{-2}^1|x|dx$


(iii) $\int_{-2}^1 xdx$
"""

# ╔═╡ 44c9faca-efb6-493c-b751-9fd69e89ecb4
begin
	f1(x)=sqrt(9-x^2)
	f3(x)=abs(x)
	theme(:wong)
 	pp =plot(f1,xlims=[-4,4],ylims=[-4,4], framestyle=:origin, xtick=-4:1:4,yticks=-4:1:4)
	md"$pp"
end


# ╔═╡ 1ae29d9c-d055-46d8-9a46-0d35a48cc58a
md""" #### 4. Approximating (Midpoint Rule)

```math
\int_a^b f(x) dx \approx \sum_{i=1}^n f(\overline{x_i})\Delta x = \Delta x\left[
f(\overline{x_1})+\cdots+f(\overline{x_n})
\right]
```
```math 
\text{where} \qquad \Delta x = \frac{b-a}{n}
```
```math 
\text{and} \qquad \overline{x_i} = \frac{1}{2}\left(x_{i-1}+x_i\right) = \textrm{midpoint of } [x_{i-1},x_i].
```
**Example**: Use the Midpoint Rule to approximate 
$${\large \int_1^2\frac{1}{x}dx}$$
with $n=5$.

(SOLUTION IN CLASS)

"""

# ╔═╡ 8d474b8c-7f6f-4ee4-9282-5e8aa0a2f7b0
m5 = [0.2*(1/x) for x in 1.1:0.2:1.9] |> sum

# ╔═╡ f9e82107-07b9-4697-88fe-81b019640e6a
integrate(1/xx,(xx,1,2)).n()

# ╔═╡ be9f84d5-3c65-4ceb-8767-3fdc41429e12
md""" **Example**

Estimate 
```math 
\int_0^1 e^{-x^2} dx
```

"""

# ╔═╡ cf3bce53-0260-403c-8910-b04b05b558fe
begin
	exact = integrate(exp(-xx^2),(xx,0,1)).n()
end

# ╔═╡ e3d540a3-7da5-4ef6-aa31-e629e752484e
md"""
**Exercises:**

1. Wrtie as definite integral 
$\lim_{n\to \infty}\sum_{i=1}^n\frac{1}{n}\cos\left(1+\frac{i}{n}\right)^2=$
2. If $\int_{-5}^7f(x)dx=-17, \int_{-5}^{11}f(x)dx=32$, and $\int_{8}^7f(x)dx=5$, then $\int_{11}^8f(x)dx=$

"""

# ╔═╡ 7fb16fd7-feac-4a75-bcf0-cf91ca7b3599
cm"""
## Section 5.4
__The Fundamental Theorem of Calculus__
> __Objectives__
> 1. Evaluate a definite integral using the Fundamental Theorem of Calculus.
> 2. Understand and use the Mean Value Theorem for Integrals.
> 3. Find the average value of a function over a closed interval.
> 4. Understand and use the Second Fundamental Theorem of Calculus.
> 5. Understand and use the Net Change Theorem.

"""

# ╔═╡ dd5ee5ee-b2a7-46d4-bc43-0b9778eefcc2
cm"""
### The Fundamental Theorem of Calculus

__Antidifferentiation and Definite Integration__

<div class="img-container">

$(Resource("https://www.dropbox.com/s/8f52dty2aywwr92/diff_vs_antidiff.jpg?raw=1",:width=>600))

</div>


* ✒ ``\displaystyle \int_a^b f(x) dx``
    * definite integral
    * number              
* ✒ ``\displaystyle \int f(x) dx``
    * indefinite integral 
    * function

__Theorem__ *The Fundamental Theorem of Calculus*

If a function ``f`` is continuous on the closed interval ``[a,b]`` and ``F`` is an antiderivative of ``f`` on the interval ``[a,b]``, then
```math
\int_a^b f(x) dx = F(b) - F(a).
```

__Remark:__

We use the notation 
```math
\int_a^b f(x) dx = \bigl. F(x)\Biggr|_a^b= F(b)-F(a) \quad \textrm{or}\quad 
\int_a^b f(x) dx =\Bigl[F(x)\Bigr]_a^b = F(b)-F(a)
```
"""

# ╔═╡ 4db12c57-014f-4aa0-a5b1-4f12eb3bf834
cm"""
__Example__

Evaluate each definite integral.

- ``\displaystyle \int_1^2 (x^2-3) dx``

$("  ")
- ``\displaystyle \int_1^4 3\sqrt{x} dx``

$("  ")
- ``\displaystyle \int_{0}^{\pi/4} \sec^2 x dx``

$("  ")
- ``\displaystyle \int_{0}^{2} \Big|2x-1\Big| dx``
"""

# ╔═╡ b592499b-cf96-486e-9067-9c79b5894641
begin
	theme(:wong)
	s54e3_f(x) = 1/x
	s54e3_x = 1:0.1:exp(1)
	s54e3_p=plot(s54e3_x,s54e3_f.(s54e3_x), label=nothing,c=:green)
	plot!(s54e3_p,s54e3_x,s54e3_f.(s54e3_x)/2,ribbon=s54e3_f.(s54e3_x)/2, linestyle=:dot,linealpha=0.1, framestyle=:origin, xticks=(1:4,[:1,:2,:3]), label=nothing, ylims=(-0.1,1.5),xlims=(-0.1,3))
	annotate!(s54e3_p,[(2,1,L"y=\frac{1}{x}"),(exp(1),-0.1,L"e")])
	cm"""
		
	__Example__
	
	Find the area of the region bounded by the graph of
	```math
	y=\frac{1}{x}
	```
	the ``x``-axis, and the vertical lines ``x=1`` and ``x=e``.
	

	$s54e3_p
	
	"""
end

# ╔═╡ bfbb3b72-dedc-476d-a028-997e98b61ae4
begin
	cm"""
	### The Mean Value Theorem for Integrals
	
	__Theorem__ *Mean Value Theorem for Integrals*
	
	If ``f`` is continuous on the closed interval ``[a,b]``, then there exists a number ``c`` in the closed interval ``[a,b]`` such that
	```math
	\int_a^b f(x) dx =f(c)(b-a).
	```
	
	<div class="img-container">

	$(Resource("https://www.dropbox.com/s/7fnr2kfq082kq0y/mvt.jpg?raw=1",
	:style=>"display:flex;align-items:center;flex-direction: column;"))
	</div>
	
	"""
end

# ╔═╡ c3650a10-dff3-4fa2-bb56-3a19e1838766
cm"""
### Average Value of a Function

__Definition of the Average Value of a Function on an Interval__

If ``f`` is integrable on the closed interval ``[a.b``, then the __average value__ of ``f`` on the interval is
```math
\textbf{Avergae value} = \frac{1}{b-a}\int_a^b f(x) dx
```

__Example__

Find the average value of ``f(x)=3x^2-2x``  on the interval ``[1,4]``.

"""

# ╔═╡ 16053a54-d268-479b-bd2e-0634c4a1bb89
cm"""
### The Second Fundamental Theorem of Calculus

<div class="img-container">

$(Resource("https://www.dropbox.com/s/knjbngrqs2r2h1z/ftc2.jpg?raw=1",
:style=>"margin-top:20px;"
))

</div>

"""

# ╔═╡ 3b115e62-8040-4a2c-8d6e-3d03669e7cd8
md"""
Consider the following function 

```math 
F(x) = \int_a^x f(t) dt
```
where ``f`` is a continuous function on the interval ``[a,b]`` and ``x \in [a,b]``.

"""

# ╔═╡ 3c16772c-394d-4472-8749-f5990bb69013
begin
	Slider4 = @bind slider4 Slider(1:0.1:5, show_value=false)
	md"x = $Slider4"
end

# ╔═╡ 3644e2e8-9b59-433e-9761-58566f0e1329
begin
	f4(x) = sin(x)+2 
	theme(:wong)
	x4 = 1:0.1:5
	y4 = f4.(x4)
	xVar =1:0.1:slider4
	yVar =f4.(xVar)/2
	p4=plot(x4,y4, label=nothing, grid=false)
	
	plot!(p4,xVar,yVar,ribbon=yVar, linestyle=:dot,linealpha=0.1, framestyle=:origin, xticks=(1:5,[:a,"","","",:b]), label=nothing, ylims=(-1,4))
	plot!(p4,xticks=(x4,[:a,["" for i in 2:length(xVar)-1]...,:x,["" for i in length(xVar):length(x4)-2]...,:b]))
	annotate!(p4,[(3.5,2.5,L"y=f(t)"),(5.2,0,L"t"),(0.2,4,L"y")])
	slider4>1 && annotate!(p4,[(slider4*0.7,1,(L"$F(x)=\int_a^x f(t) dt$",12))])
	
	md"""
	
	$p4
	"""

end

# ╔═╡ b9d687cc-9c13-4285-85ac-90ef955f94f3
begin 
	img = load("./imgs/5.3/ex1.png") |> im -> imresize(im, ratio=0.7)
md"""
**Example** 
If ``g(x) = \int_0^x f(t) dt``

$img

Find ``g(2)`` 

"""
end

# ╔═╡ 0ca459b3-36ad-46f0-b49d-af921c57b9df
cm"""
__Theorem__ *The Second Fundamental Theorem of Calculus*

If ``f`` is continuous on an open interval ``I`` containing ``a``, then, for every ``x`` in the interval,

```math

\frac{d}{dx}\left[\int_a^x f(t) \right] = f(x).
```

"""

# ╔═╡ 02ff212e-937d-4e8e-96d2-5f982618b92d
begin
md"""

##### Remarks
* ``{\large \frac{d}{dx}\left( \int_a^x f(u) du\right) = f(x)}``
* ``g(x)`` is an **antiderivative** of ``f``

##### Examples
Find the derivative of 	
	
(1) ``g_1(x) = \int_0^x \sqrt{1+t} dt``.

(2) ``g_2(x) = \int_x^0 \sqrt{1+t} dt``.
	
(3) ``g_3(x) = \int_0^{x^2} \sqrt{1+t} dt``.
	
(4) ``g_4(x) = \int_{\sin(x)}^{\cos(x)} \sqrt{1+t} dt``.
"""
end

# ╔═╡ c8d0298f-2336-41b8-a4f4-a5be5db751f3
md"""
💣 BE CAREFUL:

Evaluate ``\large \int_{-3}^6 \frac{1}{x}dx``
"""

# ╔═╡ 4d4b41dc-f02f-4404-96c1-bb78376f010b
md"""
**Example:**
Sketch the region enclosed by the given curves and calculuate its area
```math
y=2x-x^2, \quad y=0
```
Solution: In class
"""

# ╔═╡ 018998d3-5c21-468c-b3e8-f413a485eedd
begin 
	pltExmpl = plot(x->2*x-x^2, framestyle=:origin, xlims=(0,2), ylims=(-1,2),fill=(0,0.5,:green), label=nothing)
	plot!(pltExmpl,x->2*x-x^2, framestyle=:origin, xlims=(-1,3), ylims=(-1,2),label=nothing)
end

# ╔═╡ 638eef4b-d46c-453b-ac40-179ce70cc330
ff(x)=2*x-x^2;md""" A=$(integrate(ff(xx),(xx,0,2)))"""

# ╔═╡ b0fb2fbb-0175-4cce-b90d-3f9fa9b4541e
begin

md"""
### Table of Indefinite Integrals

|  | |  |
|--------------|--------------|------- |
| $$\int c f(x) dx =c\int  f(x) dx$$ |    | $\int [f(x)+g(x)] dx =\int  f(x) dx+\int g(x) dx$|
| | | |
|$$\int k dx = kx + C$$ | | $$\int x^n dx = \frac{x^{n+1}}{n+1} + C, n\not=-1$$ 
| | | |
|$$\int \frac{1}{x} dx = \ln \|x\| + C$$  || $$\int e^x dx = e^x + C$$ 
| | | |
|$$\int a^x dx = \frac{a^x}{\ln a}+ C$$  || $$\int \sin x dx = -\cos x + C$$ 
| | | |
|$$\int \cos x dx = \sin x + C$$ || $$\int \sec^2 x dx = \tan x + C$$
| | | |
|$$\int \csc^2 x dx = -\cot x + C$$ || $$\int \sec x\tan x dx = \sec x + C$$
| | | |
|$$\int \frac{1}{x^2+1} dx = \tan^{-1} x + C$$ || $$\int \frac{1}{\sqrt{1-x^2}} dx = \sin^{-1} x + C$$
| | | |
|$$\int \sinh x dx = \cosh x + C$$ || $$\int \cosh x dx = \sinh x + C$$
| | | |
|$$\int \csc x\cot x dx = -\csc x + C$$ ||
| | | |
	


"""
end

# ╔═╡ 0fd76efb-6d98-43f8-b714-8cf54fd62e7d
md"""
__Applications__

**Question:** If $y=F(x)$, then what does $F'(x)$ represents?
### Net Change Theorem 

__Theorem__ *The Net Change Theorem*

If ``F'(x)`` is the rate of change of a quantity ``F(x)`` , then the definite integral of ``F'(x)`` from ``a`` to ``b`` gives the total change, or __net change__, of ``F(x)`` on the interval ``[a,b]``.

```math
\int_a^b F'(x) dx = F(b) - F(a) \qquad \color{red}{\textrm{Net change of } F(x)}
```
- There are many applications, we will focus on one

If an object moves along a straight line with position function ``s(t)``, then its velocity is ``v(t)=s'(t)``, so
```math
\int_{t_1}^{t_2}v(t) dt = s(t_2)-s(t_1) 
```

- **Remarks**
```math
\begin{array}{rcl}
\text{displacement} &=& \int_{t_1}^{t_2}v(t) dt\\
\\
\text{total distance traveled} &=& \int_{t_1}^{t_2}|v(t)| dt \\ \\
\end{array}
```
- The acceleration of the object is ``a(t)=v'(t)``, so
```math
\int_{t_1}^{t_2}a(t) dt = v(t_2)-v(t_1) \quad \text { is the change in velocity from time  to time .}
```

"""

# ╔═╡ 78d480bf-bc4d-48e3-b3aa-100a38d6b4bc
cm"""
**Example**
A particle is moving along aline. Its velocity function (in ``m/s^2``) is given by
```math
v(t)=t^3-10t^2+29t-20,
```
<ul style="list-style-type: lower-alpha;">

<li> What is the <b>displacement</b> of the particle on the time interval 1≤ t≤ 5?</li>
<li>What is the <b>total distance</b> traveled by the particle on the time interval 1≤ t≤ 5?</li>

</ul>
"""

# ╔═╡ bc42cf6d-44be-4244-85de-a10d03884dfd
v(t) = t^3-10*t^2+29*t-20

# ╔═╡ 78d284e8-bd29-4ec3-9470-2141574787eb
begin

	u = symbols("u",real=true)
	v1(t) = v(t)
	s1(t) = convert(Float64,integrate(v1(u),(u,0,t)).n())

	theme(:default)
	a1,b1 = 1, 5
	t1 = a1:0.1:b1
	timeLength = length(t1)
	xxx = s1.(t1)
	vvv = v1.(t1)
	myXlims = s1(a1) .+ (0,20)
	myYlims = vvv |> ff -> (min(ff...)-1,max(ff...)+1)
	anim =  @animate for i ∈ 1:timeLength
		pp=plot(;layout = (2,1))
		scatter!(pp,(xxx[i],0),
			markersize=5,
			grids=:none,
			framestyle=:origin, 
			showaxis=:x, 
			yticks=nothing, 
			ylims=(-0.4,0.4),
			xlims=myXlims, 
			label=nothing,
			xticks=nothing,
			# xticks=(myXlims[1]:50:myXlims[2],[]),
			tickfontsize=8,
			subplot=1
		)
		plot!(pp,
			t1[1:i],
			vvv[1:i],
			xlims=(0,myXlims[2]),
			ylims=myYlims,
			xticks=(1:5,[:1,:2,:3,:4,:5]),
			framestyle=:origin,
			label=nothing,
			xlabel="x",
			subplot=2,
			title="Velocity Graph"
		)
		annotate!(pp,[(xxx[i],0.2,"time=$(t1[i])")], subplot=1)
		# annotate!(pp,[(5,8.2,("velocity graph",10))], subplot=2)
	end

	html""
end 

# ╔═╡ 9b822e05-ad44-4238-9bfe-4b54d6e42628
begin 
	
	velFun = @bind velfun TextField()
	md"""
	Enter the velocity function
	
	``v(t)`` = $velFun
	
	"""
	html""
end


# ╔═╡ 08e5381c-4cf1-4c70-ba74-26a05b8046fa
md"""
## Section 5.5:
**The Substitution Rule**
> __Objectives__
> 1. Use pattern recognition to find an indefinite integral.
> 2. Use a change of variables to find an indefinite integral.
> 3. Use the General Power Rule for Integration to find an indefinite integral.
> 4. Use a change of variables to evaluate a definite integral.
> 5. Evaluate a definite integral involving an even or odd function.


||||
|------|------|-------|
||solve|||
|$$\int 2x \sqrt{1+x^2} \;\; dx$$|  | $$\int \sqrt{u} \;\; du$$|

"""

# ╔═╡ f3e2034d-e259-4d0b-bca4-95fd17f69d56
cm"### Pattern Recognition"

# ╔═╡ 805cf044-8187-410e-833d-f4323ce07380
begin
	f155(x) = x/sqrt(1-4*x^2)
	# ex1_55=plot(-0.49:0.01:0.49,f155.(-0.49:0.01:0.49), framestyle=:origin)
	cm"""
	__Theorem__ *Antidifferentiation of a Composite Function*
	Let ``g`` be a function whose range is an interval ``I``, and let ``f`` be a function that is continuous on ``I``. If ``g`` is differentiable on its domain and  ``F`` is an antiderivative of ``f`` on ``I``, then
	```math
	\int f(g(x))g'(x)dx = F(g(x)) + C.
	```
	Letting ``u=g(x)`` gives ``du=g'(x)dx`` and
	```math
	\int f(u) du = F(u) + C.
	```

	<div class="img-container">
	
	$(Resource("https://www.dropbox.com/s/uua8vuahfxnp48c/subs_th.jpg?raw=1"))
	
	</div>
	
	**Substitution Rule says:** It is permissible to operate with ``dx`` and ``du`` after integral signs as if they were differentials.
	
	**Example**
	Find 
	```math
	\begin{array}{ll}
	(i) & \int \bigl(x^2+1 \bigr)^2 (2x) dx \\ \\
	(ii) & \int 5e^{5x} dx \\ \\
	(iii) & \int \frac{x}{\sqrt{1-4x^2}} dx \\ \\
	(iv) & \int \sqrt{1+x^2} \;\; x^5 dx \\ \\ 
	(v) & \int \tan x dx \\ \\
	\end{array}
	```
	
	
	"""
end

# ╔═╡ 7549863d-1e44-422f-9ddd-beec2ddcd48d
cm"""
### Change of Variables for Indefinite Integrals
__Example__: Find
```math
	\begin{array}{ll}
	(i) & \int \sqrt{2x-1} dx \\ \\
	(ii) & \int x\sqrt{2x-1} dx \\ \\
	(iii) & \int \sin^23x\cos3x dx \\ \\
	\end{array}
```
	
"""


# ╔═╡ 47d4a0d9-467b-4717-a621-9d37e3870018
cm"""
### The General Power Rule for Integration
__Theorem__ *The General Power Rule for Integration*
If ``g`` is a differentiable function of ``x``, then
```math
\int\bigl[g(x)\bigr]^ng'(x) dx = \frac{\bigl[g(x)\bigr]^{n+1}}{n+1} + C, \quad n\neq -1.
```
‍Equivalently, if ``u=g(x)``, then
```math
\int u^n du = \frac{u^{n+1}}{n+1} + C, \quad n\neq -1.
```
‍
__Example__: Find
```math
	\begin{array}{ll}
	(i) & \int 3(3x-1)^4 dx \\ \\
	(ii) & \int (e^x+1)(e^x+x) dx \\ \\
	(iii) & \int 3x^2\sqrt{x^3-2} \;dx \\ \\
	(iv) & \displaystyle \int \frac{-4x}{(1-2x^2)^2}\; dx \\ \\
	(v) & \int \cos^2 x\sin x \;dx \\ \\
	\end{array}
```
	

"""

# ╔═╡ afdac3e8-bc84-48fd-8a04-d838e038c16d
cm"""
### Change of Variables for Definite Integrals

"""

# ╔═╡ 497ff4cd-2705-49b3-bde6-671352e9b5a0
begin
	ex2fun1(x)=log(x)/x
	ex2fun2(x)=x
	ex2x1 = 1:0.1:exp(1)
	ex2x12 = 0:0.1:1
	ex2x2 = 0.6:0.1:4
	ex2x22 = log(0.6):0.1:log(4)
	
	ex2y1 =ex2fun1.(ex2x1) 
	ex2y12 =ex2fun2.(ex2x12) 
	ex2y2 =ex2fun1.(ex2x2) 
	ex2y22 =ex2fun2.(ex2x22) 
	theme(:wong)
	ex2plt1 = plot(ex2x1,ex2y1, framestyle=:origin, xlims=(0,exp(1)),ylims=(-1,1),fillrange =0,fillalpha=0.5,c=:red,label=nothing)
	plot!(ex2plt1,ex2x2,ex2y2,c=:red,label=nothing)
	xlims!(ex2plt1,-1,4)
	annotate!(ex2plt1,[(2,0.5,L"y=\frac{\ln x}{x}"),(exp(1),-0.05,text(L"e",12))])
	plot!(ex2plt1,[exp(1),exp(1)],[0,ex2fun1(exp(1))],c=:red,linewidth=3,label=nothing)

	ex2plt2 = plot(ex2x12,ex2y12, framestyle=:origin, xlims=(0,1),ylims=(-1,1),fillrange =0,fillalpha=0.5,c=:red,label=nothing)
	plot!(ex2plt2,ex2x22,ex2y22,c=:red,label=nothing)
	xlims!(ex2plt2,-1,4)
	annotate!(ex2plt2,[(2,0.5,L"v=u")])
	# ylims!()
 	# plot!(ex2plt2,ex2x,ex2y, framestyle=:origin, xlims=(1,exp(1)), fillrange =0,fillalpha=0.5,c=:red)
	# xlims!(ex2plt1,-1,2)
	# plot!(ex2plt1, fill=(0, 0.5, :red), xlims=(1,2))
	md""" 
	### Substitution: Definite Integrals
	**Example:**
		Evaluate
	
	```math
	\begin{array}{ll}
	(i) & \int_1^2 \frac{dx}{\left(3-5x\right)^2} \\ \\
	(ii) & \int_1^e \frac{\ln x}{x} dx \\ \\ 
	(iii) & \int_0^1 x(x^2+1)^3 \;dx \\ \\ 
	(iv) & \int_1^5 \frac{x}{\sqrt{2x-1}}\;dx \\ \\ 
	\end{array}
	```
	$ex2plt1	

	$ex2plt2
	
	"""
end

# ╔═╡ 3feca2ed-ff05-4c1a-a614-b1fd23674741
cm"""
### Integration of Even and Odd Functions
"""

# ╔═╡ 297d7fdb-0117-4bd1-adee-8ad640dbf025
md"""
**Integrals of Symmetric Functions**

Suppose ``f`` is continuous on **``[-a,a]``**.

* If ``f`` is **even** ``\left[f(-x)=f(x)\right]``, then 
```math
\int_{-a}^a f(x) dx = 2\int_0^a f(x) dx
```

* If ``f`` is **odd** ``\left[f(-x)=-f(x)\right]``, then 
```math
\int_{-a}^a f(x) dx = 0
```

**Example**
Find 
```math
\int_{-1}^1 \frac{\tan x}{1+x^2+x^4} dx 
```

"""

# ╔═╡ 5bca98c2-c6ef-4e95-a2c6-e99dd88b966b
cm"""
## Section 5.7
__The Natural Logarithmic Function: Integration__
> __Objectives__
> 1. Use the Log Rule for Integration to integrate a rational function.
> 2. Integrate trigonometric functions.
"""

# ╔═╡ 69dc2182-fb24-4db9-9fe6-dc6d9527facd
cm"""
### Log Rule for Integration

__Theorem__ *Log Rule for Integration*

Let ``u``  be a differentiable function of ``x``.
```math
	\begin{array}{llll}
	\textrm{(i) }& \displaystyle \int \frac{1}{x} dx &=& \ln|x| + C  \\ \\
	\textrm{(ii) }& \displaystyle \int \frac{1}{u} du &=& \ln|u| + C  \\ \\
	\end{array}
```

__Remark__
```math
 \displaystyle \int \frac{u'}{u} dx = \ln|u| + C
```
"""

# ╔═╡ 703db4e5-e64a-4b09-ba22-c2808719fd58
cm"""
__Example__

Find the area of the region bounded by the graph of
```math
y = \frac{x}{x^2+1}
```
the ``x``-axis, and the line ``x=3``.
"""

# ╔═╡ 47f63585-6b16-4545-bdf6-5cd7ed470a82
cm"""
__Examples__ Find
```math
	\begin{array}{llll}
	\textrm{(i) }& \displaystyle \int \frac{1}{4x-1} dx   \\ \\
	\textrm{(ii) }& \displaystyle \int \frac{3x^2+1}{x^3+x} dx   \\ \\
	\textrm{(iii) }& \displaystyle \int \frac{\sec^2x}{\tan x} dx   \\ \\
	\textrm{(iv) }& \displaystyle \int \frac{x^2+x+1}{x^2+1} dx   \\ \\
	\textrm{(v) }& \displaystyle \int \frac{2x}{(x+1)^2} dx   \\ \\
	\end{array}
```
"""

# ╔═╡ a1a49662-a13b-430b-b1d5-47f8f3e72f65
cm"""
__Example__ Solve the differential equation
```math
\frac{dy}{dx}=\frac{1}{x\ln x}
```
"""

# ╔═╡ 8ff69555-f7f8-4401-82c6-e27cdf65dff3
cm"""
### Integrals of Trigonometric Functions
__Example__
```math
\int \tan x dx, \quad \int \sec x dx
```

"""

# ╔═╡ 9f7d1862-b413-4292-84da-7c1d76530764
cm"""
__Remark__ Add the following to your table of antiderivatives
```math
	\begin{array}{llll}
	\displaystyle \int \sin u du &=& -\cos u + C &\qquad&  \displaystyle \int \cos u du &=& \sin u + C \\ \\

	\displaystyle \int \tan u du &=& -\ln|\cos u| + C &\qquad&  \displaystyle \int \cot u du &=& \ln|\sin u| + C \\ \\


	\displaystyle \int \sec u du &=& \ln|\sec u +\tan u| + C &\qquad&  \displaystyle \int \csc u du &=& -\ln|\csc u +\cot u| + C \\ \\
	\end{array}
```

"""

# ╔═╡ d6f0452c-cefa-49ee-87ec-a92811880ed4
cm"""
__Example__ 

Evaluate ``\displaystyle \int_{0}^{\pi/4}\sqrt{1+\tan^2 x}dx``

"""

# ╔═╡ da7c0cb8-1d2a-436a-bbb5-b53522dbd755
cm"""
## Section 5.8
### Inverse Trigonometric Functions: Integration
> __Objectives__
> 1. Integrate functions whose antiderivatives involve inverse trigonometric functions.
> 2. Use the method of completing the square to integrate a function.
> 3. Review the basic integration rules involving elementary functions.
"""

# ╔═╡ 04ce6f4c-1581-4ae1-9e9c-8d4dc75b01c7
cm"""
### Integrals Involving Inverse Trigonometric Functions
__Theorem__

Let ``u`` be a differential function of ``x``, and let ``a>0``.
```math
\begin{array}{lllll}
\textrm{1.} & \displaystyle \int\frac{du}{\sqrt{a^2-u^2}} &=&\arcsin\frac{u}{a} + C \\ \\

\textrm{2.} & \displaystyle \int\frac{du}{a^2+u^2} &=&\frac{1}{a}\arctan\frac{u}{a} + C \\ \\

\textrm{3.} & \displaystyle \int\frac{du}{u\sqrt{u^2-a^2}} &=&\frac{1}{a}\text{arcsec}\frac{|u|}{a} + C \\ \\
\end{array}
```

__Examples__
Find
```math
\begin{array}{lllll}
\textrm{➡} & \displaystyle \int\frac{dx}{\sqrt{4-x^2}}, \\ \\
\textrm{➡} & \displaystyle \int\frac{dx}{2+9x^2}, \\ \\
\textrm{➡} & \displaystyle \int\frac{dx}{x\sqrt{4x^2-9}}, \\ \\
\textrm{➡} & \displaystyle \int\frac{dx}{\sqrt{e^{2x}-1}}, \\ \\
\textrm{➡} & \displaystyle \int\frac{x+2}{\sqrt{4-x^2}}dx. \\ \\
\end{array}
```
"""

# ╔═╡ 97a73cbe-6874-4641-9ad8-66df1e8c58c1
cm"""
### Completing the Square
__Example__
Find
```math
\int\frac{dx}{x^2-4x+7}.
```
__Example__

Find the area of the region bounded by the graph of
```math
f(x) = \frac{1}{\sqrt{3x-x^2}}
```
the ``x``-axis, and the lines ``x=\frac{3}{2}`` and ``x=\frac{9}{4}``.
"""

# ╔═╡ a1439122-d0e6-4f02-9039-41edc141f64f
cm"""
## Section 5.9
__Hyperbolic Functions__

> __Objectives__
> 1. Develop properties of hyperbolic functions.
> 2. Differentiate and integrate hyperbolic functions.
> 3. Develop properties of inverse hyperbolic functions.
> 4. Differentiate and integrate functions involving inverse hyperbolic functions.

### Hyperbolic Functions

__Circle__: ``x^2+y^2=1``

<div class="img-container">

$(Resource("https://www.dropbox.com/s/c53yvdcyul4vvlz/circle.jpg?raw=1"))

</div>

__Hyperbola__: ``-x^2+y^2=1``

<div class="img-container">

$(Resource("https://www.dropbox.com/s/iy6fw024c6r50f8/hyperbola.jpg?raw=1"))

</div>


"""

# ╔═╡ e306b52c-0508-4314-9358-a12aca62ea9e
cm"""
__Definitions of the Hyperbolic Functions__
```math
\begin{array}{lllllll}
\sinh x &=& \displaystyle \frac{e^x-e^{-x}}{2} &\qquad& 
\text{csch}\; x &=& \displaystyle \frac{1}{\sinh x},\; x\neq 0\\ \\
\cosh x &=& \displaystyle \frac{e^x+e^{-x}}{2} &\qquad& 
\text{sech}\; x &=& \displaystyle \frac{1}{\cosh x}\\ \\
\tanh x &=& \displaystyle \frac{\sinh x}{\cosh x} &\qquad& 
\text{coth}\; x &=& \displaystyle \frac{1}{\tanh x},\; x\neq 0\\ \\
\end{array}
```

<div class="img-container">

$(Resource("https://www.dropbox.com/s/0q1vcqb77u0ft1t/hyper_graphs.jpg?raw=1"))

</div>
"""

# ╔═╡ 47e805e5-8558-4522-a10c-c3c9ae52b17e
cm"""
__Hyperbolic Identities__
```math
\begin{array}{rllllll}
\cosh^2 x - \sinh^2 x &=& 1, &\qquad& 
\sinh (x+y)\;  &=& \sinh x\cosh y +\cosh x\sinh y\\ \\

\tanh^2 x + \text{sech}^2 x &=& 1, &\qquad& 
\sinh (x-y)\;  &=& \sinh x\cosh y -\cosh x\sinh y\\ \\


\coth^2 x - \text{csch}^2 x &=& 1, &\qquad& 
\cosh (x+y)\;  &=& \cosh x\cosh y +\sinh x\sinh y\\ \\

 &&  &\qquad& 
\cosh (x-y)\;  &=& \cosh x\cosh y -\sinh x\sinh y\\ \\

\sinh^2 x &=& \displaystyle\frac{\cosh 2x -1}{2}, &\qquad& 
\cosh^2 x\;  &=& \displaystyle\frac{\cosh 2x +1}{2}\\ \\


\sin 2x &=& 2\sinh x\cosh x, &\qquad& 
\cosh 2x\;  &=& \cosh^2 x +\sinh^2 x\\ \\


\end{array}
```
"""

# ╔═╡ 21b53a25-5fef-4ac5-aab0-59232566c5d2
cm"""
### Differentiation and Integration of Hyperbolic Functions

__Theorem__ Let ``u`` be a differentiable function of ``x``.
```math
\begin{array}{rllllll}
\displaystyle \frac{d}{dx}\left(\sinh u\right) &=& \left(\cosh u\right)u', &\qquad& 
\displaystyle \int \cosh u du  &=& \sinh u \; +\; C\\ \\

\displaystyle \frac{d}{dx}\left(\cosh u\right) &=& \left(\sinh u\right)u', &\qquad& 
\displaystyle \int \sinh u du  &=& \cosh u \; +\; C\\ \\

\displaystyle \frac{d}{dx}\left(\tanh u\right) &=& \left(\text{sech}^2 u\right)u', &\qquad& 
\displaystyle \int \text{sech}^2 u du  &=& \tanh u \; +\; C\\ \\

\displaystyle \frac{d}{dx}\left(\coth u\right) &=& -\left(\text{csch}^2 u\right)u', &\qquad& 
\displaystyle \int \text{csch}^2 u du  &=& -\coth u \; +\; C\\ \\

\displaystyle \frac{d}{dx}\left(\text{sech} u\right) &=& -\left(\text{sech }u \tanh u\right)u', &\qquad& 
\displaystyle \int \text{sech } u\tanh u du  &=& -\text{sech } u \; +\; C\\ \\


\displaystyle \frac{d}{dx}\left(\text{csch} u\right) &=& -\left(\text{csch }u \coth u\right)u', &\qquad& 
\displaystyle \int \text{csch } u\coth u du  &=& -\text{csch } u \; +\; C\\ \\

\end{array}
```

"""

# ╔═╡ 23f24ea9-b33b-4aac-b17d-1f749360bfe7
cm"""
__Examples__

Find
```math
\begin{array}{llll}
\text{(a)} & \displaystyle \frac{d}{dx}\left[\sinh(x^2-3)\right]\\\\
\text{(b)} & \displaystyle \frac{d}{dx}\bigl[\ln\left(\cosh x\right)\bigr]\\\\
\end{array}
```

__Example__

Find the relative extrema of
```math
f(x) = (x-1)\cosh x \; -\; \sinh x.
```

__Example__ Find
```math
\int \cosh 2x \sinh^2 2x dx
```
"""

# ╔═╡ 5a3b6e5c-5e6f-4fcd-be83-325974e42008
cm"""
__Remark__

Power cables are suspended between two towers form a curve with equation
```math
y=a\cosh\frac{x}{a}.
```

<div class="img-container">

$(Resource("https://www.dropbox.com/s/24biyozrcl7mk2q/wire.jpg?raw=1"))

</div>

"""

# ╔═╡ 894378b1-811d-43ac-a700-71350e88ee40
cm"""
### Inverse Hyperbolic Functions

__Theorem__ Inverse Hyperbolic Functions
```math
\begin{array}{llllll}
\textbf{Function} &  & &\qquad& \textbf{Domain}\\ \\

\sinh^{-1}x & = & \ln\left(x+\sqrt{x^2+1}\right) &\qquad& \left(-\infty,\infty\right)\\ \\

\cosh^{-1}x & = & \ln\left(x+\sqrt{x^2-1}\right) &\qquad& \left[1,\infty\right)\\ \\

\tanh^{-1}x & = & \displaystyle\frac{1}{2}\ln\left(\frac{1+x}{1-x}\right) &\qquad& \left(-1,1\right)\\ \\


\coth^{-1}x & = & \displaystyle\frac{1}{2}\ln\left(\frac{x+1}{x-1}\right) &\qquad& \left(-\infty,-1\right)\cup \left(1,\infty\right)\\ \\


\text{sech}^{-1}x & = & \displaystyle\ln\left(\frac{1+\sqrt{1-x^2}}{x}\right) &\qquad& \left(0,1\right]\\ \\

\text{csch}^{-1}x & = & \displaystyle\ln\left(\frac{1}{x}+\frac{\sqrt{1+x^2}}{|x|}\right) &\qquad& \left(-\infty,0\right)\cup \left(0,\infty\right)\\ \\

\end{array}
```

<div class="img-container">

$(Resource("https://www.dropbox.com/s/yc0305sd3i8yr44/inverse_hyper_graphs.jpg?raw=1"))

</div>

"""

# ╔═╡ 2460d407-0fff-44c4-90ec-639f32414f49
embedYouTube(id;title) = """
<div style="display: flex; justify-content: center; flex-direction: column; align-items: center;">

<h5>$title </h5>

<div  notthestyle="position: relative; right: 0; top: 0; z-index: 300;">
	<iframe width="400" height="250" src="https://www.youtube.com/embed/$id" 	title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
</div>"""

# ╔═╡ ad3dd437-7cfc-4cdc-a951-15949d39cf15
rect(x,Δx,xs,f)=Shape([(x,0),(x+Δx,0),(x+Δx,f(xs)),(x,f(xs))])
#Shape(x .+ [0,Δx,Δx,0], [0,0,f(xs),f(xs)])

# ╔═╡ a9d0c669-f6d7-4e5f-8f57-b6bffe1710ba
function reimannSum(f,n,a,b;method="l",color=:green, plot_it=false)
	Δx =(b-a)/n
	x =a:0.1:b
	# plot(f;xlim=(-2π,2π), xticks=(-2π:(π/2):2π,["$c π" for c in -2:0.5:2]))
	
	(partition,recs) = if method=="r"
		 parts = (a+Δx):Δx:b
		 rcs = [rect(p-Δx,Δx,p,f) for p in parts]
		 (parts,rcs)
	elseif method=="m"
		parts = (a+(Δx/2)):Δx:(b-(Δx/2))
		rcs = [rect(p-Δx/2,Δx,p,f) for p in parts]
		(parts,rcs)
	elseif method=="l"
		parts = a:Δx:(b-Δx)
		rcs = [rect(p,Δx,p,f) for p in parts]
		(parts,rcs)
	else 
		parts = a:Δx:(b-Δx)
		rcs = [rect(p,Δx,rand(p:0.1:p+Δx),f) for p in parts]
		(parts,rcs)
	end
	# recs= [rect(sample(p,Δx),Δx,p,f) for p in partition]
	p=plot(x,f.(x);legend=nothing)
	plot!(p,recs,framestyle=:origin,opacity=.4, color=color)
	s = round(sum(f.(partition)*Δx),sigdigits=6)
	return plot_it ? (p,s) : s
end

# ╔═╡ d34b4862-9135-11eb-120f-6f82295f0759
begin
	theme(:wong)
	anchor1 = 0.5 
	(p,s)=reimannSum(f,n,a,b;method=lr,plot_it=true)
	
	annotate!(p,[(anchor1,f(anchor1)-2,text(L"$\sum_{i=1}^{%$n} f (x_{i})\Delta x=%$s$",12,n > 500 ? :white : :black))])
	annotate!(p,[(anchor1+0.5,f(anchor1+0.1),text(L"$y=%$f(x)$",12,:black))])
	
	md""" 	
	
	$p
	"""

end

# ╔═╡ 27e1d120-c3e1-4f3d-a263-d63204034814
begin
	left_sum=reimannSum(f,n,a,b;method="l")
	right_sum=reimannSum(f,n,a,b;method="r")
	l_sum_txt = L"R_{%$n}= %$right_sum \leq A\leq %$left_sum =L_{%$n}"
	
	
	l_sum_txt
	
	
end

# ╔═╡ cbf534bd-a329-4bc2-9940-f53a22e6d17e
begin
	theme(:wong)
	
	(p2,s2)=reimannSum(g,n2,a2,b2;method=lr2,color=:blue,plot_it=true)
	
	annotate!(p2,[(0.25,0.8,(L"$\sum_{i=1}^{%$n2} f (x^*_{i})\Delta x=%$s2$",12))])
	
	md""" 	
	
	$p2
	"""

end

# ╔═╡ 6a5d1a86-4b9e-4d65-9bd7-f39ef8b6d9b4
StartPause() = @htl("""
<div>
<button>Start</button>

<script>

	// Select elements relative to `currentScript`
	var div = currentScript.parentElement
	var button = div.querySelector("button")

	// we wrapped the button in a `div` to hide its default behaviour from Pluto

	var count = false

	button.addEventListener("click", (e) => {
		count = !count

		// we dispatch the input event on the div, not the button, because 
		// Pluto's `@bind` mechanism listens for events on the **first element** in the
		// HTML output. In our case, that's the div.

		div.value = count
		div.dispatchEvent(new CustomEvent("input"))
		e.preventDefault()
		button.innerHTML = count? "Pause" : "Start"
	})
	// Set the initial value
	div.value = count

</script>
</div>
""")

# ╔═╡ 5f0d5f9c-f0c4-43cd-8f2a-5d4c18955717
@bind start_animation StartPause()

# ╔═╡ 7d30f1de-0225-4a1e-a76e-3c305615cbe2
if (start_animation)
	gif(anim, "anim_fps125.gif", fps = 10)
end

# ╔═╡ 7f819c41-370f-49b2-9e9b-e3233ac560fd
begin
	velfunTr = replace(velfun,"t"=>"tttt")
	velFun1 = Meta.parse(velfunTr)
	ex= eval(:velFun1)	
	isValidVel = Meta.isexpr(ex,:call)
	function myVel(i)
		global tttt=i
		
		if isValidVel
			return eval(ex) 
		end
	end
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19"
ImageShow = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
ImageTransformations = "02fcd773-0e25-5acc-982a-7f6622650795"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
PlotThemes = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
PrettyTables = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[compat]
CommonMark = "~0.8.6"
FileIO = "~1.15.0"
HypertextLiteral = "~0.9.4"
ImageIO = "~0.6.6"
ImageShow = "~0.3.6"
ImageTransformations = "~0.9.5"
LaTeXStrings = "~1.3.0"
PlotThemes = "~3.0.0"
Plots = "~1.31.7"
PlutoUI = "~0.7.39"
PrettyTables = "~1.3.1"
SymPy = "~1.1.7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "95293e7478a04fa519b1a0a4f98ce36352297b9f"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra"]
git-tree-sha1 = "69f7020bd72f069c219b5e8c236c1fa90d2cb409"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.2.1"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "195c5505521008abea5aee4f96930717958eac6f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.4.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "80ca332f6dcb2508adba68f22f551adb2d00a624"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.3"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "38f7a08f19d8810338d4f5085211c7dfa5d5bdd8"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.4"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "1fd869cc3875b57347f7027521f561cf46d1fcd8"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.19.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "d08c20eef1f2cbc6e60fd3612ac4340b89fea322"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.9"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.CommonEq]]
git-tree-sha1 = "d1beba82ceee6dc0fce8cb6b80bf600bbde66381"
uuid = "3709ef60-1bee-4518-9f2f-acd86f176c50"
version = "0.2.0"

[[deps.CommonMark]]
deps = ["Crayons", "JSON", "URIs"]
git-tree-sha1 = "4cd7063c9bdebdbd55ede1af70f3c2f48fab4215"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.6"

[[deps.CommonSolve]]
git-tree-sha1 = "332a332c97c7071600984b3c31d9067e1a4e6e25"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.1"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "5856d3031cdb1f3b2b6340dfdc66b6d9a149a374"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.2.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Conda]]
deps = ["Downloads", "JSON", "VersionParsing"]
git-tree-sha1 = "6e47d11ea2776bc5627421d59cdcc1296c058071"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.7.0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "681ea870b918e7cff7111da58791d7f718067a19"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.2"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "fb5f5316dd3fd4c5e7c30a24d50643b73e37cd40"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.10.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "5158c2b41018c5f7eb1470d558127ac274eca0c9"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.1"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.Extents]]
git-tree-sha1 = "5e1e4c53fa39afe63a7d356e30452249365fba99"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.1"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "94f5101b96d2d968ace56f7f2db19d0a5f592e28"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.15.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "cf0a9940f250dc3cb6cc6c6821b4bf8a4286cf9c"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.66.2"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "2d908286d120c584abbe7621756c341707096ba4"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.66.2+0"

[[deps.GeoInterface]]
deps = ["Extents"]
git-tree-sha1 = "fb28b5dc239d0174d7297310ef7b84a11804dfab"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.0.1"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "a7a97895780dab1085a97769316aa348830dc991"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.3"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "a32d672ac2c967f3deb8a81d828afc739c838a06"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+2"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "f0956f8d42a92816d2bf062f8a6a6a0ad7f9b937"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.2.1"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "acf614720ef026d38400b3817614c45882d75500"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.4"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "342f789fd041a55166764c351da1710db97ce0e0"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.6"

[[deps.ImageShow]]
deps = ["Base64", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "b563cf9ae75a635592fc73d3eb78b86220e55bd8"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.6"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "ColorVectorSpace", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "8717482f4a2108c9358e5c3ca903d3a6113badc9"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.9.5"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "87f7662e03a649cffa2e05bf19c303e168732d3e"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.2+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "5cd07aab533df5170988219191dfad0519391428"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.3"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "64f138f9453a018c8f3562e7bae54edc059af249"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.4"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "b3364212fb5d870f724876ffcd34dd8ec6d98918"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.7"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "a77b273f1ddec645d1b7c4fd5fb98c8f90ad10a5"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.1"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "1a43be956d433b5d0321197150c2f94e16c0aaa0"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.16"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "361c2b088575b07946508f135ac556751240091c"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.17"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "5d4d2d9904227b8bd66386c1138cf4d5ffa826bf"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "0.4.9"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.MappedArrays]]
git-tree-sha1 = "e8b359ef06ec72e8c030463fe02efe5527ee5142"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.1"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "d9ab10da9de748859a7780338e1d6566993d1f25"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "b34e3bc3ca7c94914418637cb10cc4d1d80d877d"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.3"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "a7c3d1da1189a1c2fe843a3bfa04d18d20eb3211"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.1"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore"]
git-tree-sha1 = "18efc06f6ec36a8b801b23f076e3c6ac7c3bf153"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "1ea784113a6aa054c5ebd95945fa5e52c2f378e7"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.7"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "923319661e9a22712f24596ce81c54fc0366f304"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.1+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e60321e3f2616584ff98f0a4f18d98ae6f89bbb3"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.17+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "e925a64b8585aa9f4e3047b8d2cdc3f0e79fd4e4"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.16"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "03a7a85b76381a3d04c7a1656039197e70eda03d"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.11"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "0044b23da09b5608b4ecacb4e5e6c6332f833a7e"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.2"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "a7a7e1a88853564e551e4eba8650f8c38df79b37"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.1.1"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "8162b2f8547bc23876edd0c5181b27702ae58dce"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.0.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "9888e59493658e476d3073f1ce24348bdc086660"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.0"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "a19652399f43938413340b2068e11e55caa46b65"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.31.7"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "8d1f54886b9037091edf146b517989fc4a09efec"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.39"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "d7a7aef8f8f2d537104f170139553b14dfe39fe9"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.2"

[[deps.PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "53b8b07b721b77144a0fbbbc2675222ebf40a02d"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.94.1"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.Quaternions]]
deps = ["DualNumbers", "LinearAlgebra", "Random"]
git-tree-sha1 = "b327e4db3f2202a4efafe7569fcbe409106a1f75"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.5.6"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "dc84268fe0e3335a62e315a3a7cf2afa7178a734"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.3"

[[deps.RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "e7eac76a958f8664f2718508435d058168c7953d"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.3"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "22c5201127d7b243b9ee1de3b43c408879dff60f"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.3.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays", "Statistics"]
git-tree-sha1 = "3177100077c68060d63dd71aec209373c3ec339b"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "f94f779c94e58bf9ea243e77a37e16d9de9126bd"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "8fb59825be681d451c246a795117f317ecbcaa28"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.2"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d75bda01f8c31ebb72df80a46c88b25d1c79c56d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.7"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "85bc4b051546db130aeb1e8a696f1da6d4497200"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.5"

[[deps.StaticArraysCore]]
git-tree-sha1 = "5b413a57dd3cea38497d745ce088ac8592fbb5be"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.1.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArraysCore", "Tables"]
git-tree-sha1 = "8c6ac65ec9ab781af05b08ff305ddc727c25f680"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.12"

[[deps.SymPy]]
deps = ["CommonEq", "CommonSolve", "Latexify", "LinearAlgebra", "Markdown", "PyCall", "RecipesBase", "SpecialFunctions"]
git-tree-sha1 = "de83b8c89b2744fee5279326fe8e3f4a9b94d1e1"
uuid = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
version = "1.1.7"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "fcf41697256f2b759de9380a7e8196d6516f0310"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.0"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "4ad90ab2bbfdddcae329cba59dab4a8cdfac3832"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.7"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "34db80951901073501137bdbc3d5a8e7bbd06670"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.1.2"

[[deps.VersionParsing]]
git-tree-sha1 = "58d6e80b4ee071f5efd07fda82cb9fbe17200868"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.3.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "58443b63fb7e465a8a7210828c91c08b92132dff"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.14+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "78736dab31ae7a53540a6b752efc61f77b304c5b"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.8.6+1"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╟─69d7b791-2e69-490c-8d10-10fa433f0a72
# ╟─ad045108-9dca-4a61-ac88-80a3417c95f2
# ╟─1e9f4829-1f50-47ae-8745-0daa90e7aa42
# ╟─9ce352ac-f374-4eb1-9a76-524ffd8a7306
# ╟─254d027d-ab13-4928-89b5-916dbf5f0044
# ╟─0edc99ec-c39d-4a9e-af0d-c9778c6b4211
# ╟─164b1c78-9f7b-4f9d-a6a6-fbe754cdb43e
# ╟─b048a772-05c3-4cd0-97ae-5cf825127584
# ╟─f16cb891-26d7-41c9-9747-f7d6cd054bc7
# ╠═8ad65bee-9135-11eb-166a-837031c4bc45
# ╟─e7a87684-49b0-428c-9fef-248cf868cf33
# ╟─74f6ac5d-f974-4ea6-801c-b88fe3346e55
# ╟─c894d994-a7fc-4e07-8941-e9f9aa89fef0
# ╟─d34b4862-9135-11eb-120f-6f82295f0759
# ╟─27e1d120-c3e1-4f3d-a263-d63204034814
# ╟─2da325ba-48cc-44b3-be34-e0cb46e33068
# ╟─8436d1b3-c03e-42e6-bbff-e785738e0f89
# ╟─d00038ba-98e9-45db-91df-dc75cb8ec101
# ╟─ef203912-b238-40a7-9d1b-4ed9b86ccbd2
# ╟─614c0f82-523a-40a6-9b57-d8b16d2b2860
# ╟─abd37588-b86f-4e99-8728-5a362ce5f34f
# ╟─1081bd99-7658-4c32-812c-14235bd82596
# ╟─c97d5915-7f1f-4fd6-80d3-aecb256ea0de
# ╟─55084c2d-6f81-4e55-946c-703245a6bb86
# ╟─30b561dd-6e6b-4719-abc0-9938099d5487
# ╠═d854d0ea-c5dd-4efa-9f46-83807339e163
# ╟─bceda6d4-b93f-4282-8f03-fc44132ea1bb
# ╟─cbf534bd-a329-4bc2-9940-f53a22e6d17e
# ╟─7a4f6354-3d0c-4814-8c4c-2d2200568545
# ╟─94b4f73a-ee55-405a-be50-bb92048f4eb2
# ╟─9f9345b8-a29a-41fe-a41b-3dcef2e1a366
# ╟─ae6ea7e0-f6f3-4d82-a45d-2c5ed299b223
# ╟─fd726227-f911-4383-90a7-aaab504b68ef
# ╟─d76afcb0-4b38-463d-add1-a58dd6acbbc0
# ╟─e7ea2eb7-b394-4ce6-b0a9-31d229e69787
# ╟─0a344b61-a226-49ee-ba19-f618390db269
# ╟─4d72f4f3-1dbc-49b9-894f-a521a24e2531
# ╟─e427ab16-9d5a-4200-8d96-8e49ec0da312
# ╟─4e0ef31d-05e7-4974-9282-fa4579e16328
# ╟─2bef2339-7afe-427d-bdc5-19b9e9b43878
# ╟─0f3814d4-6ee7-4242-88ea-5ecc7bf752bf
# ╟─05eb2a4e-2552-4bed-9523-d4f4c8760c94
# ╟─311050cc-9f52-43e0-afca-66d225c837d2
# ╟─f5f43417-abcd-4b20-a9ff-be06157b4a02
# ╟─e6f0b66d-9efa-4d2d-93a7-0d0d82c7948a
# ╟─784142ee-1416-4ccb-a341-0497422009b6
# ╟─a42d6141-e2e3-4725-ab00-4183c16461e3
# ╟─67a805bd-640d-4d88-8d61-8fef8bb23940
# ╟─843fec4c-3a4a-4cb2-881c-9a4e3df6a5bb
# ╟─09383e0f-2b37-459e-aeb3-b8eb4f194ddd
# ╟─0cfb00ed-60fe-4ebb-b5e2-6182ace7a719
# ╟─bfd46851-772d-43d4-8875-7d5c5dfb1155
# ╟─19b11522-d11c-4fe1-8f74-5dc975d82bc0
# ╟─44c9faca-efb6-493c-b751-9fd69e89ecb4
# ╟─1ae29d9c-d055-46d8-9a46-0d35a48cc58a
# ╠═8d474b8c-7f6f-4ee4-9282-5e8aa0a2f7b0
# ╠═f9e82107-07b9-4697-88fe-81b019640e6a
# ╟─be9f84d5-3c65-4ceb-8767-3fdc41429e12
# ╠═cf3bce53-0260-403c-8910-b04b05b558fe
# ╟─e3d540a3-7da5-4ef6-aa31-e629e752484e
# ╟─7fb16fd7-feac-4a75-bcf0-cf91ca7b3599
# ╟─dd5ee5ee-b2a7-46d4-bc43-0b9778eefcc2
# ╟─4db12c57-014f-4aa0-a5b1-4f12eb3bf834
# ╟─b592499b-cf96-486e-9067-9c79b5894641
# ╟─bfbb3b72-dedc-476d-a028-997e98b61ae4
# ╟─c3650a10-dff3-4fa2-bb56-3a19e1838766
# ╟─16053a54-d268-479b-bd2e-0634c4a1bb89
# ╟─3b115e62-8040-4a2c-8d6e-3d03669e7cd8
# ╟─3c16772c-394d-4472-8749-f5990bb69013
# ╟─3644e2e8-9b59-433e-9761-58566f0e1329
# ╟─b9d687cc-9c13-4285-85ac-90ef955f94f3
# ╟─0ca459b3-36ad-46f0-b49d-af921c57b9df
# ╟─02ff212e-937d-4e8e-96d2-5f982618b92d
# ╟─c8d0298f-2336-41b8-a4f4-a5be5db751f3
# ╟─4d4b41dc-f02f-4404-96c1-bb78376f010b
# ╟─018998d3-5c21-468c-b3e8-f413a485eedd
# ╟─638eef4b-d46c-453b-ac40-179ce70cc330
# ╟─b0fb2fbb-0175-4cce-b90d-3f9fa9b4541e
# ╟─0fd76efb-6d98-43f8-b714-8cf54fd62e7d
# ╟─78d480bf-bc4d-48e3-b3aa-100a38d6b4bc
# ╠═bc42cf6d-44be-4244-85de-a10d03884dfd
# ╟─5f0d5f9c-f0c4-43cd-8f2a-5d4c18955717
# ╟─7d30f1de-0225-4a1e-a76e-3c305615cbe2
# ╟─78d284e8-bd29-4ec3-9470-2141574787eb
# ╟─9b822e05-ad44-4238-9bfe-4b54d6e42628
# ╟─08e5381c-4cf1-4c70-ba74-26a05b8046fa
# ╟─f3e2034d-e259-4d0b-bca4-95fd17f69d56
# ╟─805cf044-8187-410e-833d-f4323ce07380
# ╟─7549863d-1e44-422f-9ddd-beec2ddcd48d
# ╟─47d4a0d9-467b-4717-a621-9d37e3870018
# ╟─afdac3e8-bc84-48fd-8a04-d838e038c16d
# ╟─497ff4cd-2705-49b3-bde6-671352e9b5a0
# ╟─3feca2ed-ff05-4c1a-a614-b1fd23674741
# ╟─297d7fdb-0117-4bd1-adee-8ad640dbf025
# ╟─5bca98c2-c6ef-4e95-a2c6-e99dd88b966b
# ╟─69dc2182-fb24-4db9-9fe6-dc6d9527facd
# ╟─703db4e5-e64a-4b09-ba22-c2808719fd58
# ╟─47f63585-6b16-4545-bdf6-5cd7ed470a82
# ╟─a1a49662-a13b-430b-b1d5-47f8f3e72f65
# ╟─8ff69555-f7f8-4401-82c6-e27cdf65dff3
# ╟─9f7d1862-b413-4292-84da-7c1d76530764
# ╟─d6f0452c-cefa-49ee-87ec-a92811880ed4
# ╟─da7c0cb8-1d2a-436a-bbb5-b53522dbd755
# ╟─04ce6f4c-1581-4ae1-9e9c-8d4dc75b01c7
# ╟─97a73cbe-6874-4641-9ad8-66df1e8c58c1
# ╟─a1439122-d0e6-4f02-9039-41edc141f64f
# ╟─e306b52c-0508-4314-9358-a12aca62ea9e
# ╟─47e805e5-8558-4522-a10c-c3c9ae52b17e
# ╟─21b53a25-5fef-4ac5-aab0-59232566c5d2
# ╟─23f24ea9-b33b-4aac-b17d-1f749360bfe7
# ╟─5a3b6e5c-5e6f-4fcd-be83-325974e42008
# ╟─894378b1-811d-43ac-a700-71350e88ee40
# ╟─2460d407-0fff-44c4-90ec-639f32414f49
# ╟─a9d0c669-f6d7-4e5f-8f57-b6bffe1710ba
# ╟─ad3dd437-7cfc-4cdc-a951-15949d39cf15
# ╟─6a5d1a86-4b9e-4d65-9bd7-f39ef8b6d9b4
# ╟─7f819c41-370f-49b2-9e9b-e3233ac560fd
# ╠═e93c5882-1ef8-43f6-b1ee-ee23c813c91b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
