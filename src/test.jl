using Plots
using LaTeXStrings
# default(
#     fontfamily="serif-roman",
#     guidefontsize=28,
#     tickfontsize=20,
#     legendfontsize=20,
#     margin=5Plots.mm,
# )
# Plots.default()

x = 1:10
y = rand(10) # These are the plotting data 
plot(x, y, label="my label")
xaxis!(L"x")
yaxis!(L"y")
