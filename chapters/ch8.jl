### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 01820aa0-d887-11eb-0307-758b12f13e10
begin
	using PlutoUI
	using Plots, PlotThemes, LaTeXStrings
	using SymPy
	using Dates
	using ImageShow, ImageIO, ImageTransformations
	using FileIO
	using HypertextLiteral
end

# ╔═╡ a267a6be-6141-4472-bc34-156ba6bf8f56
TableOfContents(title="MATH 102")

# ╔═╡ e1426763-9558-4e05-a10f-3713badece23
x = symbols("x", real=true);html""

# ╔═╡ 9444b967-d4d9-441a-b295-0cc29c7fb578
begin
	p1 = plot(x->exp(-x)*cos(x),showaxis=false, ticks=nothing,label=nothing)
	md"""
	# Chapter 8: Further Applications of Integration

	## Section 8.1
	**Arc Length**

	**_QUESTION_**

	What is the length of the curve?

	$p1
	"""
end

# ╔═╡ a8d3d297-bd27-408b-857f-95ae790530a3
begin 
	img1 = load("./imgs/8.1/img1.png")
	imresize(img1,(400,900))
end

# ╔═╡ 1339001c-ad6a-485f-b2b9-43f8011c4d6b
md"""
### The Arc Length Formula
If ``f`` is continuous on ``[a,b]``, then the length of the curve ``y=f(x)``, ``a\leq x\leq b``, is 
```math
L=\int_a^b \sqrt{1+\left[f'(x)\right]^2} dx
```

**Remarks**
- Using Leibniz notation 
```math
L=\int_a^b \sqrt{1+\left(\frac{dy}{dx}\right)^2} dx
```

**Example 1:** Find the length of the arc of the semicubical parabola $y^2=x^3$ between the points $(1,1)$ and $(4,8)$. 
"""

# ╔═╡ cf63184e-1d0e-4917-bd0d-ee965abc1eb9
md"""
**Remark :**

- If ``x=g(y)``, ``c\leq y\leq d`` and ``g'(y)`` is continuous, then we have 
```math
L = \int_c^d \sqrt{1+\left[g'(y)\right]^2} dy=\int_c^d \sqrt{1+\left(\frac{dx}{dy}\right)^2} dy
```

**Example 2:**
Find the length of the arc of the parabola $y^2=x$ between the
points $(0,0)$ and $(1,1)$.
"""

# ╔═╡ 5fd0f18f-d40a-4492-a63d-566037c42ae9
md"""
**Example 3:** Set up an integral for the length of the arc of the hyperbola $xy=1$ from the point $(1,1)$ to the point $(2,{1 \over 2})$ 

"""

# ╔═╡ da787418-b9b7-437d-8d56-9a201936b9e7
integrate(sqrt(1 + 1/x^4),(x,1,2)).n()

# ╔═╡ fe1e7aae-e0f1-47db-a129-4d35b1b27938
md"""
### The Arc Length Function
```math
s(x) = \int_a^x\sqrt{1+\left[f'(t)\right]^2} dt
```

**The differential of arc length is**

```math 
ds = \sqrt{1+\left(\frac{dy}{dx}\right)^2} dx
```
"""

# ╔═╡ 7f026b61-84b8-466b-a270-491ba0fbcaf9
begin
	img2 = load("./imgs/8.1/img2.png")
	imresize(img2,(300,500))
end

# ╔═╡ d822d7aa-d77e-4cea-a3ef-40a72b72ccf4
md"""
**Example 4:** Find the arc length function for the curve $y=x^2-{1 \over 8}\ln x$ taking $P_0(1,1)$ as the starting point.
"""

# ╔═╡ 63c5c52a-0efd-4532-9043-44f9c092920f
md"""
### [Problem Set 8.1-8.2](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps8.1/ps8.1.pdf)

[Solution](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps8.1/ps8.1-solution.pdf)
"""

# ╔═╡ Cell order:
# ╟─a267a6be-6141-4472-bc34-156ba6bf8f56
# ╟─e1426763-9558-4e05-a10f-3713badece23
# ╟─9444b967-d4d9-441a-b295-0cc29c7fb578
# ╟─a8d3d297-bd27-408b-857f-95ae790530a3
# ╟─1339001c-ad6a-485f-b2b9-43f8011c4d6b
# ╟─cf63184e-1d0e-4917-bd0d-ee965abc1eb9
# ╟─5fd0f18f-d40a-4492-a63d-566037c42ae9
# ╟─da787418-b9b7-437d-8d56-9a201936b9e7
# ╟─fe1e7aae-e0f1-47db-a129-4d35b1b27938
# ╟─7f026b61-84b8-466b-a270-491ba0fbcaf9
# ╟─d822d7aa-d77e-4cea-a3ef-40a72b72ccf4
# ╟─63c5c52a-0efd-4532-9043-44f9c092920f
# ╠═01820aa0-d887-11eb-0307-758b12f13e10
