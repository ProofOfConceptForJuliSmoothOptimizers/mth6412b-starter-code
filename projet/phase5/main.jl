
using Pkg
Pkg.activate(joinpath(@__DIR__, "mth6412b/"))
using Test
import Base.show
using Plots
using LinearAlgebra
using Random, FileIO, Images, ImageView, ImageMagick


include(joinpath(@__DIR__, "exceptions.jl"))
include(joinpath(@__DIR__, "node.jl"))
include(joinpath(@__DIR__, "edge.jl"))
include(joinpath(@__DIR__, "graph.jl"))
include(joinpath(@__DIR__, "connected_component.jl"))
include(joinpath(@__DIR__, "heuristics.jl"))
include(joinpath(@__DIR__, "kruskal.jl"))
include(joinpath(@__DIR__, "prim.jl"))
include(joinpath(@__DIR__, "tree.jl"))
include(joinpath(@__DIR__, "RSL.jl"))
include(joinpath(@__DIR__, "HK.jl"))
include(joinpath(@__DIR__, "shredder-julia", "bin", "tools.jl"))

println("Make sure you are running this file from the phase4 folder!")
println("Choose a symmetric instance (e.g bays29.tsp): ")

# filename = readline()
filename = "pizza-food-wallpaper.png"
filepath = joinpath(@__DIR__, "shredder-julia", "images", "original", filename)
img = load(filepath)
img_small = imresize(img, (100,100))
w = get_edge_matrix(img_small)

for i in 1:100
    for j in i:100
        w[j,i] = w[i,j]
    end
end 

file = open(joinpath(@__DIR__, "shredder-julia", "tsp", "instances", "small-pizzetta.tsp"), "w")
write(file,"NAME : small-pizzetta\n")
write(file,"TYPE : TSP\n")
write(file, "COMMENT: Very small pizzetta\n")
write(file,"DIMENSION : 100\n")
write(file,"EDGE_WEIGHT_TYPE : EXPLICIT\n")
write(file,"EDGE_WEIGHT_FORMAT : FULL_MATRIX\n")
# write(file,"NODE_COORD_TYPE : NO_COORDS\n")
write(file,"DISPLAY_DATA_TYPE : NO_DISPLAY\n")
write(file, "EDGE_WEIGHT_SECTION\n")

for i in 1:100
    for j in 1:100
        write(file, "$(w[i,j]) ")
    end
    write(file, '\n')
end
close(file)

graph = build_graph(joinpath(@__DIR__, "shredder-julia", "tsp", "instances", "small-pizzetta.tsp"))

plot_graph(graph)

# show(graph)