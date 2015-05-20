function ret = testSoftmaxAnalytic(m, n, k)

% m = 4;
% n = 3;
% k = 2;

rng('default');
X = randi(10, [1, 1, n, m]);
y = randi(k, 1, m);
y(y == max(y)) = k;
filter = rand(1, 1, n, k);
bias = rand(1,k);

%% my softmax
[~, J1, ~, dfilter, dbias] = OleSoftMax(X, filter, bias, y, 1);
J = @(X, filter, bias) OleSoftMax(X, filter, bias, y, 1);
num_grad = numericalGrad(J, X, filter, bias);
danalytic = [dfilter(:);dbias(:)];
display([danalytic, num_grad(:)]);


%%
threshold = 1e-7;
diff = sum((danalytic(:) - num_grad(:)) .^2);
if diff > threshold
    ret = 0;
else
    ret = 1;
end
end
