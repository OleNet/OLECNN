function test_softmax_analytic

m = 4;
n = 3;
k = 2;
rng(0);
X= randi(10, n, m);
y = [1,1,2,1];
filter = rand(n, k);

%% my softmax
[J1, dfilter] = softmax_analytic(X, filter, y, m, n, k);
J = @(X, filter) softmax_analytic(X, filter, y, m, n, k);
num_grad = numerical_grad(J, X, filter);
display([dfilter(:), num_grad(:)]);


%% softmax benchmark
[J2 grad]= softmaxCost(filter', k, n, m, X, y);

end
