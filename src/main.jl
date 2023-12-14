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
	using FileIO, ImageIO, ImageShow, ImageTransformations
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
begin
cm"""
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>300))

</div>
"""
	@htl("")
end

# ╔═╡ 70404cd1-8ce0-4957-9162-265641e92f61
md"""
# 5.2: Area
__Objectives__
> 1. Use sigma notation to write and evaluate a sum.
> 2. Understand the concept of area.
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

# ╔═╡ 5d4e233e-97f6-4953-982b-b0eebce8e08d
begin
	f8(x)=sin(x)
	Δx28 = π/4
	A = Δx28*(f8(π/8)+f8(3π/8)+f8(5π/8)+f8(7π/8))
end

# ╔═╡ f607f9dc-0e79-44f4-af59-6f5f1f1336c8
md"""# 5.3: Riemann Sums and Definite Integrals

> __Objectives__
> 1. Understand the definition of a Riemann sum.
> 2. Evaluate a definite integral using limits and geometric formulas.
> 3. Evaluate a definite integral using properties of definite integrals.

"""

# ╔═╡ 9e04d2f4-6136-408b-89b1-bcbbaec5a3c0
md"## Riemann Sums"

# ╔═╡ e14c9fd5-9d79-493e-9da2-9448ee884667
g(x) = √x

# ╔═╡ 5cdf321b-e477-4218-90ea-c618c8a3ab48
begin
    ns2 = @bind n2 NumberField(2:2000,default=4)
    as2 = @bind a2 NumberField(-10:10, default=0)
    bs2 = @bind b2 NumberField(a+1:10)
    lrs2 = @bind lr2 Select(["l" => "Left", "r" => "Right", "m" => "Midpoint", "rnd" => "Random"])
    md"""
    n = $ns2  a = $as2  b = $bs2 method = $lrs2


    """
end

# ╔═╡ 11de9bf9-63cb-43a7-afcf-e520d22fbc9f
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

# ╔═╡ ab806966-58c1-45c8-a288-421f5dd99e61
md"## Definite Integrals"

# ╔═╡ 1f78f70a-15cd-4ff1-9425-a43636f95c76
md"## Properties of Definite Integrals"

# ╔═╡ 23671b7f-9a5f-433d-94ba-ea6600cbc122
md"""
# 5.4: The Fundamental Theorem of Calculus
> __Objectives__
> 1. Evaluate a definite integral using the Fundamental Theorem of Calculus.
> 2. Understand and use the Mean Value Theorem for Integrals.
> 3. Find the average value of a function over a closed interval.
> 4. Understand and use the Second Fundamental Theorem of Calculus.
> 5. Understand and use the Net Change Theorem.

"""

# ╔═╡ 168e721d-8f96-4e30-a793-d4c9e42355af
md"## The Fundamental Theorem of Calculus"

# ╔═╡ 145e1238-7bc4-4e5b-9cb7-a29697e729d8
cm"""
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
"""

# ╔═╡ 238464cf-619a-4087-8a2f-e053aa1f8bbb
cm"""


<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>300))

</div>
"""

# ╔═╡ cc47cd4c-d43e-4cf2-883c-3809639a66a0
md"## The Mean Value Theorem for Integrals"

# ╔═╡ 6646afce-19f5-4624-96ab-88f9fa9aa782
md"## The Second Fundamental Theorem of Calculus"

# ╔═╡ 7144c868-8876-46f9-b99f-89ab087389f7
cm"""

<div class="img-container">

$(Resource("https://www.dropbox.com/s/knjbngrqs2r2h1z/ftc2.jpg?raw=1",
:style=>"margin-top:20px;"
))

</div>

"""

# ╔═╡ 7c3d2ab5-2720-447d-a9e4-485017580024
md"""
Consider the following function 

```math 
F(x) = \int_a^x f(t) dt
```
where ``f`` is a continuous function on the interval ``[a,b]`` and ``x \in [a,b]``.

"""

# ╔═╡ 7c639bc1-a420-4ce7-99d7-3f0dfd8e964c
begin
    Slider4 = @bind slider4 Slider(1:0.1:5, show_value=false)
    md"x = $Slider4"
end

# ╔═╡ c61d2b1b-9492-4b7b-84eb-0bd92931eaac
begin
    f54(x) = sin(x) + 2
    theme(:wong)
    x4 = 1:0.1:5
    y4 = f54.(x4)
    xVar = 1:0.1:slider4
    yVar = f54.(xVar) / 2
    p4 = plot(x4, y4, label=nothing, grid=false)

    plot!(p4, xVar, yVar, ribbon=yVar, linestyle=:dot, linealpha=0.1, framestyle=:origin, xticks=(1:5, [:a, "", "", "", :b]), label=nothing, ylims=(-1, 4))
    plot!(p4, xticks=(x4, [:a, ["" for i in 2:length(xVar)-1]..., :x, ["" for i in length(xVar):length(x4)-2]..., :b]))
    annotate!(p4, [(3.5, 2.5, L"y=f(t)"), (5.2, 0, L"t"), (0.2, 4, L"y")])
    slider4 > 1 && annotate!(p4, [(slider4 * 0.7, 1, (L"$F(x)=\int_a^x f(t) dt$", 12))])

    md"""

    $p4
    """

end

# ╔═╡ bd61e100-44fb-4c0b-bb37-36710a65a52a
begin
    img = load("./imgs/5.3/ex1.png") |> im -> imresize(im, ratio=0.7)
    md"""
    **Example** 
    If ``g(x) = \int_0^x f(t) dt``

    $img

    Find ``g(2)`` 

    """
end

# ╔═╡ 4c0d1b28-2091-40f4-aa2d-65eea2b3dffa
md"""

__Remarks__
* ``{\large \frac{d}{dx}\left( \int_a^x f(u) du\right) = f(x)}``
* ``g(x)`` is an **antiderivative** of ``f``

__Examples__

Find the derivative of 	
	
(1) ``g_1(x) = \int_0^x \sqrt{1+t} dt``.

(2) ``g_2(x) = \int_x^0 \sqrt{1+t} dt``.
	
(3) ``g_3(x) = \int_0^{x^2} \sqrt{1+t} dt``.
	
(4) ``g_4(x) = \int_{\sin(x)}^{\cos(x)} \sqrt{1+t} dt``.
"""

# ╔═╡ fb700f45-2789-4085-a080-6d1e3d3ec3d1
md"""
💣 BE CAREFUL:

Evaluate ``\large \int_{-3}^6 \frac{1}{x}dx``
"""

# ╔═╡ 1058bdbb-969f-405a-9578-c467286cae33
md"## Net Change Theorem"

# ╔═╡ 5e181bc0-db9a-4ac5-853c-72cd1ed597b7
cm"""
- There are many applications, we will focus on one

If an object moves along a straight line with position function ``s(t)``, then its velocity is ``v(t)=s'(t)``, so
```math
\int_{t_1}^{t_2}v(t) dt = s(t_2)-s(t_1) 
```

- **Remarks**
```math
\begin{array}{rcl}
\text{displacement} &=& \displaystyle \int_{t_1}^{t_2}v(t) dt\\
\\
\text{total distance traveled} &=& \displaystyle \int_{t_1}^{t_2}|v(t)| dt \\ \\
\end{array}
```
- The acceleration of the object is ``a(t)=v'(t)``, so
```math
\int_{t_1}^{t_2}a(t) dt = v(t_2)-v(t_1) \quad \text { is the change in velocity from time  to time .}
```
"""

# ╔═╡ 4e76fbcc-27e8-46d8-9bd0-a339c5ac7508
v(t) = t^3 - 10 * t^2 + 29 * t - 20

# ╔═╡ dbfc14da-c752-46e7-ad24-938d5ea06d61
begin

    u = symbols("u", real=true)
    v1(t) = v(t)
    s1(t) = convert(Float64, integrate(v1(u), (u, 0, t)).n())

    theme(:default)
    a1, b1 = 1, 5
    t1 = a1:0.1:b1
    timeLength = length(t1)
    xxx = s1.(t1)
    vvv = v1.(t1)
    myXlims = s1(a1) .+ (0, 20)
    myYlims = vvv |> ff -> (min(ff...) - 1, max(ff...) + 1)
    anim = @animate for i ∈ 1:timeLength
        pp = plot(; layout=(2, 1))
        scatter!(pp, (xxx[i], 0),
            markersize=5,
            grids=:none,
            framestyle=:origin,
            showaxis=:x,
            yticks=nothing,
            ylims=(-0.4, 0.4),
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
            xlims=(0, myXlims[2]),
            ylims=myYlims,
            xticks=(1:5, [:1, :2, :3, :4, :5]),
            framestyle=:origin,
            label=nothing,
            xlabel="x",
            subplot=2,
            title="Velocity Graph"
        )
        annotate!(pp, [(xxx[i], 0.2, "time=$(t1[i])")], subplot=1)
        # annotate!(pp,[(5,8.2,("velocity graph",10))], subplot=2)
    end
	
	gif(anim, "example_fps15.gif", fps = 10)
end

# ╔═╡ a448117a-921f-42b7-9a25-eedb13db685c
md"""
# 5.5: The Substitution Rule
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

# ╔═╡ 06b9474d-da67-491d-8ea0-1af4c237a349
md"## Pattern Recognition"

# ╔═╡ fb811f14-8f2c-481d-927a-8670aba7112c
cm"""


<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>300))

</div>
"""

# ╔═╡ 2a88724c-0f4c-48a2-83a1-e51a2c10a0c7
md"""
## Change of Variables for Indefinite Integrals
__Example__: Find
```math
	\begin{array}{ll}
	(i) & \int \sqrt{2x-1} dx \\ \\
	(ii) & \int x\sqrt{2x-1} dx \\ \\
	(iii) & \int \sin^23x\cos3x dx \\ \\
	\end{array}
```
	
"""

# ╔═╡ 2fc3d33f-bb28-4e4c-a372-21d9006ad4df
md"""
## The General Power Rule for Integration
"""

# ╔═╡ 8868e231-cf0b-4de3-b7d3-350ec62be835
cm"""


<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>300))

</div>
"""

# ╔═╡ 059f7df0-3c91-408c-91aa-fa513864e817
x = symbols("x", real=true);

# ╔═╡ b4adbb37-dbc9-4d43-b5c1-7550b8f8dfd3
md"""
## Change of Variables for Definite Integrals
"""

# ╔═╡ f2f54f8e-125b-4e0c-bb67-444b001400d0
begin
    ex2fun1(x) = log(x) / x
    ex2fun2(x) = x
    ex2x1 = 1:0.1:exp(1)
    ex2x12 = 0:0.1:1
    ex2x2 = 0.6:0.1:4
    ex2x22 = log(0.6):0.1:log(4)

    ex2y1 = ex2fun1.(ex2x1)
    ex2y12 = ex2fun2.(ex2x12)
    ex2y2 = ex2fun1.(ex2x2)
    ex2y22 = ex2fun2.(ex2x22)
    theme(:wong)
    ex2plt1 = plot(ex2x1, ex2y1, framestyle=:origin, xlims=(0, exp(1)), ylims=(-1, 1), fillrange=0, fillalpha=0.5, c=:red, label=nothing)
    plot!(ex2plt1, ex2x2, ex2y2, c=:red, label=nothing)
    xlims!(ex2plt1, -1, 4)
    annotate!(ex2plt1, [(2, 0.5, L"y=\frac{\ln x}{x}"), (exp(1), -0.05, text(L"e", 12))])
    plot!(ex2plt1, [exp(1), exp(1)], [0, ex2fun1(exp(1))], c=:red, linewidth=3, label=nothing)

    ex2plt2 = plot(ex2x12, ex2y12, framestyle=:origin, xlims=(0, 1), ylims=(-1, 1), fillrange=0, fillalpha=0.5, c=:red, label=nothing)
    plot!(ex2plt2, ex2x22, ex2y22, c=:red, label=nothing)
    xlims!(ex2plt2, -1, 4)
    annotate!(ex2plt2, [(2, 0.5, L"v=u")])
    # ylims!()
    # plot!(ex2plt2,ex2x,ex2y, framestyle=:origin, xlims=(1,exp(1)), fillrange =0,fillalpha=0.5,c=:red)
    # xlims!(ex2plt1,-1,2)
    # plot!(ex2plt1, fill=(0, 0.5, :red), xlims=(1,2))
    md""" 
    ### Substitution: Definite Integrals
    **Example:**
    	Evaluate

    ```math
    \int_1^e \frac{\ln x}{x} dx  
    ```
    $ex2plt1	

    $ex2plt2

    """
end

# ╔═╡ 58c794e3-b35a-4e81-a136-2865e9bc53b4
cm"""
**Example:**
	Evaluate

```math
\begin{array}{ll}
(i) & \int_1^2 \frac{dx}{\left(3-5x\right)^2} \\ \\
(iii) & \int_0^1 x(x^2+1)^3 \;dx \\ \\ 
(iv) & \int_1^5 \frac{x}{\sqrt{2x-1}}\;dx \\ \\ 
\end{array}
```
"""

# ╔═╡ 2ec7cbb4-58c6-439b-9989-d45890d5bde0
md"""
## Integration of Even and Odd Functions
"""

# ╔═╡ 3464f171-a986-4e68-b0fc-63bb37d3186a
md"""# 5.7: The Natural Logarithmic Function: Integration
> __Objectives__
> 1. Use the Log Rule for Integration to integrate a rational function.
> 2. Integrate trigonometric functions.

## Log Rule for Integration
"""

# ╔═╡ cab15078-1283-4a7f-8447-1996dedf988c
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

# ╔═╡ 121748ad-633e-4057-aed1-fe55a3aaab06
begin
	rect(x, Δx, xs, f) = Shape([(x, 0), (x + Δx, 0), (x + Δx, f(xs)), (x, f(xs))])
	function reimannSum(f, n, a, b; method="l", color=:green, plot_it=false)
    Δx = (b - a) / n
    x = a:0.01:b
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

# ╔═╡ a034af46-0c78-436a-b368-c977643fa1ff
begin 
	Δx2 = (b2 - a2) / n2
    xx12 = a2:0.001:b2
	pp12,s2 = reimannSum(g, n2, a2, b2; method=lr2, color=:green, plot_it=true)
	
	sumlabel2 = lr2 == "r" ? L"S(%$n2)=%$s2" : L"s(%$n2)=%$s2"
    annotate!(pp12, [(0.2, 0.8, sumlabel2, 12)])
    annotate!(pp12, [(1.6, g(1.8), L"$y=%$(g(x))$", 12)])
	pp12
end

# ╔═╡ 12b91dea-100a-4932-8607-e8e65fff62a6
md"""
## Integrals of Trigonometric Functions
"""

# ╔═╡ 7bee0ddc-a560-4404-95c4-6afff2ee2cde
md"""# 5.8:Inverse Trigonometric Functions: Integration
> __Objectives__
> 1. Integrate functions whose antiderivatives involve inverse trigonometric functions.
> 2. Use the method of completing the square to integrate a function.
> 3. Review the basic integration rules involving elementary functions.
## Integrals Involving Inverse Trigonometric Functions
"""

# ╔═╡ f5d277d1-66ea-41b4-80a8-396b8f3dd476
cm"""

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

# ╔═╡ 8c9895fb-a48b-4466-8abf-8ad0d353ac23
md" ## Completing the Square"

# ╔═╡ 1b43f966-72bd-4706-8e2a-7acf993bd5d9
md"""
# 5.9: Hyperbolic Functions

> __Objectives__
> 1. Develop properties of hyperbolic functions (MATH101).
> 2. Differentiate (MATH101) and integrate hyperbolic functions.
> 3. Develop properties of inverse hyperbolic functions (Reading only).
> 4. Differentiate and integrate functions involving inverse hyperbolic functions. (Reading only).
"""

# ╔═╡ a81742ca-d194-4b63-87a2-136580b6c67f
cm"""
__Circle__: ``x^2+y^2=1``

<div class="img-container">

$(Resource("https://www.dropbox.com/s/c53yvdcyul4vvlz/circle.jpg?raw=1"))

</div>

__Hyperbola__: ``-x^2+y^2=1``

<div class="img-container">

$(Resource("https://www.dropbox.com/s/iy6fw024c6r50f8/hyperbola.jpg?raw=1"))

</div>


"""

# ╔═╡ 5a7927a7-65d3-445b-a0a6-fa9901414b54
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

# ╔═╡ 09f2eebb-bd91-44ad-9a04-5441dc24a3d9
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

# ╔═╡ 6319d77c-c025-4caa-aea2-d34d3fa6fe9a
md"""# 7.1: Area of a Region Between Two Curves

__Objectives__
> 1. Find the area of a region between two curves using integration.
> 2. Find the area of a region between intersecting curves using integration.
> 3. Describe integration as an accumulation process.

"""

# ╔═╡ f9d65649-3d39-42c0-9ad7-8dbf8601ea1a
begin 
	struct PlotData
		x::StepRangeLen
		fun::Function
		lb::Union{Integer,Vector{Float64}}
	end
	PlotData(x,f)=PlotData(x,f,0)	
	@recipe function f(t::PlotData; customcolor = :green, fillit=true)
		x, fun, lb = t.x, t.fun, t.lb
		xrotation --> 45
		zrotation --> 6, :quiet
		aspect_ratio --> 1
		framestyle --> :origin
		label-->nothing
		fill --> (fillit ? (lb,0.5,customcolor) : nothing)
		x, fun.(x)
	end
	# x, y = symbols("x,y", real=true)
	p1Opt = (framestyle=:origin, aspectration=1)
	function plot_implicit(F, c=0;
			xrng=(-5,5), yrng=xrng, zrng=xrng,
			nlevels=6,         # number of levels in a direction
			slices=Dict(:x => :blue,
				:y => :red,
				:z => :green), # which directions and color
			kwargs...          # passed to initial `plot` call
		)

		_linspace(rng, n=150) = range(rng[1], stop=rng[2], length=n)

		X1, Y1, Z1 = _linspace(xrng), _linspace(yrng), _linspace(zrng)

		p = Plots.plot(;legend=false,kwargs...)

		if :x ∈ keys(slices)
			for x in _linspace(xrng, nlevels)
				local X1 = [F(x,y,z) for y in Y1, z in Z1]
				cnt = contours(Y1,Z1,X1, [c])
				for line in lines(levels(cnt)[1])
					ys, zs = coordinates(line) # coordinates of this line segment
					plot!(p, x .+ 0 * ys, ys, zs, color=slices[:x])
				end
			end
		end

		if :y ∈ keys(slices)
			for y in _linspace(yrng, nlevels)
				local Y1 = [F(x,y,z) for x in X1, z in Z1]
				cnt = contours(Z1,X1,Y1, [c])
				for line in lines(levels(cnt)[1])
					xs, zs = coordinates(line) # coordinates of this line segment
					plot!(p, xs, y .+ 0 * xs, zs, color=slices[:y])
				end
			end
		end

		if :z ∈ keys(slices)
			for z in _linspace(zrng, nlevels)
				local Z1 = [F(x, y, z) for x in X1, y in Y1]
				cnt = contours(X1, Y1, Z1, [c])
				for line in lines(levels(cnt)[1])
					xs, ys = coordinates(line) # coordinates of this line segment
					plot!(p, xs, ys, z .+ 0 * xs, color=slices[:z])
				end
			end
		end


		p
	end
	html"......"
end

# ╔═╡ 256aa7fa-07a0-4a5c-8e0d-899f7358d63b
md"## Area of a Region Between Two Curves"

# ╔═╡ c0309f25-d405-439d-b6ab-964bd3852f52
begin
	cnstSlider = @bind cnstslider Slider(-2:1:2, default=0)
	n1Slider = @bind n1slider Slider(1:200, default=1,show_value=true)
	md"""
	| | |
	|---|---|
	|move $cnstSlider| ``n`` = $n1Slider|
	|||
	"""
end



# ╔═╡ 89f6aa3f-c4e0-4c40-ac65-9522bc8c4b77
begin
	f71(x) = sin(x)+3+cnstslider
	f72(x) = cos(2x)+1+cnstslider
	f73(x) = cos(2x)+4+cnstslider
	poi1=solve(f71(x)-f73(x),x) .|> p -> p.n()
	theme(:wong)
	a71,b71 = 1, 5
	Δx1 = (b71-a71)/n1slider
	x1Rect =a71:Δx1:b71
	x1 = a71:0.1:b71
	y1 = f71.(x1)
	y2 = f72.(x1)
	y3 = f73.(x1)
	
	p1=plot(x1,y1, fill=(y2,0.25,:green), label=nothing,c=:red)
	p2=plot(x1,y1, fill=(y3,0.25,:green), label=nothing,c=:red)
	
	plot!(p1,x1,y2,label=nothing)
	plot!(p2,x1,y3,label=nothing)
	annotate!(p1,[
				(3.5,3.5+cnstslider,L"y=f(x)",:red),
				(5.9,0,L"x"),
				(0.2,6,L"y"),
				(3.2,1+cnstslider,L"y=g(x)",:blue)
				]
			)
	annotate!(p2,[
				(1.2,4.5+cnstslider,L"y=f(x)",:red),
				(5.9,0,L"x"),
				(0.2,6,L"y"),
				(4,5+cnstslider,L"y=g(x)",:blue)
				]
			)
	
	plot!(p1; p1Opt...,ylims=(-3,6),xlims=(-1,6))
	recs =[
			Shape([(xi,f72(xi)),(xi+Δx1,f72(xi)),(xi+Δx1,f71(xi+Δx1)),(xi,f71(xi+Δx1))]) 			 for xi in x1Rect[1:end-1]
		  ]
	n1slider>2 && plot!(p1,recs, label=nothing,c=:green)
	plot!(p2; p1Opt...,ylims=(-3,6),xlims=(-1,6))
	scatter!(p2,(poi1[1],f73(poi1[1])), label="Point of instersection",legend=:bottomright)
	# save("./imgs/6.1/sec6.1p2.png",p2)
	# annotate!(p2,[(4,0.51,(L"$\sum_{i=1}^{%$n2} f (x^*_{i})\Delta x=%$s2$",12))])
	
	md""" **How can we find the area between the two curves?**
	
$p1
	
```math
Area = \int_a^b \left[{\color{red}f(x)} - {\color{blue}g(x)}\right] dx
```
"""

end



# ╔═╡ b6525a2a-ba92-426d-8145-ec1637b94bbe
begin
	ex1x=0:0.01:1
	ex1y=exp.(ex1x)
	ex1plt=plot(ex1x,ex1y,label=nothing,fill=(0,0.5,:red))
	plot!(ex1plt,ex1x,ex1x,fill=(0,0,:white),label=nothing)
	plot!(;p1Opt...,xlims=(-0.4,1.5),ylims=(-0.4,3.5),label=nothing,xticks=[0,0,1])
	ex1Rect = Shape([(0.5,0.55),(0.55,0.55),(0.55,exp(0.55)),(0.5,exp(0.55))])
	plot!(ex1Rect,label=nothing)
	annotate!([	(0.77,0.6,L"y=x")
			  ,	(0.7,exp(0.7)+0.2,L"y=e^x")
			  , (1.1,1.7,L"x=1")
			  , (-0.1,0.5,L"x=0")
			  , (0.54,0.44,text(L"\Delta x",10))
			  ])
	md"""
	**Solution**
	
	$ex1plt
	"""
end



# ╔═╡ d135dec8-4f04-4636-8959-826b80da3054
md"""## Area of a Region Between Intersecting Curves

In geberal,

$p2
	
```math
Area = \int_a^b \left|f(x) - g(x)\right| dx
```

"""



# ╔═╡ 7f24e7d9-b4a3-47d7-be46-0cb0489b6126
begin
	img1 = load(download("https://www.dropbox.com/s/r39ny15umqafmls/wrty.png?raw=1"))
	img1 = imresize(img1,ratio=1.5)
	md"""
	__Integrating with Respect to ``y``__
	
	$img1
	
	"""
	
end



# ╔═╡ 41e00300-a42e-4370-a771-dabd789929b7
md"""# 7.2: Volume: The Disk Method
> __Objectives__
> - Find the volume of a solid of revolution using the disk method.
> - Find the volume of a solid of revolution using the washer method.
> - Find the volume of a solid with known cross sections.

## The Disk Method


"""

# ╔═╡ 8692fe90-8a37-411d-81c7-7a5217190ab1
cm"""
**Solids of Revolution**
<div class="img-container">

$(Resource("https://www.dropbox.com/s/z2k777veuxiaorq/solids_of_revs.png?raw=1"))
</div>


<div class="img-container">

$(Resource("https://www.dropbox.com/s/ik73cokibh1fuj6/disk_volume.png?raw=1"))

__Volume of a disk__
```math
V = \pi R^2 w
```
</div>

<div class="img-container">

__Disk Method__

$(Resource("https://www.dropbox.com/s/odttq795nrpcznw/disk_method.png?raw=1"))
</div>

```math
\begin{array}{lcl}
\textrm{Volume of solid} & \approx &\displaystyle \sum_{i=1}^n\pi\bigl[R(x_i)\bigr]^2 \Delta x \\
	& = &\displaystyle \pi\sum_{i=1}^n\bigl[R(x_i)\bigr]^2 \Delta x
\end{array}
```
Taking the limit ``\|\Delta\|\to 0 (n\to \infty)``, we get


```math
\begin{array}{lcl}
\textrm{Volume of solid} & = &\displaystyle\lim_{\|\Delta\|\to 0}\pi \sum_{i=1}^n\bigl[R(x_i)\bigr]^2 \Delta x \end{array} = \pi \int_{a}^{b}\bigl[R(x)\bigr]^2 dx.
```

<div class="img-container">

__Disk Method__

__To find the volume of a solid of revolution with the disk method, use one of the formulas below__

$(Resource("https://www.dropbox.com/s/9kpj2dcrwj5y5h8/disk_volume_v_h.png?raw=1"))
</div>

"""

# ╔═╡ b80374f0-0f17-473e-8aa1-501065ec611f
md"## The Washer Method"

# ╔═╡ 95d66bca-8ba9-4e4d-b86d-302f8a869d50
cm"""
<div class="img-container">

$(Resource("https://www.dropbox.com/s/ajra8g5fr8ssewe/washer_volume.png?raw=1"))

```math
\textrm{Volume of washer} = \pi(R^2-r^2)w
```
</div>

__Washer Method__


<div class="img-container">

$(Resource("https://www.dropbox.com/s/hvwa3707bftjir0/washer_method.png?raw=1"))

```math
V = \pi\int_a^b \bigl[\left(R[x]\right)^2-\left(r[x]\right)^2) dx
```
</div>
"""

# ╔═╡ b80a56ee-6679-462c-890e-b70bef86f9de
md"## Solids with Known Cross Sections"

# ╔═╡ fa2a6253-258e-4b03-a46f-dd19a20f4316
cm"""
**Exercise**
Find the volume of the solid obtained by rotating the region bounded by ``y=x^3``, ``y=8`` , and ``x=0`` about the ``y``-axis.

**Exercise** The region ``\mathcal{R}`` enclosed by the curves ``y=x`` and ``y=x^2`` is rotated about the ``x``-axis. Find the volume of the resulting solid.

**Exercise** Find the volume of the solid obtained by rotating the region in the previous Example about the line ``y=2``.

**Exercise** Find the volume of the solid obtained by rotating the region in the previous Example about the line ``x=-1``.

"""

# ╔═╡ 33cf7304-6211-4141-a695-a82066e54f6d
md"""
**Exercise** Figure below shows a solid with a circular base of radius ``1``. Parallel cross-sections perpendicular to the base are equilateral triangles. Find the volume of the solid.
$(load(download("https://www.dropbox.com/s/bbxedang718jvvp/img4.png?dl=0")))
"""

# ╔═╡ 69917572-68d4-4713-8afb-9664cc794df8
md"""
# 7.3: Volume: The Shell Method
> __Objectives__
> 1. Find the volume of a solid of revolution using the shell method.
> 2. Compare the uses of the disk method and the shell method.

**Problem**
Find the volume of the solid generated by rotating the region bounded by ``y=2x^2-x^3`` and ``y=0`` about the ``y-``axis.
"""

# ╔═╡ e284b9db-b1cc-4334-9e9e-4665131ecad1
begin
	show_graph_s = @bind show_graph CheckBox() 
	show_rect_s = @bind show_rect CheckBox() 
	show_labels_s = @bind show_labels CheckBox() 
	md"""
	Step 1: $show_graph_s
	Step 2: $show_rect_s
	Step 3: $show_labels_s
	"""
end

# ╔═╡ 17c95cdb-09ad-4869-9c26-291f6161e217
begin
	
	f30(x)=2*x^2-x^3
	s3e0= PlotData(0:0.01:2,f30)
	s3e0p0 = plot(s3e0)
	annotate!(s3e0p0,[(1,1.2,L"y=2x^2-x^3")])
	recty=Shape([ (0.75,f30(0.75))
			, (1.75,f30(0.75))
			, (1.75,f30(0.75)+0.05)
			, (0.75,f30(0.75)+0.05)])
	ux, lx = Plots.unzip(Plots.partialcircle(0,π,100,-0.1))
	plot!(ux,lx .+ 1.15,c=:red)
	anns = [(0.65,f30(0.76),L"x_L=?",10),(1.88,f30(0.76),L"x_R=?",10)]
	s3e0p =	if show_labels 
		plot!(s3e0p0,recty,label=nothing)
		annotate!(anns)
	elseif show_rect
		plot!(s3e0p0,recty,label=nothing)
	elseif show_graph
		s3e0p0
		
	else
		""
	end
end

# ╔═╡ c716c668-4ccc-4cbe-b6a7-115e30388373
md"## The Shell Method"

# ╔═╡ 6d7d7fcb-22e0-413a-9a00-20fce9058794
begin 
	shellImg=load(download("https://www.dropbox.com/s/8a2njc50e2hptok/shell.png?dl=0"))
	md"""
	A shell is a hallow circular cylinder
	
	$shellImg

	
	"""
end

# ╔═╡ 0fa93397-1617-4757-bcb7-cdb10ba1cd43
cm"""
```math
V = 2 \pi r h \Delta r = \text{[circumference][height][thickness]}

```
"""

# ╔═╡ 2e27548d-e260-4aa1-9438-0c1762d745cc
html"""
<div style="display: flex; justify-content:center; padding:20px; border: 2px solid rgba(125,125,125,0.2);">
<div>
<h5>Cylindrical Shells Illustration</h5>
<iframe width="560" height="315" src="https://www.youtube.com/embed/JrRniVSW9tg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
</div>
"""

# ╔═╡ 1a2563ed-917d-4d30-be2f-b08025d07b64
cm"""
<div style="display: flex;  justify-content: center;">
<div style="margin-right:12px;padding:4px;border: 2px solid white; border-radius: 10px;background: #eee;">
<span style="font-size:1.5M; font-weight: 800;">Horizontal Axis of Revolution</span>

```math
\text{Volume}=V = 2\pi \int_c^d p(y) h(y) dy
```
<div class="img-container">

$(Resource("https://www.dropbox.com/s/6qmijrhprht4kqj/shell_y.png?raw=1"))

</div>

</div>

<div style="margin-right:12px;padding:4px;border: 2px solid white; border-radius: 10px;background: #eee;"><span style="font-size:1.5M; font-weight: 800;">Vertical  Axis of Revolution</span>

```math
\text{Volume}=V = 2\pi \int_a^b p(x) h(x) dx
```

<div class="img-container">

$(Resource("https://www.dropbox.com/s/ivbwuge5ti8vrff/shell_x.png?raw=1"))

</div>

</div>
</div>

"""

# ╔═╡ 8c94ff72-52d3-4445-a534-fca78768eb49
begin
	s3e0p1 = plot(s3e0)
	annotate!(s3e0p1,[(1,1.2,L"y=2x^2-x^3")])
	plot!(s3e0p1, 
			Shape( 
				[ (1.2,0),(1.3,0),(1.3,f30(1.3)),(1.2,f30(1.3))
				]
				)
		, label=nothing
		)
	md"""
**Example:**
Find the volume of the solid generated by rotating the region bounded by ``y=2x^2-x^3`` and ``y=0`` about the ``y-``axis.

Solution:
	
$s3e0p1
"""
end

# ╔═╡ e3aacea8-fa4d-4385-aa46-cd5d8f4c4f1e
md"""
**Example :**
Find the volume of the solid obtained by rotating about the ``y-``axis the region between ``y=x`` and ``y=x^2``.

"""

# ╔═╡ 378343ed-6041-49a2-b92a-c9bd3e5cad9f
md"""
**Example:**
Find the volume of the solid obtained by rotating the region bounded by ``y=x-x^2`` and ``y=0`` about the line ``x=2``.

"""

# ╔═╡ c6a90a6d-d2e3-4140-ba8c-b416e21576b8
md"""
# 7.4: Arc Length and Surfaces of Revolution
> __Objectives__
> 1. Find the arc length of a smooth curve.
> 2. Find the area of a surface of revolution.
## Arc Length
"""

# ╔═╡ cecf42f2-549f-45d7-8152-a07e0b8f26b7
md"## Area of a Surface of Revolution"

# ╔═╡ 5e99e72d-4a7f-4cd0-8edc-2579bc8218d3
cm"""
__Remark__ 

The formulas can be written as

```math
S=2\pi \int_a^b r(x) ds, \quad {\color{red} y \text{ is a function of x }}.
```
and 
```math
S=2\pi \int_c^d r(y) ds, \quad {\color{red} x \text{ is a function of y }}.
```
where 
```math
ds = \sqrt{1+\big[f'(x)\big]^2}dx \quad \text{and}\quad ds = \sqrt{1+\big[g'(y)\big]^2}dy \quad \text{respectively}.
"""

# ╔═╡ 4a853ebd-5932-4833-ab25-c2ff72ac6b6b
md"""# 8.1: Basic Integration Rules

> __Objectives__
> 1. Review procedures for fitting an integrand to one of the basic integration rules.

"""

# ╔═╡ 6d692b82-c1a3-4b1f-b499-f2025a368871
cm"""
<div style="background-color:#FF9733;color:white;font-weight:800;padding:2px 10px;width:350px;">

Review of Basic Integration Rules (``a>0``) 
</div>
<div class="img-container">

$(Resource("https://www.dropbox.com/s/56svdxjfgowjojk/int_table.png?raw=1"))

</div>
"""

# ╔═╡ dc1c0ed3-92a5-40fd-b871-d613a308557e
md"""# 8.2: Integration by Parts
> __Objectives__
> 1. Find an antiderivative using integration by parts.
*The integration rule that corresponds to the Product Rule for differentiation is called __integration by parts__*
"""

# ╔═╡ 553c76a4-3155-474a-a665-1a17ef3c76a9
cm"""
__Indefinite Integrals__
```math
\int f(x)g'\,(x) dx = f(x) g(x) - \int g(x) f'\,(x) dx
```
"""

# ╔═╡ f74eea56-a8b6-45e2-9ade-39e36e9be00c
md"""# 8.3: Trigonometric Integrals
> __Objectives__
> 1. Solve trigonometric integrals involving powers of sine and cosine.
> 2. Solve trigonometric integrals involving powers of secant and tangent.
> 3. Solve trigonometric integrals involving sine-cosine products.

**RECALL**

```math



\displaystyle
\sin^2 x + \cos^2 x =1, \quad  \tan^2 x + 1 =\sec^2 x,  \quad  1+\cot^2 x  =\csc^2 x,

```

```math
\displaystyle
\cos^2 x = \frac{1 +\cos 2x }{2}, \quad \sin^2 x = \frac{1 -\cos 2x }{2}
```

```math
\displaystyle
\begin{array}{ccc}
\sin mx\sin nx & = & \frac{1}{2}\left[\cos(m-n)x-\cos(m+n)x\right], \\[0.2cm]
\sin mx\cos nx & = & \frac{1}{2}\left[\sin(m-n)x+\sin(m+n)\right], \\[0.2cm]
\cos mx\cos nx & = & \frac{1}{2}\left[\cos(m-n)+\cos(m+n)\right], \\
\end{array}
```

```math
\int \tan x dx = \ln|\sec x| +C, \quad \int \sec x dx = \ln|\sec x+\tan x| +C
```


```math
\int \cot x dx = -\ln|\csc x| +C, \quad \int \csc x dx = \ln|\csc x-\cot x| +C
```
"""

# ╔═╡ 5ffe3671-dbed-4685-b4d2-d112015141af
md"""
## Integrals of Powers of Sine and Cosine
```math
\int \sin^mx \cos^n x dx
```

* ``m`` is ``{\color{red}\text{odd}}``, write as ``\int \sin^{m-1}x \cos^n x \sin x  dx``. _Example_: $\int \sin^5x \cos^2 x dx$


* ``n`` is ``{\color{red}\text{odd}}``,  write as ``\int \sin^mx \cos^{n-1}\cos x  dx``. _Example_ ``\int \sin^5x \cos^3 x dx``


* ``m`` and ``n`` are ``{\color{red}\text{even}}``, use formulae (_Example_ ``\int \cos^2 x dx`` and  ``\int \sin^4 x dx``)
```math
\sin^2(x)=\frac{1-\cos(2x)}{2}, \quad \cos^2(x)=\frac{1+\cos(2x)}{2}.
```
"""

# ╔═╡ bcc1522a-131a-435f-bdd3-2d5ea0ec67cf
md"""
## Integrals of Powers of Secant and Tangent

```math
\int \tan^mx \sec^n x dx
```

* ``n`` is even, write as ``\int \tan^mx \sec^{n-2}\sec^2 x  dx``. _Example_ ``\int \tan^6x \sec^4 x dx``


* ``m`` is odd, write as ``\int \tan^{m-1}x \sec^{n-1}\tan x\sec x  dx``. _Example_ ``\int \tan^5x \sec^7 x dx``.


"""

# ╔═╡ 76810624-6ffc-457e-8562-05491e2528aa
md"## Integrals Involving Sine-Cosine Products"

# ╔═╡ 9a266cbc-a292-4f68-8afa-00479060489d
md"""
# 8.4: Trigonometric Substitution
> __Objectives__
> 1. Use trigonometric substitution to find an integral.
> 2. Use integrals to model and solve real-life applications.
"""

# ╔═╡ d1fcddac-b706-4271-9f0f-6fc816876ac9
md"""
## Trigonometric Substitution
"""

# ╔═╡ 72664d64-11bc-4184-b149-fe897fa628b2
cm"""
We use __trigonometric substitution__ to find integrals involving the radicals
```math
\sqrt{a^2-u^2},\quad \sqrt{a^2+u^2},\quad \sqrt{u^2-a^2}.
```
"""

# ╔═╡ 7381759c-5ad1-4948-84dc-1311b5345b55
md"## Applications"

# ╔═╡ 9d865d41-d46a-4c23-b760-7ceee6b62936
md"""
# 8.5: Partial Fractions
> __Objectives__
> 1. Understand the concept of partial fraction decomposition.
> 2. Use partial fraction decomposition with linear factors to integrate rational functions.
> 3. Use partial fraction decomposition with quadratic factors to integrate rational functions.

## Partial Fractions

We learn how to integrate rational function: quotient of polunomial.
```math
 f(x) =\frac{P(x)}{Q(x)}, \qquad P, Q \text{ are polynomials}
```
 
**How?**

◾ __STEP 0__ : if degree of ``P`` is greater than or equal to degree of ``Q`` goto
__STEP 1__, else GOTO __STEP 2__.

◾ __STEP 1__ : Peform long division of ``P`` by ``Q`` to get 
```math
 \frac{P(x)}{Q(x)} = S(x) + \frac{R(x)}{Q(x)}
```
and apply __STEP 2__ on  ``\frac{R(x)}{Q(x)}``.

◾ __STEP 2__ : Write the __partial fractions decomposition__  

◾ __STEP 3__ : Integrate
 
"""

# ╔═╡ c040cf3d-5bce-4b59-9274-04e745f43c61
md"""
__Partial Fractions Decomposition__

We need to write ``\frac{R(x)}{Q(x)}`` as sum of __partial fractions__ by __factor__ ``Q(x)``. Based on the factors, we write the decomposition accoding to the following cases

__case 1__: ``Q(x)`` is a product of distinct linear factors.
we write 
```math
Q(x)=(a_1x+b_1)(a_2x+b_2)\cdots (a_kx+b_k)
```
then there exist constants ``A_1, A_2, \cdots, A_k`` such that
```math
\frac{R(x)}{Q(x)}= \frac{A_1}{a_1x+b_1}+\frac{A_2}{a_2x+b_2}+\cdots +\frac{A_k}{a_kx+b_k}
```

__case 2__: ``Q(x)`` is a product of linear factors, some of which are repeated.
say first one 
```math
Q(x)=(a_1x+b_1)^r(a_2x+b_2)\cdots (a_kx+b_k)
```
then there exist constants ``B_1, B_2, \cdots B_r, A_2, \cdots, A_k`` such that
```math
\frac{R(x)}{Q(x)}= \left[\frac{B_1}{a_1x+b_1}+\frac{B_2}{(a_1x+b_1)^2}+\cdots \frac{B_r}{(a_1x+b_1)^r}\right]+ \frac{A_2}{a_2x+b_2}+\cdots +\frac{A_k}{a_kx+b_k}
```


__case 3__: ``Q(x)`` contains irreducible quadratic factors, none of which is repeated.
say we have (Note: the quadratic factor ``ax^2+bx+c`` is irreducible if ``b^2-4ac<0``). For eaxmple if
```math
Q(x)=(ax^2+bx+c)(a_1x+b_1)
```
then there exist constants ``A, B,`` and ``C`` such that
```math
\frac{R(x)}{Q(x)}= \frac{Ax+B}{ax^2+bx+c}+\frac{C}{a_1x+b_1}
```

__case 4__: ``Q(x)`` contains irreducible quadratic factors, some of which are repeated. For example if
```math
Q(x)=(ax^2+bx+c)^r(a_1x+b_1)
```
then there exist constants ``A_1, B_1, A_2, B_2, \cdots A_r, B_r `` and ``C`` such that
```math
\frac{R(x)}{Q(x)}= \left[\frac{A_1x+B_1}{ax^2+bx+c}+\frac{A_2x+B_2}{(ax^2+bx+c)^2}+\cdots+\frac{A_rx+B_r}{(ax^2+bx+c)^r}\right]+\frac{C}{a_1x+b_1}
```



"""

# ╔═╡ 94380cb1-ec66-4a52-93e0-2911e2e75b9f
md"""
**More Examples**

Find
```math
\begin{array}{lll}
\text{(1)} & \displaystyle \int \frac{1}{x^2-5x+6}dx. \\
\text{(2)} &\displaystyle \int  \frac{5x^2+20x+6}{x^3+2x^2+x}dx. \\
\text{(3)} &\displaystyle \int  \frac{2x^3-4x-8}{(x^2-x)(x^2+4)}dx. \\
\text{(4)} &\displaystyle \int  \frac{8x^3+13x}{(x^2+2)^2}dx. \\
\text{(5)} &\displaystyle \int  \frac{x^3+x}{x-1}dx. \\
\text{(6)} &\displaystyle \int  \frac{x^2+2x-1}{2x^3+3x^2-2x}dx. \\
\text{(7)} &\displaystyle \int  \frac{dx}{x^2-a^2}, \text{  where } a\not = 0 \\
\text{(8)} &\displaystyle \int  \frac{x^4-2x^2+4x+1}{x^3-x^2-x+1}dx \\
\text{(9)} &\displaystyle \int  \frac{2x^2-x+4}{x^3+4x}dx \\
\text{(10)} &\displaystyle \int   \frac{4x^2-3x+2}{4x^2-4x+3}dx \\
\text{(11)} &\displaystyle \int   \frac{1-x+2x^2-x^3}{x(x^2+1)^2}dx \\
\end{array}
```

"""

# ╔═╡ 8cc6f38f-c6c9-4ad2-adb6-ba252a98e06c
md"""
**Remarks**
```math
\int \frac{dx}{x^2-a^2} = \frac{1}{2a}\ln\left|\frac{x-a}{x+a}\right|
```

```math
\int \frac{dx}{x^2+a^2} = \frac{1}{a}\tan^{-1}\left(\frac{x}{a}\right)
```
"""

# ╔═╡ b7f80565-cf9b-4c4d-ab06-aade08bfc0f9
md"""
__Rationalizing Substitutions__
Find
```math
\begin{array}{lll}
\text{(1)} & \int \frac{\sqrt{x+4}}{x}dx. \\
\text{(2)} & \int \frac{dx}{2\sqrt{x+3}+\;x}. \\
\end{array}
```
"""

# ╔═╡ a095f3d2-d61d-4ec5-a3fc-4ac7d3893ec1
md"""
# 8.7: Rational Functions of Sine & Cosine 



Special Substitution (``u = \tan \left(\frac{x}{2}\right), \quad -\pi < x < \pi``)
**(for rational functions of ``\sin x`` and ``\cos x``)**
```math
\begin{array}{lll}
dx=\frac{2}{1+u^2}du, & \cos{x}=\frac{1-u^2}{1+u^2}, &  \sin{x}=\frac{2u}{1+u^2} \\
\end{array}
```
```math
\begin{array}{lll}
\text{(1)} & \displaystyle\int \frac{dx}{3\sin x - 4 \cos x}. \\
\text{(2)} & \displaystyle\int_0^{\pi\over 2} \frac{\sin 2x \;dx}{2+\cos x}. \\
\end{array}
```

"""

# ╔═╡ 926201c3-50c7-40a8-bd21-d9b1684046b7
md"""
# 8.8: Improper Integrals
> __Objectives__
> - Evaluate an improper integral that has an infinite limit of integration.
> - Evaluate an improper integral that has an infinite discontinuity.
*__Do you know how to evaluate the following?__*
```math

\begin{array}{llr}
\text{(1)} & \int_1^{\infty} \frac{1}{x^2} dx & (\text{Type 1}) \\ \\
\text{(2)} & \int_0^{2} \frac{1}{x-1} dx & (\text{Type 2}) \\ \\
\end{array}
```
"""

# ╔═╡ 41284787-6dca-4e73-88c5-2699300d0951
md"## Improper Integrals with Infinite Limits of Integration"

# ╔═╡ 953e09f8-b986-4a82-86c8-533438cb88ad
md"""
**Example:** Determine whether the following integrals  are convergent or divergent.

```math
\begin{array}{ll}
\text{(1)} & \displaystyle \int_1^{\infty} \frac{1}{x^2} dx \\ \\
\text{(2)} & \displaystyle\int_1^{\infty} \frac{1}{x} dx \\ \\
\text{(3)} & \displaystyle\int_{0}^{\infty} e^{-x} dx\\ \\
\text{(4)} & \displaystyle\int_{-\infty}^{\infty} \frac{1}{1+x^2} dx\\ \\
\end{array}
```
"""

# ╔═╡ 146fb901-25d6-4dfb-b272-5562e83eaba8
begin
	tSlider = @bind tslider Slider(1:10000,show_value=true)
	md"""
	
	-------------
	

	t = $tSlider
	
	"""
end

# ╔═╡ 312afe0f-55bf-472b-be7e-84079c32c47d
begin
	pd1 = PlotData(1:0.1:10,x->1/x)
	pd2 = PlotData(1:0.1:10,x->1/x^2)
	int1 = round(integrate(1/x,(x,1,tslider)).n(),digits=3)
	int2 = round(integrate(1/x^2,(x,1,tslider)).n(),digits=3)
	pt1=tslider
	pt1=L"\int_1^{%$tslider} \frac{1}{x}dx = %$int1"
	pt2=L"\int_1^{%$tslider} \frac{1}{x^2}dx = %$int2"
	p881 = plot(pd1,annotation=[(3.5,4.5,pt1,12)],ylims=(-1,6))
	p882 = plot(pd2,annotation=[(3.5,4.5,pt2,12)],ylims=(-1,6))
	plot(p881,p882,layout=@layout([a b]))
	
end

# ╔═╡ 990bc451-2065-4e14-88bb-886eadd8535a
begin
	ttSlider = @bind ttslider Slider(1:1000,show_value=true)
	pSlider = @bind pslider NumberField(-10:0.1:10,default=1)
	md"""
	
	-------------
	
	|||
	|---|---|
	|||
	|p = $pSlider | 
	|||
	
	"""
end

# ╔═╡ 89eb38dc-7226-478f-9196-ddc278a3d135
begin
	tt,pp=ttslider, pslider
	ptxt = pslider==1 ? "x" : "x^{$pslider}"
	fn3(p) = p>0 ? 1/x^p : p==0 ? x : x^abs(p) 
	int3(p,t) = integrate(fn3(p),(x,1,oo))
	pt3(t)= t<1000 ? L"\int_1^{\infty} \frac{1}{%$ptxt}dx = %$(int3(pslider,ttslider))" : L"\int_1^{\infty} \frac{1}{%$ptxt}dx = %$(int3(pslider,ttslider))"
	p883=plot(-1:3;annotations=[(3,4,pt3(tt),14)], showaxis=:hide,ticks=[],label=:none,
		c=:white,ylims=(3,5),size=(600,100))
	md"""
	
	-------------
	
	$p883
	
	"""
end

# ╔═╡ 61af1772-e210-4523-9587-5105bb859020
cm"""
**Remark**

```math
\int_1^{\infty} \frac{1}{x^p}dx \quad \text{ is convergent if } p > 1 \text{ and divergent if } p\leq 1.
```

"""

# ╔═╡ b006a96a-6ebc-4e44-a2da-f202fd150005
md"## Improper Integrals with Infinite Discontinuities"

# ╔═╡ 53f18531-404b-4b46-a452-1429d145544e
cm"""
**Example:** 
```math
\begin{array}{ll}
\text{(1)} & \int_2^5 \frac{1}{\sqrt{x-2}} dx \\ \\
\text{(2)} & \int_0^{3} \frac{1}{1-x} dx \\ \\
\text{(3)} & \int_{0}^{1} \ln x dx\\ \\
\end{array}
```


"""

# ╔═╡ fe887af5-a9a4-462f-8fa9-30baae002131
md"""
# 9.1: Sequences
> Objectives
> * Write the terms of a sequence.
> * Determine whether a sequence converges or diverges.
> * Write a formula for the th term of a sequence.
> * Use properties of monotonic sequences and bounded sequences.

__Sequence__: A sequence can be thought of as a list of numbers written in a definite order:
```math
a_1, a_2, a_3, \cdots, a_n, \cdots 
```

- ``a_1``: first term,
- ``a_2``: second term,
- ``a_3``: third term,
- ``\vdots``
- ``a_n``: ``\text{n}^\text{th}`` term,


---

__For example__: 
* ``1, 2, 3, \cdots``
* ``1, 1/2, 1/3, \cdots``
* ``-1, 1, -1, \cdots``

---

__Notation:__
- ``\{a_1, a_2, a_3, \cdots, a_n, \cdots\} = \{a_n\}`` or
- ``\{a_1, a_2, a_3, \cdots, a_n, \cdots \}= \left\{a_n\right\}_{n=1}^{\infty}``

"""

# ╔═╡ 967b72bb-d439-46c3-b449-4fe9c8fa5490
md"""
__More examples__

- ``\left\{\frac{n}{n+1}\right\}``
- ``\left\{\frac{(-1)^n(n+1)}{5^n}\right\}``
- ``\left\{\sqrt{n-4}\right\}_{n=4}^{\infty}``
- ``a_1=1$, $a_2=1$ , $a_n=a_{n-1}+a_{n-2}``         (__Fibonacci sequence__)
"""

# ╔═╡ efd4f9db-2c4c-48d5-9473-34099c71e4ee
n91Slider = @bind n91slider  NumberField(1:1000);md"n = $n91Slider"

# ╔═╡ a9d506a8-dc18-4ffd-a0e7-94ee912d2a90
begin
	a91(n) = n/(n+1)
	d91=1:n91slider
	plt91 = scatter(a91.(d91), zeros(10),
		frame_style=:origin, 
		ylimits=(-0.1,1),
		xlimits=(0.2,1.2),
		yaxis=nothing,
		label=L"a_n=\frac{n}{n+1}",
		showaxis=:x,
		legend=:topleft,
		title_location=:left,
		grid=:none,
		title="Example 1"
	)
	annotate!(plt91,[(0.4,0.5,L"a_{%$n91slider}=\frac{%$n91slider}{%$(1+n91slider)}=%$(round(a91(n91slider),digits=6))")])
	if (n91slider>=99)
		
		lens!(plt91,[0.99, 1.001], [-0.1,1.1], inset = (1, bbox(0.6, 0.0, 0.4, 0.5)),
				yaxis=nothing,
				frame_style=:origin, 
				showaxis=:x,
			grid=:none,
			annotations=[(0.998,0.3,"Zoom",7)]
		)
	end
	md"""
	$plt91
	"""
		
end

# ╔═╡ 0a3e8db6-aa43-44b0-a462-850fc28e6da2
md"""
__Visualization__

1. On a number line (as above)
2. By plotting graph

"""

# ╔═╡ 2e8b9671-6e4a-4b97-9b3d-04dc9ca1437c
n92Slider = @bind n92slider  NumberField(1:1000);md"n = $n92Slider"

# ╔═╡ 49efb8aa-772b-4e82-ae95-c40003183c5b
begin
	d92=1:n92slider
	plt92 = scatter(d92, a91.(d92),
		frame_style=:origin, 
		ylimits=(-0.1,1.6),
		xlimits=(-0.1,200),
		label=L"a_n=\frac{n}{n+1}",
		legend=:topleft,
		title_location=:left,
		title="Example 1 (Graph)"
	)
	annotate!(plt92,[(100,0.5,L"a_{%$n92slider}=\frac{%$n92slider}{%$(1+n92slider)}=%$(round(a91(n92slider),digits=6))")])
# 	if (n92slider>=10)
		
# 		lens!(plt92,[n92slider-20.1, n92slider+20.1], [0.9,1.01], 
# 			inset = (1, bbox(0.6, -0.1, 0.4, 0.4)),
# 			grid=:none,
			
# 		)
	# end
	md"""
	$plt92
	"""	
end

# ╔═╡ e9055611-c65d-4bcb-bc4c-9994d7b6df7f
n93Slider = @bind n93slider  NumberField(1:1000);md"n = $n93Slider"

# ╔═╡ 1e60f9fc-b2d3-4219-8f93-72d546d9d5c8
begin
	a93(n)= (-1)^n * (n+1)/5^n
	d93=1:n93slider
	plt93 = scatter(d93, a93.(d93),
		frame_style=:origin, 
		ylimits=(-1,1),
		xlimits=(-0.1,200),
		label=L"a_n=\frac{(-1)^n\cdot(n+1)}{5^n}",
		legend=:topleft,
		title_location=:left,
		title="Example 2 (Graph)"
	)
	annotate!(plt93,[(100,0.5,L"a_{%$n93slider}=\frac{%$((-1)^n93slider) \cdot %$(1+n93slider)}{5^{%$(n93slider)}}=%$(round(a93(n93slider),digits=6))")])
# 	if (n2slider>=10)
		
# 		lens!(plt2,[n2slider-20.1, n2slider+20.1], [0.9,1.01], 
# 			inset = (1, bbox(0.6, -0.1, 0.4, 0.4)),
# 			grid=:none,
			
# 		)
	# end
	md"""
	$plt93
	"""	
end

# ╔═╡ 8fa2360c-7a35-4d4f-8b42-873d9ce4491c
n94Slider = @bind n94slider  NumberField(4:1000);md"n = $n94Slider"

# ╔═╡ 9fa571ac-b9dd-47fb-82a4-f1133b365b9d
begin
	a94(n)= sqrt(n-4)
	d94=4:n94slider
	plt94 = scatter(d94, a94.(d94),
		frame_style=:origin, 
		ylimits=(-1,100),
		
		label=L"a_n=\frac{n-4}",
		legend=:topleft,
		title_location=:left,
		title="Example 3 (Graph)"
	)
	
	if (n94slider<100)
		xlims!(plt94,-0.1,100),
		annotate!(plt94,
			[(50,50,
			L"a_{%$n94slider}=\sqrt{%$(n94slider-4)}=%$(round(a94(n94slider),digits=6))")
			]
		)	
	elseif (n94slider>100 && n94slider<=500)
		xlims!(plt94,-0.1,500),
		annotate!(plt94,
			[(250,50,
			L"a_{%$n94slider}=\sqrt{%$(n94slider-4)}=%$(round(a94(n94slider),digits=6))")
			]
		)
	else
		xlims!(plt94,-0.1,1000),
		annotate!(plt94,
			[(500,50,
			L"a_{%$n94slider}=\sqrt{%$(n94slider-4)}=%$(round(a94(n94slider),digits=6))")
			]
		)
	end
	md"""
	$plt94
	"""	
end

# ╔═╡ 680376c6-46e5-4469-8099-2052c8bbb557
md"""
#### What are trying to study?

* __convergence__ (what happended when $n$ gets larger and larger $n\to \infty$)

For **_Example 1_**: ``a_n=\frac{n}{n+1}``, it is fair to say and write
```math
\lim_{n\to \infty}\frac{n}{n+1} =1
```
"""

# ╔═╡ 3331a35d-d79e-4392-8121-76c851cfc244
begin
	n95Slider = @bind n95slider  NumberField(1:1000)
	epsSlider = @bind epsslider  NumberField(0:0.01:1, default=1)
	
	md"""
	
	----
	
	|||
	|---|---|
	|``\epsilon`` =$epsSlider |	n = $n95Slider |
	
	----
	"""
end

# ╔═╡ 63e253cd-f11b-4f65-beb6-5a7887ddd3da
begin
	d95=1:n95slider
	plt95 = scatter(d95, a91.(d95),
		frame_style=:origin, 
		ylimits=(-0.1,3),
		xlimits=(-0.1,100),
		label=L"a_n=\frac{n}{n+1}",
		legend=:topleft,
		title_location=:left,
		title="Example 1 (Graph)"
	)
	annotate!(plt95,
		[
		 (50,0.5,
L"a_{%$n95slider}=\frac{%$n95slider}{%$(1+n95slider)}=%$(round(a91(n95slider),digits=6))"
		 )
		,(20,1+epsslider+0.1, L"L+\epsilon")  	
		,(20,1-epsslider-0.1, L"L-\epsilon")  	
		]
	)
	plot!(plt95,
		[x->1,x->1-epsslider,x->1+epsslider],
		labels=:none
	)

	md"""
	$plt95
	"""	
end

# ╔═╡ 7dfaa48a-8d2a-4728-b341-693327fe6232
md"""
**Example** 

```math
\{(-1)^n\} = \{-1, 1, -1, 1, -1, 1, \cdots\}
```
"""

# ╔═╡ 0bbe4f11-24b7-4e62-9855-f4db3dcd281a
begin
	n96Slider = @bind n96slider  NumberField(1:100)
	eps2Slider = @bind eps2slider  NumberField(0:0.01:2, default=0)
	limitSlider = @bind limitslider NumberField(-2:0.1:2, default=0)
	md"""
	
	----
	
	|||
	|---|---|
	|``\epsilon`` =$eps2Slider |	n = $n96Slider |
	|``L =`` $limitSlider | |
	
	----
	"""
end

# ╔═╡ a0f07b8a-bb65-461a-b72d-3a7b133319ea
begin
	a96(n)=iseven(n) ? 1 : -1
	d96=1:n96slider
	plt96 = scatter(d96, a96.(d96),
		frame_style=:origin, 
		ylimits=(-2,2),
		xlimits=(-0.1,100),
		label=L"a_n=(-1)^n",
		legend=:topleft,
		title_location=:left,
		title="Example "
	)
	annotate!(plt96,
		[
			(50,
			 1.5,
	L"a_{%$n96slider}=%$(a96(n96slider))"
				)
		,(20,limitslider+eps2slider+0.1, L"L+\epsilon")  	
		,(20,limitslider-eps2slider-0.1, L"L-\epsilon")  
		]
	)
	plot!(plt96,
		[x->limitslider,x->limitslider-eps2slider,x->limitslider+eps2slider],
		labels=:none
	)

	md"""
	$plt96
	"""	
end

# ╔═╡ 9a46095b-a7e0-4fb4-9c18-1d13caa55c2a
md"""
**Remark**: 

```math
\lim_{n\to \infty}(-1)^n \quad \text{DNE}
```

"""

# ╔═╡ e05f081c-642b-4815-a64b-f3a3cd6a7609
md"## Limit of a Sequence"

# ╔═╡ 6bf6d15e-7bf1-4770-99c0-4ca44f79143e
md"""
**_Limit Laws for Sequences_** 
Suppose that ``\{a_n\}`` and ``\{b_n\}`` are convergent sequences and ``c`` is a constant. Then

1. **Sum Law** 
```math
\lim_{n\to\infty} \left(a_n+b_n\right)=\lim_{n\to\infty} a_n+\lim_{n\to\infty}b_n
```

2. **Difference Law**
```math
\lim_{n\to\infty} \left(a_n-b_n\right)=\lim_{n\to\infty} a_n-\lim_{n\to\infty}b_n
```

3. **Constant Multiple Law**
```math
\lim_{n\to\infty} c a_n=c\lim_{n\to\infty} a_n
```

4. **Product Law**
```math
\lim_{n\to\infty} \left(a_nb_n\right)=\lim_{n\to\infty} a_n\cdot\lim_{n\to\infty}b_n
```

5. **Quotient Law**

```math
\lim_{n\to\infty} \frac{a_n}{b_n}=\frac{\lim_{n\to\infty} a_n}{\lim_{n\to\infty}b_n}, \quad \text{if  } \lim_{n\to\infty}b_n\not=0
```

"""

# ╔═╡ c399893d-e2d7-4115-a51d-1c1b3289be53
md"""
**Power Law**
```math
\lim_{n\to\infty}  a^p_n=\left[\lim_{n\to\infty} a_n\right]^p
```
**Squeeze Theorem for Sequences** 

If ``a_n\leq b_n\leq c_n`` for ``n\geq n_0`` and ``\lim_{n\to\infty}a_n=\lim_{n\to\infty}c_n=L``, then 
```math
\lim_{n\to\infty}b_n=L.
```

**_Theorem_**

If 
```math
\lim_{n\to\infty}|a_n|=0,
``` 
then 
```math
\lim_{n\to\infty}a_n=0.
```
"""

# ╔═╡ 10d7aa3b-e125-45ef-bf2f-5c16513f3eab
md"""
**_Theorem_**

If  ``\lim_{n\to\infty}a_n=L`` and the function ``f`` is continuous at ``L``, then
```math
\lim_{n\to\infty}f(a_n)=f(L).
```

"""

# ╔═╡ cefb7ca5-1f35-476c-8740-9099bdc684d6
md"""
**Remark**

The sequence ``\{r^n\}`` is convergent if ``-1<r\leq 1``  and divergent for all other values of ``r``.
```math
\lim_{n\to\infty}r^n=\left\{\begin{array}{lll}
0 & \text{if} & -1<r<1,\\ \\
1 &  \text{if} & r=1
\end{array}
\right.
```

"""

# ╔═╡ de0066c2-bf7d-4403-a77e-894bf0feed2b
md"""
**Examples**

Find 
1. ``\lim_{n\to \infty}\left(1+\frac{1}{n}\right)^n.``
1. ``\lim_{n\to \infty}\frac{n^2}{2^n-1}.``
1. ``\lim_{n\to \infty}\frac{n}{n+1}.``
2. ``\lim_{n\to \infty}\frac{n}{\sqrt{n+1}}.``
3. ``\lim_{n\to \infty}\frac{\ln n}{n}.``
4. ``\lim_{n\to \infty}\frac{(-1)^n}{n}.``
5. ``\lim_{n\to \infty}\sin\left(\pi/n\right).``
6. ``\lim_{n\to \infty}\frac{n!}{n^n}.``
6. ``\lim_{n\to \infty}\frac{(-1)^n}{n!}.``


**Exercise**

```math
\lim_{n\to \infty}\frac{n^n}{n!}.
```
"""

# ╔═╡ cfafdd24-2f3e-4497-ace7-f65ce7093b24
md"""
## Pattern Recognition for Sequences

__Example__

Find a sequence ``\{a_n\}`` whose first five terms are
```math
\frac{2}{1},\frac{4}{3},\frac{8}{5},\frac{16}{7},\frac{32}{9},\cdots
```
and then determine whether the sequence you have chosen converges or diverges.


__Example__

Find a sequence ``\{a_n\}`` whose first five terms are
```math
-\frac{2}{1},\frac{8}{2},-\frac{26}{6},\frac{80}{24},-\frac{242}{120},\cdots
```
and then determine whether the sequence you have chosen converges or diverges.

"""

# ╔═╡ 3989fe41-0f2f-4984-9fc4-0e18bfe02238
md"""
## Monotonic and Bounded Sequences

**_Definition_**

* A sequence ``\{a_n\}`` is called **increasing** if ``a_n<a_{n+1}`` for all ``n\geq 1``, that is,``a_1<a_2<a_3<\cdots`` . 
* It is called **decreasing** if ``a_n>a_{n+1}`` for all ``n\geq 1``.
* A sequence is called **monotonic** if it is either increasing or decreasing.
"""

# ╔═╡ bba7a77e-acfa-4bf5-9aa1-0caffa595d52
md"""
**Examples**

Is the following increasing or decreasing?
1. ``\left\{\frac{3}{n+5}\right\}``.
2. ``\left\{\frac{n}{n^2+1}\right\}``.
"""

# ╔═╡ 64b6ca9c-6857-4080-998e-4b36a21c69c9
md"""
**Definition**

A sequence ``\{a_n\}``  is **bounded above** if there is a number ``M`` such that

```math
a_n\leq M\quad \text{for all } n\geq 1
```

A sequence is **bounded below** if there is a number ``m`` such that

```math
m\leq a_n\quad \text{for all } n\geq 1
```

If a sequence is bounded above and below, then it is called a **bounded sequence**.

---

**_Monotonic Sequence Theorem_**

Every bounded, monotonic sequence is convergent.

In particular, a sequence that is increasing and bounded above converges, and a sequence that is decreasing and bounded below converges.
"""


# ╔═╡ 744e2a96-aa6c-4ebb-aaca-861828dc0f0d
md"""
**Example**

```math
a_1 =2 , \quad a_{n+1}={1\over 2}\left(a_n+6\right), \quad \text{for }n=1,2,3, \cdots
```

"""

# ╔═╡ d251cca5-d846-4bc4-b43d-2114f88800b2
md"""
# 9.2: Series and Convergence
> __Objectives__
> - Understand the definition of a convergent infinite series.
> - Use properties of infinite geometric series.
> - Use the th-Term Test for Divergence of an infinite series.
"""

# ╔═╡ 8a4db3f3-adc4-422e-afe2-ce74f455cb34
# begin
# 	n98Slider = @bind n98slider  Slider(1:1000,show_value=true)
# 	md"""
	
# 	----
	
# 	||
# 	|---|
# 	|n = $n98Slider |
	
# 	----
# 	"""
# end

# ╔═╡ ebc708b9-ad01-4473-b97f-4698a86cbdc4
md"## Infinite Series"

# ╔═╡ 37f454b7-4e75-4295-95c6-0e79db7874a8
md"""

Consider the sequence ``\left\{a_n\right\}_{n=1}^{\infty}``. The expression 
```math
a_1 + a_2 + a_3 +\cdots 
```
is called an __infinite series__ (or simply __series__) and we use the notation

```math
\sum_{n=1}^{\infty}a_n \qquad \text{or} \qquad \sum a_n
```

To make sense of this sum, we define a related __sequence__ called the sequence of __partial sums__ ``\left\{s_n\right\}_{n=1}^{\infty}`` as
```math
\begin{array}{lll}
s_1 & = & a_1 \\
s_2 & = & a_1 + a_2 \\
s_3 & = & a_1 + a_2 + a_3\\
\vdots \\
s_n & = & a_1 + a_2 + \cdots + a_n =\sum_{i=1}^n a_i \\
\vdots
\end{array}
```
and give the following definition
"""

# ╔═╡ e94c302e-40e3-4191-a3c4-80d941f6ec01
md"""
**Definition**

Given a series ``\sum_{n=1}^{\infty}a_n=a_1+a_2+a_3+\cdots`` , let ``s_n``denote its ``n``th partial sum:
```math
s_n=\sum_{i=1}^{n}a_i = a_1+a_2+\cdots + a_n
```
If the sequence ``\{s_n\}`` is convergent and ``\lim_{n\to \infty}s_n=s`` exists as a real number, then the ``\sum a_n``series is called __convergent__ and we write
```math
\sum_{n=1}^{\infty}a_n=a_1+a_2+a_3+\cdots =s
```

The number ``s`` is called the __sum__ of the series.

If the sequence ``\{s_n\}`` is divergent, then the series is called __divergent__.

**Remark**
```math
\sum_{n=1}^{\infty}a_n=\lim_{n\to\infty}s_n=\lim_{n\to\infty}\sum_{i=1}^{n}a_i
```

"""

# ╔═╡ 4873c192-525b-43a2-ab48-ade173ed4a63
md"""
**Exercise**
Assume that ``\left\{a_n\right\}_{n=1}^{\infty}`` is a sequence.
1. Find 
```math
\sum_{n=1}^{\infty} a_n \quad \text{ if }\quad s_n = \sum_{i=1}^{n} a_i = \frac{n+2}{3n-5}
```
2. Can you find ``a_n``?

"""

# ╔═╡ b98685af-c363-4dc0-b2da-a3f9c6edd8bb
md"""
__Solution__ 

1. We find first 
```math
\lim_{n\to \infty}s_n =\lim_{n\to \infty}\frac{n+2}{3n - 5} = \frac{1}{3}
```
since the sequence ``\{s_n\}`` converges to ``1 \over 3``, then the series converges and its sum is
```math
\sum_{n=1}^{\infty} a_n = \frac{1}{3}
```

2. Note that 
```math
\begin{array}{lll}
a_n &=& s_n - s_{n-1} = \frac{n+2}{3n - 5} - \frac{(n-1)+2}{3(n-1) - 5}\\
&=&\frac{n+2}{3n - 5}- \frac{n+1}{3n - 8} \\
&=& \frac{(n+2)(3n-8)- (n+1)(3n - 5)}{(3n - 5)(3n-8)}
\end{array}
```
so,
```math
a_n = \frac{-11}{(3n - 5)(3n-8)}
```
"""

# ╔═╡ 9ea80853-2666-4bd6-8b8b-74512955cbf1
md"""
### Telescoping sum
Find the sum of the following series
```math
\sum_{n=1}^{\infty} \frac{1}{n(n+1)}
```
__Solution in class__

---
"""

# ╔═╡ 1af379da-ab4a-4a25-84ff-fc02f2a12eeb
md"""
**Recall**

```math
\lim_{n\to \infty} r^n =\left\{\begin{array}{lll}
    0 & \text{if} & |r|<1 (-1<r<1),\\
    1 & \text{if} & r=1 ,\\
\end{array}\right.
```

So ``\{r^n\}`` converges if ``r\in (-1,1]`` and diverges otherwise

"""

# ╔═╡ 333bae8c-c2e5-4460-b75e-6befc39c4295
md"""
## Geometric Series
The series 
```math
a + a r + a r^2 + \cdots =\sum_{n=1}^{\infty}ar^{n-1}, \qquad a\not = 0
```
is called the __geometric series__ with __common ration__ ``r``

It is convergent if ``|r|< 1`` and its sum is 
```math
\sum_{n=1}^{\infty}ar^{n-1} =\frac{a}{1-r}, \qquad |r|<1
```
and divergent if ``|r|\geq 1``.

**Remark**
In words: the sum of a convergent geometric series is
```math
\frac{\text{first term}}{1-\text{common ratio}}
```

"""

# ╔═╡ 3c259ccc-ff27-4cfd-9ca1-49eb0fcf37fc
md"""
**_Examples_**
1. Find the sum of the geomtric series 
```math
4 - 3 + {9\over 4} - {27 \over 16} + \cdots
```
2. Is the series 
```math
\sum_{n=1}^{\infty} 2^{2n}\; 3^{1-n} \quad \text{convergent or divergent?}
```
3. Write ``2.\bar{7}`` as rational number (ratio of integers).
4. Find the sum of the series 
```math
\sum_{n=0}^{\infty} x^n \quad \text{where}\quad |x|<1.
```

"""

# ╔═╡ 0bc2f276-a8ac-49dc-874a-17c51ae34209
md"""
## Test for Divergence
**Example**
Show that the harmonic series
```math
\sum_{n=1}^{\infty}\frac{1}{n} = 1 + \frac{1}{2}+ \frac{1}{3}+ \frac{1}{4}+\cdots
```
is divergent.

"""

# ╔═╡ 1dca9c92-d15b-4079-bc5c-678e1498a0ae
md"""
**_Theorem_**
If the series 
```math
\sum_{n=1}^{\infty}a_n
```
converges, then
```math
\lim_{n\to \infty}a_n = 0.
```

__Proof__ 

```math
a_n = s_n - s_{n-1}
```

--- 

**_Divergence Test_**
```math
\text{If }\lim_{n\to \infty}a_n \not= 0 \quad \text{or } \lim_{n\to \infty}a_n \text{ DNE}\quad \text{   then the series }\quad
\sum_{n=1}^{\infty}a_n \text{ is divergenet} 
```

---

**_Example_**

```math
\text{The series }\quad \sum_{n=1}^{\infty}\frac{n^2+1}{2n^2+5} \quad \text{is divergent.}
```
---

"""

# ╔═╡ 0308be88-8c68-4ea6-861d-f6a216299aa5
md"""
### Properties of Convergent Series

**_Theorem_**
If ``\sum a_n`` and ``\sum b_n`` are convergent series, then so are the series ``\sum ca_n`` (where ``c`` is a constant), ``\sum (a_n+b_n)``, and ``\sum (a_n-b_n)``, and

```math
\begin{array}{llcl}
\text{(i)} & \sum_{n=1}^{\infty} c a_n &=& c\sum_{n=1}^{\infty} a_n \\ \\ 
\text{(ii)} & \sum_{n=1}^{\infty} \left(a_n+b_n\right) &=& \sum_{n=1}^{\infty} a_n+\sum_{n=1}^{\infty} b_n \\ \\ 
\text{(iii)} & \sum_{n=1}^{\infty} \left(a_n-b_n\right) &=& \sum_{n=1}^{\infty} a_n-\sum_{n=1}^{\infty} b_n \\ \\ \end{array}
```
"""

# ╔═╡ f5d01c74-be75-43ab-bbb5-b4984854a324
md"""
---

**_Remark_**

If it can be shown that  
```math
\sum_{n=100}^{\infty}a_n
```
is convergent. Then 
```math
\sum_{n=1}^{\infty}a_n
```
is convergent.

"""

# ╔═╡ f4628bf9-d130-4882-a634-443ed1c5f4ef
md"""
# 9.3: The Integral Test and $p$-Series
> __Objectives__
> - Use the Integral Test to determine whether an infinite series converges or diverges.
> - Use properties of -series and harmonic series.

**The Integral Test and Estimates of Sums**

Suppose ``f`` a function that is 
1. continuous on ``[1, \infty)``,
2. positive on ``[1, \infty)``,
3. decreasing on ``[1, \infty)``

and let ``a_n=f(n)``. Then the series 
```math
\sum_{n=1}^{\infty}a_n
```
is convergent if and only if the improper integral 
```math
\int_1^\infty f(x) dx
```
is convergent. In other words:
1. If ``\displaystyle\int_1^\infty f(x) dx`` is convergent, then is ``\displaystyle\sum_{n=1}^{\infty}a_n`` convergent.
2. If ``\displaystyle\int_1^\infty f(x) dx`` is divergent, then is ``\displaystyle\sum_{n=1}^{\infty}a_n`` divergent.

**_Examples_**

Test for convergence 
```math
\sum_{n=1}^{\infty}\frac{1}{n^2}, \qquad \sum_{n=1}^{\infty}\frac{1}{n}
```
__Solution in class__ 

"""

# ╔═╡ 57c1a8b8-b489-4121-905c-a6cdafe42d4f
md"""
**_Remark_**
```math
\text{The series } \sum_{n=1}^{\infty}\frac{1}{n^2} \text{ is convergent but }
\sum_{n=1}^{\infty}\frac{1}{n^2}\not=1.
```
```math
\text{It sum is actually equal to }
\sum_{n=1}^{\infty}\frac{1}{n^2}=\frac{\pi^2}{6}
```

"""

# ╔═╡ 7cd0ace0-8af3-4932-ad3b-7406c6200f04
md"""
## P-series and the Harmonic Series
```math
\text{The } p-\text{series}\quad \sum_{n=1}^{\infty}\frac{1}{n^p}
\quad \text{is convergent if } p>1 \text{ and is divergent if } p\leq 1.
```

---
1. ``\sum_{n=1}^{\infty}\frac{1}{n^{1\over 3}}`` is divergent; because it is a ``p-``series with ``p={1\over 3}<1``.
2. ``\sum_{n=1}^{\infty}\frac{1}{n^{3}}`` is convergent; because it is a ``p-``series with ``p={3}>1``.

**_Example_**

Show that 
```math
\sum_{n=1}^{\infty}\frac{\ln n}{n}
```
is divergent.
"""

# ╔═╡ de0c96d2-af55-4858-9287-f497963b22ef
md"""
## Estimating the Sum of a Series
Suppose that the __integral test__ is used to show that
```math
\sum_{n=1}^{\infty}a_n
```
is __convergent__. So its sequenc of partial sums ``\left\{s_n=\sum_{i=1}^n a_i\right\}`` is convergent; that is
```math
\lim_{n\to\infty}s_n=s.
```
So we can write
```math
\underset{s}{\underbrace{\sum_{n=1}^{\infty}a_n}} = 
\underset{s_n}{\underbrace{\sum_{i=1}^{n}a_i}} + \underset{R_n}{\underbrace{\sum_{i=n+1}^{\infty}a_i}}
```
``R_n`` is the __Remainder__ or the error when ``s_n`` is used to approximate ``s``.
"""


# ╔═╡ f5220cd2-d75e-44f2-b80f-ee9577735b1e
begin
	estF(x) = (sqrt(x)/x+1)
	estR=0:0.1:10
	estPltstr=(
		label=:none,
		annotations=[(1,4,L"y=f(x)")],
		xlims=(-1,10), 
		aspect_ratio=1,
		frame_style=:origin,
		xticks=(1:10,[L"n",[L"n+{%$i}" for i in 1:10]...])
	)

	gvmePlt(x,y,o)=plot(x,y;o...)
	estP=gvmePlt(estR,estF.(estR),estPltstr)
	rct(i) =Shape([(i,0),(i+1,0),(i+1,estF(i+1)),(i,estF(i+1))])
	rct2(i) =Shape([(i,0),(i+1,0),(i+1,estF(i)),(i,estF(i))])
	estP1= plot!(estP,[rct(i) for i in 1:10],c=palette(:BuGn_7)[3], label=:none)
	estP2=gvmePlt(estR,estF.(estR),estPltstr)
	plot!(estP2,[rct2(i) for i in 2:10],c=palette(:BuGn_7)[3], label=:none)
	annotate!(estP,[(i+0.5,0.8,L"a_{n+%$i}",10) for i in 1:9])
	annotate!(estP2,[(i+0.5,0.8,L"a_{n+%$(i-1)}",10) for i in 2:9])
	# palette([:purple, :green], 7)[1]
	md"""
	$estP1
	```math
	R_n = a_{n+1}+a_{n+2}+a_{n+3}+\cdots \leq \int_n^{\infty} f(x) dx
	```
	$estP2
	```math
	R_n = a_{n+1}+a_{n+2}+a_{n+3}+\cdots \geq \int_{n+1}^{\infty} f(x) dx
	```
	"""
end

# ╔═╡ 53d12832-df52-488f-a9f0-4b5809c626fd
1/200, 1/242

# ╔═╡ e8e33cc8-09ab-4ebe-b507-ffabb215d4bd
md"""
**_Remainder Estimate for the Integral Test_**
Suppose ``f(k)=a_k``, where ``f`` is a continuous, positive, decreasing function for  ``x\geq n`` and ``\sum a_n``  is convergent. If ``R_n=s-s_n``, then

```math
	\int_{n+1}^{\infty} f(x) dx \leq R_n  \leq \int_n^{\infty} f(x) dx
```

"""

# ╔═╡ 918ebe8d-2872-4baa-ba4b-0970fdd02457
md"""
# 9.4: Comparisons of Series
> __Objectives__
> - Use the Direct Comparison Test to determine whether a series converges or diverges.
> - Use the Limit Comparison Test to determine whether a series converges or diverges.

**The Comparison Tests**

### The Direct Comparison Test

Suppose that ``\sum a_n`` and ``\sum b_n`` are series with positive terms.

* If ``\sum b_n`` is convergent and ``a_n\leq b_n`` for all ``n``, then ``\sum a_n`` is also convergent.
* If ``\sum b_n`` is divergent and ``a_n\geq b_n`` for all ``n`` , then is ``\sum a_n`` also divergent


---

**_Remarks_**
* Most of the time we use one of these series: 
    - ``p-``series ``\sum \frac{1}{n^p}``
    - geometric series.



"""

# ╔═╡ 079a24f1-52a7-4f2b-af4e-5853eb2f67a1
md"""
**_Examples_**
Test for convegence 
```math
\begin{array}{lrrr}
\text{(1)} & \sum_{n=1}^{\infty}\frac{5}{2n^2+4n+3}\\ \\
\text{(2)} & \sum_{n=1}^{\infty}\frac{\ln n}{n}\\
\end{array}
```

"""

# ╔═╡ f15e4057-a44c-4220-a164-6ce19b34d411
md"""
## The Limit Comparison Test

Suppose ``\sum a_n`` that and ``\sum b_n`` are series with positive terms. If
```math
\lim_{n\to\infty}\frac{a_n}{b_n} = c
```
where ``c`` is a finite number and ``c>0``, then either both series converge or both diverge.

**_Remark_**

Exercises `40` and `41` deal with the cases ``c=0`` and ``c=\infty`` .

"""

# ╔═╡ dd22655b-c111-4b7f-95f2-eb32c60908fc
md"""
**_Examples_**
Test for convegence 
```math
\begin{array}{llrr}
\text{(3)} & \sum_{n=1}^{\infty}\frac{1}{2^n-1}\\ \\
\text{(4)} & \sum_{n=1}^{\infty}\frac{2n^2+3n}{\sqrt{5+n^5}}\\
\end{array}
```
"""

# ╔═╡ 2845f715-b032-493f-a979-782fb70b700e
begin
	function poolcode()
		cm"""
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>300))

</div>"""
	end
	function bbl(t,s)
		beginBlock(t,s)
	end
	ebl()=endBlock()
	function bth(s)
		beginTheorem(s)
	end
	eth()=endTheorem()
	ex(n::Int;s::String="")=ex("Example $n",s)
	ex(t,s)=example(t,s)
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

# ╔═╡ 75777562-49ab-47a3-bb8e-b70150f85023
cm"""

$(beginBlock("Definition of Riemann Sum",""))

Let ``f`` be defined on the closed interval ``[a,b]``, and let ``\Delta`` be a partition of ``[a,b]`` given by

```math

a=x_0 < x_1 < x_2 < \cdots < x_{n-1} < x_n = b

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
$(endBlock())
"""


# ╔═╡ 73a7a8e2-67f6-4c49-9775-c67f6c86dbd9
cm"""
$(beginBlock("Definition of Definite Integral",""))
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

$(endBlock())
"""

# ╔═╡ d8637bcf-0735-4faf-a708-a259c6f88a82
cm"""
$(beginTheorem("Continuity Implies Integrability"))

If a function ``f`` is continuous on the closed interval ``[a,b]``, then ``f`` is integrable on ``[a,b]``. That is, 

```math
\int_a^b f(x) dx \quad \textrm{exists}.
```
$(endTheorem())
"""

# ╔═╡ 35e9fefc-1e71-4413-862b-28cfb690777d
cm"""
$(beginTheorem("The Definite Integral as the Area of a Region"))

If ``f`` is continuous and nonnegative on the closed interval ``[a,b]``, then the area of the region bounded by the graph of ``f``, the ``x``-axis, and the vertical lines ``x=a`` and ``x=b`` is
```math
\textrm{Area} = \int_a^b f(x) dx
```
‍$(endTheorem())
‍
"""

# ╔═╡ 9f24cb36-7067-433c-8cb1-eeed7cd20a91
cm"""
$(example("Example 3", "Areas of Common Geometric Figures"))

Evaluate each integral using a geometric formula.
- ``\displaystyle\int_1^3 4 dx``
- ``\displaystyle\int_0^3 (x+2) dx``
- ``\displaystyle\int_{-2}^2 \sqrt{4-x^2} dx``
"""

# ╔═╡ 71726e74-dc4f-432b-8860-8da68721a44f
begin
	f2(x) = sin(x) + 2
    theme(:wong)
    x521 = 1:0.1:5
    y = f2.(x521)
    p3 = plot(x521, y, label=nothing)
    plot!(p3, x521, y / 2, ribbon=y / 2, linestyle=:dot, linealpha=0.1, framestyle=:origin, xticks=(1:5, [:a, "", "", "", :b]), label=nothing, ylims=(-1, 4))
    annotate!(p3, [(3.5, 2.5, L"y=f(x)"), (5.2, 0, L"x"), (0.2, 4, L"y")])
cm"""
$(beginBlock("Remark","The definite integral  is a **number**"))
- It does not depend on ``x``. In fact, we could use any letter in place of ``x`` without changing the value of the integral:

```math
\int_a^b f(x) dx = \int_a^b f(y) dy =\int_a^b f(w) dw =\int_a^b f(😀) d😀 
```
- If ``f(x)\ge 0``, the integral ``\int_a^b f(x) dx`` is the area under the curve ``y=f(x)`` from ``a`` to ``b``.	

    $p3

- ``\int_a^b f(x) dx`` is the net area
<div class="img-container" >

$(Resource("https://www.dropbox.com/s/ol9l38j2a53usei/note3.png?raw=1"))
</div>

$(endBlock())
"""
end

# ╔═╡ f63868f3-2b63-4b37-9d3e-a88869df3266
cm"""
$(beginBlock("Definitions","Two Special Definite Integrals"))
- If ``f``  is defined at ``x=a``, then ``\displaystyle \int_a^a f(x) dx =0``.
- If ``f``  is integrable on ``[a,b]``, then ``\displaystyle \int_b^a f(x) dx =- \int_a^b f(x) dx``.
$(endBlock())
"""

# ╔═╡ f7b3d05b-dc54-4589-99cf-d6cb5bb9988c
cm"""
$(beginTheorem("Additive Interval Property"))
If ``f`` is integrable on the three closed intervals determined by ``a, b`` and ``c``, then
```math
\int_a^b f(x) dx = \int_a^c f(x) dx + \int_c^b f(x) dx.
```
$(endTheorem())
"""

# ╔═╡ 3f4dd200-084f-4c84-be5d-4181c06ba6fb
cm"""

$(beginTheorem("Properties of Definite Integrals"))
- If ``f``  and ``g`` are integrable on ``[a,b]`` and ``k`` is a constant, then the functions ``kf`` and ``f\pm g`` are integrable on ``[a,b]``, and
 	1. ``\displaystyle \int_a^b kf(x) dx = k \int_a^b f(x) dx``.
	2. ``\displaystyle \int_a^b \left[f(x)\pm g(x)\right] dx = \int_a^b f(x) dx\pm \int_a^b g(x) dx``.
$(endTheorem())
"""

# ╔═╡ a6d576ad-6a3a-4be5-aece-ec5d1337b529
cm"""
$(beginTheorem("Preservation of Inequality"))
- If ``f`` is integrable and nonnegative on the closed interval ``[a,b]``, then
```math
0\leq \int_a^b f(x) dx.
```
- If ``f`` and ``g`` are integrable on the closed interval ``[a,b]`` and ``f(x)\leq g(x)`` for every ``x`` in ``[a,b]`` , then
```math
\int_a^b f(x) dx \leq \int_a^b g(x) dx.
```
$(endTheorem())

"""

# ╔═╡ 16065d17-56b1-4ec3-837c-47e11131eefa
cm"""
$(example("Examples",""))

<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>300))

</div>
"""

# ╔═╡ 9656e6b2-4cbc-4554-bf7f-3db26663211f
cm"""
$(beginTheorem("The Fundamental Theorem of Calculus"))

If a function ``f`` is continuous on the closed interval ``[a,b]`` and ``F`` is an antiderivative of ``f`` on the interval ``[a,b]``, then
```math
\int_a^b f(x) dx = F(b) - F(a).
```
$(endTheorem())

"""

# ╔═╡ 23a1010a-9c9c-4112-bf4d-1fa03a8cc011
cm"""

$(beginBlock("Remark",""))

We use the notation 
```math
\int_a^b f(x) dx = \bigl. F(x)\Biggr|_a^b= F(b)-F(a) \quad \textrm{or}\quad 
\int_a^b f(x) dx =\Bigl[F(x)\Bigr]_a^b = F(b)-F(a)
```
$(endBlock())
"""

# ╔═╡ 61615d24-734e-4e75-8137-1b9887c4ce15
cm"""
$(example("Example 1", "Evaluating a Definite Integral"))

Evaluate each definite integral.

- ``\displaystyle \int_1^2 (x^2-3) dx``

$("  ")
- ``\displaystyle \int_1^4 3\sqrt{x} dx``

$("  ")
- ``\displaystyle \int_{0}^{\pi/4} \sec^2 x dx``

$("  ")
- ``\displaystyle \int_{0}^{2} \Big|2x-1\Big| dx``
"""

# ╔═╡ 6de623d1-8004-4b8f-8604-f871abc366e1
begin
    theme(:wong)
    s54e3_f(x) = 1 / x
    s54e3_x = 1:0.1:exp(1)
    s54e3_p = plot(s54e3_x, s54e3_f.(s54e3_x), label=nothing, c=:green)
    plot!(s54e3_p, s54e3_x, s54e3_f.(s54e3_x) / 2, ribbon=s54e3_f.(s54e3_x) / 2, linestyle=:dot, linealpha=0.1, framestyle=:origin, xticks=(1:4, [:1, :2, :3]), label=nothing, ylims=(-0.1, 1.5), xlims=(-0.1, 3))
    annotate!(s54e3_p, [(2, 1, L"y=\frac{1}{x}"), (exp(1), -0.1, L"e")])
    cm"""
    	
    $(example("Example 3","Using the Fundamental Theorem to Find Area"))

    Find the area of the region bounded by the graph of
    ```math
    y=\frac{1}{x}
    ```
    the ``x``-axis, and the vertical lines ``x=1`` and ``x=e``.


    $s54e3_p

    """
end

# ╔═╡ af677c0a-98cf-4347-ba90-740ac4619416
cm"""
$(beginTheorem("The Mean Value Theorem for Integrals"))

If ``f`` is continuous on the closed interval ``[a,b]``, then there exists a number ``c`` in the closed interval ``[a,b]`` such that
```math
\int_a^b f(x) dx =f(c)(b-a).
```

<div class="img-container">

$(Resource("https://www.dropbox.com/s/7fnr2kfq082kq0y/mvt.jpg?raw=1",
:style=>"display:flex;align-items:center;flex-direction: column;"))
</div>

$(endTheorem())

"""


# ╔═╡ 6f705724-6c27-44d9-a904-ad60b7ad4e78
begin 
	ttt = md"## Average Value of a Function"
cm"""
$ttt

$(beginBlock("Definition","the Average Value of a Function on an Interval"))

If ``f`` is integrable on the closed interval ``[a,b]``, then the __average value__ of ``f`` on the interval is
```math
\textbf{Avergae value} = \frac{1}{b-a}\int_a^b f(x) dx
```
$(endBlock())

$(example("Example 4","Finding the Average Value of a Function"))

Find the average value of ``f(x)=3x^2-2x``  on the interval ``[1,4]``.

"""
end

# ╔═╡ a1857e56-2442-48d2-a2be-65d44f042483
cm"""
$(beginTheorem("The Second Fundamental Theorem of Calculus"))

If ``f`` is continuous on an open interval ``I`` containing ``a``, then, for every ``x`` in the interval,

```math

\frac{d}{dx}\left[\int_a^x f(t) \right] = f(x).
```
$(endTheorem())

"""

# ╔═╡ b8a5ff39-9800-4556-8715-2a556a5c628f
cm"""
**Question:** If ``y=F(x)``, then what does ``F'(x)`` represents?

$(beginTheorem("The Net Change Theorem"))

If ``F'(x)`` is the rate of change of a quantity ``F(x)`` , then the definite integral of ``F'(x)`` from ``a`` to ``b`` gives the total change, or __net change__, of ``F(x)`` on the interval ``[a,b]``.

```math
\int_a^b F'(x) dx = F(b) - F(a) \qquad \color{red}{\textrm{Net change of } F(x)}
```
$(endTheorem())
"""

# ╔═╡ d83e79d3-86fa-41e3-b453-c59bedb94520
cm"""
$(example("Example 10","Solving a Particle Motion Problem"))
A particle is moving along aline. Its velocity function (in ``m/s^2``) is given by
```math
v(t)=t^3-10t^2+29t-20,
```
<ul style="list-style-type: lower-alpha;">

<li> What is the <b>displacement</b> of the particle on the time interval 1≤ t≤ 5?</li>
<li>What is the <b>total distance</b> traveled by the particle on the time interval 1≤ t≤ 5?</li>

</ul>
"""

# ╔═╡ 021c3697-be87-4011-9fde-a09b569a09d3
# f155(x) = x / sqrt(1 - 4 * x^2)
# ex1_55=plot(-0.49:0.01:0.49,f155.(-0.49:0.01:0.49), framestyle=:origin)
cm"""
$(beginTheorem("Antidifferentiation of a Composite Function"))
Let ``g`` be a function whose range is an interval ``I``, and let ``f`` be a function that is continuous on ``I``. If ``g`` is differentiable on its domain and  ``F`` is an antiderivative of ``f`` on ``I``, then
```math
\int f(g(x))g'(x)dx = F(g(x)) + C.
```
Letting ``u=g(x)`` gives ``du=g'(x)dx`` and
```math
\int f(u) du = F(u) + C.
```
$(endTheorem())
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


# ╔═╡ eb8cb9bd-04d4-416c-aa11-24a3238d6185
cm"""
$(beginTheorem("The General Power Rule for Integration"))
If ``g`` is a differentiable function of ``x``, then
```math
\int\bigl[g(x)\bigr]^ng'(x) dx = \frac{\bigl[g(x)\bigr]^{n+1}}{n+1} + C, \quad n\neq -1.
```
‍Equivalently, if ``u=g(x)``, then
```math
\int u^n du = \frac{u^{n+1}}{n+1} + C, \quad n\neq -1.
```
$(endTheorem())
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

# ╔═╡ 9b865f48-d71a-4d69-9ce5-e941a8d26df9
cm"""
$(beginTheorem("Integration of Even and Odd Functions"))
Let ``f`` be integrable on **``[-a,a]``**.

* If ``f`` is **even** ``\left[f(-x)=f(x)\right]``, then 
```math
\int_{-a}^a f(x) dx = 2\int_0^a f(x) dx
```

* If ``f`` is **odd** ``\left[f(-x)=-f(x)\right]``, then 
```math
\int_{-a}^a f(x) dx = 0
```
$(endTheorem())

**Example**
Find 
```math
\int_{-1}^1 \frac{\tan x}{1+x^2+x^4} dx 
```

"""

# ╔═╡ 3afeb15b-1f61-483a-b9e7-513e31b8b2d0
cm"""
$(bth("Log Rule for Integration"))

Let ``u``  be a differentiable function of ``x``.
```math
	\begin{array}{llll}
	\textrm{(i) }& \displaystyle \int \frac{1}{x} dx &=& \ln|x| + C  \\ \\
	\textrm{(ii) }& \displaystyle \int \frac{1}{u} du &=& \ln|u| + C  \\ \\
	\end{array}
```
$(eth())

$(bbl("Remark",""))

```math
 \displaystyle \int \frac{u'}{u} dx = \ln|u| + C
```

$(ebl())
"""

# ╔═╡ 7935b0f9-ab43-4d64-bb60-262cf8af71bd
cm"""
$(ex(1,s="Using the Log Rule for Integration"))
```math
\int \frac{2}{x}dx
```
$(ex(3,s="Finding Area with the Log Rule"))
Find the area of the region bounded by the graph of
```math
y = \frac{x}{x^2+1}
```
the ``x``-axis, and the line ``x=3``.

<hr>

$(ex(5,s="Using Long Division Before Integrating"))
```math
\int \frac{x^2+x+1}{x^2+1}dx
```
$(poolcode())
"""

# ╔═╡ 496deea6-4854-4e25-8803-c291765892e5
cm"""
$(ex(7,s="Solve the differential equation"))
Solve 
```math
\frac{dy}{dx}=\frac{1}{x\ln x}
```

"""

# ╔═╡ 3e81f117-a31f-41f3-9cb8-7e7f5371bf9d
cm"""
$(ex(8,s="Using a Trigonometric Identity"))

```math
\int \tan x dx
```

$(ex(9,s="Derivation of the Secant Formula"))

```math
\int \sec x dx
```
"""

# ╔═╡ 1ba2cd48-1f1e-46b9-9bc0-ec90a4bb3161
cm"""
$(bth("Integrals Involving Inverse Trigonometric Functions"))

Let ``u`` be a differential function of ``x``, and let ``a>0``.
```math
\begin{array}{lllll}
\textrm{1.} & \displaystyle \int\frac{du}{\sqrt{a^2-u^2}} &=&\arcsin\frac{u}{a} + C \\ \\

\textrm{2.} & \displaystyle \int\frac{du}{a^2+u^2} &=&\frac{1}{a}\arctan\frac{u}{a} + C \\ \\

\textrm{3.} & \displaystyle \int\frac{du}{u\sqrt{u^2-a^2}} &=&\frac{1}{a}\text{arcsec}\frac{|u|}{a} + C \\ \\
\end{array}
```
$(eth())
"""

# ╔═╡ 90a7cfa3-0c17-49e3-a0f7-5de745888863
cm"""
$(ex(5,s="Completing the Square"))
Find
```math
\int\frac{dx}{x^2-4x+7}.
```
$(ex(6, s="Completing the Square"))
Find the area of the region bounded by the graph of
```math
f(x) = \frac{1}{\sqrt{3x-x^2}}
```
the ``x``-axis, and the lines ``x=\frac{3}{2}`` and ``x=\frac{9}{4}``.

"""

# ╔═╡ 2f9c1c00-c765-4d95-9c52-d9b397498f80
cm"""
$(bth("Differentiation and Integration of Hyperbolic Functions"))

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
$(eth())
"""

# ╔═╡ 6a763c24-f0cd-4442-9e7a-bf6a024b9a38
cm"""
$(ex(4,s="Integrating a Hyperbolic Function"))
Find
```math
\int \cosh 2x \sinh^2 2x dx
```
"""

# ╔═╡ ebe40dc4-5052-4abc-baf3-720cec4da2b3
cm"""

**Remark**
- Area = ``y_{top}-y_{bottom}``.

$(ex(1,s="Finding the Area of a Region Between Two Curves"))

Find the area of the region bounded above by ``y=e^x``, bounded below by ``y=x``, bounded on the sides by ``x=0`` and ``x=1``.

---
"""



# ╔═╡ 79009edb-ce5c-4559-af1d-5f3e868b55ad
cm"""
$(ex(2,s="A Region Lying Between Two Intersecting Graphs"))

Find the area of the region enclosed by the graphs of ``f(x)=2-x^2`` and ``g(x)=x``.

*Solution in class*

---
"""



# ╔═╡ 69015687-860b-45fc-a09b-683c0a71dcbc
cm"""
$(ex(3,s="A Region Lying Between Two Intersecting Graphs"))

Find the area of the region bounded by the curves 

```math 
y=\cos(x), \;\; y=\sin(x), \;\; x=0, \;\; x=\frac{\pi}{2}
```


---
"""



# ╔═╡ 272b1195-9e7a-43c3-81ea-dbf493a1120c
cm"""
$(ex(4,s="Curves That Intersect at More than Two Points"))
Find the area of the region between the graphs of
```math
f(x) = 3x^3-x^2 -10x, \qquad g(x)=-x^2+2x.
```
"""

# ╔═╡ b4d3f89a-62a4-454a-b15e-c6e9c2cc5b41
cm"""
$(ex(5,s="Horizontal Representative Rectangles"))
Find the area of the region bounded by the graphs of ``x=3-y^2`` and ``x=y+1``.
"""

# ╔═╡ e73977c4-d5a9-46ae-bc71-8b4b2e6b37ba
cm"""
$(ex(1,s="Using the Disk Method"))
Find the volume of the solid formed by revolving the region bounded by the graph of
```math
f(x) = \sqrt{\sin x}
```
and the ``x``-axis (``0\leq x\leq \pi``) about the ``x``-axis
"""

# ╔═╡ cf9b982a-77e0-4c4d-8543-d216fa7e8470
cm"""
$(ex(2,s="Using a Line That Is Not a Coordinate Axis"))
Find the volume of the solid formed by revolving the region bounded by the graphs of
```math
f(x)=2-x^2
```
and ``g(x)=1``  about the line ``y=1``.
"""

# ╔═╡ af02099b-229a-446f-bc6d-f83e56429e7c
cm"""
$(ex(3,s="Using the Washer Method"))
Find the volume of the solid formed by revolving the region bounded by the graphs of
```math
y=\sqrt{x} \qquad \textrm{and}\qquad  y = x^2
```
about the ``x``-axis.
"""

# ╔═╡ b6562828-b81a-41b2-a1f0-0e679866192c
cm"""
$(ex(4,s="Integrating with Respect to `y`: Two-Integral Case")) 
Find the volume of the solid formed by revolving the region bounded by the graphs of
```math
y=x^2+1, \quad y=0, \quad x=0, \quad \textrm{and}\quad x=1
```
about the ``y``-axis
"""

# ╔═╡ 40c1a6a7-65c1-4ef6-bee8-2eb454dcf83a
cm"""

[Example 1](https://www.geogebra.org/m/XFgMaKTy) | [Example 2](https://www.geogebra.org/m/XArpgR3A)

$(bbl("Volumes of Solids with Known Cross Sections",""))
1. For cross sections of area ``A(x)`` taken perpendicular to the ``x``-axis,
```math
V = \int_a^b A(x) dx
```
2. For cross sections of area ``A(y)`` taken perpendicular to the ``y``-axis,
```math
V = \int_c^d A(y) dy
```
$(ebl())

$(ex(6,s="Triangular Cross Sections"))
The base of a solid is the region bounded by the lines
```math
f(x)=1-\frac{x}{2},\quad g(x)=-1+\frac{x}{2}\quad \textrm{and}\quad x=0.
```
The cross sections perpendicular to the ``x``-axis are equilateral triangles.
"""


# ╔═╡ aa8b23ea-7ee0-44dd-8be5-0ef50b27ad19
cm"""
$(ex(4,s="Shell Method Preferable"))
Find the volume of the solid formed by revolving the region bounded by the graphs of
```math
y=x^2+1, \quad y=0, \quad x=0, \quad \text{and}\quad x=1.
```
about the ``y``-axis.
"""

# ╔═╡ d396aa7f-f00c-4162-b97b-30029a07a844
cm"""
$(ex(5,s="Shell Method Necessary"))
Find the volume of the solid formed by revolving the region bounded by the graphs of ``y=x^3+x+1``, ``y=1``, and ``x=1`` about the line ``x=2``.
"""

# ╔═╡ 2c1066df-5a47-4dab-bfc6-aad429a8b29c
cm"""
$(bbl("Definition","Arc Length"))

Let the function ``y=f(x)`` represents a smooth curve on the interval ``[a,b]``. The __arc length__ of ``f`` between ``a`` and ``b`` is
```math
s = \int_a^b\sqrt{1+[f'(x)]^2} dx.
```

Similarly, for a smooth curve ``x=g(y)``, the arc length of ``g`` between ``c`` and  ``d`` is
```math
s = \int_c^d\sqrt{1+[g'(y)]^2} dy.
```
$(ebl())
"""

# ╔═╡ 1999bcc0-86dc-4b2c-9443-b8dc993f3e53
cm"""
$(ex(2, s="Finding Arc Length"))
Find the arc length of the graph of ``y=\displaystyle \frac{x^3}{6}+\frac{1}{2x}`` on the interval ``[\frac{1}{2},2]``. 
"""

# ╔═╡ 9c1d6d7a-710c-4ed3-be52-854c5ef4f1d2
cm"""
$(ex(3, s="Finding Arc Length"))
Find the arc length of the graph of ``\displaystyle (y-1)^3=x^2`` on the interval ``[0,8]``. 
"""

# ╔═╡ 790bc605-988a-4925-af1c-57a50f7369a4
cm"""
$(ex(4, s="Finding Arc Length"))
Find the arc length of the graph of ``y=\ln(\cos x)`` from ``x=0`` to ``x=\pi/4``.
"""

# ╔═╡ 7375a71f-c0e1-483b-a6df-a6b69843ae3f
cm"""
$(bbl("Definition","Surface of Revolution"))
When the graph of a continuous function is revolved about a line, the resulting surface is a __surface of revolution__.
$(ebl())
"""

# ╔═╡ b953048b-5d03-4f15-88c4-b4dbc7282c5f
cm"""

<div class="img-container">

$(Resource("https://www.dropbox.com/s/199tfveph8mi2kz/surface_rev.png?raw=1"))

__Surface Area of *frustum*__
```math
S=2\pi r L, \quad \text{where}\quad r=\frac{r_1+r_2}{2}
```
</div>

Consider a function ``f`` that has a continuous derivative on the interval ``[a,b]``. The graph of ``f`` is revolved about the ``x``-axis

<div class="img-container">

$(Resource("https://www.dropbox.com/s/f454ldbfk1z3o2z/surface_rev2.png?raw=1"))

__Surface Area Formula__
```math
S=2\pi \int_a^b x \sqrt{1+[f'(x)]^2} dx.
```
</div>

$(bbl("Definition","Area of a Surface of Revolution"))

Let ``y=f(x)`` have a continuous derivative on the interval ``[a,b]``. 

<div class="img-container">

$(Resource("https://www.dropbox.com/s/2fup4uwh5uclrmv/surface_rev3.png?raw=1"))
</div>

The area ``S`` of the surface of revolution formed by revolving the graph of ``f`` about a horizontal or vertical axis is

```math
S=2\pi \int_a^b r(x) \sqrt{1+[f'(x)]^2} dx, \quad {\color{red} y \text{ is a function of x }}.
```
where ``r(x)`` is the distance between the graph of ``f`` and the axis of revolution. 

If ``x=g(y)`` on the interval ``[c,d]`` , then the surface area is

```math
S=2\pi \int_a^b r(y) \sqrt{1+[g'(y)]^2} dy, \quad {\color{red} x \text{ is a function of y }}.
```
where ``r(y)`` is the distance between the graph of ``g`` and the axis of revolution.
$(ebl())
"""

# ╔═╡ da267376-b6d5-449c-9e4c-b9a5076f286d
cm"""
$(ex(6,s="The Area of a Surface of Revolution"))
Find the area of the surface formed by revolving the graph of ``f(x)=x^3`` on the interval ``[0,1]`` about the ``x``-axis.


$(ex(7,s="The Area of a Surface of Revolution"))
Find the area of the surface formed by revolving the graph of ``f(x)=x^2`` on the interval ``[0,\sqrt{2}]`` about the ``y``-axis.
"""


# ╔═╡ ecb4d1c0-eaae-422b-b594-67019ad34f7f
cm"""
$(ex(3,s=""))
Find ``\displaystyle \int \frac{x^2}{\sqrt{16-x^6}} dx``.

$(ex(4,s="A Disguised Form of the Log Rule"))
Find ``\displaystyle \int \frac{dx}{1+e^x} ``.

"""

# ╔═╡ dff3a46f-1381-4aee-be0f-255c5d68b69f
cm"""
$(bth("Integration by Parts"))
If ``u`` and ``v`` are functions of ``x`` and have continuous derivatives, then
```math
\int u dv = uv -\int v du.
```

$(eth())
"""

# ╔═╡ 93d08547-3e82-48ab-a00c-c06bcd82d1e5
cm"""
$(ex(1,s="Integration by Parts"))
Find ``\displaystyle \int x e^x dx``.

$(ex(2,s="Integration by Parts"))
Find ``\displaystyle \int x^2 \ln x dx``.

$(ex(3,s="An Integrand with a Single Term"))
Evaluate ``\displaystyle \int_0^1 \arcsin x dx``.


$(ex(4,s="Repeated Use of Integration by Parts"))
Find ``\displaystyle \int x^2 \sin x dx``.

$(ex(5,s="Integration by Parts"))
Find ``\displaystyle \int\sec^3 x dx``.s

$(ex(7,s="Using the Tabular Method"))
Find ``\displaystyle \int x^2 \sin 4x dx``.
"""

# ╔═╡ cc45268c-aecc-4f3d-ba15-07557d216ada
cm"""
$(ex(1,s="Power of Sine Is Odd and Positive"))
Find ``\displaystyle \int \sin^3 x \cos^4 x dx``.
"""

# ╔═╡ ddd59a41-8932-4105-9734-e2e333f3544d
cm"""
$(ex(2,s="Power of Cosine Is Odd and Positive"))
Evaluate ``\displaystyle \int_{\pi/6}^{\pi/3}\frac{\cos^3 x}{\sqrt{\sin x}} dx``.
"""

# ╔═╡ 9b72a023-f462-408e-8c1c-8d29197910e7
cm"""
$(ex(3,s="Power of Cosine Is Even and Nonnegative"))
Find ``\displaystyle \int \cos^4 x dx``.
"""

# ╔═╡ be2a345f-576f-41c1-8048-38959cb054d2
cm"""
$(ex(4,s="Power of Tangent Is Odd and Positive"))
Find ``\displaystyle \int \frac{\tan^3x}{\sqrt{\sec x}} dx``.
"""

# ╔═╡ 0d75292d-4ecc-4c02-9566-aac213b56def
cm"""
$(ex(5,s="Power of Secant Is Even and Positive"))
Find ``\displaystyle \int \sec^4 3x \tan^3 3x dx``.
"""

# ╔═╡ 49b1d6cf-9f6a-4035-83b2-9cf149608107
cm"""
$(ex(6,s="Power of Tangent Is Even"))
Evaluate ``\displaystyle \int_0^{\pi/4}\tan^4 x dx``.
"""

# ╔═╡ 758f54b6-9643-4d66-a22e-d3fc432bb3b7
cm"""
$(ex(7,s="Converting to Sines and Cosines"))
Find ``\displaystyle \int \frac{\sec x}{\sqrt{\tan^2 x}} dx``.
"""

# ╔═╡ 8abaf091-1709-40af-ab35-454429c7befd
cm"""
$(ex(8,s="Using a Product-to-Sum Formula"))
Find ``\displaystyle \int \sin 5x \cos 4x dx``.
"""

# ╔═╡ b4c7bc3c-be86-494a-92b7-da2fe1dbb03b
cm"""
$(ex(1,s="Trigonometric Substitution"))
Find ``\displaystyle \int \frac{dx}{x^2\sqrt{9-x^2}}``.

$(ex(2,s="Trigonometric Substitution"))
Find ``\displaystyle \int \frac{dx}{\sqrt{4x^2+1}}``.


$(ex(3,s="Trigonometric Substitution: Rational Powers"))
Find ``\displaystyle \int \frac{dx}{(x^2+1)^{3/2}}``.


$(ex(4,s="Converting the Limits of Integration"))
Find ``\displaystyle \int_{\sqrt{3}}^{2} \frac{\sqrt{x^2-3}}{x}dx``.
"""

# ╔═╡ e039ddb5-000f-4289-9a0c-9fc02b401dbf
cm"""
$(ex(5,s="Finding Arc Length"))
Find the arc length of the graph of ``f(x)=\frac{1}{2}x^2`` from ``x=0`` to ``x=1``.


"""

# ╔═╡ fda5809c-cd1e-4be1-8091-c927efa44bed
cm"""
$(example("Example","Partial Fractions")) 
Write out the form of the partial fractions decomposition of the function
```math
\frac{x^3+x+1}{x(x-1)(x+1)^2(x^2+x+1)(x^2+4)^2}
```
"""

# ╔═╡ 9bb81d90-4ec1-4669-aaf8-571428fd1c43
cm"""
$(bbl("Definition of an Improper Integral of Type 1",""))

**(a)** If ``\int_a^t f(x) dx`` exists for every number ``t\ge a``, then
```math
\int_a^{\infty} f(x) dx = \lim_{t\to \infty} \int_a^t f(x) dx
```
provided this limit exists (as a finite number).


**(b)** If ``\int_t^b f(x) dx`` exists for every number ``t\le b``, then
```math
\int_{-\infty}^b f(x) dx = \lim_{t\to -\infty} \int_t^b f(x) dx
```
provided this limit exists (as a finite number).

The improper integrals ``\int_a^{\infty} f(x) dx`` and ``\int_{-\infty}^b f(x) dx`` are called *__convergent__* if the corresponding limit exists and *__divergent__* if the limit does not exist.

**(c)** If both ``\int_a^{\infty} f(x) dx`` and ``\int_{-\infty}^b f(x) dx`` are convergent, then we define
```math
\int_{-\infty}^{\infty} f(x) dx =  \int_{-\infty}^a f(x) dx +\int_a^{\infty} f(x) dx
```

In part (c) any real number  can be used
$(ebl())
"""


# ╔═╡ f36c8419-9fc0-40b3-8c35-302694ae02c7
cm"""
$(bbl("Definition of an Improper Integral of Type 2",""))

**(a)** If ``f`` is continuous on ``[a,b)`` and is discontinuous at ``b``, then

```math
\int_a^b f(x) dx = \lim_{t\to b^-} \int_a^t f(x) dx
```

provided this limit exists (as a finite number).


**(b)** If ``f`` is continuous on ``(a,b]`` and is discontinuous at ``a``, then
```math
\int_a^b f(x) dx = \lim_{t\to a^{+}} \int_t^b f(x) dx
```
provided this limit exists (as a finite number).


The improper integral ``\int_a^b f(x) dx`` is called **convergent** if the corresponding limit exists and **divergent** if the limit does not exist.

**(c)** If ``f`` has a discontinuity at ``c``, where ``a < c < b``, and both ``\int_a^c f(x) dx`` and ``\int_c^b f(x) dx`` are convergent, then we define

```math
\int_{a}^{b} f(x) dx =  \int_{a}^c f(x) dx +\int_c^b f(x) dx
```

$(ebl())

"""

# ╔═╡ c226414b-a365-448d-b063-b51107dc9af8
cm"""
$(ex(9,s="Doubly Improper Integral"))
Evaluate ``\displaystyle \int_0^{\infty}\frac{dx}{\sqrt{x}(x+1)}``
"""

# ╔═╡ 66b5302a-2646-495f-a408-8963b7530949
cm"""
$(bbl("Definition of the Limit of a Sequence",""))

Let ``L`` be a real number. The __limit__ of a sequence ``\{a_n\} is ``L``, written as
```math
\lim_{n\to\infty} a_n = L
```
if for each ``\epsilon >0``, there exists ``M>0`` such that ``|a_n-L|<\epsilon`` whenever ``n>M``. If the limit ``L`` of a sequence exists, then the sequence __converges__ to ``L``. If the limit of a sequence does not exist, then the sequence __diverges__.

$(ebl())
"""

# ╔═╡ d7bfd01a-e1c6-4abb-a58f-bd35bacc0a2d
cm"""
$(bth("Limit of a Sequence"))
If 
```math
\lim_{x\to\infty}f(x)=L \quad \text{and}\quad f(n)=a_n \quad \text{when} \; n \text{ is an integer}, 
```
then 
```math
\lim_{n\to\infty}a_n=L.
```
$(eth())
* **Remark**
```math
\lim_{n\to\infty} \frac{1}{n^r} = 0 \quad \text{if} \quad r>0
"""

# ╔═╡ d0af669e-bce0-4aa8-a897-9f887bd27d1c
md"""
**_Exercises_**

Test for convegence 
```math
\begin{array}{llrr}
\text{(5)} & \sum_{n=1}^{\infty}\frac{n+3^n}{n+2^n}\\ \\
\text{(6)} & \sum_{n=1}^{\infty}\frac{1}{n^{1+{1\over n}}}\\
\end{array}
```
"""

# ╔═╡ 704cc640-acc1-4c21-9673-3092a45d1377
md"""
# 9.5: Alternating Series
> **objectives**
> - Use the Alternating Series Test to determine whether an infinite series converges.
> - Use the Alternating Series Remainder to approximate the sum of an alternating series.
> - Classify a convergent series as absolutely or conditionally convergent.
> - Rearrange an infinite series to obtain a different sum. 


An __alternating series__ is a series whose terms are alternately __positive__ and __negative__. For examples:

```math
1-\frac{1}{2}+\frac{1}{3}-\frac{1}{4}+\frac{1}{5}-\frac{1}{6}+\cdots = \sum_{n=1}^{\infty}(-1)^{(n-1)}\frac{1}{n}
```

```math
-\frac{1}{2}+\frac{2}{3}-\frac{3}{4}+\frac{4}{5}-\frac{5}{6}+\frac{6}{7}-\cdots = \sum_{n=1}^{\infty}(-1)^{n}\frac{n}{n+1}
```

```math
\text{alternating series}\quad \sum_{n=1}^{\infty}a_n = \sum_{n=1}^{\infty}(-1)^{n-1}b_n
```

**_Alternating Series Test_**

If the alternating series
```math
\sum_{n=1}^{\infty}(-1)^{n-1}b_n = b_1-b_2+b_3-b_4+b_5-b_6+\cdots \quad (b_n>0)
```
satisfies the conditions
```math
\begin{array}{cll}
\text{(i)}& b_{n+1}\leq b_n & \text{for all } n \\ \\
\text{(ii)}& \lim_{n\to\infty}b_n=0
\end{array}
```
then the series is convergent.

"""

# ╔═╡ ccef397a-98e7-4d27-82e2-228e5154d63a
n9Slider = @bind n9slider  Slider(1:1000,show_value=true);md"n = $n9Slider"


# ╔═╡ 959825de-2ae7-4212-893d-f8a66f91b39c
begin
	a9(n) = ((-1)^(n))/(n)
	d9=2:(1+n9slider)
	bs92 = (n9slider>9) ? "\\sum_{i=1}^{$n9slider}(-1)^{n-1}b_i" : (join([(i==n9slider) ?  "b_{$i}" :  
				iseven(i) ? "b_{$i}+" : "b_{$i}-" for i in 1:n9slider]))
	
	plt9 = scatter(a9.(d9), zeros(10),
		frame_style=:origin, 
		ylimits=(-0.1,1),
		xlimits=(-0.36,0.55),
		yaxis=nothing,
		label=:none,
		showaxis=:x,
		ticks=[],
		legend=:topleft,
		title_location=:left,
		grid=:none,
		title=L"\textrm{Proof}",
		annotations=[(0.2,0.8,L"s_{%$n9slider}=%$bs92")]
	)
	annotate!(plt9,[(a9(d9[i]),0.04,L"s_{%$i}",8) for i in 1:n9slider])
	
	md"""
	$plt9
	"""
		
end

# ╔═╡ cc66678d-7ddc-47db-86e0-5ee50bb58af6
md"""
**_Example_**
Test for convegrnce 
```math
\begin{array}{cl}
\text{(1)} &  \sum_{n=1}^\infty \frac{(-1)^{n-1}}{n} \\ \\

\text{(2)} & \sum_{n=1}^\infty (-1)^{n}\frac{3n}{4n-1}\\ \\

\text{(3)} & \sum_{n=1}^\infty (-1)^{n+1}\frac{n^2}{n^3+1}
\end{array}
```
"""

# ╔═╡ 5abe72af-e1d9-4002-84ef-954329dc23c6
md"""
### Estimating Sums of Alternating Series
If ``s=\sum (-1)^{n-1}b_n``, where ``b_n>0``, is the sum of an alternating series that satisfies
```math
\begin{array}{cl}
\text{(i)} & b_{n+1}\leq b_n \quad \text{and} \\ \\
\text{(ii)} & \lim_{n\to\infty}b_n =0
\end{array}
```
then
```math
\left|R_n\right|=\left|s-s_n\right|\leq b_{n+1}

```

"""

# ╔═╡ efadc950-2f26-4e5e-bc8b-36862bd8cca8
md"""
**_Example_**
How many terms of the series 
```math
\sum_{n=1}^{\infty}{\frac{(-1)^{n+1}}{{n^6}}}
```
do we need to add in order to find the sum accurate with $|error|< 0.000001$?

"""

# ╔═╡ 35e833fa-4ec5-4c95-9e50-1fc99ea1e09f
# n10Slider = @bind n10slider NumberField(1:20);md"n = $n10Slider"

# ╔═╡ f154ffb1-c488-4fca-9631-b5e56f286f3a
md"""
### Absolute Convergence and Conditional Convergence
* A series ``\sum a_n`` is called __absolutely convergent__ if the series of absolute values ``\sum |a_n|`` is convergent.
* A series ``\sum a_n`` is called __conditionally convergent__ if it is convergent but not absolutely convergent; that is, ``\sum a_n`` if converges but ``\sum |a_n|``  diverges.

---

**_Theorem_**

If a series ``\sum a_n`` is absolutely convergent, then it is convergent.

"""

# ╔═╡ 9a6aad50-069e-4264-90d0-2fa508769e70
md"""
**_Examples_**
Determine whether the series is absolutely convergent, conditionally convergent, or divergent
```math
\begin{array}{lcl}
\text{(i)} & &\sum^{\infty}_{n=1}\frac{(-1)^n}{n}  \\ \\
\text{(ii)} & &\sum^{\infty}_{n=1}\frac{(-1)^n}{n^2}  \\ \\
\text{(iii)} & &\sum^{\infty}_{n=1}\frac{(-1)^n}{\sqrt[3]{n}}  \\ \\
\text{(v)} & &\sum^{\infty}_{n=1}(-1)^n\frac{n}{2n+1}  \\ \\
\end{array}
```
"""

# ╔═╡ df5b6e45-37cb-4a2d-9427-946a57794960
md"""
# 9.6: The Ratio and Root Tests
> __Objectives__
> - Use the Ratio Test to determine whether a series converges or diverges.
> - Use the Root Test to determine whether a series converges or diverges.
> - Review the tests for convergence and divergence of an infinite series. 

## The Ratio Test
```math
\begin{array}{ll}
\text{(i)} &\text{If } \lim_{n\to\infty}\left|\frac{a_{n+1}}{a_n}\right|=L<1,\text{ then the series is absolutely convergent} \\
& \text{(and therefore convergent).} \\ \\

\text{(ii)} &\text{If } \lim_{n\to\infty}\left|\frac{a_{n+1}}{a_n}\right|=L>1 \text{ or }\lim_{n\to\infty}\left|\frac{a_{n+1}}{a_n}\right|=\infty,\\
& \text{ then the series is divergent} \\ \\

\text{(iii)} & If \lim_{n\to\infty}\left|\frac{a_{n+1}}{a_n}\right|=1,
\text{ the Ratio Test is inconclusive;} \\
& \text{that is, no conclusion can be drawn about}\\
& \text{the convergence or divergence of} \sum a_n.
\end{array}
```
"""

# ╔═╡ c9c85ae9-2b27-4f54-a470-49a8bf28a82d
md"""
## The Root Test
```math
\begin{array}{ll}
\text{(i)} &\text{If } \lim_{n\to\infty}\sqrt[n]{\left|a_n\right|}=L<1,\text{ then the series is absolutely convergent} \\
& \text{(and therefore convergent).} \\ \\

\text{(ii)} &\text{If } \lim_{n\to\infty}\sqrt[n]{\left|a_n\right|}=L>1 \text{ or }\lim_{n\to\infty}\sqrt[n]{\left|a_n\right|}=\infty,\\
& \text{ then the series is divergent} \\ \\

\text{(iii)} & If \lim_{n\to\infty}\sqrt[n]{\left|a_n\right|}=1,
\text{ the Ratio Test is inconclusive}.
\end{array}
```
"""

# ╔═╡ 81881f3c-c074-44c9-8246-d5825dee9069
md"""
**_Examples_**
Test for convergence 
```math
\begin{array}{lrl}
    \text{(1)} & \text{     } & \sum_{n=1}^\infty \frac{\cos n}{n^3}\\ \\
    \text{(2)} & \text{     } & \sum_{n=1}^\infty (-1)^n\frac{n^3}{3^n}\\ \\ 
    \text{(3)} & \text{     } & \sum_{n=1}^\infty  \left(\frac{2n+5}{5n+2}\right)^n \\
\end{array}
```

"""

# ╔═╡ 2a079f3f-d9e2-424c-b88a-408d352be5c6
[cos(π*n) for n in 1:10]

# ╔═╡ 8141bdca-0127-4d3a-b277-2da3779aead5
md"""
# 9.7: Taylor Polynomials and Approximations
> __Objectives__
> - Find polynomial approximations of elementary functions and compare them with the elementary functions.
> - Find Taylor and Maclaurin polynomial approximations of elementary functions.
> - Use the remainder of a Taylor polynomial.

"""

# ╔═╡ b317f1f5-0b07-4257-82d1-fa9cb313b901
begin
	p962 = md"""
For the function ``f(x)=e^x``, find a first-degree polynomial function ``P_1(x)=a_0+a_1x``  whose value and slope agree with the value and slope of  at  ``x=0``.
"""

cm"""
## Polynomial Approximations of Elementary Functions

$p962

"""

end

# ╔═╡ af7bdbca-ab63-4823-a2f3-efe1af56b7f4
begin 
	showSn = @bind showsn Radio(["show"=>"Show", "hide"=>"Hide"], default="show")
	nStart = @bind nstart NumberField(-1:1, default=0) 
	nTerms = @bind nterms NumberField(nstart:100) 
	# n starts from   $nStart
	md"""
	$showSn
	
	
	
	n = $nTerms
	"""
end

# ╔═╡ 3f16a586-692d-495b-9cc7-63c5cc635ebd
begin
	an(x,n)=x^n/factorial(n)
	fn(x)=exp(x)
	# an1(x,n)=factorial(big(n))*x^n
	
	intrvl = -4.1:0.01:4.1
	plus_or_empty(n,last) = (n<last) ? " + " : ""
	term_reps(n,last) = join(
			[
			  n==0 ? "1" : (n==1) ? "x" : "x^{$n}/{$n}!"
			, plus_or_empty(n,last)
			])
	
	ps1(x,s,e) = sum([an(x,i) for i in s:e])
	plt=plot()
	if (showsn=="show")
	plt = plot!(plt,
				 intrvl
			   , ps1.(intrvl,nstart,nterms)
			   , label=(nterms>=10) ? latexstring("P_{$(nterms)}(x)=\\sum_{n=0}^{$(nterms)}\\frac{x^n}{n!}") : latexstring("P_{$(nterms)}(x)="*
						join([term_reps(i,nterms) for i in nstart:nterms])
								  )
			  )
	end
	plot!(plt,intrvl,fn.(intrvl),label=L"f(x)=e^x",c=:green)
	plot!(plt;
			  frame_style=:origin
			, ylims=(-0.5,3)
			, legend=:topleft
	)
	# plt =plot(plts)
	md"""
	$plt
	"""
end

# ╔═╡ 7392677a-a151-484d-ba48-6ac841c9a98a
md"""
## Taylor and Maclaurin Polynomials

"""

# ╔═╡ 588305e1-3818-4007-b1c0-267e96a7fe7a
cm"""
$(bbl("Definitions","of th Taylor Polynomial and th Maclaurin Polynomial"))
If ``f`` has ``n`` derivatives at ``c``, then the polynomial
```math
P_n(x)=f(c)+f'(c)(x-c)+\frac{f''(c)}{2!}(x-c)^2
+\cdots +\frac{f^{(n)}(c)}{n!}(x-c)^n
```
is called the ``n``th __Taylor polynomial__ for ``f`` at ``c``. If ``c``, then
```math
P_n(x)=f(0)+f'(0)x+\frac{f''(0)}{2!}x^2
+\cdots +\frac{f^{(n)}(0)}{n!}x^n
```
is also called ``n``th th __Maclaurin polynomial__ for ``f``.
$(ebl())
"""

# ╔═╡ 828f4175-0f55-45af-85d2-6c396325462e
cm"""
$(ex(3,s="A Maclaurin Polynomial for e^x"))

$(ex(4,s="Finding Taylor Polynomials for lnx"))
Find the Taylor polynomials ``P_0, P_1, P_2, P_3``, and ``P_4`` for
```math
f(x)=\ln x
```
centered at ``c=1``.

$(ex(5,s="Finding Maclaurin Polynomials for cosx"))
Find the Taylor polynomials ``P_0, P_2, P_4``, and ``P_6`` to approximate ``\cos(0.1)``.

$(ex(6,s="Finding Taylor Polynomials for sin x"))
Find the Taylor polynomial ``P_3``for
```math
f(x)=\sin x
```
centered at ``c=\pi/6``.

$(ex(7,s="Approximation Using Maclaurin Polynomials"))
Use a fourth Maclaurin polynomial to approximate the value of ``\ln(1.1)``.
"""

# ╔═╡ eda03c6d-6d83-4bc0-964d-8091ffc8f777
md"""
# 9.8: Power Series
> __Objectives__
> -Understand the definition of a power series.
> - Find the radius and interval of convergence of a power series.
> - Determine the endpoint convergence of a power series.
> - Differentiate and integrate a power series.

A series of the form 
```math
\sum_{n=0}^{\infty} a_n(x-c)^n = a_0 + a_1(x-c) +a_2(x-c)^2 +a_3(x-c)^3 + \cdots
```
is called a __power series in ``(x-c)``__ or a __power series centered at ``c``__ or a __power series about ``c``__

We are interested in __finding the values of ``x`` for which this series is convergent.__
"""

# ╔═╡ a276e779-9072-4634-bb7a-f7190b275c95
md"## Radius and Interval of Convergence"

# ╔═╡ 312270b2-40e1-44b9-a87c-a0602f3c6633
md"""
----

__*Theorem*__
For a power series ``\sum_{n=0}^{\infty}a_n(x-c)^n``, there are only three possibilities:

(i) The series converges only when ``x=c``.

(ii)The series converges for all ``x``.

(iii) There is a positive number ``R`` such that the series converges if 
``|x-c|<R`` and diverges if ``|x-c|>R``.

__Remarks__

- The number ``R`` is called the __radius of convergence__ of the power series.
   - The radius of convergence is ``R=0`` in case (i) 
   - ``R=\infty`` in case (ii). 
- The __interval of convergence__ of a power series is the interval that consists of all values of  for which the series converges. 
   - In case (i) the interval consists of just a single point ``a``. 
   - In case (ii) the interval is ``(-\infty,\infty)``.
"""

# ╔═╡ cc8e6d6c-d756-4401-abf3-e268763b8bea
cm"""
$(example("Examples",""))

```math
\begin{array}{l@{\,\,\,\,}l}
(1) & \displaystyle\sum_{n=0}^\infty n! x^n\\ \\
(2) & \displaystyle\sum_{n=1}^\infty \frac{(x-3)^n}{n}\\ \\
(3) & \displaystyle\sum_{n=0}^\infty \frac{(-1)^nx^{2n}}{(2n)!}
\end{array}
```

"""

# ╔═╡ 7ab9ae32-2ea1-451c-8fe9-77f6fe628f8d
md"""
## Endpoint Convergence
"""

# ╔═╡ 54bf8db4-d8a6-40ba-ba9d-c14dad31e70a
md"""
#### Examples
Find the radius of convergence and interval of convergence of the series
```math
\begin{array}{l@{\,\,\,\,}l}
(4) & \sum_{n=0}^\infty \frac{(-1)^nx^n}{\sqrt{n+1}}\\
(5) & \sum_{n=0}^\infty \frac{n(x+2)^n}{3^{n+1}}\\
\end{array}
```

"""

# ╔═╡ b08d4a39-32ec-4323-b3d6-4aed3a08e7d6
md"""
## Differentiation and Integration of Power Series
**(term-by-term differentiation and integration)**

__*Theorem*__

If the power series ``\sum a_n(x-c)^n``  has radius of convergence ``R>0``, then the function ``f`` defined by
```math
f(x) = a_0+a_1(x-c)+a_2(x-c)^2+\cdots = \sum_{n=0}^{\infty}a_n(x-c)^n
```
is differentiable (and therefore continuous) on the interval ``(a-R,a+R)`` and
```math
\begin{array}{lllll}
\text{(i)} &\text{}& f'(x) &=& 
a_1+2a_2(x-c)+3a_2(x-c)^2+\cdots \\
&&&=& \sum_{n=1}^{\infty}na_n(x-c)^{n-1} \\ \\
\text{(ii)} &\text{}& \int f(x) dx &=& 
C + a_0(x-c)+a_1\frac{(x-c)^2}{2}+a_2\frac{(x-c)^3}{3}+\cdots \\
&&&=&C+\sum_{n=0}^{\infty}a_n\frac{(x-c)^{n+1}}{n+1} \\ \\

\end{array}
```

The radii of convergence of the power series in Equations (i) and (ii) are both ``R``.

"""

# ╔═╡ d5e4d679-8871-496d-88d8-a7ac7891058e
cm"""
$(ex(8,s="Intervals of Convergence"))
Consider the function
```math
f(x)= \sum_{n=1}^{\infty}\frac{x^n}{n}
```
Find the interval of convergence for each of the following.
1. ``\displaystyle f(x)``
1. ``\displaystyle f'(x)``
1. ``\displaystyle \int f(x) dx``

"""

# ╔═╡ 9fe9a0ee-ba90-44fa-ba59-cb8c145f0f26
md"""
# 9.9: Representation of Functions by Power Series
> **Objectives**
> - Find a geometric power series that represents a function.
> - Construct a power series using series operations.

## Geometric Power Series
```math
\frac{1}{1-x} = 1 + x + x^2 +x^3 +\cdots =\sum_{n=0}^{\infty}x^n, \quad |x|<1.
```
"""

# ╔═╡ 07333593-857d-4f0b-a245-253d50505a46
md"""
#### Examples
1. Express as the sum of a power series and find the interval of convergence.
```math
f(x)=\frac{1}{1+x^2}
```
2. Find a power series representation for 
```math
f(x)=\frac{1}{x+2}
```
3. Find a power series representation for 
```math
f(x)=\frac{x^3}{x+2}
```

4. Find a power series representation around ``1`` for 
```math
f(x)=\frac{1}{x}
```
__SOLUTION IN CLASS__

"""

# ╔═╡ a20dcc68-ebc7-4e3c-8bec-aaa01b84ae89
cm"""
$(bbl("Operations with Power Series",""))
Let ``f(x)=\displaystyle \sum_{n=0}^{\infty}a_n x^n`` and ``g(x)=\displaystyle \sum_{n=0}^{\infty}b_n x^n``.
1. ``f(kx) = \displaystyle  \sum_{n=0}^{\infty}a_n k^nx^n``.
1. ``f(x^N) = \displaystyle  \sum_{n=0}^{\infty}a_n x^{Nn}``.
1. ``f(x)\pm g(x) = \displaystyle  \sum_{n=0}^{\infty}(a_n\pm b_n) x^n``.
$(ebl())
"""

# ╔═╡ 333af7ee-6593-4edf-bd00-aade7de8f743
md"""
#### Examples
4. Express as a power series 
```math
f(x) = \frac{3x-1}{x^2-1}
```
4. Express as a power series 
```math
f(x) = \frac{1}{(1-x)^2}
```
5. Express as a power series 
```math
f(x) = \ln(1+x)
```
6. Express as a power series 
```math
f(x) = \tan^{-1}x
```

7. Evaluate
```math
\int \frac{dx}{1+x^7}
```

8. Approximate ``\pi``
```math
4\tan^{-1}\frac{1}{5}-\tan^{-1}\frac{1}{239} = \frac{\pi}{4} \quad \text{(see ex. 44)}
```

__SOLUTION IN CLASS__

"""

# ╔═╡ cfdba930-c066-401d-99e5-b90b0e667469
md"""# 9.10: Taylor and Maclaurin Series [^⭐]
[^⭐]:  Students have to memorize the power series representations of the functions
``f(x) =\frac{1}{1+x}, e^x, \sin x , \cos x , \arctan x , (1 + 𝑥)^𝑘`` in page 674. 
> **Objectives**
> - Find a Taylor or Maclaurin series for a function.
> - Find a binomial series.
> - Use a basic list of Taylor series to find other Taylor series.

* By the end of this section we will be able to write the following power series representations of certain functions

```math
{\small
\begin{array}{llcllllr}
{\small \text{(1)}} & \frac{1}{1-x} &=&
	\sum_{n=0}^{\infty} x^n &=& 
	1+x+x^2+x^3+\cdots,&R=1 \\

{\small \text{(2)}} & \ln(1+x) &=&
	\sum_{n=0}^{\infty} (-1)^{n} \frac{x^{n+1}}{n+1} &=& 
	x-\frac{x^2}{2}+\frac{x^3}{3}-\frac{x^4}{4}+\cdots,&R=1 \\

{\small \text{(3)}} & \tan^{-1}x &=&
	\sum_{n=0}^{\infty} (-1)^n \frac{x^{2n+1}}{2n+1} &=& 
	x-\frac{x^3}{3}+\frac{x^5}{5}-\frac{x^7}{7}+\cdots,&R=1 \\

{\small \text{(4)}} & e^x &=&
	\sum_{n=0}^{\infty} \frac{x^n}{n!} &=& 
	1+\frac{x}{1!}+\frac{x^2}{2!}+\frac{x^3}{3!}+\cdots,&R=\infty \\


{\small \text{(5)}} & \sin x &=&
	\sum_{n=0}^{\infty} (-1)^n\frac{x^{2n+1}}{(2n+1)!} &=& 
	x-\frac{x^3}{3!}+\frac{x^5}{5!}-\frac{x^7}{7!}+\cdots,&R=\infty \\

{\small \text{(6)}} & \cos x &=&
	\sum_{n=0}^{\infty} (-1)^n\frac{x^{2n}}{(2n)!} &=& 
	1-\frac{x^2}{2!}+\frac{x^4}{4!}-\frac{x^6}{6!}+\cdots,&R=\infty \\


{\small \text{(7)}} & (1+x)^k &=&
\sum_{n=0}^{\infty} \left(\begin{array}{c}k\\n\end{array}\right)x^n &=& 
	1+kx+\frac{k(k-1)}{2!}x^2+\frac{k(k-1)(k-2)}{3!}x^3+\cdots,&R=1 \\



\end{array}
}
```

"""

# ╔═╡ 77657ac7-e6a5-409c-9166-03a85c2c5041
cm"""
$(bth("Taylor Theorem"))
If ``f`` has a power series representation (expansion) at ``a`` , that is, if

```math
f(x) = \sum_{n=0}^{\infty}c_n (x-a)^n, \quad |x-c| < R
```

then its coefficients are given by the formula
```math
c_n = \frac{f^{(n)}(a)}{n!}
```

**_Remarks_** 
- The series is called the __Taylor series of the function ``f`` at ``a`` (or about ``a`` or centered at ``a``)__.
- (__Maclaurin Series__) If ``a=0``, Taylor series becomes
```math
{\small
f(x) = \sum_{n=0}^{\infty}\frac{f^{(n)}(0)}{n!} x^n=f(0)+\frac{f'(0)}{1!}x
+\frac{f''(0)}{2!}x^2+\frac{f'''(0)}{3!}x^3+\cdots
}
```
$(eth())
"""

# ╔═╡ 3b6124f6-fbf5-4b17-9329-be9f9bb75d43
md"""
#### Examples (important)
- Find __*Maclaurin*__ series for 

```math

\begin{array}{lll}
{\small \text{(1)}} & f(x)=e^x \\
{\small \text{(2)}} & f(x)=\sin x \\
{\small \text{(3)}} & f(x)=\cos x \\
\end{array}
```
- Find Taylor Series of ``f(x)=\sin x\quad ``   about  ``\quad {\pi \over 3}``.


"""

# ╔═╡ 25b5bcc3-a325-4999-8a5e-89c5103b4649
md"""
### The Binomial Series
**Example**: 
Find the Maclaurin series for ``f(x)=(1+x)^k``, where ``k`` is any real number.

__*Solution: In Class*__

"""

# ╔═╡ 94c3cb66-7cc7-493e-b21b-319d573c74ec
md"""
__*The Binomial Series (Theorem)*__

If ``k`` is any real number and ``|x|<1``, then
```math
(1+x)^k=\sum_{n=0}^{\infty}\begin{pmatrix}
k \\ n
\end{pmatrix}x^n = 1 + k x + \frac{k(k-1)}{2!}x^2 +
\frac{k(k-1)(k-2)}{3!}x^3 +\cdots

```
where 
```math
\left(\begin{array}{c} k \\ n\end{array}\right) = \frac{k(k-1)(k-2)\cdots (k-n+1)}{n!}
```
__*Remarks*__

* This is called __binomial coefficients__. Note that 
```math
\left(\begin{array}{c} k \\ n\end{array}\right) =0 \qquad \text{if} \quad k \text{ is integer and } k<n
```

```math
\left(\begin{array}{c} k \\ 0\end{array}\right) =1, \quad  \left(\begin{array}{c} k \\ 1\end{array}\right) =k
```
* If ``-1<k\leq 0``, it converges at ``x=1``.
* If ``k\geq 0`` it converges at ``x=\pm 1``.

"""

# ╔═╡ 7785276c-89f5-42f0-8598-61043f9fe035
md"""
#### Example
Find the Maclaurin series for the function 
```math
f(x)=\frac{1}{\sqrt{4-x}}
```
and its radius of convergence.

"""

# ╔═╡ 1797a33c-54c8-4471-b632-4f3b311502d2
md"""
## Deriving Taylor Series from a Basic List
__Check the table__
#### Examples
- Find the Maclaurin series for
```math
\begin{array}{lll}
{\small \text{(a)}} & f(x)=x\cos x \\
{\small \text{(b)}} & f(x)=\ln (1+3x^2)\\
\end{array}
```

- Find the function represented by the power series 
```math
\sum_{n=0}^{\infty}(-1)^n\frac{2^nx^n}{n!}
```

- Find the sum of the series 
```math
\frac{1}{1\cdot 2}-\frac{1}{2\cdot 2^2}+\frac{1}{3\cdot 2^3}-
\frac{1}{4\cdot 2^4}+ \cdots
```

"""

# ╔═╡ a34a788e-5824-4a58-b3fb-2e650ca96b8a
md"""
#### More Examples
- Evaluate
```math
\int e^{-x^2} dx
```
- Evaluate 
```math
\lim_{x\to 0}\frac{e^x-1-x}{x^2}
```
- Find the first 3 nonzero terms of Maclaurin series for 
```math
(a) \quad e^x\sin x \qquad (b)\quad \tan x 
```
- Find the sum of
```math
(a) \quad \sum_{n=0}^\infty \frac{x^{4n}}{n!}\qquad (b)\quad \sum_{n=0}^\infty (-1)^n\frac{\pi^{2n+1}}{4^{2n+1}(2n+1)!}
```
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19"
ImageShow = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
ImageTransformations = "02fcd773-0e25-5acc-982a-7f6622650795"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
PlotThemes = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[compat]
Colors = "~0.12.10"
CommonMark = "~0.8.12"
FileIO = "~1.16.1"
HypertextLiteral = "~0.9.4"
ImageIO = "~0.6.7"
ImageShow = "~0.3.8"
ImageTransformations = "~0.10.0"
LaTeXStrings = "~1.3.0"
PlotThemes = "~3.1.0"
Plots = "~1.38.17"
PlutoUI = "~0.7.52"
SymPy = "~1.1.12"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.2"
manifest_format = "2.0"
project_hash = "0dfc044350e3544ed06633bd47b08a9a26f92a3d"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "91bd53c39b9cbfb5ef4b015e8b582d344532bd0a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.0"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "76289dc51920fdc6e0013c872ba9551d54961c24"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.6.2"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

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

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "16351be62963a67ac4083f748fdb3cca58bfd52f"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

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

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e30f2f4e20f7f186dc36529910beaedc60cfa644"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.16.0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "02aa26a4cf76381be7f66e020a3eddeb27b0a092"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "d9a8f86737b665e15a9641ecbac64deef9ce6724"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.23.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.CommonEq]]
git-tree-sha1 = "d1beba82ceee6dc0fce8cb6b80bf600bbde66381"
uuid = "3709ef60-1bee-4518-9f2f-acd86f176c50"
version = "0.2.0"

[[deps.CommonMark]]
deps = ["Crayons", "JSON", "PrecompileTools", "URIs"]
git-tree-sha1 = "532c4185d3c9037c0237546d817858b23cf9e071"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.12"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "e460f044ca8b99be31d35fe54fc33a5c33dd8ed7"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.9.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "5372dbbf8f0bdb8c700db5367132925c0771ef7e"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.1"

[[deps.Conda]]
deps = ["Downloads", "JSON", "VersionParsing"]
git-tree-sha1 = "8c86e48c0db1564a1d49548d3515ced5d604c408"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.9.1"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "f9d7112bfff8a19a3a4ea4e03a8e6a91fe8456bf"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3dbd312d370723b6bb43ba9d02fc36abade4518d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.15"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "e90caa41f5a86296e014e148ee061bd6c3edec96"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.9"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

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
git-tree-sha1 = "299dc33549f68299137e51e6d49a13b5b1da9673"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.1"

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
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

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
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "d73afa4a2bb9de56077242d98cf763074ab9a970"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.9"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1596bab77f4f073a14c62424283e7ebff3072eca"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.9+1"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

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
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "cb56ccdd481c0dd7f975ad2b3b62d9eda088f7e2"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.14"

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
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "2e4520d67b0cef90865b3ef727594d2a58e0e1f8"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.11"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "fc5d1d3443a124fde6e92d0260cd9e064eba69f8"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.1"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "bca20b2f5d00c4fbc192c3212da8fa79f4688009"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.7"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "355e2b974f2e3212a75dfb60519de21361ad3cb7"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.9"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "3b5344bcdbdc11ad58f3b1956709b5b9345355de"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.8"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "7ec124670cbce8f9f0267ba703396960337e54b5"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.10.0"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3d09a9f60edf77f8a4d99f9e015e8fbf9989605d"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.7+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "5cd07aab533df5170988219191dfad0519391428"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "721ec2cf720536ad005cb38f50dbba7b02419a15"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.7"

[[deps.IntervalSets]]
deps = ["Dates", "Random"]
git-tree-sha1 = "8e59ea773deee525c99a8018409f64f19fb719e6"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.7"
weakdeps = ["Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsStatisticsExt = "Statistics"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "4ced6667f9974fc5c5943fa5e2ef1ca43ea9e450"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.8.0"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "327713faef2a3e5c80f96bf38d1fa26f7a6ae29e"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.3"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

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

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f689897ccbe049adb19a065c495e75f372ecd42b"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.4+0"

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
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "f428ae552340899a935973270b8d98e5a31c49fe"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.1"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

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
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

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
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "a03c77519ab45eb9a34d3cfe2ca223d79c064323"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.1"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9ee1618cbf5240e6d4e0371d6f24065083f60c48"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.11"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "2ac17d29c523ce1cd38e27785a7d23024853a4bb"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.10"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "a4ca623df1ae99d09bc9868b008262d0c0ac1e4f"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "bbb5c2115d63c2f1451cb70e5ef75e8fe4707019"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.22+0"

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
git-tree-sha1 = "2e73fe17cac3c62ad1aebe70d44c963c3cfdc3e3"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.2"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+0"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "9b02b27ac477cad98114584ff964e3052f656a0f"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.0"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "716e24b21538abc91f6205fd1d8363f39b442851"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.2"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f6cf8e7944e50901594838951729a1861e668cb8"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.2"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "f92e1315dadf8c46561fb9396e525f7200cdc227"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.5"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "9f8675a55b37a70aa23177ec110f6e3f4dd68466"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.17"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "e47cd150dbe0443c3a3651bc5b9cbd5576ab75b7"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.52"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "ae36206463b2395804f2787ffe172f44452b538d"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.8.0"

[[deps.PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "43d304ac6f0354755f1d60730ece8c499980f7ba"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.96.1"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "364898e8f13f7eaaceec55fd3d08680498c0aa6e"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.4.2+3"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "da095158bdc8eaccb7890f9884048555ab771019"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.4"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "54ccb4dbab4b1f69beb255a2c0ca5f65a9c82f08"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.5.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

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

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "c60ec5c62180f27efea3ba2908480f8055e17cee"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "e2cfc4012a19088254b3950b85c3c1d8882d864d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.3.1"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore"]
git-tree-sha1 = "9cabadf6e7cd2349b6cf49f1915ad2028d65e881"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.6.2"
weakdeps = ["Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "75ebe04c5bed70b91614d684259b661c9e6274a4"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.SymPy]]
deps = ["CommonEq", "CommonSolve", "Latexify", "LinearAlgebra", "Markdown", "PyCall", "RecipesBase", "SpecialFunctions"]
git-tree-sha1 = "ed1605d9415cccb50e614b8fe0035753877b5303"
uuid = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
version = "1.1.12"

    [deps.SymPy.extensions]
    SymPySymbolicUtilsExt = "SymbolicUtils"

    [deps.SymPy.weakdeps]
    SymbolicUtils = "d1185830-fcd6-423d-90d6-eec64667417b"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

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
git-tree-sha1 = "8621f5c499a8aa4aa970b1ae381aae0ef1576966"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.4"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "b7a5e99f24892b6824a954199a45e9ffcc1c70f0"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.0"

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

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "a72d22c7e13fe2de562feda8645aa134712a87ee"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.17.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.VersionParsing]]
git-tree-sha1 = "58d6e80b4ee071f5efd07fda82cb9fbe17200868"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.3.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

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
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cf2c7de82431ca6f39250d2fc4aacd0daa1675c0"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.4+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

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
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

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
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"

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
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

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
# ╠═5d4e233e-97f6-4953-982b-b0eebce8e08d
# ╟─f607f9dc-0e79-44f4-af59-6f5f1f1336c8
# ╟─9e04d2f4-6136-408b-89b1-bcbbaec5a3c0
# ╠═e14c9fd5-9d79-493e-9da2-9448ee884667
# ╟─5cdf321b-e477-4218-90ea-c618c8a3ab48
# ╟─a034af46-0c78-436a-b368-c977643fa1ff
# ╟─75777562-49ab-47a3-bb8e-b70150f85023
# ╟─11de9bf9-63cb-43a7-afcf-e520d22fbc9f
# ╟─ab806966-58c1-45c8-a288-421f5dd99e61
# ╟─73a7a8e2-67f6-4c49-9775-c67f6c86dbd9
# ╟─d8637bcf-0735-4faf-a708-a259c6f88a82
# ╟─35e9fefc-1e71-4413-862b-28cfb690777d
# ╟─9f24cb36-7067-433c-8cb1-eeed7cd20a91
# ╟─71726e74-dc4f-432b-8860-8da68721a44f
# ╟─1f78f70a-15cd-4ff1-9425-a43636f95c76
# ╟─f63868f3-2b63-4b37-9d3e-a88869df3266
# ╟─f7b3d05b-dc54-4589-99cf-d6cb5bb9988c
# ╟─3f4dd200-084f-4c84-be5d-4181c06ba6fb
# ╟─a6d576ad-6a3a-4be5-aece-ec5d1337b529
# ╟─16065d17-56b1-4ec3-837c-47e11131eefa
# ╟─23671b7f-9a5f-433d-94ba-ea6600cbc122
# ╟─168e721d-8f96-4e30-a793-d4c9e42355af
# ╟─145e1238-7bc4-4e5b-9cb7-a29697e729d8
# ╟─9656e6b2-4cbc-4554-bf7f-3db26663211f
# ╟─23a1010a-9c9c-4112-bf4d-1fa03a8cc011
# ╟─61615d24-734e-4e75-8137-1b9887c4ce15
# ╟─238464cf-619a-4087-8a2f-e053aa1f8bbb
# ╟─6de623d1-8004-4b8f-8604-f871abc366e1
# ╟─cc47cd4c-d43e-4cf2-883c-3809639a66a0
# ╟─af677c0a-98cf-4347-ba90-740ac4619416
# ╟─6f705724-6c27-44d9-a904-ad60b7ad4e78
# ╟─6646afce-19f5-4624-96ab-88f9fa9aa782
# ╟─7144c868-8876-46f9-b99f-89ab087389f7
# ╟─7c3d2ab5-2720-447d-a9e4-485017580024
# ╟─7c639bc1-a420-4ce7-99d7-3f0dfd8e964c
# ╟─c61d2b1b-9492-4b7b-84eb-0bd92931eaac
# ╟─bd61e100-44fb-4c0b-bb37-36710a65a52a
# ╟─a1857e56-2442-48d2-a2be-65d44f042483
# ╟─4c0d1b28-2091-40f4-aa2d-65eea2b3dffa
# ╟─fb700f45-2789-4085-a080-6d1e3d3ec3d1
# ╟─1058bdbb-969f-405a-9578-c467286cae33
# ╟─b8a5ff39-9800-4556-8715-2a556a5c628f
# ╟─5e181bc0-db9a-4ac5-853c-72cd1ed597b7
# ╟─d83e79d3-86fa-41e3-b453-c59bedb94520
# ╠═4e76fbcc-27e8-46d8-9bd0-a339c5ac7508
# ╟─dbfc14da-c752-46e7-ad24-938d5ea06d61
# ╟─a448117a-921f-42b7-9a25-eedb13db685c
# ╟─06b9474d-da67-491d-8ea0-1af4c237a349
# ╟─021c3697-be87-4011-9fde-a09b569a09d3
# ╟─fb811f14-8f2c-481d-927a-8670aba7112c
# ╟─2a88724c-0f4c-48a2-83a1-e51a2c10a0c7
# ╟─2fc3d33f-bb28-4e4c-a372-21d9006ad4df
# ╟─eb8cb9bd-04d4-416c-aa11-24a3238d6185
# ╟─8868e231-cf0b-4de3-b7d3-350ec62be835
# ╟─059f7df0-3c91-408c-91aa-fa513864e817
# ╟─b4adbb37-dbc9-4d43-b5c1-7550b8f8dfd3
# ╟─f2f54f8e-125b-4e0c-bb67-444b001400d0
# ╟─58c794e3-b35a-4e81-a136-2865e9bc53b4
# ╟─2ec7cbb4-58c6-439b-9989-d45890d5bde0
# ╟─9b865f48-d71a-4d69-9ce5-e941a8d26df9
# ╟─3464f171-a986-4e68-b0fc-63bb37d3186a
# ╟─3afeb15b-1f61-483a-b9e7-513e31b8b2d0
# ╟─7935b0f9-ab43-4d64-bb60-262cf8af71bd
# ╟─cab15078-1283-4a7f-8447-1996dedf988c
# ╟─121748ad-633e-4057-aed1-fe55a3aaab06
# ╟─496deea6-4854-4e25-8803-c291765892e5
# ╟─12b91dea-100a-4932-8607-e8e65fff62a6
# ╟─3e81f117-a31f-41f3-9cb8-7e7f5371bf9d
# ╟─7bee0ddc-a560-4404-95c4-6afff2ee2cde
# ╟─1ba2cd48-1f1e-46b9-9bc0-ec90a4bb3161
# ╟─f5d277d1-66ea-41b4-80a8-396b8f3dd476
# ╟─8c9895fb-a48b-4466-8abf-8ad0d353ac23
# ╟─90a7cfa3-0c17-49e3-a0f7-5de745888863
# ╟─1b43f966-72bd-4706-8e2a-7acf993bd5d9
# ╟─a81742ca-d194-4b63-87a2-136580b6c67f
# ╟─5a7927a7-65d3-445b-a0a6-fa9901414b54
# ╟─09f2eebb-bd91-44ad-9a04-5441dc24a3d9
# ╟─2f9c1c00-c765-4d95-9c52-d9b397498f80
# ╟─6a763c24-f0cd-4442-9e7a-bf6a024b9a38
# ╟─6319d77c-c025-4caa-aea2-d34d3fa6fe9a
# ╟─f9d65649-3d39-42c0-9ad7-8dbf8601ea1a
# ╟─256aa7fa-07a0-4a5c-8e0d-899f7358d63b
# ╟─c0309f25-d405-439d-b6ab-964bd3852f52
# ╟─89f6aa3f-c4e0-4c40-ac65-9522bc8c4b77
# ╟─ebe40dc4-5052-4abc-baf3-720cec4da2b3
# ╟─b6525a2a-ba92-426d-8145-ec1637b94bbe
# ╟─d135dec8-4f04-4636-8959-826b80da3054
# ╟─79009edb-ce5c-4559-af1d-5f3e868b55ad
# ╟─69015687-860b-45fc-a09b-683c0a71dcbc
# ╟─272b1195-9e7a-43c3-81ea-dbf493a1120c
# ╟─7f24e7d9-b4a3-47d7-be46-0cb0489b6126
# ╟─b4d3f89a-62a4-454a-b15e-c6e9c2cc5b41
# ╟─41e00300-a42e-4370-a771-dabd789929b7
# ╟─8692fe90-8a37-411d-81c7-7a5217190ab1
# ╟─e73977c4-d5a9-46ae-bc71-8b4b2e6b37ba
# ╟─cf9b982a-77e0-4c4d-8543-d216fa7e8470
# ╟─b80374f0-0f17-473e-8aa1-501065ec611f
# ╟─95d66bca-8ba9-4e4d-b86d-302f8a869d50
# ╟─af02099b-229a-446f-bc6d-f83e56429e7c
# ╟─b6562828-b81a-41b2-a1f0-0e679866192c
# ╟─b80a56ee-6679-462c-890e-b70bef86f9de
# ╟─40c1a6a7-65c1-4ef6-bee8-2eb454dcf83a
# ╟─fa2a6253-258e-4b03-a46f-dd19a20f4316
# ╟─33cf7304-6211-4141-a695-a82066e54f6d
# ╟─69917572-68d4-4713-8afb-9664cc794df8
# ╟─e284b9db-b1cc-4334-9e9e-4665131ecad1
# ╟─17c95cdb-09ad-4869-9c26-291f6161e217
# ╟─c716c668-4ccc-4cbe-b6a7-115e30388373
# ╟─6d7d7fcb-22e0-413a-9a00-20fce9058794
# ╟─0fa93397-1617-4757-bcb7-cdb10ba1cd43
# ╟─2e27548d-e260-4aa1-9438-0c1762d745cc
# ╟─1a2563ed-917d-4d30-be2f-b08025d07b64
# ╟─8c94ff72-52d3-4445-a534-fca78768eb49
# ╟─e3aacea8-fa4d-4385-aa46-cd5d8f4c4f1e
# ╟─378343ed-6041-49a2-b92a-c9bd3e5cad9f
# ╟─aa8b23ea-7ee0-44dd-8be5-0ef50b27ad19
# ╟─d396aa7f-f00c-4162-b97b-30029a07a844
# ╟─c6a90a6d-d2e3-4140-ba8c-b416e21576b8
# ╟─2c1066df-5a47-4dab-bfc6-aad429a8b29c
# ╟─1999bcc0-86dc-4b2c-9443-b8dc993f3e53
# ╟─9c1d6d7a-710c-4ed3-be52-854c5ef4f1d2
# ╟─790bc605-988a-4925-af1c-57a50f7369a4
# ╟─cecf42f2-549f-45d7-8152-a07e0b8f26b7
# ╟─7375a71f-c0e1-483b-a6df-a6b69843ae3f
# ╟─b953048b-5d03-4f15-88c4-b4dbc7282c5f
# ╟─5e99e72d-4a7f-4cd0-8edc-2579bc8218d3
# ╟─da267376-b6d5-449c-9e4c-b9a5076f286d
# ╟─4a853ebd-5932-4833-ab25-c2ff72ac6b6b
# ╟─6d692b82-c1a3-4b1f-b499-f2025a368871
# ╟─ecb4d1c0-eaae-422b-b594-67019ad34f7f
# ╟─dc1c0ed3-92a5-40fd-b871-d613a308557e
# ╟─553c76a4-3155-474a-a665-1a17ef3c76a9
# ╟─dff3a46f-1381-4aee-be0f-255c5d68b69f
# ╟─93d08547-3e82-48ab-a00c-c06bcd82d1e5
# ╟─f74eea56-a8b6-45e2-9ade-39e36e9be00c
# ╟─5ffe3671-dbed-4685-b4d2-d112015141af
# ╟─cc45268c-aecc-4f3d-ba15-07557d216ada
# ╟─ddd59a41-8932-4105-9734-e2e333f3544d
# ╟─9b72a023-f462-408e-8c1c-8d29197910e7
# ╟─bcc1522a-131a-435f-bdd3-2d5ea0ec67cf
# ╟─be2a345f-576f-41c1-8048-38959cb054d2
# ╟─0d75292d-4ecc-4c02-9566-aac213b56def
# ╟─49b1d6cf-9f6a-4035-83b2-9cf149608107
# ╟─758f54b6-9643-4d66-a22e-d3fc432bb3b7
# ╟─76810624-6ffc-457e-8562-05491e2528aa
# ╟─8abaf091-1709-40af-ab35-454429c7befd
# ╟─9a266cbc-a292-4f68-8afa-00479060489d
# ╟─d1fcddac-b706-4271-9f0f-6fc816876ac9
# ╟─72664d64-11bc-4184-b149-fe897fa628b2
# ╟─b4c7bc3c-be86-494a-92b7-da2fe1dbb03b
# ╟─7381759c-5ad1-4948-84dc-1311b5345b55
# ╟─e039ddb5-000f-4289-9a0c-9fc02b401dbf
# ╟─9d865d41-d46a-4c23-b760-7ceee6b62936
# ╟─c040cf3d-5bce-4b59-9274-04e745f43c61
# ╟─fda5809c-cd1e-4be1-8091-c927efa44bed
# ╟─94380cb1-ec66-4a52-93e0-2911e2e75b9f
# ╟─8cc6f38f-c6c9-4ad2-adb6-ba252a98e06c
# ╟─b7f80565-cf9b-4c4d-ab06-aade08bfc0f9
# ╟─a095f3d2-d61d-4ec5-a3fc-4ac7d3893ec1
# ╟─926201c3-50c7-40a8-bd21-d9b1684046b7
# ╟─41284787-6dca-4e73-88c5-2699300d0951
# ╟─9bb81d90-4ec1-4669-aaf8-571428fd1c43
# ╟─953e09f8-b986-4a82-86c8-533438cb88ad
# ╟─146fb901-25d6-4dfb-b272-5562e83eaba8
# ╟─312afe0f-55bf-472b-be7e-84079c32c47d
# ╟─990bc451-2065-4e14-88bb-886eadd8535a
# ╟─89eb38dc-7226-478f-9196-ddc278a3d135
# ╟─61af1772-e210-4523-9587-5105bb859020
# ╟─b006a96a-6ebc-4e44-a2da-f202fd150005
# ╟─f36c8419-9fc0-40b3-8c35-302694ae02c7
# ╟─53f18531-404b-4b46-a452-1429d145544e
# ╟─c226414b-a365-448d-b063-b51107dc9af8
# ╟─fe887af5-a9a4-462f-8fa9-30baae002131
# ╟─967b72bb-d439-46c3-b449-4fe9c8fa5490
# ╟─efd4f9db-2c4c-48d5-9473-34099c71e4ee
# ╟─a9d506a8-dc18-4ffd-a0e7-94ee912d2a90
# ╟─0a3e8db6-aa43-44b0-a462-850fc28e6da2
# ╟─2e8b9671-6e4a-4b97-9b3d-04dc9ca1437c
# ╟─49efb8aa-772b-4e82-ae95-c40003183c5b
# ╟─e9055611-c65d-4bcb-bc4c-9994d7b6df7f
# ╟─1e60f9fc-b2d3-4219-8f93-72d546d9d5c8
# ╟─8fa2360c-7a35-4d4f-8b42-873d9ce4491c
# ╟─9fa571ac-b9dd-47fb-82a4-f1133b365b9d
# ╟─680376c6-46e5-4469-8099-2052c8bbb557
# ╟─3331a35d-d79e-4392-8121-76c851cfc244
# ╟─63e253cd-f11b-4f65-beb6-5a7887ddd3da
# ╟─7dfaa48a-8d2a-4728-b341-693327fe6232
# ╟─0bbe4f11-24b7-4e62-9855-f4db3dcd281a
# ╟─a0f07b8a-bb65-461a-b72d-3a7b133319ea
# ╟─9a46095b-a7e0-4fb4-9c18-1d13caa55c2a
# ╟─e05f081c-642b-4815-a64b-f3a3cd6a7609
# ╟─66b5302a-2646-495f-a408-8963b7530949
# ╟─d7bfd01a-e1c6-4abb-a58f-bd35bacc0a2d
# ╟─6bf6d15e-7bf1-4770-99c0-4ca44f79143e
# ╟─c399893d-e2d7-4115-a51d-1c1b3289be53
# ╟─10d7aa3b-e125-45ef-bf2f-5c16513f3eab
# ╟─cefb7ca5-1f35-476c-8740-9099bdc684d6
# ╟─de0066c2-bf7d-4403-a77e-894bf0feed2b
# ╟─cfafdd24-2f3e-4497-ace7-f65ce7093b24
# ╟─3989fe41-0f2f-4984-9fc4-0e18bfe02238
# ╟─bba7a77e-acfa-4bf5-9aa1-0caffa595d52
# ╟─64b6ca9c-6857-4080-998e-4b36a21c69c9
# ╟─744e2a96-aa6c-4ebb-aaca-861828dc0f0d
# ╟─d251cca5-d846-4bc4-b43d-2114f88800b2
# ╟─8a4db3f3-adc4-422e-afe2-ce74f455cb34
# ╟─ebc708b9-ad01-4473-b97f-4698a86cbdc4
# ╟─37f454b7-4e75-4295-95c6-0e79db7874a8
# ╟─e94c302e-40e3-4191-a3c4-80d941f6ec01
# ╟─4873c192-525b-43a2-ab48-ade173ed4a63
# ╟─b98685af-c363-4dc0-b2da-a3f9c6edd8bb
# ╟─9ea80853-2666-4bd6-8b8b-74512955cbf1
# ╟─1af379da-ab4a-4a25-84ff-fc02f2a12eeb
# ╟─333bae8c-c2e5-4460-b75e-6befc39c4295
# ╟─3c259ccc-ff27-4cfd-9ca1-49eb0fcf37fc
# ╟─0bc2f276-a8ac-49dc-874a-17c51ae34209
# ╟─1dca9c92-d15b-4079-bc5c-678e1498a0ae
# ╟─0308be88-8c68-4ea6-861d-f6a216299aa5
# ╟─f5d01c74-be75-43ab-bbb5-b4984854a324
# ╟─f4628bf9-d130-4882-a634-443ed1c5f4ef
# ╟─57c1a8b8-b489-4121-905c-a6cdafe42d4f
# ╟─7cd0ace0-8af3-4932-ad3b-7406c6200f04
# ╟─de0c96d2-af55-4858-9287-f497963b22ef
# ╟─f5220cd2-d75e-44f2-b80f-ee9577735b1e
# ╠═53d12832-df52-488f-a9f0-4b5809c626fd
# ╟─e8e33cc8-09ab-4ebe-b507-ffabb215d4bd
# ╟─918ebe8d-2872-4baa-ba4b-0970fdd02457
# ╟─079a24f1-52a7-4f2b-af4e-5853eb2f67a1
# ╟─f15e4057-a44c-4220-a164-6ce19b34d411
# ╟─dd22655b-c111-4b7f-95f2-eb32c60908fc
# ╟─2845f715-b032-493f-a979-782fb70b700e
# ╟─d0af669e-bce0-4aa8-a897-9f887bd27d1c
# ╟─704cc640-acc1-4c21-9673-3092a45d1377
# ╟─ccef397a-98e7-4d27-82e2-228e5154d63a
# ╟─959825de-2ae7-4212-893d-f8a66f91b39c
# ╟─cc66678d-7ddc-47db-86e0-5ee50bb58af6
# ╟─5abe72af-e1d9-4002-84ef-954329dc23c6
# ╟─efadc950-2f26-4e5e-bc8b-36862bd8cca8
# ╟─35e833fa-4ec5-4c95-9e50-1fc99ea1e09f
# ╟─f154ffb1-c488-4fca-9631-b5e56f286f3a
# ╟─9a6aad50-069e-4264-90d0-2fa508769e70
# ╟─df5b6e45-37cb-4a2d-9427-946a57794960
# ╟─c9c85ae9-2b27-4f54-a470-49a8bf28a82d
# ╟─81881f3c-c074-44c9-8246-d5825dee9069
# ╠═2a079f3f-d9e2-424c-b88a-408d352be5c6
# ╟─8141bdca-0127-4d3a-b277-2da3779aead5
# ╟─b317f1f5-0b07-4257-82d1-fa9cb313b901
# ╟─af7bdbca-ab63-4823-a2f3-efe1af56b7f4
# ╟─3f16a586-692d-495b-9cc7-63c5cc635ebd
# ╟─7392677a-a151-484d-ba48-6ac841c9a98a
# ╟─588305e1-3818-4007-b1c0-267e96a7fe7a
# ╟─828f4175-0f55-45af-85d2-6c396325462e
# ╟─eda03c6d-6d83-4bc0-964d-8091ffc8f777
# ╟─a276e779-9072-4634-bb7a-f7190b275c95
# ╟─312270b2-40e1-44b9-a87c-a0602f3c6633
# ╟─cc8e6d6c-d756-4401-abf3-e268763b8bea
# ╟─7ab9ae32-2ea1-451c-8fe9-77f6fe628f8d
# ╟─54bf8db4-d8a6-40ba-ba9d-c14dad31e70a
# ╟─b08d4a39-32ec-4323-b3d6-4aed3a08e7d6
# ╟─d5e4d679-8871-496d-88d8-a7ac7891058e
# ╟─9fe9a0ee-ba90-44fa-ba59-cb8c145f0f26
# ╟─07333593-857d-4f0b-a245-253d50505a46
# ╟─a20dcc68-ebc7-4e3c-8bec-aaa01b84ae89
# ╟─333af7ee-6593-4edf-bd00-aade7de8f743
# ╟─cfdba930-c066-401d-99e5-b90b0e667469
# ╟─77657ac7-e6a5-409c-9166-03a85c2c5041
# ╟─3b6124f6-fbf5-4b17-9329-be9f9bb75d43
# ╟─25b5bcc3-a325-4999-8a5e-89c5103b4649
# ╟─94c3cb66-7cc7-493e-b21b-319d573c74ec
# ╟─7785276c-89f5-42f0-8598-61043f9fe035
# ╟─1797a33c-54c8-4471-b632-4f3b311502d2
# ╟─a34a788e-5824-4a58-b3fb-2e650ca96b8a
# ╠═196f8120-431b-11ee-0ec5-2b6391383266
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
