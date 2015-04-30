function testcnn( )
%TESTCNN Summary of this function goes here
%   Detailed explanation goes here

%%
p = imread('peppers.png');
net = InitModel();
score = OleFF(p, net);
end

