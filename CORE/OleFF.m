function [ score ] = OleFF( X, net )
%OLEFF Summary of this function goes here
%   Detailed explanation goes here

%% 
i = 1;
res = {};
while i < length(net.layer)
    
    switch net.layer{i}.type
        case 'conv' 
            res{end+1} = OleConv(X, net.layer{i}.filter);
        case 'pool'
            res{end+1} = OlePool(X, net.layer{i}.size);
        case 'relu' 
            res{end+1} = OleRelu(X);
        case 'softmax' 
            res{end+1} =  OleSoftMax(X, theta);
        otherwise
    end
    
i = i + 1;
end

score = 0;
end

