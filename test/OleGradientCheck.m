function numGrad = OleGradientCheck(fun)

%%
rng(0);
x = randi([-5 5], 1, 10);
epsilon = 1e-4;
x = 1.00;
y = 2.00;
numGradx = (fun(x+epsilon, y) - fun(x-epsilon,y)) / (2*epsilon);
numGrady = (fun(x, y+epsilon) - fun(x,y-epsilon)) / (2*epsilon);
numGrad = [numGradx numGrady];

end