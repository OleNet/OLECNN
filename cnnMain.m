function cnnMain( )
%TESTCNN Summary of this function goes here
%   Detailed explanation goes here

%%
addpath ./util
addpath ./CORE
addpath ./cnnsanitycheck


%%
epoch = 30;
% p = imread('peppers.png');
% X = rand(3,3,3,4);
X = zeros(3, 3, 3, 200);
X = X - rand(size(X));
X = cat(4, X, ones(3, 3, 3, 200));
M = size(X, 4);
y = [ones(1,200), ones(1,200)+1];
randIdx = randperm(M);

X_ = X(:,:,:,randIdx);
y_ = y(randIdx);

net = InitModel();
for i = 1 : epoch
    [score, net] = OlePipeLine(X_, net, y_);
    fprintf('epoch: %d\t', i);
    [~, pred] = max(score{end}.Prop, [], 1);
    acc = sum(pred==y_) / length(pred);
    fprintf('acc:%f\n', acc);
    disp([y_(1:10); pred(1:10)] );
end

i;
end

