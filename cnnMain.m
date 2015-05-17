function cnnMain( )
%TESTCNN Summary of this function goes here
%   Detailed explanation goes here

%%
% p = imread('peppers.png');
X = rand(3,3,3,4);
y = [1 10 3 6];
net = InitModel();
score = OlePipeLine(X, net, y);
end

