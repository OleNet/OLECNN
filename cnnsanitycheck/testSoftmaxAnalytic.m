function ret = testSoftmaxAnalytic

m = 4;
n = 3;
k = 2;

rng('default');
X = randi(10, [1, 1, n, m]);
y = [1,1,2,1];
filter = rand(1, 1, n, k);

%% my softmax
[J1, ~, dfilter] = OleSoftMax(X, filter, y, 1);
J = @(X, filter) OleSoftMax(X, filter, y, 1);
num_grad = numericalGrad(J, X, filter);
display([dfilter(:), num_grad(:)]);


%%
threshold = 1e-7;
diff = sum((dfilter(:) - num_grad(:)) .^2);
if diff > threshold
    ret = 0;
else
    ret = 1;
end
end
