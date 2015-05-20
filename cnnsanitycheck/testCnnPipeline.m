function ret = testCnnPipeline(m, n, k)

X = rand(3,3,n,m);
y = randi(k, 1, m);
net = InitModel();

%% my cnn pipeline
J = @(X, net) lossWrapper(X, net, y);
num_grad = numericalGrad4CNN(J, X, net);
[J, dtheta] = lossWrapper(X, net, y);
display([dtheta(:), num_grad(:)]);


%%
threshold = 1e-7;
diff = sum((dtheta(:) - num_grad(:)) .^2);
if diff > threshold
    ret = 0;
else
    ret = 1;
end
end
