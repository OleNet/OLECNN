function ret = testCnnPipeline

m = 4;
n = 3;
k = 2;
X = rand(3,3,3,4);
y = [1 10 3 6];
net = InitModel();

%% my cnn pipeline
J = @(X, net) lossWrapper(X, net, y);
num_grad = numericalGrad4CNN(J, X, net);
[J, dfilter] = lossWrapper(X, net, y);
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
