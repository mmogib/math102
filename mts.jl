### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 3084f9c1-f94c-4429-aa1b-17e6323611be
begin
	struct MTSStat
		slice::Int
		occurance::Int
		percentage::Float64
	end
	Base.isless(a::MTSStat, b::MTSStat) = Base.isless(b.occurance,a.occurance)
	MTSStat(a,b) = MTSStat(a,b,0.0)
end

# ╔═╡ f71d93b6-bf47-4d04-a9a3-fcaeee86eb88
function playMTS(n;categories=100)
	calcPerc(i,chosen,n) = begin 
			cnt= count(==(i),chosen)
			MTSStat(i,cnt,round(cnt/n,digits=4))
	end
	wheels = [[1,2,rand(3:categories,10)...] for _ in 1:n]
	matches = [rand(wheel,2) for wheel in wheels]
	chosen = reduce((a,b)->[a...,b...], matches;init=[])
	counts = [calcPerc(i,chosen,n) for i in 1:categories]
	sort(counts)
	# reduce((a,b)->[a...,b...], wheels;init=[])
	# wheels = reduce((a,b)->[a...,b...],[repeat([1,2],n),[rand(3:100,10) for _ in 1:n]...], init=[])
	# wheelDicts = [Dict([(i,0) for i in wheels[j]]) for j in 1:n]
	# for i in 1:n
	# 	wheel = wheels[i]
	# 	# matches = [rand(wheel) for _ in 1:n]
	# end
	# matches = [rand(wheels[i]) for i in 1:n]
	# counts = [(i,count(==(i), matches)) for i in wheel]
	 
end
	

# ╔═╡ a7dcfc9c-5215-4f12-b651-55a804e7fd4f
playMTS(1000)

# ╔═╡ Cell order:
# ╠═3084f9c1-f94c-4429-aa1b-17e6323611be
# ╠═f71d93b6-bf47-4d04-a9a3-fcaeee86eb88
# ╠═a7dcfc9c-5215-4f12-b651-55a804e7fd4f
