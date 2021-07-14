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
	# import Pkg
	# Pkg.add("Contour")
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
	using Contour
end

# ╔═╡ ad045108-9dca-4a61-ac88-80a3417c95f2
TableOfContents(title="MATH102 - TERM 203")

# ╔═╡ 1e9f4829-1f50-47ae-8745-0daa90e7aa42
md""" # Chapter 6

## Section 6.1

"""

# ╔═╡ 90f42d35-f81e-4c38-8a73-77b37755f671
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
	x, y = symbols("x,y", real=true)
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

# ╔═╡ b048a772-05c3-4cd0-97ae-5cf825127584
md""" 
### Areas Between Curves




"""

# ╔═╡ aac97852-3abc-4455-80fe-a61aec320d24
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

# ╔═╡ e427ab16-9d5a-4200-8d96-8e49ec0da312
begin
	f1(x) = sin(x)+3+cnstslider
	f2(x) = cos(2x)+1+cnstslider
	f3(x) = cos(2x)+4+cnstslider
	poi1=solve(f1(x)-f3(x),x) .|> p -> p.n()
	theme(:wong)
	a1,b1 = 1, 5
	Δx1 = (b1-a1)/n1slider
	x1Rect =a1:Δx1:b1
	x1 = a1:0.1:b1
	y1 = f1.(x1)
	y2 = f2.(x1)
	y3 = f3.(x1)
	
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
			Shape([(xi,f2(xi)),(xi+Δx1,f2(xi)),(xi+Δx1,f1(xi+Δx1)),(xi,f1(xi+Δx1))]) 			 for xi in x1Rect[1:end-1]
		  ]
	n1slider>2 && plot!(p1,recs, label=nothing,c=:green)
	plot!(p2; p1Opt...,ylims=(-3,6),xlims=(-1,6))
	scatter!(p2,(poi1[1],f3(poi1[1])), label="Point of instersection",legend=:bottomright)
	# save("./imgs/6.1/sec6.1p2.png",p2)
	# annotate!(p2,[(4,0.51,(L"$\sum_{i=1}^{%$n2} f (x^*_{i})\Delta x=%$s2$",12))])
	
	md""" **How can we find the area between the two curves?**
	
$p1
	
```math
Area = \int_a^b \left[{\color{red}f(x)} - {\color{blue}g(x)}\right] dx
```
"""

end

# ╔═╡ 2ddde4c4-8217-41e3-9235-a6370b11ae5c
md"""

**Remark**
- Area = ``y_{top}-y_{bottom}``.

**Example 1**

Find the area of the region bounded above by $y=e^x$, bounded below by $y=x$, bounded on the sides by $x=0$ and $x=1$.

---
"""

# ╔═╡ 07dee140-2553-4b2e-bd28-1dda978fb34c
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

# ╔═╡ d7928de3-89a4-4475-ba5b-2e707084685b
md"""
In geberal,

$p2
	
```math
Area = \int_a^b \left|f(x) - g(x)\right| dx
```

"""

# ╔═╡ 784142ee-1416-4ccb-a341-0497422009b6
html"<hr>"

# ╔═╡ a65d268a-cb45-4d6c-ac77-ac719010cfb3
md"""
**Example 2**

Find the area of the region enclosed by the parabolas $y=x^2$ and $y=2x-x^2$.

*Solution in class*

---
"""


# ╔═╡ 6a4dd437-8be1-4e17-b484-65707ec28215
begin
	ex2f1(x)=x^2
	ex2f2(x)=2x-x^2
	ex2poi=solve(ex2f1(x)-ex2f2(x)) .|> p->convert(Int,p.n())
	ex2x=0:0.01:1
	ex2widex=-1:0.01:2
	ex2y1=ex2f1.(ex2x)
	ex2y1wide=ex2f1.(ex2widex)
	ex2y2=ex2f2.(ex2x)
	ex2y2wide=ex2f2.(ex2widex)
	ex2plt=plot(ex2x,ex2y2,label=nothing,fill=(0,0.5,:green))
	plot!(ex2plt,ex2x,ex2y1,fill=(0,0,:white),label=nothing)
	plot!(ex2widex,ex2y1wide, c=:red,label=nothing)
	plot!(ex2widex,ex2y2wide, c=:blue,label=nothing)
	plot!(;p1Opt...,xlims=(-0.4,1.5),ylims=(-0.4,2),label=nothing,xticks=[0,0,1])
	ex2Rect = Shape([ (0.5,ex2f2(0.55))
					, (0.55,ex2f2(0.55))
					, (0.55,ex2f1(0.55))
					, (0.5,ex2f1(0.55))
					])
	plot!(ex2Rect,label=nothing)
	scatter!(ex2poi,ex2f1.(ex2poi),label=nothing)
	annotate!([	(0.77,0.4,L"y=x^2")
			  ,	(0.7,1.1,L"y=2x-x^2")
			  , (0.54,0.24,text(L"\Delta x",10))
			  ])
	md"""
	**Solution**
	
	$ex2plt
	"""
end

# ╔═╡ 4337bc1f-933f-4e8d-abae-46b8ad99409e
md"""
**Example 3**

Find the area of the region bounded by the curves 

```math 
y=\cos(x), \;\; y=\sin(2x), \;\; x=0, \;\; x=\frac{\pi}{2}
```


---
"""

# ╔═╡ 539cbac4-c1be-4f9d-b076-215c4430a3a6
begin
	ex3f1(x) = cos(x)
	ex3f2(x) = sin(2x)
	ex3X=0:0.01:(π+0.019)/2
	
	ex3Y1=ex3f1.(ex3X)
	ex3Y2=ex3f2.(ex3X)
	ex3P = plot(ex3X,ex3Y1,label=L"y=\cos(x)", c=:red)
	plot!(ex3P,ex3X,ex3Y1,fill=(ex3Y2,0.25,:green),label=nothing,c=nothing)
	plot!(ex3P,ex3X,ex3Y2,label=L"y=\sin(2x)",c=:blue)
	plot!(ex3P;p1Opt...,xlims=(-1,π),ylims=(-1.1,1.1))
	scatter!(ex3P,(π/6,ex3f1(π/6)),label=nothing,c=:black)
	
	md"""
	**Solution**
	
	$ex3P
	"""
end

# ╔═╡ 1006936d-e13e-4146-b0ac-905acb1f7d08
begin
	img1 = load(download("https://www.dropbox.com/s/r39ny15umqafmls/wrty.png?raw=1"))
	img1 = imresize(img1,ratio=1.5)
	md"""
	### Integrating with Respect to ``y``
	
	$img1
	
	"""
	
end

# ╔═╡ 64f36566-5747-4c8f-b90f-1ced674365cb
md"""
**Example 4**

Find the area enclosed by the line ``y=x-1``  and the parabola ``y^2=2x+6``.

"""

# ╔═╡ 61b6234e-5cb2-4337-ae29-14106ac6bd59
begin
	ex4p = plot(x->x^2/2 -3,x->x,-5,6,c=:blue,label=L"y^2=2x+6")
	plot!(ex4p,x->x,x->x-1,-5,6;p1Opt...,c=:red,label=L"y=x-1",xticks=-3:1:15)
	(ex4poi1,ex4poi2)=solve([y^2-2*x-6,y-x+1],[x,y]) 
	scatter!([ex4poi1,ex4poi2],xlims=(-3.5,7),label=nothing,legend=:topleft)
	md"""
	**Solution:**
	$ex4p
	"""
end

# ╔═╡ e370f794-41b6-4acf-9ef6-453fba223dea
# integrate(y+1-(y^2/2-3),(y,-2,4))

# ╔═╡ 629f1cf7-ffa9-496b-9a3f-405089b43a8e
md"""
**Example 5**

Find the area of the region enclosed by the curves ``y= {1\over x}``, ``y=x``, and ``y={1\over 4} x``, using
* ``x`` as the variable of integration and
* ``y`` as the variable of integration.


"""

# ╔═╡ 0b4677a8-93e3-4fc9-91e8-8a7e77d18e2b
begin
	x5=0.1:0.1:10
	x51=0:0.1:1
	p5 = plot(x->x/4, xlims=(-1,10), framestyle=:origin, aspectratio=1,label=nothing)
	plot!(x->x,c=:red,label=nothing)
	# plot!(x51,1 ./ x51,fill=(x51/4,0.5,:blue),c=:white)
	plot!(x5,1 ./ x5,c=:green,label=nothing)
	xlims!(-0.1,3)
	ylims!(-0.1,2)
end

# ╔═╡ 13625b14-ac53-4995-bbcb-205cdf672c2a
md"""
### [Problem Set 6.1](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps6.1/ps6.1.pdf)

([Solution](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps6.1/ps6.1-solution.pdf))
"""

# ╔═╡ 598b7b2e-01dd-41aa-966a-a361921a5c60
md"""
## Section 6.2
**Volumes**

Let's start with a simple solid **`cylinders`**

$(load(download("https://www.dropbox.com/s/mofqdenjokjci44/img1.png?dl=0")))

### Cross-Section Method
$(load(download("https://www.dropbox.com/s/xz80mrwj2fserd5/img2.png?dl=0")))

Let's now try to find a formula for finding the volume of this solid

$(load(download("https://www.dropbox.com/s/uvz7my3n08fgm6w/img3.png?dl=0")))


"""

# ╔═╡ 5c1989f5-bd7b-4c82-a9e3-54f47539fe2d
md"""
* Let’s divide ``S`` into ``n`` “slabs” of equal width ``\Delta x`` by using the planes``P_{x_1},P_{x_2},\cdots`` to slice the solid. (*Think of slicing a loaf of bread.*) 
* If we choose sample points ``x_i^*`` in ``[x_{i-1},x_i]`` , we can approximate the ``i``th slab ``S_i`` by a cylinder with base area ``A(x_i^*)`` and height ``\Delta x``.

```math
V(S_i) \approx A(x_i^*)\Delta x
```

So, we have

```math
V \approx \sum_{i=1}^{n} A(x_i^*)\Delta x
```
#### Definition of Volume
Let ``S`` be a solid that lies between ``x=a`` and ``x=b``. If the cross-sectional area of ``S`` in the plane ``P_x`` , through ``x`` and perpendicular to the ``x``-axis, is ``A(x)`` , where ``A`` is a continuous function, then the **volume** of ``S``  is 
```math
V = \lim_{n\to\infty} \sum_{i=1}^{n} A(x_i^*)\Delta x = \int_{a}^{b}A(x) dx
```
"""

# ╔═╡ 078023da-23bc-4401-a1dc-fe869400f9b0
md"""
### Volumes of Solids of Revolution
If we revolve a region about a line, we obtain a **solid of revolution**. In the following examples we see that for such a solid, cross-sections perpendicular to the axis of rotation are **circular**.

**Example 1**
Find the volume of the solid obtained by rotating about the ``x``-axis the region under the curve ``y=\sqrt{x}`` from ``0`` to ``1`` . Illustrate the definition of volume by sketching a typical approximating cylinder.
"""

# ╔═╡ 440eec5a-5a9b-4783-9dd2-3427fe340bc6
begin
	fun(x)=sqrt(x)
	s6e1 = PlotData(0:0.01:1, fun)	
	tt=range(0.1,stop=1,length=100) |> collect
	ss=range(0.1,stop=1,length=100) |> collect
	y_grid = [x for x=ss for y=tt]
	z_grid = [y for x=ss for y=tt]
	f(x, z) = begin
         x ^ 2 + z ^2
    end
	p3 =plot(	
				plot(s6e1; customcolor = :black )
			,	plot_implicit((x,y,z)->y^2+z^2-x,xrng=(-2,2),yrng=(-1,1),zrng=(-1,2),
   nlevels=200, slices=Dict(:x=>:red),aspect_ratio=1,frame_style=:origin)
			)
	md"""
	**Solution**

	$p3

	"""
end

# ╔═╡ 835bf3cc-eca3-4e8a-9c7a-dd0fa3c17525
md"""
**Example 2**
Find the volume of the solid obtained by rotating the region bounded by ``y=x^3``, ``y=8`` , and ``x=0`` about the ``y``-axis.
"""

# ╔═╡ 635e4f34-9401-4234-936b-8b1029c6a7db
md"""
**Example 3** The region ``\mathcal{R}`` enclosed by the curves ``y=x`` and ``y=x^2`` is rotated about the ``x``-axis. Find the volume of the resulting solid.

"""

# ╔═╡ c9b6ee5f-be74-4067-8bff-8e408ddd0196
md"""
**Example 4** Find the volume of the solid obtained by rotating the region in the previous Example about the line ``y=2``.
"""

# ╔═╡ 48dcb862-d764-4421-851a-213c9d733b02
md"""
**Example 5** Find the volume of the solid obtained by rotating the region in the previous Example about the line ``x=-1``.
"""

# ╔═╡ 383f7db2-80f5-4a68-a2d1-e34bdc804bff
md"""

**Summary: Volume of Solids of Revolution (Rotation)**

WE USE CROSS-SECTION METHOD
1. If the cross-section is a __DESK__ we user $$A=\pi r^2$$
2. If the cross-section is a __WASHER__ (وردة), we user $$A=\pi \left(r_{\text{out}}^2-r_{\text{in}}^2\right)$$

"""

# ╔═╡ 8d1a94f7-f6e6-4b95-a45e-03550125801e
md"""
**Example 6** Figure below shows a solid with a circular base of radius ``1``. Parallel cross-sections perpendicular to the base are equilateral triangles. Find the volume of the solid.
$(load(download("https://www.dropbox.com/s/bbxedang718jvvp/img4.png?dl=0")))
"""

# ╔═╡ 5e9b4aad-328e-443b-8f9e-d643e93414e1
md"""
### [Problem Set 6.2](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps6.2/ps6.2.and.revision.pdf)


([Solution](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps6.2/ps6.2.and.revision-solution.pdf))
"""

# ╔═╡ 3d267c3e-4509-48d6-a094-39e15940fd6c
md"""
## Section 6.3
**Volumes by Cylindrical Shells**

**Problem**
Find the volume of the solid generated by rotating the region bounded by ``y=2x^2-x^3`` and ``y=0`` about the ``y-``axis.
"""

# ╔═╡ 21848166-fbf0-4e1d-8e90-e0060abcc170
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

# ╔═╡ 088a349a-f632-45af-866f-6315ed1e47a5
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

# ╔═╡ 1dbbef99-3674-42fe-ab48-1ab6b72d0652
begin 
	shellImg=load(download("https://www.dropbox.com/s/8a2njc50e2hptok/shell.png?dl=0"))
	md"""
	A shell is a hallow circular cylinder
	
	$shellImg
	"""
end

# ╔═╡ 05af66f4-1013-4374-8c85-9265f123934e
md"""
```math
V = 2 \pi r h \Delta r = \text{[circumference][height][thickness]}

```
"""

# ╔═╡ 7396e0b3-753e-40fa-8bb5-30ccb4bac550
html"""
<div style="display: flex; justify-content:center; padding:20px; border: 2px solid rgba(125,125,125,0.2);">
<div>
<h5>Cylindrical Shells Illustration</h5>
<iframe width="560" height="315" src="https://www.youtube.com/embed/JrRniVSW9tg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
</div>
"""

# ╔═╡ af99b1ed-07cc-47aa-b05a-35590bd19da8
md"""
```math
V \approx \sum_{i=1}^n V_i = \sum_{i=1}^n 2\pi \bar{x}_if(\bar{x}_i)\Delta x
```

Hence,
```math
V = \lim_{n\to\infty}\sum_{i=1}^n 2\pi \bar{x}_if(\bar{x}_i)\Delta x = \int_a^b 2\pi x f(x) dx
```
"""

# ╔═╡ 5e5c5013-2b13-4a59-a325-91ebcf811cb2
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
**Example 1:**
Find the volume of the solid generated by rotating the region bounded by ``y=2x^2-x^3`` and ``y=0`` about the ``y-``axis.

Solution:
	
$s3e0p1
"""
end

# ╔═╡ d61e07a2-25da-4189-9689-57a6bb642b6e
md"""
**Example 2:**
Find the volume of the solid obtained by rotating about the ``y-``axis the region between ``y=x`` and ``y=x^2``.

"""

# ╔═╡ 5072c45e-2efd-44cf-a0fc-380972e270e2
md"""
**Example 4:**
Find the volume of the solid obtained by rotating the region bounded by ``y=x-x^2`` and ``y=0`` about the line ``x=2``.

"""

# ╔═╡ 1397dcce-011f-4cf2-948d-16a344a5f018
md"""
### [Problem Set 6.3](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps6.3/ps6.3.pdf)

[Solution](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps6.3/ps6.3-solution.pdf)
"""

# ╔═╡ 28e60db5-e3d7-49d5-b530-97fc52a8fe5b
md"""
## Section 6.5 
**Average Value of a Function**

**Question**: What is the avergae value of finitely many numbers $y_1, y_2, \cdots, y_n$?

Answer: 
```math
y_{\text{avg}}=\frac{y_1+y_2+\cdots+y_n}{n}
```
**Question**: What is the average value of a function $y=f(x)$ where $x\in [a,b]$?

Answer: 
```math
f_{\text{avg}}=\frac{1}{b-a}\int_a^b f(x) dx
```

"""

# ╔═╡ 851f9c56-2d0c-493a-be53-b2fc77ec1bfb
md"""
**Remark**
For a positive function, we can think of this definition as saying 
```math
\frac{\text{area}}{\text{width}}=\text{average height}
```

**Example 1:** Find the average value of the function ``f(x)=1+x^2`` on the interval ``[-1,2]`` .

"""

# ╔═╡ 530c6d53-1a7b-4b0f-87c3-949e92d16784
md"""
### The Mean Value Theorem for Integrals 

If ``f`` is continuous on ``[a,b]``, then there exists a number ``c`` in 
``[a,b]`` such that 
```math
f(c)=f_{\text{avg}}=\frac{1}{b-a}\int_a^b f(x) dx
```
that is,
```math
\int_a^b f(x) dx = f(c)(b-a)
```
"""

# ╔═╡ b01b8817-be8d-4c67-8a8f-8515d11da0f5
md"""
**Example:**
Find the sum of the numbers ``c`` for which the average value of 
```math
f(x)=9x^2+4x+3
```
becomes 4 on the interval ``[0,c]``.
"""

# ╔═╡ cb7d7e25-a12a-4043-8954-a4547fe6c968
md"""
### [Problem Set 6.5](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps6.5/ps6.5.pdf)

[Solution](https://github.com/mmogib/math102-term203/blob/master/problem_sets/ps/ps6.5/ps6.5-solution.pdf)
"""

# ╔═╡ ca2016b0-83dd-445f-99a0-b685d6151eb3
hline()=html"<hr>"

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

# ╔═╡ Cell order:
# ╟─ad045108-9dca-4a61-ac88-80a3417c95f2
# ╟─1e9f4829-1f50-47ae-8745-0daa90e7aa42
# ╠═90f42d35-f81e-4c38-8a73-77b37755f671
# ╟─b048a772-05c3-4cd0-97ae-5cf825127584
# ╟─aac97852-3abc-4455-80fe-a61aec320d24
# ╟─e427ab16-9d5a-4200-8d96-8e49ec0da312
# ╟─2ddde4c4-8217-41e3-9235-a6370b11ae5c
# ╟─07dee140-2553-4b2e-bd28-1dda978fb34c
# ╟─d7928de3-89a4-4475-ba5b-2e707084685b
# ╟─784142ee-1416-4ccb-a341-0497422009b6
# ╟─a65d268a-cb45-4d6c-ac77-ac719010cfb3
# ╟─6a4dd437-8be1-4e17-b484-65707ec28215
# ╟─4337bc1f-933f-4e8d-abae-46b8ad99409e
# ╟─539cbac4-c1be-4f9d-b076-215c4430a3a6
# ╟─1006936d-e13e-4146-b0ac-905acb1f7d08
# ╟─64f36566-5747-4c8f-b90f-1ced674365cb
# ╟─61b6234e-5cb2-4337-ae29-14106ac6bd59
# ╠═e370f794-41b6-4acf-9ef6-453fba223dea
# ╟─629f1cf7-ffa9-496b-9a3f-405089b43a8e
# ╟─0b4677a8-93e3-4fc9-91e8-8a7e77d18e2b
# ╟─13625b14-ac53-4995-bbcb-205cdf672c2a
# ╟─598b7b2e-01dd-41aa-966a-a361921a5c60
# ╟─5c1989f5-bd7b-4c82-a9e3-54f47539fe2d
# ╟─078023da-23bc-4401-a1dc-fe869400f9b0
# ╠═440eec5a-5a9b-4783-9dd2-3427fe340bc6
# ╟─835bf3cc-eca3-4e8a-9c7a-dd0fa3c17525
# ╟─635e4f34-9401-4234-936b-8b1029c6a7db
# ╟─c9b6ee5f-be74-4067-8bff-8e408ddd0196
# ╟─48dcb862-d764-4421-851a-213c9d733b02
# ╟─383f7db2-80f5-4a68-a2d1-e34bdc804bff
# ╟─8d1a94f7-f6e6-4b95-a45e-03550125801e
# ╟─5e9b4aad-328e-443b-8f9e-d643e93414e1
# ╟─3d267c3e-4509-48d6-a094-39e15940fd6c
# ╟─21848166-fbf0-4e1d-8e90-e0060abcc170
# ╟─088a349a-f632-45af-866f-6315ed1e47a5
# ╟─1dbbef99-3674-42fe-ab48-1ab6b72d0652
# ╟─05af66f4-1013-4374-8c85-9265f123934e
# ╟─7396e0b3-753e-40fa-8bb5-30ccb4bac550
# ╟─af99b1ed-07cc-47aa-b05a-35590bd19da8
# ╟─5e5c5013-2b13-4a59-a325-91ebcf811cb2
# ╟─d61e07a2-25da-4189-9689-57a6bb642b6e
# ╟─5072c45e-2efd-44cf-a0fc-380972e270e2
# ╟─1397dcce-011f-4cf2-948d-16a344a5f018
# ╟─28e60db5-e3d7-49d5-b530-97fc52a8fe5b
# ╟─851f9c56-2d0c-493a-be53-b2fc77ec1bfb
# ╟─530c6d53-1a7b-4b0f-87c3-949e92d16784
# ╟─b01b8817-be8d-4c67-8a8f-8515d11da0f5
# ╟─cb7d7e25-a12a-4043-8954-a4547fe6c968
# ╟─ca2016b0-83dd-445f-99a0-b685d6151eb3
# ╟─a9d0c669-f6d7-4e5f-8f57-b6bffe1710ba
# ╟─ad3dd437-7cfc-4cdc-a951-15949d39cf15
# ╟─6a5d1a86-4b9e-4d65-9bd7-f39ef8b6d9b4
# ╠═e93c5882-1ef8-43f6-b1ee-ee23c813c91b
