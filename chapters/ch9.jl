### A Pluto.jl notebook ###
# v0.19.26

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

# ╔═╡ 5bf32a96-dad7-11eb-3d06-adc496c7e800
begin
	using CommonMark, ImageIO, FileIO, ImageShow
	using PlutoUI
	using Plots, PlotThemes, LaTeXStrings, Random
	using SymPy
	using HypertextLiteral
	using ImageTransformations
	using Colors
end

# ╔═╡ d49029eb-fe4a-493e-b2df-a29ddb3740bf
@htl("""
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
blockquote:after {
  color: transparent;
  content: close-quote;
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

.div-50 {
  position: relative;
  height: 50px;
}
.div-100 {
  position: relative;
  height: 100px;
}
.div-200 {
  position: relative;
  height: 200px;
}
.div-300 {
  position: relative;
  height: 300px;
}
.div-400 {
  position: relative;
  height: 400px;
}

.right-formula {
  width: 50%;
  text-align: center;
  position: absolute;
  top: 0;
  right: 0;
  padding: 5px;
  border: 2px solid blue;
}

</style>

""")

# ╔═╡ 738772a6-d798-41d6-aa6d-c599d6d65ef7
TableOfContents(title="MATH102")

# ╔═╡ 6906df3e-afaa-4884-9825-abcf8fef2cbb
cm"""
# Chapter 9:  Infinite Series
#### Sequences, Series, and Power Series

"""

# ╔═╡ 6019adf1-f462-4e30-beca-ed460822279e
md"""
## 9.1: Sequences
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

# ╔═╡ 85a3375a-d660-4af3-a1e0-c7d2d6fbc22a
md"""
__More examples__

- ``\left\{\frac{n}{n+1}\right\}``
- ``\left\{\frac{(-1)^n(n+1)}{5^n}\right\}``
- ``\left\{\sqrt{n-4}\right\}_{n=4}^{\infty}``
- ``a_1=1$, $a_2=1$ , $a_n=a_{n-1}+a_{n-2}``         (__Fibonacci sequence__)
"""

# ╔═╡ b59b486a-f4ba-447a-9e29-5806254832f2
n1Slider = @bind n1slider  Slider(1:1000,show_value=true);md"n = $n1Slider"

# ╔═╡ 608e786a-322f-4fab-9536-c06fa33b5ba6
begin
	
	a1(n) = n/(n+1)
	d1=1:n1slider
	plt1 = scatter(a1.(d1), zeros(10),
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
	annotate!(plt1,[(0.4,0.5,L"a_{%$n1slider}=\frac{%$n1slider}{%$(1+n1slider)}=%$(round(a1(n1slider),digits=6))")])
	if (n1slider>=99)
		
		lens!(plt1,[0.99, 1.001], [-0.1,1.1], inset = (1, bbox(0.6, 0.0, 0.4, 0.5)),
				yaxis=nothing,
				frame_style=:origin, 
				showaxis=:x,
			grid=:none,
			annotations=[(0.998,0.3,"Zoom",7)]
		)
	end
	md"""
	$plt1
	"""
		
end

# ╔═╡ 904be4c9-7e3a-4c07-8b59-c5afbddcaffd
md"""
### Visualization
1. On a number line (as above)
2. By plotting graph

"""

# ╔═╡ 52682ee6-929e-4e49-9ed9-eec5e62eb84e
n2Slider = @bind n2slider  Slider(1:1000,show_value=true);md"n = $n2Slider"

# ╔═╡ 97e90d04-99b3-4c54-8f14-5e09f1c4933f
begin
	d2=1:n2slider
	plt2 = scatter(d2, a1.(d2),
		frame_style=:origin, 
		ylimits=(-0.1,1.6),
		xlimits=(-0.1,200),
		label=L"a_n=\frac{n}{n+1}",
		legend=:topleft,
		title_location=:left,
		title="Example 1 (Graph)"
	)
	annotate!(plt2,[(100,0.5,L"a_{%$n2slider}=\frac{%$n2slider}{%$(1+n2slider)}=%$(round(a1(n2slider),digits=6))")])
# 	if (n2slider>=10)
		
# 		lens!(plt2,[n2slider-20.1, n2slider+20.1], [0.9,1.01], 
# 			inset = (1, bbox(0.6, -0.1, 0.4, 0.4)),
# 			grid=:none,
			
# 		)
	# end
	md"""
	$plt2
	"""	
end

# ╔═╡ df9175b2-587e-4822-a06a-f05a643489c9
n3Slider = @bind n3slider  Slider(1:1000,show_value=true);md"n = $n3Slider"

# ╔═╡ 74efcc77-ccf2-4742-b34c-ebee1fdc66c9
begin
	a3(n)= (-1)^n * (n+1)/5^n
	d3=1:n3slider
	plt3 = scatter(d3, a3.(d3),
		frame_style=:origin, 
		ylimits=(-1,1),
		xlimits=(-0.1,200),
		label=L"a_n=\frac{(-1)^n\cdot(n+1)}{5^n}",
		legend=:topleft,
		title_location=:left,
		title="Example 2 (Graph)"
	)
	annotate!(plt3,[(100,0.5,L"a_{%$n3slider}=\frac{%$((-1)^n3slider) \cdot %$(1+n3slider)}{5^{%$(n3slider)}}=%$(round(a3(n3slider),digits=6))")])
# 	if (n2slider>=10)
		
# 		lens!(plt2,[n2slider-20.1, n2slider+20.1], [0.9,1.01], 
# 			inset = (1, bbox(0.6, -0.1, 0.4, 0.4)),
# 			grid=:none,
			
# 		)
	# end
	md"""
	$plt3
	"""	
end

# ╔═╡ 0bbbe226-b241-4822-98f9-9027285cc1ad
n4Slider = @bind n4slider  Slider(4:1000,show_value=true);md"n = $n4Slider"

# ╔═╡ c17721b0-e71e-4a4b-a2e0-8bc447a30d4a
begin
	a4(n)= sqrt(n-4)
	d4=4:n4slider
	plt4 = scatter(d4, a4.(d4),
		frame_style=:origin, 
		ylimits=(-1,100),
		
		label=L"a_n=\frac{n-4}",
		legend=:topleft,
		title_location=:left,
		title="Example 3 (Graph)"
	)
	
	if (n4slider<100)
		xlims!(plt4,-0.1,100),
		annotate!(plt4,
			[(50,50,
			L"a_{%$n4slider}=\sqrt{%$(n4slider-4)}=%$(round(a4(n4slider),digits=6))")
			]
		)	
	elseif (n4slider>100 && n4slider<=500)
		xlims!(plt4,-0.1,500),
		annotate!(plt4,
			[(250,50,
			L"a_{%$n4slider}=\sqrt{%$(n4slider-4)}=%$(round(a4(n4slider),digits=6))")
			]
		)
	else
		xlims!(plt4,-0.1,1000),
		annotate!(plt4,
			[(500,50,
			L"a_{%$n4slider}=\sqrt{%$(n4slider-4)}=%$(round(a4(n4slider),digits=6))")
			]
		)
	end
	md"""
	$plt4
	"""	
end

# ╔═╡ 4b42abb2-178f-40f4-891b-ff10c207c4cc
md"""
#### What are trying to study?

* __convergence__ (what happended when $n$ gets larger and larger $n\to \infty$)

For **_Example 1_**: ``a_n=\frac{n}{n+1}``, it is fair to say and write
```math
\lim_{n\to \infty}\frac{n}{n+1} =1
```
"""

# ╔═╡ d79b7dfa-f50b-4550-89ab-f7337c0466a8
begin
	n5Slider = @bind n5slider  Slider(1:1000,show_value=true)
	epsSlider = @bind epsslider  Slider(0:0.01:1,show_value=true, default=1)
	
	md"""
	
	----
	
	|||
	|---|---|
	|``\epsilon`` =$epsSlider |	n = $n5Slider |
	
	----
	"""
end

# ╔═╡ e7833bdc-92b4-446f-891f-35eabe9f669f
begin
	d5=1:n5slider
	plt5 = scatter(d5, a1.(d5),
		frame_style=:origin, 
		ylimits=(-0.1,3),
		xlimits=(-0.1,100),
		label=L"a_n=\frac{n}{n+1}",
		legend=:topleft,
		title_location=:left,
		title="Example 1 (Graph)"
	)
	annotate!(plt5,
		[
		 (50,0.5,
L"a_{%$n5slider}=\frac{%$n5slider}{%$(1+n5slider)}=%$(round(a1(n5slider),digits=6))"
		 )
		,(20,1+epsslider+0.1, L"L+\epsilon")  	
		,(20,1-epsslider-0.1, L"L-\epsilon")  	
		]
	)
	plot!(plt5,
		[x->1,x->1-epsslider,x->1+epsslider],
		labels=:none
	)

	md"""
	$plt5
	"""	
end

# ╔═╡ 0fef6299-e663-456b-8bc0-0d7844ec928f
md"""
**Example** 

```math
\{(-1)^n\} = \{-1, 1, -1, 1, -1, 1, \cdots\}
```
"""

# ╔═╡ 90d9db55-3ffe-4580-af2c-c3972ac7916d
begin
	n6Slider = @bind n6slider  Slider(1:100,show_value=true)
	eps2Slider = @bind eps2slider  Slider(0:0.01:2,show_value=true, default=0)
	limitSlider = @bind limitslider NumberField(-2:0.1:2, default=0)
	md"""
	
	----
	
	|||
	|---|---|
	|``\epsilon`` =$eps2Slider |	n = $n6Slider |
	|``L =`` $limitSlider | |
	
	----
	"""
end

# ╔═╡ e7d604e2-7783-4798-a4bd-6e59ddcffd9b
begin
	a6(n)=iseven(n) ? 1 : -1
	d6=1:n6slider
	plt6 = scatter(d6, a6.(d6),
		frame_style=:origin, 
		ylimits=(-2,2),
		xlimits=(-0.1,100),
		label=L"a_n=(-1)^n",
		legend=:topleft,
		title_location=:left,
		title="Example "
	)
	annotate!(plt6,
		[
			(50,
			 1.5,
	L"a_{%$n6slider}=%$(a6(n6slider))"
				)
		,(20,limitslider+eps2slider+0.1, L"L+\epsilon")  	
		,(20,limitslider-eps2slider-0.1, L"L-\epsilon")  
		]
	)
	plot!(plt6,
		[x->limitslider,x->limitslider-eps2slider,x->limitslider+eps2slider],
		labels=:none
	)

	md"""
	$plt6
	"""	
end

# ╔═╡ eed45dbf-2094-4151-af98-d6b8455f1751
md"""
**Remark**: 

```math
\lim_{n\to \infty}(-1)^n = \text{DNE}
```

"""

# ╔═╡ 229f5c7b-99e9-4e67-af46-e68ec7017825
md"""
### Limit of a Sequence
**_Theorem_**

If ``\lim_{x\to\infty}f(x)=L`` and ``f(n)=a_n`` when ``n`` is an integer, then ``\lim_{n\to\infty}a_n=L``.

* **Remark**
```math
\lim_{n\to\infty} \frac{1}{n^r} = 0 \quad \text{if} \quad r>0
```

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

# ╔═╡ 6361a3e1-73a5-490b-81d8-5219d3d82ba8
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

# ╔═╡ 125b2567-069d-4e8f-81bd-c7c5734f62db
md"""
**_Theorem_**

If  ``\lim_{n\to\infty}a_n=L`` and the function ``f`` is continuous at ``L``, then
```math
\lim_{n\to\infty}f(a_n)=f(L).
```

"""

# ╔═╡ 12b14e19-050a-40b7-9672-604c4f764489
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

# ╔═╡ 89b158f0-0cf1-45b6-89fd-d68701dcd172
begin
	n7Slider = @bind n7slider  Slider(1:1000,show_value=true)
	rSlider = @bind rslider NumberField(-2:0.1:2, default=0)
	md"""
	
	----
	
	|||
	|---|---|
	|``r =`` $rSlider |	n = $n7Slider |
	
	----
	"""
end

# ╔═╡ 10798218-8de6-47c9-94f3-077078cd7ce9
begin
	a7(n)= rslider^n
	d7=1:n7slider
	plt7 = scatter(d7, a7.(d7),
		frame_style=:origin, 
		ylimits=(-1,100),
		
		label=L"a_n=%$rslider",
		legend=:topleft,
		title_location=:left,
		title="Example"
	)
	
	if (n7slider<100)
		xlims!(plt7,-0.1,100),
		annotate!(plt7,
			[(50,50,
			L"a_{%$n7slider}=%$rslider^{%$n7slider} =%$(round(a7(n7slider),digits=6))")
			]
		)	
	elseif (n7slider>100 && n7slider<=500)
		xlims!(plt7,-0.1,500),
		annotate!(plt7,
			[(250,50,
			L"a_{%$n7slider}=%$rslider^{%$n7slider}= %$(round(a7(n7slider),digits=6))")
			]
		)
	else
		xlims!(plt7,-0.1,1000),
		annotate!(plt7,
			[(500,50,
			L"a_{%$n7slider}=%$rslider^{%$n7slider}= %$(round(a7(n7slider),digits=6))")
			]
		)
	end
	md"""
	$plt7
	"""	
end

# ╔═╡ 7a6ac495-c92a-4d81-8ba3-a9f236ec14c3
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

# ╔═╡ 744a2fbb-b718-4958-bd1c-eb00df14b3c0
md"""
### Pattern Recognition for Sequences

__Example__

Find a sequence ``\{a_n\}`` whose first five terms are
```math
\frac{2}{1},\frac{4}{3},\frac{8}{5},\frac{16}{7},\frac{32}{9},
```
and then determine whether the sequence you have chosen converges or diverges.


__Example__

Find a sequence ``\{a_n\}`` whose first five terms are
```math
-\frac{2}{1},\frac{8}{2},-\frac{26}{6},\frac{80}{24},-\frac{242}{120},
```
and then determine whether the sequence you have chosen converges or diverges.

"""

# ╔═╡ 2bee38b7-e767-453e-818d-fec74e81c887
md"""
### Monotonic and Bounded Sequences

**_Definition_**

* A sequence ``\{a_n\}`` is called **increasing** if ``a_n<a_{n+1}`` for all ``n\geq 1``, that is,``a_1<a_2<a_3<\cdots`` . 
* It is called **decreasing** if ``a_n>a_{n+1}`` for all ``n\geq 1``.
* A sequence is called **monotonic** if it is either increasing or decreasing.
"""

# ╔═╡ 4cb2514e-9266-424c-8bf0-f0b2217cf2aa
md"""
**Examples**

Is the following increasing or decreasing?
1. ``\left\{\frac{3}{n+5}\right\}``.
2. ``\left\{\frac{n}{n^2+1}\right\}``.
"""

# ╔═╡ 0b15c5f3-5238-4251-b31a-c82704bd0e80
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

# ╔═╡ f5cf327c-9f3b-4c50-9e92-96471d0874b6
md"""
**Example**

```math
a_1 =2 , \quad a_{n+1}={1\over 2}\left(a_n+6\right), \quad \text{for }n=1,2,3, \cdots
```

"""

# ╔═╡ 5fa58a4d-d6b3-400c-9112-eca8b94e99ae
an(n) = (n==1) ? 2 : (1/2)*(an(n-1)+6)

# ╔═╡ 732f8e3f-75ed-47a3-8329-ca55549b0ebf
md"""
## 9.2: Series and Convergence
> __Objectives__
> - Understand the definition of a convergent infinite series.
> - Use properties of infinite geometric series.
> - Use the th-Term Test for Divergence of an infinite series.
"""

# ╔═╡ 08f9b6b9-f820-4c7c-8eea-7588aba8c9ae
begin
	n8Slider = @bind n8slider  Slider(1:1000,show_value=true)
	md"""
	
	----
	
	||
	|---|
	|n = $n8Slider |
	
	----
	"""
end

# ╔═╡ c1edd4a2-8952-4181-9cdb-0e434d5dc222
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

# ╔═╡ 2e13ed47-1710-4a00-a16f-78a0b73a47d1
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

# ╔═╡ ab86d276-e619-4a05-aaf5-51ed88276d80
md"""
### Questions we want to answer about `Series`
```math
\sum_{n=1}^{\infty}a_n
```
1. does this converge?
2. if it does, what is its sum?

**Examples**
Does the following series converge? 
1. ``\sum_{n=1}^{\infty}n ``
2. ``\sum_{n=1}^{\infty} \frac{1}{2^n}``

"""

# ╔═╡ 33e3781a-06a6-41dd-9afa-87f29aa6df09
md"""
**Exercise**
Assume that ``\left\{a_n\right\}_{n=1}^{\infty}`` is a sequence.
1. Find 
```math
\sum_{n=1}^{\infty} a_n \quad \text{ if }\quad s_n = \sum_{i=1}^{n} a_i = \frac{n+2}{3n-5}
```
2. Can you find ``a_n``?

"""

# ╔═╡ a5bf66f5-5afd-46b6-8400-3eb66f0ce94e
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


# ╔═╡ 48849ed1-36f5-4299-8c23-465253243234
md"""
### Telescoping sum
Find the sum of the following series
```math
\sum_{n=1}^{\infty} \frac{1}{n(n+1)}
```
__Solution in class__

---
"""

# ╔═╡ cd19fc91-194c-4d46-ba30-ccfa7da4ff46
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

# ╔═╡ b4cef0ce-33c6-474f-bef9-314bc43eaa30
md"""
### Geometric Series
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

# ╔═╡ 100f4345-f0e4-4892-9709-162e3a4c39cb
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

# ╔═╡ a58d86b1-d211-49ee-807d-f545550feb4a
md"""
### Test for Divergence
**Example**
Show that the harmonic series
```math
\sum_{n=1}^{\infty}\frac{1}{n} = 1 + \frac{1}{2}+ \frac{1}{3}+ \frac{1}{4}+\cdots
```
is divergent.

"""

# ╔═╡ ce8e2e40-8126-4c82-befd-67d6e5a18dc9
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

# ╔═╡ 052e1dcd-532a-4bba-94cf-2045ce39e3a0
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

# ╔═╡ 0f9d4aa8-8678-416a-aa78-43564e600b68
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

# ╔═╡ f5940c72-c53b-477e-901a-065890994424
md"""
## 9.3: The Integral Test and $p$-Series
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
1. If ``\int_1^\infty f(x) dx`` is convergent, then is ``\sum_{n=1}^{\infty}a_n`` convergent.
2. If ``\int_1^\infty f(x) dx`` is divergent, then is ``\sum_{n=1}^{\infty}a_n`` divergent.

**_Examples_**

Test for convergence 
```math
\sum_{n=1}^{\infty}\frac{1}{n^2}, \qquad \sum_{n=1}^{\infty}\frac{1}{n}
```
__Solution in class__ 

"""

# ╔═╡ 647499ff-0a1a-47b7-b380-cefb3e4d8deb
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

# ╔═╡ c649ea68-d3af-4573-a3cf-d252c7df0c82
md"""
### P-series
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

# ╔═╡ 035f9728-3d6a-429d-91f4-9585a2f6caf8
md"""
### Estimating the Sum of a Series
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

# ╔═╡ ea18fd6b-c0fa-4085-8353-101a71ee17ac
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

# ╔═╡ 7b45a531-c3c3-4301-9e67-99b1de59e280
md"""
**_Remainder Estimate for the Integral Test_**
Suppose ``f(k)=a_k``, where ``f`` is a continuous, positive, decreasing function for  ``x\geq n`` and ``\sum a_n``  is convergent. If ``R_n=s-s_n``, then

```math
	\int_{n+1}^{\infty} f(x) dx \leq R_n  \leq \int_n^{\infty} f(x) dx
```

"""

# ╔═╡ d395cf53-882e-4b1c-af71-eeed7dec80bb
md"""
**_Example 5_**

(a) Approximate the sum of the series 
```math
\sum \frac{1}{n^3}
```
by using the sum of the first ``10`` terms. Estimate the error involved in this approximation.

(b) How many terms are required to ensure that the sum is accurate to within ``0.0005``?
"""

# ╔═╡ 69009dbb-3db0-4da9-993d-e27fd15981f7
nnnSlider = @bind nnn NumberField(1:50);md"n = $nnnSlider"

# ╔═╡ c1fb160e-e9bf-4872-b959-226c917e06a1
md"""
## 9.4: Comparisons of Series
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

# ╔═╡ 969d060c-5829-40fc-ac52-e04af4618899
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

# ╔═╡ 7dda009d-9b2d-4508-8847-1ea107edd2cb
md"""
### The Limit Comparison Test

Suppose ``\sum a_n`` that and ``\sum b_n`` are series with positive terms. If
```math
\lim_{n\to\infty}\frac{a_n}{b_n} = c
```
where ``c`` is a finite number and ``c>0``, then either both series converge or both diverge.

**_Remark_**

Exercises `40` and `41` deal with the cases ``c=0`` and ``c=\infty`` .

"""

# ╔═╡ 08b6efff-e3f6-47fa-9b09-57b641c1f598
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

# ╔═╡ 4bb1c6d6-e533-4dae-a449-64f0dbe27bad
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

# ╔═╡ 89f93052-2d9c-49d1-a6c1-b416900fd309
md" --- "

# ╔═╡ f52f9c5e-0571-4317-9345-cc57ca99cfb1
md"""
## 9.5: Alternating Series
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

# ╔═╡ d1e642ba-8674-4c20-838e-dcdb6535fc52
n9Slider = @bind n9slider  Slider(1:1000,show_value=true);md"n = $n9Slider"

# ╔═╡ 1a252854-d2d4-4eec-8da7-9b7fe389e4eb
begin
	a9(n) = ((-1)^(n))/(n)
	d9=2:(1+n9slider)
	bs = (n9slider>9) ? "\\sum_{i=1}^{$n9slider}(-1)^{n-1}b_i" : (join([(i==n9slider) ?  "b_{$i}" :  
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
		annotations=[(0.2,0.8,L"s_{%$n9slider}=%$bs")]
	)
	annotate!(plt9,[(a9(d9[i]),0.04,L"s_{%$i}",8) for i in 1:n9slider])
	
	md"""
	$plt9
	"""
		
end

# ╔═╡ 9a8d25f4-eba2-4c9f-912b-bdd77f4e4d51
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

# ╔═╡ 04b5c50f-9931-43b4-a13a-d99e2bc73772
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

# ╔═╡ 54196593-483e-4906-9b2d-a9a19b3389d3
md"""
**_Example_**
How many terms of the series 
```math
\sum_{n=1}^{\infty}{\frac{(-1)^{n+1}}{{n^6}}}
```
do we need to add in order to find the sum accurate with $|error|< 0.000001$?

"""

# ╔═╡ d4b70d69-8784-4200-a81b-386204363c6f
n10Slider = @bind n10slider NumberField(1:20);md"n = $n10Slider"

# ╔═╡ f99a7e1d-6f35-4d50-833c-fb72b88eb963
md"""
### Absolute Convergence and Conditional Convergence
* A series ``\sum a_n`` is called __absolutely convergent__ if the series of absolute values ``\sum |a_n|`` is convergent.
* A series ``\sum a_n`` is called __conditionally convergent__ if it is convergent but not absolutely convergent; that is, ``\sum a_n`` if converges but ``\sum |a_n|``  diverges.

---

**_Theorem_**

If a series ``\sum a_n`` is absolutely convergent, then it is convergent.

"""

# ╔═╡ 855bc814-73ae-48be-b1e4-2acd574484ae
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

# ╔═╡ cf69a563-8562-47d5-bf3e-e293ac73b8c1
md"""
## 9.6: The Ratio and Root Tests
> __Objectives__
> - Use the Ratio Test to determine whether a series converges or diverges.
> - Use the Root Test to determine whether a series converges or diverges.
> - Review the tests for convergence and divergence of an infinite series. 

### The Ratio Test
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

# ╔═╡ 60e396d0-a49d-4a8e-b703-7164724c5179
md"""
### The Root Test
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


# ╔═╡ cc4929ef-aa8c-44c1-82fc-f292a2816e02
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

# ╔═╡ a68491a7-3711-4afd-9fc0-cd4ea648ce35
md"""
## 9.7: Taylor Polynomials and Approximations
> __Objectives__
> - Find polynomial approximations of elementary functions and compare them with the elementary functions.
> - Find Taylor and Maclaurin polynomial approximations of elementary functions.
> - Use the remainder of a Taylor polynomial.

"""


# ╔═╡ 70f3c4c8-ac81-4802-8635-5c534aa60c89
begin
	p2 = md"""
For the function ``f(x)=e^x``, find a first-degree polynomial function ``P_1(x)=a_0+a_1x``  whose value and slope agree with the value and slope of  at  ``x=0``.
"""

cm"""
## Polynomial Approximations of Elementary Functions

$p2

"""

end

# ╔═╡ 160cdcab-eac4-4ebe-9f99-4167af5dec6f
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


# ╔═╡ 13ff7fc2-db56-4383-8f56-9eb789dce213
begin
	an(x,n)=x^n/factorial(n)
	fn(x)=exp(x)
	# an1(x,n)=factorial(big(n))*x^n
	
	intrvl = -4.1:0.01:4.1
	plus_or_empty(n,last) = (n<last) ? " + " : ""
	term_reps(n,last) = join(
			[
			  n==0 ? "1" : (n==1) ? "x" : "x^{$n}"
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

# ╔═╡ 725356c8-c1c7-4fe9-8b31-a54350eb6192
an(70)

# ╔═╡ 8afca44c-2856-43bc-b14f-7bdebe6a4760
P6(x)=1-x^2/2 + x^4/factorial(4) - x^6/factorial(6)

# ╔═╡ 860e68e5-a93c-4a87-8464-630cd002c107
# @edit cos(0.1)
P6(0.1),cos(0.1)

# ╔═╡ cb98e7c3-62ff-42cf-808f-809fabe2b72b
md"""
## 9.8: Power Series
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



# ╔═╡ a51f8b2a-a408-46a6-a1be-acf3d6861b18
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

# ╔═╡ c9b1a284-d79f-4eb6-9c7e-36e56b085ebf
md"""
#### Examples

```math
\begin{array}{l@{\,\,\,\,}l}
(1) & \sum_{n=0}^\infty n! x^n\\ \\
(2) & \sum_{n=1}^\infty \frac{(x-3)^n}{n}\\ \\
(3) & J_0(x)=\sum_{n=0}^\infty \frac{(-1)^nx^{2n}}{2^{2n}(n!)^2}
\end{array}
```

"""

# ╔═╡ d2c75d50-8b18-423e-a5dd-ec608fa64a0b
cm"""
## Endpoint Convergence
"""

# ╔═╡ b47c9840-40a9-48f2-87b8-a48d37a80b56
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

# ╔═╡ 0943a708-7258-4320-8b52-ec9cd237ec4b
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

# ╔═╡ ac0bd656-3bd3-47fd-9815-078f073d3280
md"""
## 9.9: Representation of Functions by Power Series
> **Objectives**
> - Find a geometric power series that represents a function.
> - Construct a power series using series operations.

### Representations of Functions using Geometric Series
```math
\frac{1}{1-x} = 1 + x + x^2 +x^3 +\cdots =\sum_{n=0}^{\infty}x^n, \quad |x|<1.
```
"""

# ╔═╡ aabf07ca-9b1a-4cb7-bda3-667bf6b89b82
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

# ╔═╡ 0a42b7f1-5795-4327-9710-b18e077ffb72
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

# ╔═╡ c58f2776-5233-4892-88d1-81b50141f447
md"""
## 9.10: Taylor and Maclaurin Series [^⭐]
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

# ╔═╡ fe3a7852-896d-4eb2-af96-6a1fa1aee476
md"""
**_Theorem_**(Taylor Theorem)

If ``f`` has a power series representation (expansion) at ``a`` , that is, if
```math
f(x) = \sum_{n=0}^{\infty}c_n (x-a)^n, \qquad |x-a|<R
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
"""


# ╔═╡ b56f67a6-65dc-4ac5-a86e-933b92742e7f
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

# ╔═╡ a18b2edf-4493-487a-a52c-7cd9f612cd90
md"""
### The Binomial Series
**Example**: 
Find the Maclaurin series for ``f(x)=(1+x)^k``, where ``k`` is any real number.

__*Solution: In Class*__

"""

# ╔═╡ 4e98445a-3c9d-402c-8164-dc3486ef1094
md"""
__*The Binomial Series (Theorem)*__

If ``k`` is any real number and ``|x|<1``, then
```math
(1+x)^k=\sum_{n=0}^{\infty}\begin{pmatrix}
k \\ n
\end{pmatrix}x^n = 1 + k x + \frac{k(k-1)}{2!}x^2 +
\frac{k(k-1)(k-2)}{3!}x^3 +\cdots

```



"""


# ╔═╡ 3fa4faa0-b767-4204-a062-a4ba0c1ebed0
md"""
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

# ╔═╡ 8f838fb6-17b6-4c11-b9f7-8d2e2af930b3
md"""
#### Example
Find the Maclaurin series for the function 
```math
f(x)=\frac{1}{\sqrt{4-x}}
```
and its radius of convergence.

"""

# ╔═╡ eacbb51c-7a2c-44a4-aec0-a08bc168a635
md"""
### New Taylor Series from Old
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

# ╔═╡ eaa0cda6-641d-4830-8dd5-e3d844131a57
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

# ╔═╡ 7a09f760-0ee8-403c-80cf-7715193d62b3
begin
	n,i = symbols("n,i", integer=true)
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

end

# ╔═╡ ca411c6d-4ddb-4646-aaa5-1aa40937327e
begin
	s1(n) = 1/(2^n)
	s1exact = summation(s1(n),(n,1,n8slider))
	s2exact = summation(n,(n,1,n8slider))
	s1exactn=round(s1exact.n(),digits=8)
	s1exactsol= (n8slider<20) ? s1exact : s1exactn
	s2exactn=round(s2exact.n(),digits=8)
	# gr(size = (500, 165))
	plot(;		yaxis=nothing,
				frame_style=:origin, 
				showaxis=false,
				ticks=[],
				ylims=(0,1),
		annotations=[
			(0.6,0.75,
				L"\sum_{i=1}^na_i=\sum_{n=1}^{%$n8slider}\frac{1}{2^n}=%$s1exactsol",10
			),
			(0.58,0.5,
				L"\sum_{i=1}^na_i=\sum_{n=1}^{%$n8slider}n=%$s2exact",10
			)
		],
			grid=:none,)
	
end

# ╔═╡ 33464e2b-7169-4baa-96af-ba763c9bfacc
begin
	if isinteger(nnn)
	ann(n)=1/n^3
	s10=sum([ann(i) for i in 1:nnn])
	sExact=summation(ann(n),(n,1,oo)).n()
	r10=sExact-s10
	md"""
	``s=``$sExact

	``s_n=``$s10
	
	``R_n``=$r10
	
	"""
	end
end

# ╔═╡ f6b4ff16-91fb-45e1-88b5-e450aeaf6139
begin
	seq12(n)=((-1)^(n+1))/n^6
	s=summation(seq12(n),(n,1,oo)).n()
	sn=round(sum(seq12.(1:n10slider)),digits=15)
	rn=round(abs(s-sn);sigdigits=1)
	md"""
	``s\;\;\;\;\;= \;``$s
	
	``s_n\;\;\;=\;``$sn
	
	``\left|R_n\right|=\;``$rn
	
	"""
end


# ╔═╡ f6184770-7282-4418-8935-31c690bd8472
begin
	tth=md"""
If ``f`` has ``n`` derivatives at ``c``, then the polynomial

```math
P_n(x) = f(c) + f'(c)(x-c) + \frac{f''(c)}{2!}(x-c)^2+\cdots + \frac{f^{(n)}(c)}{n!}(x-c)^n
```
is called the __``n``th Taylor polynomial for ``f`` at ``c``__. 

If ``c=0``, then

```math
P_n(x) = f(0) + f'(0)x + \frac{f''(0)}{2!}x^2+\cdots + \frac{f^{(n)}(0)}{n!}x^n
```
is also called the __``n``th Maclaurin polynomial for ``f``__.

"""
	
cm"""
## Taylor and Maclaurin Polynomials

$(beginBlock("Definitions of th Taylor Polynomial and th Maclaurin Polynomial",""))

$(tth)
$(endBlock())
"""
end

# ╔═╡ ad55800e-0a4c-45d0-b163-9d64d4fc4199
begin
s97exsp1=md"""
Find the Taylor polynomials ``P_0``, ``P_1``, ``P_2``, ``P_3``, and ``P_4`` for
```math
f(x)=\ln x
```
centered at ``c=1``.
"""
cm"""
$(example("Example 3","A Maclaurin Polynomial for e^x"))
$(example("Example 4","Finding Taylor Polynomials for ln x"))

$s97exsp1
	"""
end

# ╔═╡ 09d8ac0a-31d6-4b7a-8822-11e3ebd18072
begin
s97exsp2 = md"""
Find the Maclaurin polynomials ``P_0``, ``P_2``, ``P_4``, and ``P_6`` for ``f(x)=\cos x``. Use ``P_6(x)`` to approximate the value of ``\cos(0.1)``.
"""
cm"""
$(example("Example 5","Finding Maclaurin Polynomials for cos x"))

$s97exsp2

"""
end

# ╔═╡ 644eb07c-0c7b-4758-9178-46e263f17a58
begin
s97exsp3 = md"""
Find the third Taylor polynomial ``P_3`` for ``f(x)=\sin x`` at ``c={\pi\over 6}``. 
"""
cm"""
$(example("Example 6","Finding a Taylor Polynomial for sin x"))

$s97exsp3

"""
end

# ╔═╡ 6cbe46d7-9b91-4e21-8681-496820ca12c3
begin
s97exsp4 = md"""
Use a fourth Maclaurin polynomial to approximate the value of ``\ln (1.1)``.
"""
cm"""
$(example("Example 7","Approximation Using Maclaurin Polynomials"))

$s97exsp4

"""
end

# ╔═╡ d5e7df5e-9122-4f38-bc40-b4c8b0a44175
begin
	sec98ex1 = md"""
	```math
	f(x)= \sum_{n=1}^{\infty}\frac{x^n}{n}
	```
	Find the interval of convergence for each of the following

	- ``\int f(x) dx``
	- ``f(x)``
	- ``f'(x)``

	"""
cm"""
$(example("Example 8","Intervals of Convergence"))

$sec98ex1

"""
end

# ╔═╡ 43bc70eb-5e09-46e4-925c-2dd65792f676
begin
	sec99th=md"""
	Let ``f(x) = \displaystyle \sum_{n=0}^{\infty} a_n x^n`` and ``g(x) = \displaystyle \sum_{n=0}^{\infty} b_n x^n``. Then
	1. ``\displaystyle f(kx)=\sum_{n=0}^{\infty} a_n k^nx^n``
	1. ``\displaystyle f(x^N)=\sum_{n=0}^{\infty} a_n x^{nN}``
	1. ``\displaystyle f(x)\pm g(x)=\sum_{n=0}^{\infty} (a_n\pm b_n) x^n ``
	"""
	cm"""
	$(beginBlock("Operations with Power Series",""))

	$sec99th

	$(endBlock())
	"""
end

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
Colors = "~0.12.8"
CommonMark = "~0.8.2"
FileIO = "~1.10.1"
HypertextLiteral = "~0.9.0"
ImageIO = "~0.5.6"
ImageShow = "~0.3.2"
ImageTransformations = "~0.8.12"
LaTeXStrings = "~1.2.1"
PlotThemes = "~2.0.1"
Plots = "~1.19.4"
PlutoUI = "~0.7.9"
SymPy = "~1.0.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "07bb704daf5d3d0eb653593d903c9da081fbf98d"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "485ee0867925449198280d4af84bdb46a2a404d0"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.0.1"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "a4d07a1c313392a77042855df46c5f534076fab9"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c3598e525718abcc440f69cc6d5f60dda0a1b61e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.6+5"

[[deps.CEnum]]
git-tree-sha1 = "215a9aa4a1f23fbd05b92769fdd62559488d70e9"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.1"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "e2f47f6d8337369411569fd45ae5753ca10394c6"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.0+6"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "f53ca8d41e4753c41cdafa6ec5f7ce914b34be54"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "0.10.13"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random", "StaticArrays"]
git-tree-sha1 = "ed268efe58512df8c7e224d2e170afd76dd6a417"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.13.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "42a9b08d3f2f951c9b283ea427d96ed9f1f30343"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.5"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.CommonMark]]
deps = ["Crayons", "JSON", "URIs"]
git-tree-sha1 = "1060c5023d2ac8210c73078cb7c0c567101d201c"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.2"

[[deps.CommonSolve]]
git-tree-sha1 = "68a0743f578349ada8bc911a5cbd5a2ef6ed6d1f"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.0"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "344f143fa0ec67e47917848795ab19c6a455f32c"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.32.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

[[deps.Conda]]
deps = ["JSON", "VersionParsing"]
git-tree-sha1 = "299304989a5e6473d985212c28928899c74e9421"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.5.2"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "6d1c23e740a586955645500bbec662476204a52c"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.1"

[[deps.Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[deps.DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4437b64df1e0adccc3e5d1adbc3ac741095e4677"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.9"

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
git-tree-sha1 = "a32185f5428d3986f47c2ab78b1f216d5e6cc96f"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "92d8f9f208637e8d2d28c664051a00569c01493d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.1.5+1"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b3bfd02e98aedfa5cf885665493c5598c350cd2f"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.2.10+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "LibVPX_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "3cc57ad0a213808473eafef4845a74766242e05f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.3.1+4"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "256d8e6188f3f1ebfa1a5d17e072a0efafa8c5bf"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.10.1"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "35895cf184ceaab11fd778b4590144034a167a2f"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.1+14"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "cbd58c9deb1d304f5a245a0b7eb841a2560cfec6"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.1+5"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "0c603255764a1fa0b61752d2bec14cfbd18f7fe8"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.5+1"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "9f473cdf6e2eb360c576f9822e7c765dd9d26dbc"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.58.0"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "eaf96e05a880f3db5ded5a5a8a7817ecba3c7392"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.58.0+0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "58bcdf5ebc057b085e58d95c138725628dd7453c"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.1"

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
git-tree-sha1 = "2c1cf4df419938ece72de17f368a021ee162762e"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "c6a1fff2fd4b1da29d3dccaffb1e1001244d844e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.12"

[[deps.HypertextLiteral]]
git-tree-sha1 = "72053798e1be56026b81d4e2682dbe58922e5ec9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.0"

[[deps.IdentityRanges]]
deps = ["OffsetArrays"]
git-tree-sha1 = "be8fcd695c4da16a1d6d0cd213cb88090a150e3b"
uuid = "bbac6d45-d8f3-5730-bfe4-7a449cd117ca"
version = "0.3.1"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "84677012257b18dfdad166352f0632136cee99f2"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.1"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "75f7fea2b3601b58f24ee83617b528e57160cbfd"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.1"

[[deps.ImageIO]]
deps = ["FileIO", "Netpbm", "PNGFiles", "TiffImages", "UUIDs"]
git-tree-sha1 = "d067570b4d4870a942b19d9ceacaea4fb39b69a1"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.5.6"

[[deps.ImageShow]]
deps = ["Base64", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "e439b5a4e8676da8a29da0b7d2b498f2db6dbce3"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.2"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "ColorVectorSpace", "CoordinateTransformations", "IdentityRanges", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "d966631de06f36c8cd4bec4bb2e8fa731db16ed9"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.8.12"

[[deps.IndirectArrays]]
git-tree-sha1 = "c2a145a145dc03a7620af1444e0264ef907bd44f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "0.5.1"

[[deps.Inflate]]
git-tree-sha1 = "f5fc07d4e706b84f72d54eedcc1c13d92fb0871c"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.2"

[[deps.IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "1470c80592cf1f0a35566ee5e93c5f8221ebc33a"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.13.3"

[[deps.IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d735490ac75c5cb9f1b00d8b5509c11984dc6943"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.0+0"

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
git-tree-sha1 = "c7f1c695e06c01b95a67f0cd1d34994f3e7db104"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.2.1"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "a4b12a1bd2ebade87891ab7e36fdbce582301a92"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.6"

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

[[deps.LibVPX_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "12ee7e23fa4d18361e7c2cde8f8337d4c3101bc7"
uuid = "dd192d2f-8180-539f-9fb4-cc70b1dcf69a"
version = "1.10.0+0"

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
git-tree-sha1 = "c9551dd26e31ab17b86cbd00c2ede019c08758eb"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "LinearAlgebra"]
git-tree-sha1 = "7bd5f6565d80b6bf753738d2bc40a5dfea072070"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.2.5"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "6a8a2a625ab0dea913aba95c11370589e0239ff0"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.6"

[[deps.MappedArrays]]
git-tree-sha1 = "18d3584eebc861e311a552cbb67723af8edff5de"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.0"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

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
git-tree-sha1 = "4ea90bd5d3985ae1f9a908bd4500ae88921c5ce7"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.0"

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
git-tree-sha1 = "bfe47e760d60b82b66b61d2d44128b62e3a369fb"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.5"

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
git-tree-sha1 = "4f825c6da64aebaa22cc058ecfceed1ab9af1c7e"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.10.3"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "15003dcb7d8db3c6c857fda14891a539a8f2705a"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.10+0"

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

[[deps.PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "520e28d4026d16dcf7b8c8140a3041f0e20a9ca8"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.7"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fa5e78929aebc3f6b56e1a88cf505bb00a354c4"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.8"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "c8abc88faa3f7a3950832ac5d6e690881590d6dc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.0"

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
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "501c20a63a34ac1d015d5304da0e645f42d91c9f"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.0.11"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs"]
git-tree-sha1 = "1e72752052a3893d0f7103fbac728b60b934f5a5"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.19.4"

[[deps.PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "afadeba63d90ff223a6a48d2009434ecee2ec9e8"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.1"

[[deps.PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "169bb8ea6b1b143c5cf57df6d34d022a7b60c6db"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.92.3"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Ratios]]
git-tree-sha1 = "37d210f612d70f3f7d57d488cb3b6eff56ad4e41"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.0"

[[deps.RecipesBase]]
git-tree-sha1 = "b3fb709f3c97bfc6e948be68beeecb55a0b340ae"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.1.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "2a7a2469ed5d94a98dea0e85c46fa653d76be0cd"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.3.4"

[[deps.Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[deps.Rotations]]
deps = ["LinearAlgebra", "StaticArrays", "Statistics"]
git-tree-sha1 = "2ed8d8a16d703f900168822d83699b8c3c1a5cd8"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.0.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

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
deps = ["ChainRulesCore", "LogExpFunctions", "OpenSpecFun_jll"]
git-tree-sha1 = "508822dca004bf62e210609148511ad03ce8f1d8"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.6.0"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "885838778bb6f0136f8317757d7803e0d81201e4"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.9"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "fed1ec1e65749c4d96fc20dd13bea72b55457e62"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.9"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "000e168f5cc9aded17b6999a560b7c11dda69095"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.0"

[[deps.Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[deps.SymPy]]
deps = ["CommonSolve", "LinearAlgebra", "Markdown", "PyCall", "RecipesBase", "SpecialFunctions"]
git-tree-sha1 = "8f0cd4e2cb847346de37a8980bc2c8ea635ec3f0"
uuid = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
version = "1.0.50"

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
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "8ed4a3ea724dac32670b062be3ef1c1de6773ae8"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.4.4"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TiffImages]]
deps = ["ColorTypes", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "OffsetArrays", "OrderedCollections", "PkgVersion", "ProgressMeter"]
git-tree-sha1 = "03fb246ac6e6b7cb7abac3b3302447d55b43270e"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.4.1"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.VersionParsing]]
git-tree-sha1 = "80229be1f670524750d905f8fc8148e5a8c4537f"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll"]
git-tree-sha1 = "2839f1c1296940218e35df0bbb220f2a79686670"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.18.0+4"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "59e2ad8fd1591ea019a5259bd012d7aee15f995c"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.3"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

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
git-tree-sha1 = "cc4bf3fdde8b7e3e9fa0351bdeedba1cf3b7f6e6"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "acc685bcf777b2202a904cdcb49ad34c2fa1880c"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.14.0+4"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7a5780a0d9c6864184b3a2eeeb833a0c871f00ab"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "0.1.6+4"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

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
git-tree-sha1 = "d713c1ce4deac133e3334ee12f4adff07f81778f"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2020.7.14+2"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "487da2f8f2f0c8ee0e83f39d13037d6bbf0a45ab"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.0.0+3"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╠═d49029eb-fe4a-493e-b2df-a29ddb3740bf
# ╠═738772a6-d798-41d6-aa6d-c599d6d65ef7
# ╠═6906df3e-afaa-4884-9825-abcf8fef2cbb
# ╠═6019adf1-f462-4e30-beca-ed460822279e
# ╟─85a3375a-d660-4af3-a1e0-c7d2d6fbc22a
# ╟─b59b486a-f4ba-447a-9e29-5806254832f2
# ╟─608e786a-322f-4fab-9536-c06fa33b5ba6
# ╟─904be4c9-7e3a-4c07-8b59-c5afbddcaffd
# ╟─52682ee6-929e-4e49-9ed9-eec5e62eb84e
# ╟─97e90d04-99b3-4c54-8f14-5e09f1c4933f
# ╟─df9175b2-587e-4822-a06a-f05a643489c9
# ╟─74efcc77-ccf2-4742-b34c-ebee1fdc66c9
# ╟─0bbbe226-b241-4822-98f9-9027285cc1ad
# ╟─c17721b0-e71e-4a4b-a2e0-8bc447a30d4a
# ╟─4b42abb2-178f-40f4-891b-ff10c207c4cc
# ╟─d79b7dfa-f50b-4550-89ab-f7337c0466a8
# ╟─e7833bdc-92b4-446f-891f-35eabe9f669f
# ╟─0fef6299-e663-456b-8bc0-0d7844ec928f
# ╟─90d9db55-3ffe-4580-af2c-c3972ac7916d
# ╟─e7d604e2-7783-4798-a4bd-6e59ddcffd9b
# ╟─eed45dbf-2094-4151-af98-d6b8455f1751
# ╟─229f5c7b-99e9-4e67-af46-e68ec7017825
# ╟─6361a3e1-73a5-490b-81d8-5219d3d82ba8
# ╟─125b2567-069d-4e8f-81bd-c7c5734f62db
# ╟─12b14e19-050a-40b7-9672-604c4f764489
# ╟─89b158f0-0cf1-45b6-89fd-d68701dcd172
# ╟─10798218-8de6-47c9-94f3-077078cd7ce9
# ╟─7a6ac495-c92a-4d81-8ba3-a9f236ec14c3
# ╟─744a2fbb-b718-4958-bd1c-eb00df14b3c0
# ╟─2bee38b7-e767-453e-818d-fec74e81c887
# ╟─4cb2514e-9266-424c-8bf0-f0b2217cf2aa
# ╟─0b15c5f3-5238-4251-b31a-c82704bd0e80
# ╟─f5cf327c-9f3b-4c50-9e92-96471d0874b6
# ╟─5fa58a4d-d6b3-400c-9112-eca8b94e99ae
# ╠═725356c8-c1c7-4fe9-8b31-a54350eb6192
# ╟─732f8e3f-75ed-47a3-8329-ca55549b0ebf
# ╟─08f9b6b9-f820-4c7c-8eea-7588aba8c9ae
# ╟─ca411c6d-4ddb-4646-aaa5-1aa40937327e
# ╟─c1edd4a2-8952-4181-9cdb-0e434d5dc222
# ╟─2e13ed47-1710-4a00-a16f-78a0b73a47d1
# ╟─ab86d276-e619-4a05-aaf5-51ed88276d80
# ╟─33e3781a-06a6-41dd-9afa-87f29aa6df09
# ╟─a5bf66f5-5afd-46b6-8400-3eb66f0ce94e
# ╟─48849ed1-36f5-4299-8c23-465253243234
# ╟─cd19fc91-194c-4d46-ba30-ccfa7da4ff46
# ╟─b4cef0ce-33c6-474f-bef9-314bc43eaa30
# ╟─100f4345-f0e4-4892-9709-162e3a4c39cb
# ╟─a58d86b1-d211-49ee-807d-f545550feb4a
# ╟─ce8e2e40-8126-4c82-befd-67d6e5a18dc9
# ╟─052e1dcd-532a-4bba-94cf-2045ce39e3a0
# ╟─0f9d4aa8-8678-416a-aa78-43564e600b68
# ╟─f5940c72-c53b-477e-901a-065890994424
# ╟─647499ff-0a1a-47b7-b380-cefb3e4d8deb
# ╟─c649ea68-d3af-4573-a3cf-d252c7df0c82
# ╟─035f9728-3d6a-429d-91f4-9585a2f6caf8
# ╟─ea18fd6b-c0fa-4085-8353-101a71ee17ac
# ╟─7b45a531-c3c3-4301-9e67-99b1de59e280
# ╟─d395cf53-882e-4b1c-af71-eeed7dec80bb
# ╟─69009dbb-3db0-4da9-993d-e27fd15981f7
# ╟─33464e2b-7169-4baa-96af-ba763c9bfacc
# ╟─c1fb160e-e9bf-4872-b959-226c917e06a1
# ╟─969d060c-5829-40fc-ac52-e04af4618899
# ╟─7dda009d-9b2d-4508-8847-1ea107edd2cb
# ╟─08b6efff-e3f6-47fa-9b09-57b641c1f598
# ╟─4bb1c6d6-e533-4dae-a449-64f0dbe27bad
# ╟─89f93052-2d9c-49d1-a6c1-b416900fd309
# ╟─f52f9c5e-0571-4317-9345-cc57ca99cfb1
# ╟─d1e642ba-8674-4c20-838e-dcdb6535fc52
# ╟─1a252854-d2d4-4eec-8da7-9b7fe389e4eb
# ╟─9a8d25f4-eba2-4c9f-912b-bdd77f4e4d51
# ╟─04b5c50f-9931-43b4-a13a-d99e2bc73772
# ╟─54196593-483e-4906-9b2d-a9a19b3389d3
# ╟─d4b70d69-8784-4200-a81b-386204363c6f
# ╟─f6b4ff16-91fb-45e1-88b5-e450aeaf6139
# ╟─f99a7e1d-6f35-4d50-833c-fb72b88eb963
# ╟─855bc814-73ae-48be-b1e4-2acd574484ae
# ╟─cf69a563-8562-47d5-bf3e-e293ac73b8c1
# ╟─60e396d0-a49d-4a8e-b703-7164724c5179
# ╟─cc4929ef-aa8c-44c1-82fc-f292a2816e02
# ╟─a68491a7-3711-4afd-9fc0-cd4ea648ce35
# ╟─70f3c4c8-ac81-4802-8635-5c534aa60c89
# ╟─160cdcab-eac4-4ebe-9f99-4167af5dec6f
# ╟─13ff7fc2-db56-4383-8f56-9eb789dce213
# ╟─f6184770-7282-4418-8935-31c690bd8472
# ╟─ad55800e-0a4c-45d0-b163-9d64d4fc4199
# ╟─09d8ac0a-31d6-4b7a-8822-11e3ebd18072
# ╠═8afca44c-2856-43bc-b14f-7bdebe6a4760
# ╠═860e68e5-a93c-4a87-8464-630cd002c107
# ╟─644eb07c-0c7b-4758-9178-46e263f17a58
# ╟─6cbe46d7-9b91-4e21-8681-496820ca12c3
# ╟─cb98e7c3-62ff-42cf-808f-809fabe2b72b
# ╟─a51f8b2a-a408-46a6-a1be-acf3d6861b18
# ╟─c9b1a284-d79f-4eb6-9c7e-36e56b085ebf
# ╟─d2c75d50-8b18-423e-a5dd-ec608fa64a0b
# ╟─b47c9840-40a9-48f2-87b8-a48d37a80b56
# ╟─0943a708-7258-4320-8b52-ec9cd237ec4b
# ╟─d5e7df5e-9122-4f38-bc40-b4c8b0a44175
# ╟─ac0bd656-3bd3-47fd-9815-078f073d3280
# ╟─aabf07ca-9b1a-4cb7-bda3-667bf6b89b82
# ╟─43bc70eb-5e09-46e4-925c-2dd65792f676
# ╟─0a42b7f1-5795-4327-9710-b18e077ffb72
# ╟─c58f2776-5233-4892-88d1-81b50141f447
# ╟─fe3a7852-896d-4eb2-af96-6a1fa1aee476
# ╟─b56f67a6-65dc-4ac5-a86e-933b92742e7f
# ╟─a18b2edf-4493-487a-a52c-7cd9f612cd90
# ╟─4e98445a-3c9d-402c-8164-dc3486ef1094
# ╟─3fa4faa0-b767-4204-a062-a4ba0c1ebed0
# ╟─8f838fb6-17b6-4c11-b9f7-8d2e2af930b3
# ╟─eacbb51c-7a2c-44a4-aec0-a08bc168a635
# ╟─eaa0cda6-641d-4830-8dd5-e3d844131a57
# ╠═7a09f760-0ee8-403c-80cf-7715193d62b3
# ╠═5bf32a96-dad7-11eb-3d06-adc496c7e800
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
