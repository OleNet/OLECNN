function testCnnPipeline

m = 4;
n = 3;
k = 2;
X = rand(3,3,3,4);
y = [1 10 3 6];
net = InitModel();

%% my cnn pipeline
J = @(X, net) lossWrapper(X, net, y);
num_grad = net_numerical_grad(J, X, net);
[J, dfilter] = lossWrapper(X, net, y);
display([dfilter(:), num_grad(:)]);

end
