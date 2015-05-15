function testcnn( )
%TESTCNN Summary of this function goes here
%   Detailed explanation goes here

%%
% p = imread('peppers.png');
p = rand(3,3,3,4);
y = randi(10, 1, 4);
net = InitModel();
score = OlePipeLine(p, net, y);
end

