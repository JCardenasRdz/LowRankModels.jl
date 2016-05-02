using LowRankModels
import StatsBase: sample, WeightVec

println("\n\nk lines\n=======\n\n")


## generate data
srand(1);
m,n,k = 300,300,5;
file_prefix = "klines_n=300_r=5" #n=$(n)_r=$k"
kfit = k
# variance of measurement
sigmasq = .1

# coordinates of covariates
X_real = zeros(m,k)
for i=1:m
    X_real[i,sample(1:k)] = rand()
end
# directions of observations
Y_real = randn(k,n) 

XY = X_real*Y_real;
A = XY # + sqrt(sigmasq)*randn(m,n)

# and the model
losses = QuadLoss()
rx, ry = OneSparseConstraint(), QuadReg(.01);
glrm = GLRM(A,losses,rx,ry,kfit)
glrm_apalm = GLRM(A,losses,rx,ry,kfit)

include("fit_n_plot.jl")