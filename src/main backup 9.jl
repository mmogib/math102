### A Pluto.jl notebook ###
# v0.19.27

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

# ╔═╡ 196f8120-431b-11ee-0ec5-2b6391383266
begin
	# import Pkg
	# Pkg.add("PyCall")
	using PyCall
	using SymPy
	using PlutoUI
	using CommonMark
	using Plots, PlotThemes, LaTeXStrings
	using HypertextLiteral
	using Colors
	using Random
end

# ╔═╡ 6f06c858-3279-4e3b-9b51-3536910bd161
@htl("""
<style>
@import url("https://mmogib.github.io/math102/custom.css");
</style>
""")

# ╔═╡ 657f46ac-d024-4853-a793-2d4a2f181936
TableOfContents(title="MATH102")

# ╔═╡ f86a60f7-f8c5-4942-9dad-7c5eb5ca8b00
cm"""
<div style="color:red;font-size:16pt;">

[Syllabus](https://www.dropbox.com/scl/fi/blnlbqsaxakwoexafg4uq/Math102SyllabusT231.pdf?rlkey=fzy43rthbvpb9lnq0seiu4qb4&raw=1)

</div>
"""

# ╔═╡ d72d6d49-c687-41c7-a776-e8abc8db04b0
cm"""
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>300))

</div>
"""

# ╔═╡ 70404cd1-8ce0-4957-9162-265641e92f61
md"""
# 5.2: Area
__Objectives__
> 1. Use sigma notation to write and evaluate a sum.
> 2. Use sigma notation to write and evaluate a sum.
> 3. Approximate the area of a plane region.
> 4. Find the area of a plane region using limits.
## Sigma Notation
"""

# ╔═╡ 52cfed78-4bf4-4596-bf45-7ebca9cdce9b
md""" 
## Area 


In __Euclidean geometry__, the simplest type of plane region is a rectangle. Although people often say that the *formula* for the area of a rectangle is
```math
A = bh
```
it is actually more proper to say that this is the *definition* of the __area of a rectangle__.

For a triangle ``A=\frac{1}{2}bh``

$(Resource("https://www.dropbox.com/s/sfsg0d4ha1m2gc6/triangle_area.jpg?raw=1", :width=>300))
"""

# ╔═╡ 8ea4ac55-81ed-4aba-af98-cdfc0e52a3bc
md"""
## The Area of a Plane Region

__Example__

Use __five__ rectangles to find two approximations of the area of the region lying between the graph of
```math
f(x)=5-x^2
```
and the $x$-axis between $x=0$ and $x=2$.
"""

# ╔═╡ dd6c385b-104c-48fb-a773-311634138512
f(x) = 5 - x^2

# ╔═╡ 22528ddb-263a-4230-8505-d77e83ab7fe9
begin
    ns = @bind n NumberField(2:4000,  default=5)
    as = @bind a NumberField(0:1)
    bs = @bind b NumberField(a+2:10)
    lrs = @bind lr Select(["l" => "Left", "r" => "Right", "m" => "Midpoint", "rnd" => "Random"])

    md"""
    n = $ns  a = $as  b = $bs method = $lrs

    """
end

# ╔═╡ b25ad83b-282b-4a71-8bb0-b2a3dfd7b3f7
@bind showPlot Radio(["show" => "✅", "hide" => "❌"], default="hide")

# ╔═╡ 588d54fb-0b20-41af-9cc3-0472cfac15bc
# @bind showConnc Radio(["show" => "✅", "hide" => "❌"], default="hide")

# ╔═╡ 632fd3cf-e084-4a33-a20c-b51ffba3d188
# (showConnc == "show") ? md"""
#   $$A=\lim_{n\to \infty} R_n =\lim_{n\to \infty} L_n =\frac{22}{3}$$
#   """ : ""

# ╔═╡ 8a198b9e-693d-4d00-99c8-df4bbacc9000
md"## Finding Area by the Limit Definition"

# ╔═╡ 9d231370-6a39-4732-9962-8c2277c2e706
begin
    findingAreaP = plot(0.2:0.1:4, x -> 0.6x^3 - (10 / 3) * x^2 + (13 / 3) * x + 1.4, fillrange=zero, fillalpha=0.35, c=:red, framestyle=:origin, label=nothing, ticks=nothing)
    plot!(findingAreaP, -0.1:0.1:4.1, x -> 0.6x^3 - (10 / 3) * x^2 + (13 / 3) * x + 1.4, c=:green, label=nothing)
    annotate!(findingAreaP, [
        (0.1, 4, text(L"y", 14)),
        (4.1, 0.1, text(L"x", 14)),
        (0.2, -0.1, text(L"a", 14)),
        (4, -0.1, text(L"b", 14)),
        (3.9, 4, text(L"f", 14))
    ])
    cm"""
Find the area of  a plane region bounded above by the graph of a nonnegative, __continuous__ function
```math
y=f(x)
```
The region is bounded below by the `x-`axis and the left and right boundaries of the region are the vertical lines ``x=a`` and ``x=b``
<div class="img-container">

$(Resource("https://www.dropbox.com/s/hnspiptmyybneqn/area_with_lower_and_upper.jpg?raw=1",:width=>400))
</div>
	
    """
end

# ╔═╡ 7d978a1a-1ae3-42e3-be3b-4c2c748ea677
cm"""
- To approximate the area of the region, begin by subdividing the interval  into  subintervals, each of width
```math
\Delta x = \frac{b-a}{n}
```
- The endpoints of the intervals are
```math
{\color{purple}{\overset{a=x_0}{\overbrace{\color{black}{a+0(\Delta x)}}}}} < 
{\color{purple}{\overset{a=x_1}{\overbrace{\color{black}{a+1(\Delta x)}}}}} < 
{\color{purple}{\overset{a=x_2}{\overbrace{\color{black}{a+2(\Delta x)}}}}} < 
\cdots < 
{\color{purple}{\overset{a=x_n}{\overbrace{\color{black}{a+n(\Delta x)}}}}}.
```
- Let
```math
\begin{array}{lcl}
\displaystyle f(m_i) & = & \text{Minimum value of } f(x) \text{ on the }i^{\text{th}}\text{ subinterval} \\
\\
\displaystyle f(M_i) & = & \text{Maximum value of } f(x) \text{ on the }i^{\text{th}}\text{ subinterval} \\
\\
\end{array}
```
-  Define an __inscribed rectangle__ lying inside the ``i^{\text{th}}`` subregion
-  Define an __circumscribed rectangle__ lying outside the ``i^{\text{th}}`` subregion
```math
\left(\text{Area of inscribed rectangle}\right)=
f(m_i)\Delta x \leq f(M_i)\Delta x =
\left(\text{Area of circumscribed rectangle}\right)
```
- The sum of the areas of the inscribed rectangles is called a __lower sum__, and the sum of the areas of the circumscribed rectangles is called an __upper sum__.
```math
\begin{array}{lclcll}
\text{Lower sum}&=&s(n) &=&\displaystyle \sum_{i=1}^n f(m_i)\Delta x & {\color{red}\text{Area of inscribed rectangle}}\\
\\
\text{Upper sum}&=&S(n) &=&\displaystyle \sum_{i=1}^n f(M_i)\Delta x & {\color{red}\text{Area of circumscribed rectangle}}\\
\end{array}
```
- The actual area of the region lies between these two sums.
```math
s(n) \leq \left(\text{Area of region}\right) \leq S(n).
```
"""

# ╔═╡ d0460f4d-2162-4a7e-baa4-1971a37c073c
begin
    ns4 = @bind n4 NumberField(2:4000,  default=5)
    as4 = @bind a4 NumberField(0:1)
    bs4 = @bind b4 NumberField(a4+2:10)
    lrs4 = @bind lr4 Select(["l" => "Left", "r" => "Right"])

    md"""
    n = $ns4  a = $as4  b = $bs4 method = $lrs4

    """
end

# ╔═╡ 6f2239b7-9b87-4fc4-b106-9b8d7c562c73
f4(x) = x^2

# ╔═╡ 059f7df0-3c91-408c-91aa-fa513864e817
x = symbols("x", real=true);

# ╔═╡ 121748ad-633e-4057-aed1-fe55a3aaab06
begin
	rect(x, Δx, xs, f) = Shape([(x, 0), (x + Δx, 0), (x + Δx, f(xs)), (x, f(xs))])
	function reimannSum(f, n, a, b; method="l", color=:green, plot_it=false)
    Δx = (b - a) / n
    x = a:0.1:b
    # plot(f;xlim=(-2π,2π), xticks=(-2π:(π/2):2π,["$c π" for c in -2:0.5:2]))

    (partition, recs) = if method == "r"
        parts = (a+Δx):Δx:b
        rcs = [rect(p - Δx, Δx, p, f) for p in parts]
        (parts, rcs)
    elseif method == "m"
        parts = (a+(Δx/2)):Δx:(b-(Δx/2))
        rcs = [rect(p - Δx / 2, Δx, p, f) for p in parts]
        (parts, rcs)
    elseif method == "l"
        parts = a:Δx:(b-Δx)
        rcs = [rect(p, Δx, p, f) for p in parts]
        (parts, rcs)
    else
        parts = a:Δx:(b-Δx)
        rcs = [rect(p, Δx, rand(p:0.1:p+Δx), f) for p in parts]
        (parts, rcs)
    end
    # recs= [rect(sample(p,Δx),Δx,p,f) for p in partition]
    p = plot(x, f.(x); legend=nothing)
    plot!(p, recs, framestyle=:origin, opacity=0.4, color=color)
    s = round(sum(f.(partition) * Δx), sigdigits=6)
    return plot_it ? (p, s) : s
	end
	@htl("")
end

# ╔═╡ 32a94030-1e05-48dd-9cd6-ec73824002ea
begin
    if showPlot == "show"
        Δx = (b - a) / n
        xx1 = a:0.1:b
		pp1,s = reimannSum(f, n, a, b; method=lr, color=:green, plot_it=true)
        # # plot(f;xlim=(-2π,2π), xticks=(-2π:(π/2):2π,["$c π" for c in -2:0.5:2]))

        # # recs= [rect(sample(p,Δx),Δx,p,f) for p in partition]
        # pp1=plot(xx1,f.(xx1);legend=nothing)
        # pp1 = plot!(xx1, f.(xx1), fillrange=zero, fillalpha=0.35, c=:blue, framestyle=:origin, label=nothing)
        anck1 = (b - a) / 2
        anck2 = f(anck1) / 2
        annotate!(pp1, [(anck1, anck2, L"$S$", 12)])
        annotate!(pp1, [(anck1, f(anck1), L"$y=%$f(x)$", 12)])
		pp1
    end
end

# ╔═╡ 2d285491-37ce-4b4b-a3d0-a2a23fbd8f6a
begin 
		Δx4 = (b4 - a4) / n4
        xx14 = a4:0.1:b4
		pp14,s4 = reimannSum(f4, n4, a4, b4; method=lr4, color=:green, plot_it=true)
		anck14 = (b4 - a4) / 3
        anck24 = f4(anck14)+1 
		sumlabel = lr4 == "r" ? L"S(%$n4)=%$s4" : L"s(%$n4)=%$s4"
        annotate!(pp14, [(0.5, 2.5, sumlabel, 12)])
        annotate!(pp14, [(1.6, f4(1.8), L"$y=%$(f4(x))$", 12)])
		pp14
end

# ╔═╡ 2845f715-b032-493f-a979-782fb70b700e
begin
	function beginBlock(title,subtitle)
		"""<div style="box-sizing: border-box;">
		<div style="display: flex;flex-direction: column;border: 6px solid rgba(200,200,200,0.5);box-sizing: border-box;">
		<div style="display: flex;">
		<div style="background-color: #FF9733;
		    border-left: 10px solid #df7300;
		    padding: 5px 10px;
		    color: #fff!important;
		    clear: left;
		    margin-left: 0;font-size: 112%;
		    line-height: 1.3;
		    font-weight: 600;">$title</div>  <div style="olor: #000!important;
		    margin: 0 0 20px 25px;
		    float: none;
		    clear: none;
		    padding: 5px 0 0 0;
		    margin: 0 0 0 20px;
		    background-color: transparent;
		    border: 0;
		    overflow: hidden;
		    min-width: 100px;font-weight: 600;
		    line-height: 1.5;">$subtitle</div>
		</div>
		<p style="padding:5px;">
	"""
	end
	function beginTheorem(subtitle)
		beginBlock("Theorem",subtitle)
	end
	function endBlock()
		"""</p></div></div>"""
	end
	function endTheorem()
		 endBlock()
	end
	function example(lable,desc)
		"""<div style="display:flex;">
	<div style="
	font-size: 112%;
	    line-height: 1.3;
	    font-weight: 600;
	    color: #f9ce4e;
	    float: left;
	    background-color: #5c5c5c;
	    border-left: 10px solid #474546;
	    padding: 5px 10px;
	    margin: 0 12px 20px 0;
	    border-radius: 0;
	">$lable:</div>
	<div style="flex-grow:3;
	line-height: 1.3;
	    font-weight: 600;
	    float: left;
	    padding: 5px 10px;
	    margin: 0 12px 20px 0;
	    border-radius: 0;
	">$desc</div>
	</div>"""
	end
	@htl("")
end

# ╔═╡ ca146f79-9ed2-46e2-ba90-b27bcf57aec0
cm"""
$(beginBlock("Sigma Notation",""))

The sum of ``n`` terms  ``a_1, a_2, \cdots, a_n`` is written as
```math
\sum_{i=1}^n a_i = a_1+ a_2+ \cdots+ a_n
```
where ``i`` is the __index of summation__, ``a_i`` is the th __``i``th term__ of the sum, and the upper and lower bounds of summation are ``n`` and ``1``.
$(endBlock())
"""

# ╔═╡ 7222def6-d1fe-4b23-9f69-a485bd1e2468
cm"""
$(beginBlock("Summation Properties",""))

```math

\begin{array}{lcl}
 \displaystyle\sum_{i=1}^n k a_i &=& \displaystyle k\sum_{i=1}^n  a_i \\
\\
 \displaystyle\sum_{i=1}^n (a_i\pm b_i) &=& \displaystyle\sum_{i=1}^n  a_i\pm\sum_{i=1}^n  b_i \\
\\

\end{array} 
```
$(endBlock())

$(beginTheorem("Summation Formulas"))
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

$(endTheorem())


"""


# ╔═╡ 7f16b45b-3147-412d-9261-33cc9de09d37
cm"""
$(example("Example 1","Evaluating a Sum"))
Evaluate ``\displaystyle \sum_{i=1}^n\frac{i+1}{n}`` for ``n=10, 100, 1000`` and ``10,000``.
"""

# ╔═╡ 83a3909a-67a0-4f37-86c0-dfc9c575a52f
cm"""
$(example("Example 4","Finding Upper and Lower Sums for a Region"))
Find the upper and lower sums for the region bounded by the graph of ``f(x)=x^2`` and the ``x-``axis between ``x=0`` and ``x=2``.
"""

# ╔═╡ b2862683-eac6-4153-92e0-9944693c3ccc
cm"""
$(beginTheorem("Limits of the Lower and Upper Sums"))

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
$(endTheorem())
"""

# ╔═╡ 30d3b82f-5dd0-4524-8136-93b31879ae2c
cm"""
$(beginBlock("Definition","Area of a Region in the Plane"))

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

$(endBlock())
"""

# ╔═╡ a003044f-5d2a-4a07-b240-66fe50ebae32
cm"""
$(example("Example 5","Finding Area by the Limit Definition"))

Find the area of the region bounded by the graph of ``f(x)=x^3`` , the ``x``-axis, and the vertical lines ``x=0`` and ``x=1``.

"""

# ╔═╡ e4564cd6-1b68-4d7e-83cc-44d388fec9ed
cm"""
$(example("Example 7","A Region Bounded by the <i>y</i>-axis"))
Find the area of the region bounded by the graph of ``f(y)=y^2`` and the ``y``-axis for ``0\leq y\leq 1``.))
"""

# ╔═╡ 94d2d514-daa7-42af-92ed-5af176c30e12
cm"""
### Midpoint Rule
```math
\textrm{Area} \approx \sum_{i=1}^n f\left(\frac{x_{i-1}+x_i}{2}\right)\Delta x.
```
$(example("Example 8","Approximating Area with the Midpoint Rule"))

Use the Midpoint Rule with ``n=4`` to approximate the area of the region bounded by the graph of ``f(x)=\sin x`` and the ``x``-axis for ``0\leq x\leq \pi``.
"""

# ╔═╡ Cell order:
# ╟─6f06c858-3279-4e3b-9b51-3536910bd161
# ╟─657f46ac-d024-4853-a793-2d4a2f181936
# ╟─f86a60f7-f8c5-4942-9dad-7c5eb5ca8b00
# ╟─d72d6d49-c687-41c7-a776-e8abc8db04b0
# ╟─70404cd1-8ce0-4957-9162-265641e92f61
# ╟─ca146f79-9ed2-46e2-ba90-b27bcf57aec0
# ╟─7222def6-d1fe-4b23-9f69-a485bd1e2468
# ╟─7f16b45b-3147-412d-9261-33cc9de09d37
# ╟─52cfed78-4bf4-4596-bf45-7ebca9cdce9b
# ╟─8ea4ac55-81ed-4aba-af98-cdfc0e52a3bc
# ╠═dd6c385b-104c-48fb-a773-311634138512
# ╟─22528ddb-263a-4230-8505-d77e83ab7fe9
# ╟─b25ad83b-282b-4a71-8bb0-b2a3dfd7b3f7
# ╟─32a94030-1e05-48dd-9cd6-ec73824002ea
# ╟─588d54fb-0b20-41af-9cc3-0472cfac15bc
# ╟─632fd3cf-e084-4a33-a20c-b51ffba3d188
# ╟─8a198b9e-693d-4d00-99c8-df4bbacc9000
# ╟─9d231370-6a39-4732-9962-8c2277c2e706
# ╟─7d978a1a-1ae3-42e3-be3b-4c2c748ea677
# ╟─83a3909a-67a0-4f37-86c0-dfc9c575a52f
# ╟─d0460f4d-2162-4a7e-baa4-1971a37c073c
# ╠═6f2239b7-9b87-4fc4-b106-9b8d7c562c73
# ╟─2d285491-37ce-4b4b-a3d0-a2a23fbd8f6a
# ╟─b2862683-eac6-4153-92e0-9944693c3ccc
# ╟─30d3b82f-5dd0-4524-8136-93b31879ae2c
# ╟─a003044f-5d2a-4a07-b240-66fe50ebae32
# ╟─e4564cd6-1b68-4d7e-83cc-44d388fec9ed
# ╟─94d2d514-daa7-42af-92ed-5af176c30e12
# ╟─059f7df0-3c91-408c-91aa-fa513864e817
# ╟─121748ad-633e-4057-aed1-fe55a3aaab06
# ╟─2845f715-b032-493f-a979-782fb70b700e
# ╠═196f8120-431b-11ee-0ec5-2b6391383266
