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

# ╔═╡ 5bf32a96-dad7-11eb-3d06-adc496c7e800
begin
	using CommonMark, ImageIO, FileIO, ImageShow
	using PlutoUI
	using Plots, PlotThemes, LaTeXStrings, Random
	using SymPy
	using HypertextLiteral
	using ImageTransformations
end

# ╔═╡ 738772a6-d798-41d6-aa6d-c599d6d65ef7
TableOfContents(title="MATH102-CH11")

# ╔═╡ 6906df3e-afaa-4884-9825-abcf8fef2cbb
md"""
# Chapter 11:  
#### Sequences, Series, and Power Series

"""

# ╔═╡ 6019adf1-f462-4e30-beca-ed460822279e
md"""
## Section 11.1:
##### Sequences
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
### Properties of Convergent Sequences
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
			L"a_{%$n7slider}=%$rslider^{%$n7slider} =%$(round(a7(n4slider),digits=6))")
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
1. ``\lim_{n\to \infty}\frac{n}{n+1}.``
2. ``\lim_{n\to \infty}\frac{n}{\sqrt{n+1}}.``
3. ``\lim_{n\to \infty}\frac{\ln n}{n}.``
4. ``\lim_{n\to \infty}\frac{(-1)^n}{n}.``
5. ``\lim_{n\to \infty}\sin\left(\pi/n\right).``
6. ``\lim_{n\to \infty}\frac{n!}{n^n}.``

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

# ╔═╡ d58d9919-1412-4ade-a6e2-416d33bea113
md"""
### [Problem Set 11.1](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps11.1/ps11.1.pdf)

[Solution](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps11.1/ps11.1-solution.pdf)
"""

# ╔═╡ 732f8e3f-75ed-47a3-8329-ca55549b0ebf
md"""
## Section 11.2
**Series**
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

# ╔═╡ fcafea75-2567-4125-8244-b5075ca50942
md"""
### [Problem Set 11.2](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps11.2/ps11.2.pdf)

[Solution](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps11.2/ps11.2-solution.pdf)
"""

# ╔═╡ 7a09f760-0ee8-403c-80cf-7715193d62b3
begin
	n,i = symbols("n,i", integer=true)
	html""
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
			(0.7,0.75,
				L"a_n=\sum_{n=1}^{%$n8slider}\frac{1}{2^n}=%$s1exactsol",10
			),
			(0.58,0.2,
				L"a_n=\sum_{n=1}^{%$n8slider}n=%$s2exact",10
			)
		],
			grid=:none,)
	
end

# ╔═╡ Cell order:
# ╟─738772a6-d798-41d6-aa6d-c599d6d65ef7
# ╟─6906df3e-afaa-4884-9825-abcf8fef2cbb
# ╟─6019adf1-f462-4e30-beca-ed460822279e
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
# ╟─2bee38b7-e767-453e-818d-fec74e81c887
# ╟─4cb2514e-9266-424c-8bf0-f0b2217cf2aa
# ╟─0b15c5f3-5238-4251-b31a-c82704bd0e80
# ╟─f5cf327c-9f3b-4c50-9e92-96471d0874b6
# ╟─d58d9919-1412-4ade-a6e2-416d33bea113
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
# ╟─fcafea75-2567-4125-8244-b5075ca50942
# ╠═7a09f760-0ee8-403c-80cf-7715193d62b3
# ╠═5bf32a96-dad7-11eb-3d06-adc496c7e800
