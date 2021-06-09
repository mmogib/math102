### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ e93c5882-1ef8-43f6-b1ee-ee23c813c91b
begin
	import Pkg
	Pkg.activate(mktempdir())
	Pkg.add([
		Pkg.PackageSpec(name="ImageIO", version="0.5"),
		Pkg.PackageSpec(name="ImageShow", version="0.3"),
		Pkg.PackageSpec(name="FileIO", version="1.9"),
		Pkg.PackageSpec(name="CommonMark", version="0.8"),
		Pkg.PackageSpec(name="Plots", version="1.16"),
		Pkg.PackageSpec(name="PlotThemes", version="2.0"),
		Pkg.PackageSpec(name="LaTeXStrings", version="1.2"),
		Pkg.PackageSpec(name="PlutoUI", version="0.7"),
		Pkg.PackageSpec(name="Pluto", version="0.14"),
		Pkg.PackageSpec(name="SymPy", version="1.0"),
		Pkg.PackageSpec(name="ImageTransformations", version="0.8")
	])

	using CommonMark, ImageIO, FileIO, ImageShow
	using PlutoUI
	using Plots, PlotThemes, LaTeXStrings, Random
	using SymPy
	using ImageTransformations
end

# ╔═╡ ad045108-9dca-4a61-ac88-80a3417c95f2
TableOfContents()

# ╔═╡ 1e9f4829-1f50-47ae-8745-0daa90e7aa42
md""" # Chapter 5 

## Section 5.1

"""

# ╔═╡ b048a772-05c3-4cd0-97ae-5cf825127584
md""" 
### The Area Problem 





"""

# ╔═╡ 41603f71-3724-4fcc-8421-1a64f34ff80f
md""" 
*Find the area of the regoin $S$*.

$(load("./imgs/5.1/ex1-0.png"))
"""

# ╔═╡ 8ad65bee-9135-11eb-166a-837031c4bc45
f(x)=sin(x)

# ╔═╡ e7a87684-49b0-428c-9fef-248cf868cf33
begin 
	ns = @bind n  Slider(2:2000,show_value=true, default=4)
	as = @bind a  NumberField(0:1)
	bs = @bind b  NumberField(a+1:10)
	lrs = @bind lr Select(["l"=>"Left","r"=>"Right","m"=>"Midpoint"])
	md"""
	n = $ns  a = $as  b = $bs method = $lrs
	
	
	"""
end

# ╔═╡ 2da325ba-48cc-44b3-be34-e0cb46e33068
@bind showConnc Radio(["show" => "✅", "hide" => "❌"], default="hide")

# ╔═╡ 8436d1b3-c03e-42e6-bbff-e785738e0f89
(showConnc=="show") ? md"""
$$A=\lim_{n\to \infty} R_n =\lim_{n\to \infty} L_n =\frac{1}{3}$$
""" : ""

# ╔═╡ 1081bd99-7658-4c32-812c-14235bd82596
begin
	im1 = load("./imgs/5.1/general.png")
	im2 = load("./imgs/5.1/definition2.png")
	im3 = load("./imgs/5.1/sample_points.png")
	md"""
	**In General**
	
	$im1
	
	$im2
		
	$im3	
	"""
end

# ╔═╡ 55084c2d-6f81-4e55-946c-703245a6bb86
md"""
**Remark**

In general, we form lower (and upper) sums by choosing the sample points $x^*_i$ so that $f(x^*_i)$ is the minimum (and maximum) value of $f$ on the $i$ th subinterval. 

$(load("./imgs/5.1/upper_lower.png"))
"""

# ╔═╡ ba3e664e-8952-4159-bfb7-b24d9e9fb1d2
md"""
### Distance Problem

Find the distance traveled by an object during a certain time period if the velocity of the object is known at all times. (In a sense this is the inverse problem of the velocity problem that we discussed in Section 2.1.) If the velocity
remains constant, then the distance problem is easy to solve by means of the formula
$$distance = velocity \times	 time$$

**Example**

$(load("./imgs/5.1/distance.png"))

"""

# ╔═╡ 8e5fcb62-afeb-410d-8cc2-e0b27e052a25
begin
	t = 0:5:30
	v = [25, 31, 35, 43, 47, 45, 41]
	l =t[1:end-1].*v[1:end-1]
	r =t[2:end].*v[2:end]
	ln, rn = l |> sum, r|>sum
	ld = reduce((x1,x2)->"$x1 + $x2",l[2:end];init="$(l[1])") *"=$ln"
	rd = reduce((x1,x2)->"$x1 + $x2",r[2:end];init="$(r[1])") *"=$rn"
	md"""
	'
	$$L_n$$ =
	$ld
	
	'
	$$R_n$$ =
	$rd
	
	"""
end

# ╔═╡ 30b561dd-6e6b-4719-abc0-9938099d5487
md""" ## Section 5.2 (The Definite Intergal)

"""

# ╔═╡ d854d0ea-c5dd-4efa-9f46-83807339e163
g(x)=-(x-2)^3+1

# ╔═╡ bceda6d4-b93f-4282-8f03-fc44132ea1bb
begin 
	ns2 = @bind n2  Slider(2:2000,show_value=true, default=4)
	as2 = @bind a2  NumberField(0:1)
	bs2 = @bind b2  NumberField(a+2*pi:10)
	lrs2 = @bind lr2 Select(["l"=>"Left","r"=>"Right","m"=>"Midpoint", "rnd"=>"Random"])
	md"""
	n = $ns2  a = $as2  b = $bs2 method = $lrs2
	
	
	"""
end

# ╔═╡ 94b4f73a-ee55-405a-be50-bb92048f4eb2
md"""
### Definition

```math 
\int_a^b f(x) dx = \lim_{n\to \infty} \sum_{i=1}^n f(x_i^*)\Delta x 
```
is the **definite integral of ``f`` from ``a`` to ``b``** provided that this limit exists and gives the same value for all possible choices of *sample points*. 

* If it does exist, we say that ``f`` is **integrable** on ``[a,b]``.
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

$(load("./imgs/5.2/note3.png"))
"""

# ╔═╡ 2bef2339-7afe-427d-bdc5-19b9e9b43878
begin 
	s52q1Check = @bind s52q1chk Radio(["show"=>"show","hide"=>"hide"],default="hide")
	
md""" 
**Question 1:** 

$(load("./imgs/5.2/q1.png"))

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

$(load("./imgs/5.2/q1.png"))

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


# ╔═╡ 039cf09b-67c1-46d0-aecc-97e5633d5e89
md"""
### Evaluating Definite Integrals

1. Using the definition
2. Using a Computer Algebra System
3. Interpreting as areas
4. Approximating
5. Using integration techniques (tricks)

"""

# ╔═╡ 843fec4c-3a4a-4cb2-881c-9a4e3df6a5bb
begin 
	hline = html"<hr>"
md"""
#### 1. Using the definition

For this, we need the following formula 

```math
\displaystyle
\begin{array}{ll}
(1) & \sum_{i=1}^n 1 = n \\
\\
(2) & \sum_{i=1}^n i = \frac{n(n+1)}{2} \\
\\
(3) & \sum_{i=1}^n i^2 =  \frac{n(n+1)(2n+1)}{6} \\
\\
(4) & \sum_{i=1}^n i^3 = \left[\frac{n(n+1)}{2}\right]^2 \\
\\
\end{array} 
```

and the following properties


```math
\displaystyle
\begin{array}{lcl}
 \sum_{i=1}^n c a_i &=& c\sum_{i=1}^n  a_i \\
\\
 \sum_{i=1}^n (a_i+b_i) &=& \sum_{i=1}^n  a_i+\sum_{i=1}^n  b_i \\
\\
\sum_{i=1}^n (a_i-b_i) &=& \sum_{i=1}^n  a_i-\sum_{i=1}^n  b_i \\
\\
\end{array} 
```

**Example**

Evalute 
```math
\int_0^1 x^2 dx
```
	
$hline

"""
end

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

# ╔═╡ 19b11522-d11c-4fe1-8f74-5dc975d82bc0
md"""
#### 3. Interpreting as areas
**Example:**
Evaluate the following integrals by interpreting each in terms of areas

(i) $\int_0^3  \sqrt{9-x^2} dx$  

(ii) $\int_{-2}^1|x|dx$
"""

# ╔═╡ 44c9faca-efb6-493c-b751-9fd69e89ecb4
begin
	f1(x)=sqrt(9-x^2)
	f3(x)=abs(x)
	theme(:wong)
 	plot(f3,xlims=[-4,4],ylims=[-4,4], framestyle=:origin, xtick=-4:1:4,yticks=-4:1:4)
	md""
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

# ╔═╡ 4f7c92e6-ac18-45b9-a5ed-1dd6ca6703e0
md""" ### Properties of the Definite Integral
```math
\int_b^a f(x) dx = -\int_a^b f(x) dx
```

```math
\int_a^a f(x) dx = 0
```
$hline

```math
\begin{array}{ll}
\text{(1)} & \int_a^b c dx = c(b-a)\quad \text{where } c \text{ is any constant}. \\ \\
\text{(2)} & \int_a^b \left[f(x)+g(x)\right] dx = \int_a^b f(x) dx +\int_a^b g(x) dx \\ \\
\text{(3)} & \int_a^b cf(x) dx =  c\int_a^b f(x) dx \\ \\
\text{(4)} & \int_a^b \left[f(x)-g(x)\right] dx = \int_a^b f(x) dx -\int_a^b g(x) dx \\ \\
\text{(4)} & \int_a^c f(x) dx+\int_c^b f(x) dx = \int_a^b f(x) dx \\ \\

\end{array}
```

**Comparison Properties of the Integral**
```math
\begin{array}{ll}
\text{(6)} & \text{If } f(x)\geq 0 \text{ for } a\leq x\leq b, \text{ then } \int_a^bf(x)dx\ge 0. \\ \\
\text{(7)} & \text{If } f(x)\geq g(x) \text{ for } a\leq x\leq b, \text{ then } \int_a^bf(x)dx\ge \int_a^bg(x)dx. \\ \\
\text{(8)} & \text{If } m \leq f(x)\leq M \text{ for } a\leq x\leq b, \text{ then } \\ \\

& \qquad \qquad m(b-a)\leq \int_a^bf(x)dx \leq M(b-a) \\ \\

\end{array}
```


"""

# ╔═╡ be9f84d5-3c65-4ceb-8767-3fdc41429e12
md""" **Example**

Estimate 
```math 
\int_0^1 e^{-x^2} dx
```

"""

# ╔═╡ cf3bce53-0260-403c-8910-b04b05b558fe
begin
	# exact = integrate(exp(-xx^2),(xx,0,1)).n()
end

# ╔═╡ e3d540a3-7da5-4ef6-aa31-e629e752484e
md"""
**Exercises:**

1. Evaluate 
$\lim_{n\to \infty}\sum_{i=1}^n\frac{1}{n}\cos\left(1+\frac{i}{n}\right)^2=$
2. If $\int_{-5}^7f(x)dx=-17, \int_{-5}^{11}f(x)dx=32$, and $\int_{8}^7f(x)dx=5$, then $\int_{11}^8f(x)dx=$

"""

# ╔═╡ 13625b14-ac53-4995-bbcb-205cdf672c2a
md"""
### [Problem Set 5.2](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps5.2.pdf)

"""

# ╔═╡ 4b23913f-0cc7-4c16-85a5-bbe37c30f4d8
md""" 
$hline

## Section 5.3 (The Fundamental Theorem of Calculus)

**Discovery:**

If ``f(x)\geq -1``, let

```math
A(x) = \int_{-1}^x (1+t^2) dt
```
``A(x)`` represents the area of a region. 

* _Sketch that region_. 
* Find an expression for ``A(x)``
* Find ``A'(x)``. What do you notice?


"""


# ╔═╡ 3b115e62-8040-4a2c-8d6e-3d03669e7cd8
md"""
Consider the following function 

```math 
g(x) = \int_a^x f(t) dt
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
	# annotate!(p2,[(4,0.51,(L"$\sum_{i=1}^{%$n2} f (x^*_{i})\Delta x=%$s2$",12))])
	
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

# ╔═╡ 02ff212e-937d-4e8e-96d2-5f982618b92d
begin
md"""
### The Fundamental Theorem of Calculus, Part 1 

If ``f`` is continuous on ``[a,b]``, then the function ``g`` defined by
```math
g(x) = \int_a^x f(t) dt, \qquad a\leq x\leq b
```
is continuous on ``[a,b]`` and differentiable on ``(a,b)``, and ``g'(x)=f(x)``.

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

# ╔═╡ ad3dd437-7cfc-4cdc-a951-15949d39cf15
rect(x,Δx,xs,f)=Shape([(x,0),(x+Δx,0),(x+Δx,f(xs)),(x,f(xs))])
#Shape(x .+ [0,Δx,Δx,0], [0,0,f(xs),f(xs)])

# ╔═╡ a9d0c669-f6d7-4e5f-8f57-b6bffe1710ba
function reimannSum(f,n,a,b;method="l",color=:green)
	Δx =(b-a)/n
	x =a:0.1:b
	# plot(f;xlim=(-2π,2π), xticks=(-2π:(π/2):2π,["$c π" for c in -2:0.5:2]))
	
	p=plot(x,f.(x);legend=nothing)
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
	plot!(p,recs,framestyle=:origin,opacity=.4, color=color)
	s = round(sum(f.(partition)*Δx),sigdigits=6)
	return (p,s)
end

# ╔═╡ d34b4862-9135-11eb-120f-6f82295f0759
begin
	theme(:wong)
	
	(p,s)=reimannSum(f,n,a,b;method=lr)
	
	annotate!(p,[(0.3,0.75,(L"$\sum_{i=1}^{%$n} f (x_{i})\Delta x=%$s$",12))])
	
	md""" 	
	
	$p
	"""

end

# ╔═╡ cbf534bd-a329-4bc2-9940-f53a22e6d17e
begin
	theme(:wong)
	
	(p2,s2)=reimannSum(g,n2,a2,b2;method=lr2,color=:blue)
	
	annotate!(p2,[(2,4.51,(L"$\sum_{i=1}^{%$n2} f (x^*_{i})\Delta x=%$s2$",12))])
	
	md""" 	
	
	$p2
	"""

end

# ╔═╡ Cell order:
# ╟─ad045108-9dca-4a61-ac88-80a3417c95f2
# ╟─1e9f4829-1f50-47ae-8745-0daa90e7aa42
# ╟─b048a772-05c3-4cd0-97ae-5cf825127584
# ╟─41603f71-3724-4fcc-8421-1a64f34ff80f
# ╠═8ad65bee-9135-11eb-166a-837031c4bc45
# ╟─e7a87684-49b0-428c-9fef-248cf868cf33
# ╟─d34b4862-9135-11eb-120f-6f82295f0759
# ╟─2da325ba-48cc-44b3-be34-e0cb46e33068
# ╟─8436d1b3-c03e-42e6-bbff-e785738e0f89
# ╟─1081bd99-7658-4c32-812c-14235bd82596
# ╟─55084c2d-6f81-4e55-946c-703245a6bb86
# ╟─ba3e664e-8952-4159-bfb7-b24d9e9fb1d2
# ╟─8e5fcb62-afeb-410d-8cc2-e0b27e052a25
# ╟─30b561dd-6e6b-4719-abc0-9938099d5487
# ╟─d854d0ea-c5dd-4efa-9f46-83807339e163
# ╟─bceda6d4-b93f-4282-8f03-fc44132ea1bb
# ╟─cbf534bd-a329-4bc2-9940-f53a22e6d17e
# ╟─94b4f73a-ee55-405a-be50-bb92048f4eb2
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
# ╟─039cf09b-67c1-46d0-aecc-97e5633d5e89
# ╟─843fec4c-3a4a-4cb2-881c-9a4e3df6a5bb
# ╟─0cfb00ed-60fe-4ebb-b5e2-6182ace7a719
# ╟─19b11522-d11c-4fe1-8f74-5dc975d82bc0
# ╟─44c9faca-efb6-493c-b751-9fd69e89ecb4
# ╟─1ae29d9c-d055-46d8-9a46-0d35a48cc58a
# ╟─4f7c92e6-ac18-45b9-a5ed-1dd6ca6703e0
# ╟─be9f84d5-3c65-4ceb-8767-3fdc41429e12
# ╟─cf3bce53-0260-403c-8910-b04b05b558fe
# ╟─e3d540a3-7da5-4ef6-aa31-e629e752484e
# ╟─13625b14-ac53-4995-bbcb-205cdf672c2a
# ╟─4b23913f-0cc7-4c16-85a5-bbe37c30f4d8
# ╟─3b115e62-8040-4a2c-8d6e-3d03669e7cd8
# ╟─3c16772c-394d-4472-8749-f5990bb69013
# ╟─3644e2e8-9b59-433e-9761-58566f0e1329
# ╟─b9d687cc-9c13-4285-85ac-90ef955f94f3
# ╟─02ff212e-937d-4e8e-96d2-5f982618b92d
# ╟─a9d0c669-f6d7-4e5f-8f57-b6bffe1710ba
# ╟─ad3dd437-7cfc-4cdc-a951-15949d39cf15
# ╠═e93c5882-1ef8-43f6-b1ee-ee23c813c91b
