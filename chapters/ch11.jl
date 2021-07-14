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
	using Colors
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
1. ``\lim_{n\to \infty}\frac{n}{n+1}.``
2. ``\lim_{n\to \infty}\frac{n}{\sqrt{n+1}}.``
3. ``\lim_{n\to \infty}\frac{\ln n}{n}.``
4. ``\lim_{n\to \infty}\frac{(-1)^n}{n}.``
5. ``\lim_{n\to \infty}\sin\left(\pi/n\right).``
6. ``\lim_{n\to \infty}\frac{n!}{n^n}.``


**Exercise**

```math
\lim_{n\to \infty}\frac{n^n}{n!}.
```
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

# ╔═╡ 725356c8-c1c7-4fe9-8b31-a54350eb6192
an(20)

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

# ╔═╡ f5940c72-c53b-477e-901a-065890994424
md"""
### Section 11.3:
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

# ╔═╡ e84c4828-5030-4280-9d46-33e1c88087f9
md"""
### [Problem Set 11.3](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps11.3/ps11.3.pdf)

[Solution](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps11.3/ps11.3-solution.pdf)
"""

# ╔═╡ c1fb160e-e9bf-4872-b959-226c917e06a1
md"""
## Section 11.4:
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

Exercises `48` and `49` deal with the cases ``c=0`` and ``c=\infty`` .

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

# ╔═╡ bfb4abf0-6d91-49d3-9c73-759d9acb9d35
md"""
### [Problem Set 11.4](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps11.4/ps11.4.pdf)

[Solution](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps11.4/ps11.4-solution.pdf)
"""

# ╔═╡ 89f93052-2d9c-49d1-a6c1-b416900fd309
md" --- "

# ╔═╡ f52f9c5e-0571-4317-9345-cc57ca99cfb1
md"""
## Section: 11.5
**Alternating Series and Absolute Convergence**

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

# ╔═╡ fbc354f5-2d6b-44e2-87b8-13af626837b4
md"""
### [Problem Set 11.5](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps11.5/ps11.5.pdf)

[Solution](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps11.5/ps11.5-solution.pdf)
"""

# ╔═╡ cf69a563-8562-47d5-bf3e-e293ac73b8c1
md"""
## Section 11.6
**The Ratio and Root Tests**
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
## Section 11.7:
**Strategies of testing convergence**

Please read the textbook and solve as much as you can from the exercises list.

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
# ╠═5fa58a4d-d6b3-400c-9112-eca8b94e99ae
# ╠═725356c8-c1c7-4fe9-8b31-a54350eb6192
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
# ╟─f5940c72-c53b-477e-901a-065890994424
# ╟─647499ff-0a1a-47b7-b380-cefb3e4d8deb
# ╟─c649ea68-d3af-4573-a3cf-d252c7df0c82
# ╟─035f9728-3d6a-429d-91f4-9585a2f6caf8
# ╟─ea18fd6b-c0fa-4085-8353-101a71ee17ac
# ╟─7b45a531-c3c3-4301-9e67-99b1de59e280
# ╟─d395cf53-882e-4b1c-af71-eeed7dec80bb
# ╟─69009dbb-3db0-4da9-993d-e27fd15981f7
# ╟─33464e2b-7169-4baa-96af-ba763c9bfacc
# ╟─e84c4828-5030-4280-9d46-33e1c88087f9
# ╟─c1fb160e-e9bf-4872-b959-226c917e06a1
# ╟─969d060c-5829-40fc-ac52-e04af4618899
# ╟─7dda009d-9b2d-4508-8847-1ea107edd2cb
# ╟─08b6efff-e3f6-47fa-9b09-57b641c1f598
# ╟─4bb1c6d6-e533-4dae-a449-64f0dbe27bad
# ╟─bfb4abf0-6d91-49d3-9c73-759d9acb9d35
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
# ╟─fbc354f5-2d6b-44e2-87b8-13af626837b4
# ╟─cf69a563-8562-47d5-bf3e-e293ac73b8c1
# ╟─60e396d0-a49d-4a8e-b703-7164724c5179
# ╟─cc4929ef-aa8c-44c1-82fc-f292a2816e02
# ╟─a68491a7-3711-4afd-9fc0-cd4ea648ce35
# ╟─7a09f760-0ee8-403c-80cf-7715193d62b3
# ╠═5bf32a96-dad7-11eb-3d06-adc496c7e800
