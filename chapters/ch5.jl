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

# ╔═╡ 67c9d3f4-9135-11eb-08c9-8fc2ac77c20b
using PlutoUI, Plots, PlotThemes, LaTeXStrings

# ╔═╡ 62b9638e-914b-11eb-0c15-67e165c9b61a
using CommonMark, ImageIO, FileIO, ImageShow

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

# ╔═╡ ad3dd437-7cfc-4cdc-a951-15949d39cf15
rect(x,Δx,xs,f)=Shape([(x,0),(x+Δx,0),(x+Δx,f(xs)),(x,f(xs))])
#Shape(x .+ [0,Δx,Δx,0], [0,0,f(xs),f(xs)])

# ╔═╡ a9d0c669-f6d7-4e5f-8f57-b6bffe1710ba
function reimannSum(f,n,a,b;method="l")
	Δx =(b-a)/n
	x =a:0.1:b
	# plot(f;xlim=(-2π,2π), xticks=(-2π:(π/2):2π,["$c π" for c in -2:0.5:2]))
	
	p=plot(x,f.(x);legend=nothing)
	(partition,sample) = if method=="r"
		 ((a+Δx):Δx:b,(xx,yy)->(xx-yy))
	elseif method=="m"
		((a+(Δx/2)):Δx:(b-(Δx/2)),(xx,yy)->(xx-yy/2))
	else
		( a:Δx:(b-Δx),(xx,yy)->(xx))
	end
	recs= [rect(sample(p,Δx),Δx,p,f) for p in partition]
	plot!(p,recs,framestyle=:origin,opacity=.4, color=:green)
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

# ╔═╡ 5b5d9f84-9136-11eb-0853-6533eea80d82
 # using Pkg;Pkg.add("ImageShow")

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
# ╟─a9d0c669-f6d7-4e5f-8f57-b6bffe1710ba
# ╟─ad3dd437-7cfc-4cdc-a951-15949d39cf15
# ╟─67c9d3f4-9135-11eb-08c9-8fc2ac77c20b
# ╟─5b5d9f84-9136-11eb-0853-6533eea80d82
# ╟─62b9638e-914b-11eb-0c15-67e165c9b61a
