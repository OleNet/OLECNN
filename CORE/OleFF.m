function [ score ] = OleFF( X, net, y )
%OLEFF Summary of this function goes here
%   Detailed explanation goes here

%% 
i = 1;
res = {};
res{1}.X = X;
while i <= length(net.layer)
    
    switch net.layer{i}.type
        case 'conv' 
            res{end+1}.X = OleConv(res{end}.X, net.layer{i}.filter);
        case 'pool'
            res{end+1}.X = OlePool(res{end}.X, net.layer{i}.size);
        case 'relu' 
            res{end+1}.X = OleRelu(res{end}.X);
        case 'softmax' 
            res{end+1}.X =  OleSoftMax(res{end}.X, net.layer{i}.filter, y);
        otherwise
    end
    
i = i + 1;
end

score = 0;
end

